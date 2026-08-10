import 'package:chat_app/models/message.dart';
import 'package:chat_app/screen/chat_cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit () : super(const ChatInitial());
  final CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);
  List<Message> messagesList = [];




  void sendMessage({required String message,required String email }){
   try {
     messages.add({
       kMessage: message,
       kCreatedAt: DateTime.now(),
       'id': email
     });
   }on Exception catch(e){

   }




}
void getMessages(){
  messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event){
    messagesList.clear();
    for(var doc in event.docs)
      {
        messagesList.add(Message.fromJson(doc));
      }

    emit(ChatSuccess(messages: messagesList));

  });

}


}