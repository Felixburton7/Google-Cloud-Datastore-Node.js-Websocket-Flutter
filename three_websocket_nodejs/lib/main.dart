import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/message_bloc.dart';
import 'bloc/message_event.dart';
import '../repository/message_repository.dart';
import 'presentation/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageRepository messageRepository =
        MessageRepository(baseUrl: 'http://localhost:3000');

    return MaterialApp(
      title: 'Flutter BLoC Datastore App',
      home: BlocProvider(
        create: (context) => MessageBloc(
          repository: messageRepository,
          websocketUrl: 'ws://localhost:8081',
        )..add(LoadMessages()),
        child: MyHomePage(),
      ),
    );
  }
}
