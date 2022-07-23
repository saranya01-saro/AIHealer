import 'package:flash_chat/recomscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  var url = "https://mysterious-oasis-43260.herokuapp.com/emotion";
  Future<dynamic> getData(review) async {
    String requesturl = '$url?Query=$review';
    http.Response response = await http.get(requesturl);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      sentiment = decodedData.toString();
      Future<dynamic> getData(review) async {
        String requesturl = '$url?Query="$review"';
        http.Response response = await http.get(requesturl);
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          print(decodedData);
          sentiment = decodedData.toString();
          messageTextController.clear();
        } else {
          print(response.statusCode);
          throw 'Problem with request';
        }
      }

      messageTextController.clear();
    } else {
      print(response.statusCode);
      throw 'Problem with request';
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      } else {
        print('some error');
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
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
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //messagesStream();
              }),
        ],
        title: Text('DEAR DIARY'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_healer.jpg"), fit: BoxFit.cover)),
        //child: Container()

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //child: Row
            MessagesStream(),

            Container(
              decoration: kMessageContainerDecoration,
              /*
              */

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      msg = messageText;
                      await getData(msg);
                      await Navigator.pushNamed(context, Recomscreen.id);
                      messageTextController.clear();

                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'created_at': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Submit!',
                      // style: kSendButtonTextStyle,
                      style: TextStyle(color: Colors.white),
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('created_at').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message.data['text'];
          final messagesender = message.data['sender'];
          final currentSender = loggedInUser.email;
          if (messagesender == currentSender) {
            final messageBubble = MessageBubble(
              sender: messagesender,
              text: messageText,
              isMe: currentSender == messagesender ? true : false,
            );
            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.created_at});
  final String sender;
  final String text;
  final bool isMe;
  final Timestamp created_at;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment:
        // isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          //Text(
          //convertTimeStamp('created_at'),

          // style: TextStyle(fontSize: 12.0, color: Colors.black54),
          //),
          Material(
            elevation: 10.0,
            borderRadius: isMe
                ? BorderRadius.only(
                    //topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(20.0),
                    // bottomRight: Radius.circular(30.0)
                    topRight: Radius.circular(20.0))
                : BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    //bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(20.0)
                    //topLeft: Radius.circular(30.0),
                    ),
            color: isMe ? Colors.deepOrangeAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } // widget
} //class

String convertTimeStamp(timeStamp) {
//Pass the epoch server time and the it will format it for you
  String formatted = formatTime(timeStamp).toString();
  return formatted;
}
