import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/main.dart';

class AllBills extends StatelessWidget {
  const AllBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Bills'), actions: [Text('\nDecember'),15.w.width],),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          itemBuilder: (context, index) {
            return ExpansionTile(
                shape: Border.all(color: Colors.black),
                collapsedBackgroundColor: Colors.blue.withOpacity(0.8),
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Bill No ${index + 1}'),
                    Text('2 Dec 2023'),
                  ],
                ),
                trailing:  Column(  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('amount : 2000 rs'),
                        Text('pending : 500 rs'),
                      ],
                    ),
                title: Text('Shubham Gupta'),
                children: [
                  Table(
                      columnWidths: {
                        0: FlexColumnWidth(2.5), // Item Name
                        1: FlexColumnWidth(1), // Quantity
                        2: FlexColumnWidth(1), // Rate
                        3: FlexColumnWidth(
                            1.5), // Total${data[index]['billNo']}
                      },
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          padText(' Item Name'),
                          padCenterText('(KG)'),
                          padCenterText('Rate'),
                          padCenterText('Total')
                        ]),
                        ...List.generate(5, (indx) {
                          return TableRow(children: [
                            padText(homeController.jBFproducts[indx]),
                            padCenterText('5'),
                            padCenterText('70'),
                            padCenterText('350')
                          ]);
                        }),
                        TableRow(children: [
                          padCenterText('Grand Total'),
                          padCenterText('20'),
                          Text(''),
                          padCenterText('2000')
                        ])
                      ])
                ]);
          },
          separatorBuilder: (context, index) => 10.h.height,
          itemCount: 5),
    );
  }

  Widget padText(txt) {
    return TableCell(
        child: Padding(padding: const EdgeInsets.all(8), child: Text('$txt')));
  }

  Widget padCenterText(txt) {
    return TableCell(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(child: Text('$txt'))));
  }
}
