import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

final firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessagesStream(),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      //Implement send functionality.
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
   const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.Collection('messages').snapshots(),
      builder: (context:snapshot){
    if(!snapshot.hasData){
    return const Center(
    child: CircularProgressIndicator(
    backgroundColor:Colors.lightBlueAccent,
    ),
    );
    }
    final messeges= snapshot.data.documents.reversed;
    List<MessageBubble> messageBubbles=[];
    for (var message in messages){
    final messageText= message.data['text'];
    final messageSender= message.data['sender'];
    final currentUser =loggedInUser.email;

    final messageBubble=MessageBubble(
    sender:MessageSender,
    text:messageText,
    isMe: currentUser==messageSender,

    );
    messageBubbles.add(messageBubble);
    }
    return Expanded(
    child: ListView(
    reverse: true,
    padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
    children:messageBubbles,
    ),
    );
    },
    );
  }
}


class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, this.sender, this.text, this.isMe})
      : super(key: key);
  final String sender;
  final String text;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment
            .start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),

          ),
          Material(
            borderRadius: isMe ? const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            )
                : const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0),

            ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 20.0,),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),),
            ),


          )
        ],
      ),

    );
  }
}















