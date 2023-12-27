import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/Utils/text.dart';
import 'package:jbf/View/Bottom%20Bar/chat/message_1.dart';

class ChatsCC extends StatelessWidget {
  const ChatsCC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Scrollbar(thickness: 20.w,
        child: ListView.builder(
          reverse: true,
          itemCount: m1['messages'].length,
          itemBuilder: (context, index) {
            var message = m1['messages'][index];
            String senderName = message['sender_name'].length < 10
                ? message['sender_name'].toString()
                : message['sender_name'].toString().substring(0, 10);
            var dd = DateTime.fromMillisecondsSinceEpoch(message['timestamp_ms']);
            String time =
                '${dd.day}/${dd.month}/${dd.year} - ${dd.hour}:${dd.minute}:${dd.second}';
        
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [text12BlackBold(senderName), text12Black(time)]),
                  5.h.height,
                  text12Black(message['content'] ?? '1 time photo bheja'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
