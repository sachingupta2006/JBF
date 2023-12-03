import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Controller/home_controller.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Customer/perticular_customer_details.dart';
import 'package:jbf/View/bill.dart';

import 'Customer/add_customers.dart';

final selectedIndex = 2.obs;

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  var screens = [
    const AddCustomers(),
    const Bill(),
    const PerticularCustomerDetails(indexNo: 0),
    const Bill(),
  ];
  List name = ['Home', 'Visits', 'Share', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          bool exitBool = false;
          await Get.dialog(AlertDialog(
              contentPadding: EdgeInsets.all(25.w),
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
                          20.h.height,
                          CommonButton(
                            text: 'Yes, Exit',
                            ontap: () {
                              Get.back();
                              exitBool = true;
                            },
                          ),
                          20.h.height,
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
              padding: EdgeInsets.symmetric(vertical: 10.h),
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
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(active ? 0.2 : 0),
                borderRadius: BorderRadius.circular(25)),
            child: Row(children: [
              Icon(
                Icons.home,
                size: 30.h,
                color: active ? Colors.blue : Colors.black,
              ),
              // Image.asset(active ? pngBlue[index] : pngBlack[index], width: 20),
              active
                  ? Text('  ${name[index]}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold))
                  : 0.w.width
            ])));
  }
}
