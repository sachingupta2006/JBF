import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/custom_textformfield.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/main.dart';

class SearchCustomer extends StatelessWidget {
  const SearchCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: CustomTextFormField(),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            String name = '${homeController.customerDetails[index]['name']}';
            String area = '${homeController.customerDetails[index]['area']}';
            String address =
                '${homeController.customerDetails[index]['address']}';
            var code = homeController.customerDetails[index]['code'];
            return GestureDetector(
              onTap: () {
                homeController.customerIndex.value = index;
                Get.back();
                print(homeController.customerIndex.value);
              },
              child: ListTile(
                leading: Text('$code'),
                trailing: Text('$area'),
                title: Text(name),
                subtitle: Text('$address'),
              ),
            );
          },
          separatorBuilder: (context, index) => 10.h.height,
          itemCount: homeController.customerDetails.length),
    );
  }
}
