import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/main.dart';

class PerticularCustomerDetails extends StatelessWidget {
  const PerticularCustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    String name = '${homeController.customerDetails[index]['name']}';
    String area = '${homeController.customerDetails[index]['area']}';
    String address = '${homeController.customerDetails[index]['address']}';
    String phone = '${homeController.customerDetails[index]['phone']}';
    var code = homeController.customerDetails[index]['code'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Perticular Customer Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Text('$code'),
              trailing: Text('$area'),
              title: Text(name),
              subtitle: Text('$address'),
            ),
            Text(phone),
            100.h.height
          ],
        ),
      ),
    );
  }
}
