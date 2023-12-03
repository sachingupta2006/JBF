import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Customer/perticular_customer_details.dart';
import 'package:jbf/main.dart';

import '../../Utils/common_button.dart';
import '../../Utils/custom_textformfield.dart';

class AddCustomers extends StatelessWidget {
  const AddCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Customer Details'), actions: [
          GestureDetector(
              onTap: () {
                Get.bottomSheet(addCustomer(context));
              },
              child: Icon(Icons.add)),
          20.w.width
        ]),
        body: Obx(
          () => ListView.separated(
              itemBuilder: (context, index) {
                String name =
                    '${homeController.customerDetails[index]['name']}';
                String area =
                    '${homeController.customerDetails[index]['area']}';
                String address =
                    '${homeController.customerDetails[index]['address']}';
                String phone =
                    '${homeController.customerDetails[index]['phone']}';
                var code = homeController.customerDetails[index]['code'];
                return ListTile(
                  onTap: () {
                    Get.to(() => PerticularCustomerDetails(
                          indexNo: index,
                        ));
                    print('object123');
                  },
                  onLongPress: () {
                    Get.dialog(AlertDialog(
                        contentPadding: EdgeInsets.all(25.w),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: Container(
                            color: Colors.white,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        20.h.height,
                                        CommonButton(
                                          size: 10.sp,
                                          text: 'Delete Customer Details',
                                          ontap: () {
                                            Get.back();
                                            Get.dialog(AlertDialog(
                                                content: Container(
                                                    color: Colors.white,
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                    'Are you sure you want to exit the app?'),
                                                                20.h.height,
                                                                CommonButton(
                                                                  size: 10.sp,
                                                                  text:
                                                                      'Yes, Exit',
                                                                  ontap: () {
                                                                    Get.back();
                                                                    homeController
                                                                        .customerDetails
                                                                        .removeAt(
                                                                            index);
                                                                  },
                                                                ),
                                                                20.h.height,
                                                                CommonButtonGrey(
                                                                    size: 10.sp,
                                                                    text:
                                                                        'No, Cancel',
                                                                    ontap: () =>
                                                                        Get.back())
                                                              ])
                                                        ]))));
                                          },
                                        ),
                                        20.h.height,
                                        CommonButtonGrey(
                                            size: 10.sp,
                                            text: 'Edit Customer Details',
                                            ontap: () {
                                              Get.back();

                                              Get.bottomSheet(editCustomer(
                                                  index,
                                                  name,
                                                  phone,
                                                  address,
                                                  area));
                                            })
                                      ])
                                ]))));
                  },
                  leading: Text('$code'),
                  trailing: Text('$area'),
                  title: Text(name),
                  subtitle: Text('$address'),
                );
              },
              separatorBuilder: (context, index) => 15.h.height,
              itemCount: homeController.customerDetails.length),
        ));
  }

  Widget addCustomer(context) {
    TextEditingController customerNameTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController addressTEC = TextEditingController();
    var location = ['Mira Bhayander', 'Mumbai', 'Virar'].obs;
    var selectedLoaction = 'Mira Bhayander'.obs;
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
                Text('Add New Customer'),
              ],
            ),
            Divider(color: Colors.black, thickness: 1, height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  20.h.height,
                  CustomTextFormField(keyboardType: TextInputType.name,
                      controller: customerNameTEC, hint: 'Customer Name'),
                  20.h.height,
                  CustomTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneTEC,
                      hint: 'Mobile number'),

                  20.h.height,
                  CustomTextFormField(controller: addressTEC, hint: 'Address'),
                  20.h.height,
                  Row(
                    children: [
                      Text('Choose area of shop :  '),
                      Obx(
                        () => DropdownButton(
                          elevation: 0,
                          items: location.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            selectedLoaction.value = newValue.toString();
                          },
                          value: selectedLoaction.value,
                        ),
                      ),
                    ],
                  ),
                  20.h.height,
                  // Obx(() {
                  // AddVisitController addVisitController =
                  //     Get.put(AddVisitController());
                  // return
                  //  addVisitController.isLoading.value
                  //     ? const Center(child: CircularProgressIndicator())
                  //     :
                  CommonButton(
                      ontap: () async {
                        String code = '${selectedLoaction.value.split(' ').map((e) {
                              if (e.isNotEmpty) {
                                return e[0].toUpperCase();
                              }
                              return '';
                            }).toList().join()} ${customerNameTEC.text.length < 3 ? customerNameTEC.text : customerNameTEC.text.substring(0, 3)}';
                        Map<String, String> newCustomerData = {
                          'name': customerNameTEC.text,
                          'address': addressTEC.text,
                          'area': selectedLoaction.value,
                          'phone': phoneTEC.text,
                          'code': code
                        };
                        homeController.customerDetails.add(newCustomerData);
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

  Widget editCustomer(
      int index, String name, String phone, String address, String area) {
    TextEditingController customerNameTEC = TextEditingController(text: name);
    TextEditingController phoneTEC = TextEditingController(text: phone);
    TextEditingController addressTEC = TextEditingController(text: address);
    var location = ['Mira Bhayander', 'Mumbai', 'Virar'].obs;
    var selectedLoaction = '$area'.obs;
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
                Text('Edit Customer Details'),
              ],
            ),
            Divider(color: Colors.black, thickness: 1, height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  20.h.height,
                  CustomTextFormField(
                      controller: customerNameTEC, hint: 'Customer Name'),
                  20.h.height,
                  CustomTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneTEC,
                      hint: 'Mobile number'),

                  20.h.height,
                  CustomTextFormField(controller: addressTEC, hint: 'Address'),
                  20.h.height,
                  Row(
                    children: [
                      Text('Choose area of shop :  '),
                      Obx(
                        () => DropdownButton(
                          elevation: 0,
                          items: location.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            selectedLoaction.value = newValue.toString();
                          },
                          value: selectedLoaction.value,
                        ),
                      ),
                    ],
                  ),
                  20.h.height,
                  // Obx(() {
                  // AddVisitController addVisitController =
                  //     Get.put(AddVisitController());
                  // return
                  //  addVisitController.isLoading.value
                  //     ? const Center(child: CircularProgressIndicator())
                  //     :
                  CommonButton(
                      ontap: () async {
                        await homeController.editCustomerDetails(
                            index,
                            customerNameTEC.text,
                            addressTEC.text,
                            selectedLoaction.value,
                            phoneTEC.text);
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
