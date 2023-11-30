import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jbf/Controller/home_controller.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/dashboard.dart';

import 'add_customers.dart';

final selectedIndex = 0.obs;

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  var screens = [
    const AddCustomers(),
    const Dashboard(),
    const Dashboard(),
    const Dashboard(),
  ];
  List name = ['Home', 'Visits', 'Share', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          bool exitBool = false;
          await Get.dialog(AlertDialog(
              contentPadding: EdgeInsets.all(25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                  color: Colors.white,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          Text('Are you sure you want to exit the app?'),
                          20.0.height,
                          CommonButton(
                            text: 'Yes, Exit',
                            ontap: () {
                              Get.back();
                              exitBool = true;
                            },
                          ),
                          20.0.height,
                          CommonButtonGrey(
                              text: 'No, Cancel', ontap: () => Get.back())
                        ])
                      ]))));
          return exitBool;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: screens[selectedIndex.value],
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -8),
                    blurRadius: 8)
              ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      screens.length, (index) => activeIcon(index))),
            )),
      ),
    );
  }

  Widget activeIcon(int index) {
    bool active = false;
    HomeController homeController = Get.put(HomeController());
    if (selectedIndex.value == index) {
      active = true;
    }
    return InkWell(
        onTap: () {
          selectedIndex.value = index;
          homeController.edit.value = false;
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(active ? 0.2 : 0),
                borderRadius: BorderRadius.circular(25)),
            child: Row(children: [
              Icon(Icons.home,size: 30,color: active ? Colors.blue : Colors.black,),
              // Image.asset(active ? pngBlue[index] : pngBlack[index], width: 20),
              active
                  ? Text('  ${name[index]}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                  : 0.0.width
            ])));
  }
}
