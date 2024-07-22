import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Messages Yet..."),
          );
        }

        if (chatSnapshot.hasError) {
          return const Center(child: Text("Something went wrong..."));
        }

        final loadedmessages = chatSnapshot.data!.docs;
        return ListView.builder(
          itemCount: loadedmessages.length,
          itemBuilder: (context, index) => Text(loadedmessages[index].data()['text'])
        );
      },
    );
  }
}
