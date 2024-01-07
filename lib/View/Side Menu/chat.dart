import 'package:flutter/material.dart';
import 'package:jbf/Utils/text.dart';

import 'message_bubble.dart';
import 'message_model.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(
      {super.key,
      required this.userId,
      required this.name,
      required this.isOnline});
  final String userId;
  final String name;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final messages = [
      Message(
          senderId: '2',
          receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          content: 'Hello',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          receiverId: '2',
          content: 'How are you?',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: '2',
          receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          content: 'Fine',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          receiverId: '2',
          content: 'What are you doing?',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: '2',
          receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          content: 'Nothing',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          receiverId: '2',
          content: 'Can you help me?',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: '2',
          receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          content:
              'https://images.unsplash.com/photo-1669992755631-3c46eccbeb7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
          sentTime: DateTime.now(),
          messageType: MessageType.image),
      Message(
          senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          receiverId: '2',
          content: 'Thank you',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
        senderId: '2',
        receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
        content: 'You are welcome',
        sentTime: DateTime.now(),
        messageType: MessageType.text,
      ),
      Message(
          senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          receiverId: '2',
          content: 'Bye',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: '2',
          receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          content: 'Bye',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          receiverId: '2',
          content: 'See you later',
          sentTime: DateTime.now(),
          messageType: MessageType.text),
      Message(
          senderId: '2',
          receiverId: 'gNfEHSQZ5ZUcY6JG5AarK8O0SVw1',
          content: 'See you later',
          sentTime: DateTime.now(),
          messageType: MessageType.text)
    ];
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
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          )),
      bottomNavigationBar: Row(
        children: [
          Expanded(child: TextFormField()),
          ElevatedButton(onPressed: () {}, child: text15BlackBold('Send'))
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 20),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final isTextMessage = messages[index].messageType == MessageType.text;
          final isMe = messages[index].receiverId != messages[index].senderId;

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
      ),
    );
  }
}
