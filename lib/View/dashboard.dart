import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Customer/perticular_customer_details.dart';
import 'package:jbf/View/search_customer.dart';
import 'package:jbf/main.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // List bills = [
    //   {
    //     'shopName': 'Mahalaxmi',
    //     'billNo': '1',
    //     'billDate': DateTime.now(),
    //     'shopAddress':
    //         'Shop no : 12, Ganga society, Near balaji circle, shanti park, mira road(E), 401107',
    //     'items': [
    //       {'name': 'JBF - Sev (20 kg)', 'quantity': 2, 'rate': 20.0},
    //       {'name': 'JBF - Bundle (5 kg)', 'quantity': 3, 'rate': 15.0},
    //     ]
    //   },
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              Get.to(() => PerticularCustomerDetails(indexNo: homeController.customerIndex.value));
            },
            child: Text(
              'View Previous Bills',
              style: TextStyle(color: Colors.white),
            )),
        20.w.width
      ], title: Text('Bill')),
      body: Obx(() {
        double totalQuantity = 0.0;
        double totalAmount = 0.0;
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
                        ...List.generate(homeController.jBFproducts.length,
                            (indx) {
                          return TableRow(
                            children: [
                              padText(homeController.jBFproducts[indx]),
                              padCenterText('5'),
                              padCenterText('70'),
                              padCenterText('350'),
                            ],
                          );
                        }),
                        TableRow(
                          children: [
                            padCenterText('Grand Total'),
                            padCenterText('${totalQuantity.toInt()}'),
                            Text(''),
                            padCenterText('$totalAmount'),
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
//     // for (var item in data[index]['items']) {
//     //   totalQuantity += item['quantity'];
//     //   totalAmount += item['quantity'] * item['rate'];
//     // }
