import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jbf/View/Side%20Menu/chat.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'user_model.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = [
      UserModel(
        uid: '0',
        name: 'Harry',
        email: 'test@test.test',
        image: 'https://i.pravatar.cc/150?img=0',
        isOnline: true,
        lastActive: DateTime.now(),
      ),
      UserModel(
        uid: '1',
        name: 'Sonal',
        email: 'test@test.test',
        image: 'https://i.pravatar.cc/150?img=1',
        isOnline: false,
        lastActive: DateTime.now(),
      ),
      UserModel(
        uid: '2',
        name: 'Ahmed',
        email: 'test@test.test',
        image: 'https://i.pravatar.cc/150?img=2',
        isOnline: true,
        lastActive: DateTime.now(),
      ),
      UserModel(
        uid: '3',
        name: 'Pankaj',
        email: 'test@test.test',
        image: 'https://i.pravatar.cc/150?img=3',
        isOnline: false,
        lastActive: DateTime.now(),
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => ChatPage(
                    userId: userData[index].uid,
                    name: userData[index].name,
                    isOnline: userData[index].isOnline));
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(userData[index].image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CircleAvatar(
                        backgroundColor: userData[index].isOnline
                            ? Colors.green
                            : Colors.grey,
                        radius: 5,
                      ),
                    ),
                  ],
                ),
                title: Text(
                  userData[index].name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Last Active : ${timeago.format(userData[index].lastActive)}',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
