import 'package:equatable/equatable.dart';
import '../bloc/message_bloc.dart';
import '../models/message_model.dart';

abstract class MessageEvent {}

class LoadMessages extends MessageEvent {}

class AddMessage extends MessageEvent {
  final Message message;
  AddMessage(this.message);
}
