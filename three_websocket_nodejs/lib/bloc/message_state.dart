import 'package:equatable/equatable.dart';
import '../message_model.dart';

abstract class MessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;

  MessageLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class MessageError extends MessageState {}
