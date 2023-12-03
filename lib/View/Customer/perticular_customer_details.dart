import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/main.dart';

class PerticularCustomerDetails extends StatelessWidget {
  const PerticularCustomerDetails({super.key, required this.indexNo});
  final int indexNo;

  @override
  Widget build(BuildContext context) {
    int index = indexNo;
    String name = '${homeController.customerDetails[index]['name']}';
    String area = '${homeController.customerDetails[index]['area']}';
    String address = '${homeController.customerDetails[index]['address']}';
    String phone = '${homeController.customerDetails[index]['phone']}';
    var code = homeController.customerDetails[index]['code'];

    double totalQuantity = 0.0;
    double totalAmount = 0.0;
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
            10.h.height,
            ...List.generate(
                4,
                (index) => Column(
                      children: [
                        15.h.height,
                        ExpansionTile(
                          collapsedBackgroundColor:
                              Colors.blue.withOpacity(0.8),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('2 Dec 2023'),
                              Text('bill no 72'),
                              Column(
                                children: [
                                  Text('amount : 2000 rs'),
                                  Text('pending : 500 rs'),
                                ],
                              ),
                            ],
                          ),
                          children: [
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(3), // Item Name
                                1: FlexColumnWidth(1), // Quantity
                                2: FlexColumnWidth(1), // Rate
                                3: FlexColumnWidth(
                                    1), // Total${data[index]['billNo']}
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
                                ...List.generate(
                                    homeController.jBFproducts.length, (indx) {
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
                        )
                      ],
                    )),
            100.h.height
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
