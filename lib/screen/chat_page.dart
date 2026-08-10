import 'package:chat_app/widget/chatbubleForFrind.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/message.dart';
import '../widget/chat_buble.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _sendMessage(String email) {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    messages.add({
      kMessage: text,
      kCreatedAt: DateTime.now(),
      'id': email,
    });

    _textController.clear();
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final messagesList = snapshot.data!.docs
                .map((doc) => Message.fromJson(doc))
                .toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final message = messagesList[index];
                      return message.id == email
                          ? ChatBuble(message: message)
                          : Chatbubleforfrind(message: message);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (_) => _sendMessage(email),
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: kPrimaryColor),
                        onPressed: () => _sendMessage(email),
                      ),
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
            );
          }

          return const Center(child: Text('No messages yet.'));
        },
      ),
    );
  }
}