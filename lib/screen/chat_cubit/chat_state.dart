import 'package:chat_app/models/message.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ChatState {
  const  ChatState();
}

final class ChatInitial extends  ChatState {
  const ChatInitial();
}



 class ChatSuccess extends  ChatState {
  List<Message> messages;

   ChatSuccess({required this.messages});
}

