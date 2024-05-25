import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'message_event.dart';
import 'message_state.dart';
import '../message_repository.dart';
import '../message_model.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository repository;
  final WebSocketChannel _channel;

  MessageBloc({required this.repository, required String websocketUrl})
      : _channel = WebSocketChannel.connect(Uri.parse(websocketUrl)),
        super(MessageLoading()) {
    on<LoadMessages>(_onLoadMessages);
    on<AddMessage>(_onAddMessage);

    _channel.stream.listen((data) {
      add(LoadMessages());
    });
  }

  Future<void> _onLoadMessages(
      LoadMessages event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    print('Fetching messages...');

    try {
      final messages = await repository.fetchMessages();
      emit(MessageLoaded(messages: messages));
      print('Fetched messages: $messages');
    } catch (e) {
      emit(MessageError());
      print('Error fetching messages: $e');
    }
  }

  Future<void> _onAddMessage(
      AddMessage event, Emitter<MessageState> emit) async {
    try {
      await repository.addMessage(event.message);
      add(LoadMessages());
    } catch (e) {
      print('Failed to add message: $e');
    }
  }

  @override
  Future<void> close() {
    _channel.sink.close();
    return super.close();
  }
}
