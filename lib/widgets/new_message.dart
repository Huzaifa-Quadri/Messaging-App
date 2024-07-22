  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';

  class NewMessage extends StatefulWidget {
    const NewMessage({super.key});

    @override
    State<NewMessage> createState() => _NewMessageState();
  }

  class _NewMessageState extends State<NewMessage> {
    final _messagecontroller = TextEditingController();

    @override
    void dispose(){
      _messagecontroller.dispose(); 
      super.dispose();
    }


    @override
    Widget build(BuildContext context) {


      void sendMessage()async{
        final sentmessage = _messagecontroller.text;

        if (sentmessage.trim().isEmpty) {
          return;
        }

        FocusScope.of(context).unfocus();
        print("Keyboard down");
        //Todo : Message Sent

        final user = FirebaseAuth.instance.currentUser!;   //* Provide us with info of currently logged in user
        final userinfo = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        print("data is sending");
        FirebaseFirestore.instance.collection('chat').add({
          'text' : sentmessage,
          'time' : Timestamp.now(),
          'user_id' : user.uid,
          'username' : userinfo.data()!['username'],
          'userimage' : userinfo.data()!['image_url']
        });
        print("data is sent");

        _messagecontroller.clear();  
      }

      return Padding(
        padding: const EdgeInsets.only(left: 10,right: 5, bottom: 14),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  label: Text('Send Message...'),
                ),
                textCapitalization: TextCapitalization.characters,
                enableSuggestions: true,
                controller: _messagecontroller,
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.send,
              color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      );
    }
  }
