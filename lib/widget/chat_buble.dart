

import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/message.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key,required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Container(
        padding: EdgeInsets.only(top:32 ,bottom:32 ,right:32,left:16),


       // alignment: Alignment.centerLeft,

        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(

              bottomRight:Radius.circular(32) ,
              topLeft:Radius.circular(32) ,
              topRight: Radius.circular(32),
            ),
            color: kPrimaryColor

        ),
        child:Text(message.message,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
