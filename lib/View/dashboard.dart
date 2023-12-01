import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbf/Utils/sizebox.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List bills = [
      {
        'shopName': 'Mahalaxmi',
        'billNo': '1',
        'billDate': DateTime.now(),
        'shopAddress':
            'Shop no : 12, Ganga society, Near balaji circle, shanti park, mira road(E), 401107',
        'items': [
          {'name': 'JBF - Sev (20 kg)', 'quantity': 2, 'rate': 20.0},
          {'name': 'JBF - Bundle (5 kg)', 'quantity': 3, 'rate': 15.0},
        ]
      },
      {
        'shopName': 'Shop name',
        'billNo': '2',
        'billDate': DateTime.now(),
        'shopAddress': '',
        'items': [
          {'name': 'JBF - Sev (20 kg)', 'quantity': 2, 'rate': 20.0},
          {'name': 'JBF - Bundle (5 kg)', 'quantity': 3, 'rate': 15.0},
        ]
      },
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset(
            'assets/icon.jpeg',
            height: 40,
          )),
      body: BillWidget(data: bills, index: 0),
    );
  }
}

class BillWidget extends StatelessWidget {
  const BillWidget({super.key, required this.data, required this.index});
  final List data;
  final int index;

  @override
  Widget build(BuildContext context) {
    // return
    double totalQuantity = 0.0;
    double totalAmount = 0.0;

    for (var item in data[index]['items']) {
      totalQuantity += item['quantity'];
      totalAmount += item['quantity'] * item['rate'];
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jay Bajrang Foods',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          8.h.height,
          Text(
              'Kashimira, Navin Gaothan, S No.82 Part 1, St.Xavier School Road, Mira Road(E) Maharashtra Thane - 401107 Mobile : 9699997596/8898200140'),
          8.h.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Date: ${data[index]['billDate'].toString().substring(0, 10)}'),
              Text('Bill No: ${data[index]['billNo']}'),
            ],
          ),
          8.h.height,
          Text('${data[index]['shopName']}'),
          8.h.height,
          Text('${data[index]['shopAddress']}'),
          8.h.height,
          Table(
            columnWidths: {
              0: FlexColumnWidth(3), // Item Name
              1: FlexColumnWidth(1), // Quantity
              2: FlexColumnWidth(1), // Rate
              3: FlexColumnWidth(1), // Total
            },
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  TableCell(child: Text(' Item Name')),
                  TableCell(child: Center(child: Text('Quantity'))),
                  TableCell(child: Center(child: Text('Rate'))),
                  TableCell(child: Center(child: Text('Total'))),
                ],
              ),
              ...List.generate(data[index]['items'].length, (indx) {
                String name = ' ${data[index]['items'][indx]['name']}';
                var quantity = data[index]['items'][indx]['quantity'] ?? 0;
                var rate = data[index]['items'][indx]['rate'] ?? 0;
                return TableRow(
                  children: [
                    TableCell(child: Text(name)),
                    TableCell(child: Center(child: Text('$quantity'))),
                    TableCell(child: Center(child: Text('$rate'))),
                    TableCell(
                      child: Center(child: Text('${quantity * rate}')),
                    ),
                  ],
                );
              }),
              TableRow(
                children: [
                  TableCell(child: Center(child: Text('Grand Total'))),
                  TableCell(
                      child: Center(child: Text('${totalQuantity.toInt()}'))),
                  TableCell(child: Center(child: Text(''))),
                  TableCell(child: Center(child: Text('$totalAmount'))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// class BillWidget extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//   }
// }
