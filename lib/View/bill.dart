import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Customer/perticular_customer_details.dart';
import 'package:jbf/View/search_customer.dart';
import 'package:jbf/main.dart';

class Bill extends StatelessWidget {
  const Bill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              Get.to(() => PerticularCustomerDetails(
                  indexNo: homeController.customerIndex.value));
            },
            child: Text(
              'View Previous Bills',
              style: TextStyle(color: Colors.white),
            )),
        20.w.width
      ], title: Text('Bill')),
      body: Obx(() {
        var cDetails =
            homeController.customerDetails[homeController.customerIndex.value];

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jay Bajrang Foods',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            'Date: ${DateTime.now().toString().substring(0, 10)}'),
                      ],
                    ),
                    8.h.height,
                    Text(
                        'Kashimira, Navin Gaothan, S No.82 Part 1, St.Xavier School Road, Mira Road(E) Maharashtra Thane - 401107 Mobile : 9699997596/8898200140'),
                    8.h.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${cDetails['area']}'),
                        Text('Bill No: 1'),
                      ],
                    ),
                    8.h.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => SearchCustomer());
                                },
                                child: Text(
                                  '${cDetails['name']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.h,
                                      color: Colors.black),
                                ))),
                        Text('${cDetails['phone']}'),
                      ],
                    ),
                    8.h.height,
                    Text('${cDetails['address']}'),
                    8.h.height,
                    Table(
                      columnWidths: {
                        0: FlexColumnWidth(3), // Item Name
                        1: FlexColumnWidth(1), // Quantity
                        2: FlexColumnWidth(1), // Rate
                        3: FlexColumnWidth(1), // Total${data[index]['billNo']}
                      },
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            padText(' Item Name'),
                            padCenterText('Quantity'),
                            padCenterText('Rate'),
                            padCenterText('Total'),
                          ],
                        ),
                        ...List.generate(4, (indx) {
                          var products = homeController.jBFproducts[indx];
                          var rateCont = homeController.existingRateTEC[indx];
                          var qCont = homeController.existingQuantityTEC[indx];
                          double a = rateCont.text == ''
                              ? 0
                              : double.parse(rateCont.text);
                          double b =
                              qCont.text == '' ? 0 : double.parse(qCont.text);
                          String totalAmount = '${a * b}';
                          return TableRow(
                            children: [
                              padText(products),
                              textFieldInt(controller: qCont),
                              textFieldInt(controller: rateCont),
                              textFieldInt(
                                  showCursor: false,
                                  keyboardType: TextInputType.none,
                                  text: totalAmount == '0.0' ? '' : totalAmount)
                            ],
                          );
                        }),
                        ...List.generate(
                            homeController.selectedProductList.length, (indx) {
                          var rateCont = homeController.newRateTEC[indx];
                          var qCont = homeController.newQuantityTEC[indx];
                          double a = rateCont.text == ''
                              ? 0
                              : double.parse(rateCont.text);
                          double b =
                              qCont.text == '' ? 0 : double.parse(qCont.text);
                          String totalAmount = '${a * b}';
                          return TableRow(
                            children: [
                              padText(homeController.selectedProductList[indx]),
                              textFieldInt(controller: qCont),
                              textFieldInt(controller: rateCont),
                              textFieldInt(
                                  showCursor: false,
                                  keyboardType: TextInputType.none,
                                  text: totalAmount == '0.0' ? '' : totalAmount)
                            ],
                          );
                        }),
                        TableRow(children: [
                          GestureDetector(
                              onTap: () => Get.bottomSheet(selectProduct()),
                              child: Container(
                                child: Text('\n\n'),
                              )),
                          padCenterText(''),
                          textFieldInt(
                              showCursor: false,
                              keyboardType: TextInputType.none,
                              text: ''),
                          padCenterText('')
                        ]),
                        TableRow(
                          children: [
                            padCenterText('Grand Total'),
                            textFieldInt(
                                showCursor: false,
                                keyboardType: TextInputType.none,
                                text: homeController.grandTotalQuantity()),
                            padCenterText(''),
                            textFieldInt(
                                showCursor: false,
                                keyboardType: TextInputType.none,
                                text: homeController.grandTotalAll())
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              100.h.height
            ],
          ),
        );
      }),
    );
  }

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
            20.h.height,
            Row(
              children: [
                30.w.width,
                Text('Select Product'),
              ],
            ),
            Divider(color: Colors.black, thickness: 1, height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.h.height,
                  ...List.generate(homeController.jBFproducts.length - 5,
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
                                fontWeight: FontWeight.bold, fontSize: 20.sp)),
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget padText(txt) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Text('$txt'),
    ));
  }

  Widget padCenterText(txt) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(child: Text('$txt')),
      ),
    );
  }
}

Widget textFieldInt(
    {TextEditingController? controller,
    String? text,
    bool? showCursor = true,
    TextInputType? keyboardType}) {
  return TableCell(
    child: TextFormField(
      showCursor: showCursor,
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType:
          keyboardType ?? TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      ],
      decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
    ),
  );
}

//     // for (var item in data[index]['items']) {
//     //   totalQuantity += item['quantity'];
//     //   totalAmount += item['quantity'] * item['rate'];
//     // }
