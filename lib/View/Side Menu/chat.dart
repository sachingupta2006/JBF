import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jbf/Utils/text.dart';

import 'message_bubble.dart';
import 'message_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.recieverId,
      required this.name,
      required this.isOnline,
      required this.senderId});
  final String recieverId;
  final String senderId;
  final String name;
  final bool isOnline;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> _chatCollection =
      FirebaseFirestore.instance.collection('chats');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              CircleAvatar(
                // backgroundImage: NetworkImage(userData.image),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      color: widget.isOnline ? Colors.green : Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          )),
      bottomNavigationBar: Row(
        children: [
          Expanded(child: TextFormField(controller: _messageController)),
          ElevatedButton(
              onPressed: () {
                _sendMessage(widget.recieverId, _messageController.text);
              },
              child: text15BlackBold('Send'))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _chatCollection
              .doc(_getChatRoomId(widget.recieverId, widget.recieverId))
              .collection('messages')
              .orderBy('sentTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var messages = snapshot.data!.docs
                .map((doc) =>
                    Message.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              reverse: true,
              padding: EdgeInsets.only(bottom: 20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isTextMessage =
                    messages[index].messageType == MessageType.text;
                final isMe =
                   messages[index].senderId != widget.recieverId;

                return isTextMessage
                    ? MessageBubble(
                        isMe: isMe,
                        message: messages[index],
                        isImage: false,
                      )
                    : MessageBubble(
                        isMe: isMe,
                        message: messages[index],
                        isImage: true,
                      );
              },
            );
          }),
    );
  }

  void _sendMessage(String receiverUid, String message) {
    if (message.trim().isNotEmpty) {
      _chatCollection
          .doc(_getChatRoomId(widget.recieverId, receiverUid))
          .collection('messages')
          .add({
            'senderId': widget.recieverId,
            'receiverId': receiverUid,
            'content': message,
            'sentTime': FieldValue.serverTimestamp(),
            'messageType': MessageType.text.toJson(),
          })
          .then((value) => _messageController.clear())
          .catchError((error) => print('Failed to send message: $error'));
    }
  }

  String _getChatRoomId(String senderId, String recieverId) {
    List<String> ids = [senderId, recieverId];
    ids.sort();
    return ids.join('_');
  }
}

    // final messages = [
    //   Message(
    //       senderId: '2',
    //       receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       content: 'Hello',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       receiverId: '2',
    //       content: 'How are you?',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: '2',
    //       receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       content: 'Fine',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       receiverId: '2',
    //       content: 'What are you doing?',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: '2',
    //       receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       content: 'Nothing',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       receiverId: '2',
    //       content: 'Can you help me?',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: '2',
    //       receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       content:
    //           'https://images.unsplash.com/photo-1669992755631-3c46eccbeb7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.image),
    //   Message(
    //       senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       receiverId: '2',
    //       content: 'Thank you',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //     senderId: '2',
    //     receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //     content: 'You are welcome',
    //     sentTime: DateTime.now(),
    //     messageType: MessageType.text,
    //   ),
    //   Message(
    //       senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       receiverId: '2',
    //       content: 'Bye',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: '2',
    //       receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       content: 'Bye',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       receiverId: '2',
    //       content: 'See you later',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text),
    //   Message(
    //       senderId: '2',
    //       receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
    //       content: 'See you later',
    //       sentTime: DateTime.now(),
    //       messageType: MessageType.text)
    // ];