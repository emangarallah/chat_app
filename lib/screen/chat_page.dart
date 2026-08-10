import 'package:chat_app/screen/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screen/chat_cubit/chat_state.dart';
import 'package:chat_app/widget/chatbubleForFrind.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant.dart';
import '../models/message.dart';
import '../widget/chat_buble.dart';

class ChatPage extends StatelessWidget {


   ChatPage({super.key});
   static String id = 'ChatPage';
   List<Message> messagesList = [];




  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();


  @override




  @override
  Widget build(BuildContext context) {
    // Safe extraction of email argument
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 50),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'pacifico',
              ),
            ),
          ],
        ),
      ),
      body: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit,ChatState>(
                     builder:(context,state) {
                       var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                      return ListView.builder(
                         reverse: true,
                         controller: _scrollController,
                         itemCount: messagesList.length,
                         itemBuilder: (context, index) {
                           final message = messagesList[index];
                           return message.id == email
                               ? ChatBuble(message: message)
                               : Chatbubleforfrind(message: message);
                         },
                       );
                     },



                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _textController,

                    onSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);



                      _textController.clear();
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );

                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(Icons.send, color: kPrimaryColor),


                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );

  }
}