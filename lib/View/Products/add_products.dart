import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/custom_textformfield.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/main.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Products Details'), actions: [
          GestureDetector(
              onTap: () {
                Get.bottomSheet(addProduct(context));
              },
              child: Icon(Icons.add)),
          20.w.width
        ]),
        body:
            // Obx(() =>
            ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: InkWell(
                        onLongPress: () {
                          Get.dialog(longPressWidget(index));
                        },
                        child: Text(homeController.jBFproducts[index])),
                  );
                },
                itemCount: homeController.jBFproducts.length)
        // ),
        );
  }

  AlertDialog longPressWidget(index) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(25.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Container(
            color: Colors.white,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    20.h.height,
                    CommonButton(
                      size: 10.sp,
                      text: 'Delete Product Details',
                      ontap: () {
                        Get.back();
                        Get.dialog(AlertDialog(
                            content: Container(
                                color: Colors.white,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'Are you sure you want to delete the product?'),
                                            20.h.height,
                                            CommonButton(
                                              size: 10.sp,
                                              text: 'Yes, Delete',
                                              ontap: () {
                                                Get.back();
                                                homeController.jBFproducts
                                                    .removeAt(index);
                                              },
                                            ),
                                            20.h.height,
                                            CommonButtonGrey(
                                                size: 10.sp,
                                                text: 'No, Cancel',
                                                ontap: () => Get.back())
                                          ])
                                    ]))));
                      },
                    ),
                    20.h.height,
                    CommonButtonGrey(
                        size: 10.sp,
                        text: 'Edit Product Details',
                        ontap: () {
                          Get.back();
                          Get.bottomSheet(editCustomer(
                              index, homeController.jBFproducts[index]));
                        })
                  ])
                ])));
  }

  Widget addProduct(context) {
    TextEditingController productNameTEC = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.height,
            Row(
              children: [
                30.w.width,
                Text('Add New Product'),
              ],
            ),
            Divider(color: Colors.black, thickness: 1, height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  20.h.height,
                  CustomTextFormField(
                      keyboardType: TextInputType.name,
                      controller: productNameTEC,
                      hint: 'Product Name'),
                  20.h.height,
                  CommonButton(
                      ontap: () async {
                        homeController.jBFproducts.add(productNameTEC.text);
                        Get.back();
                      },
                      text: 'Submit'),
                  // }),
                  20.h.height,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget editCustomer(int index, String name) {
    TextEditingController productNameTEC = TextEditingController(text: name);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.height,
            Row(
              children: [
                30.w.width,
                Text('Edit Product Details'),
              ],
            ),
            Divider(color: Colors.black, thickness: 1, height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  20.h.height,
                  CustomTextFormField(
                      controller: productNameTEC, hint: 'Product Name'),
                  20.h.height,
                  CommonButton(
                      ontap: () {
                        homeController.jBFproducts[index] = productNameTEC.text;
                        Get.back();
                      },
                      text: 'Save Changes'),
                  // }),
                  20.h.height,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
