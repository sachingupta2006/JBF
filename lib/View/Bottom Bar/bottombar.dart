import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Bottom%20Bar/All%20Bills/all_bills.dart';
import 'package:jbf/View/Bottom%20Bar/Bill/bill.dart';
import 'package:jbf/View/Bottom%20Bar/side_menu.dart';
import 'Customer/add_customers.dart';
import 'Products/add_products.dart';

final selectedIndex = 1.obs;

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
    AllBills(),
    const AddProducts(),
  ];
  List name = ['Customer', 'Bill', 'All Bills', 'Products'];

  List bottomIcons = [
    Icons.person_add_alt,
    Icons.note_add_outlined,
    Icons.notes,
    Icons.production_quantity_limits
  ];

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
            drawer: drawer(),
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: screens[selectedIndex.value],
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h),
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

  Widget drawer() {
    return drawerCustom(context);
  }

  Widget activeIcon(int index) {
    bool active = false;
    if (selectedIndex.value == index) {
      active = true;
    }
    return InkWell(
        onTap: () {
          selectedIndex.value = index;
          setState(() {});
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(active ? 0.2 : 0),
                borderRadius: BorderRadius.circular(25)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                bottomIcons[index],
                size: 20.sp,
                color: active ? Colors.blue : Colors.black,
              ),
              // Image.asset(active ? pngBlue[index] : pngBlack[index], width: 20),
              Text('${name[index]}',
                  style: TextStyle(
                      color: active ? Colors.blue : Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold))
              // : 0.w.width
            ])));
  }
}
