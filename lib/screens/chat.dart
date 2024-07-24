import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:messaging_app/screens/message_screen.dart';
import 'package:messaging_app/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupnotification() async{
    final req = FirebaseMessaging.instance;
    await req.requestPermission();

    final token = await req.getToken();
    print(token);
  }

  @override
  void initState() {
    super.initState();

    setupnotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon:const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: MessageScreen()
          ),
          NewMessage()
        ],
      )
      // body: const Center(
      //   child: Text("No Data here !!"),
      // ),
    );
  }
}
