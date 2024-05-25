import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/message_bloc.dart';
import '../bloc/message_event.dart';
import '../bloc/message_state.dart';
import 'message_model.dart';

class MyHomePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _articleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MessageLoaded) {
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.messages[index].name),
                        subtitle: Text(
                            '${state.messages[index].message}\n${state.messages[index].article}'),
                      );
                    },
                  );
                } else if (state is MessageError) {
                  return Center(child: Text('Failed to load messages'));
                }
                return Center(child: Text('No messages'));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Enter message'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _articleController,
              decoration: InputDecoration(labelText: 'Enter article'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final message = Message(
                name: _nameController.text,
                message: _messageController.text,
                article: _articleController.text,
              );
              context.read<MessageBloc>().add(AddMessage(message));
            },
            child: Text('Add Message'),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
