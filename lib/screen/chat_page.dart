import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';
import '../models/message.dart';
import '../widget/chat_buble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: kPrimaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kLogo,height: 50,),
          Text('Scolar chat',style: TextStyle(color: Colors.white,fontFamily: 'pacifico'),),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,

    ),
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context,index){

              return ChatBuble();
            }
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'send Message',
                suffixIcon: Icon(Icons.send,color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: Colors.red

                  ),

                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  )

                )
              ),
            ),
          ),
        ],
      ),




    
    
    );
  }
}
