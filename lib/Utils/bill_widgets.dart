import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/main.dart';

import 'text.dart';

Widget selectProduct() {
  return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.h.height,
                Row(
                  children: [
                    30.w.width,
                    Text('Select Product',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1, height: 10.h),
                Row(children: [
                  Obx(() => Checkbox(
                      value: homeController.puranaCheckBox.value,
                      onChanged: (value) {
                        homeController.puranaCheckBox.value =
                            !homeController.puranaCheckBox.value;
                      })),
                  Text('Purana', style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // 20.h.height,
                  ...List.generate(homeController.jBFproducts.length - 4,
                      (index) {
                    return InkWell(
                        onTap: () async {
                          homeController.productsSelectedSet
                              .add(homeController.jBFproducts[index + 4]);
                          homeController.addProductToTableFunc();
                          await homeController.newRateNquantityTecAdd();
                          Get.back();
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            child: Text(homeController.jBFproducts[index + 4],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp))));
                  })
                ]),
                50.h.height
              ])));
}

Widget padText(txt) {
  return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(padding: EdgeInsets.all(4.h), child: text10Black('$txt')));
}

Widget padCenterText(txt) {
  return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Center(
          child: Padding(
              padding: EdgeInsets.all(4.h), child: text12Black('$txt'))));
}

TableRow purana() {
  return !homeController.puranaCheckBox.value
      ? TableRow(children: [blank(), blank(), blank(), blank()])
      : TableRow(children: [
          padText(' Purana'),
          Text(''),
          Text(''),
          textFieldInt(controller: homeController.puranaTEC)
        ]);
}

Widget textFieldInt(
    {TextEditingController? controller,
    String? text,
    bool? showCursor = true,
    TextInputType? keyboardType}) {
  return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: SizedBox(
          height: 38.h,
          child: TextFormField(
              cursorHeight: 13.h,
              style: TextStyle(fontSize: 12.sp),
              showCursor: showCursor,
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: keyboardType ??
                  TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ],
              decoration: InputDecoration(
                  hintText: text,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0)))));
}
