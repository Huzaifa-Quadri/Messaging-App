import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:messaging_app/widgets/message_bubble.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentlyloggedInUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
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
            padding: const EdgeInsets.only(
              bottom: 40,
              top: 15,
              right: 10,
              left: 10,
            ),
            reverse: true,
            itemCount: loadedmessages.length,
            itemBuilder: (context, index) {
              final chatMessage = loadedmessages[index].data();
              final nextChatMessage = index + 1 < loadedmessages.length
                  ? loadedmessages[index + 1].data()
                  : null;

              final currentUserId = chatMessage['user_id'];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['user_id'] : null;

              final isNextUserSame = currentUserId == nextMessageUserId;
              if (isNextUserSame) {

                return MessageBubble.next(
                  message: chatMessage['text'],
                  isMe: currentlyloggedInUser.uid == currentUserId,
                );

              } else {
                return MessageBubble.first(
                  userImage: chatMessage['userimage'],
                  username: chatMessage['username'],
                  message: chatMessage['text'],
                  isMe: currentlyloggedInUser.uid == currentUserId,
                );
              }
            });
      },
    );
  }
}
