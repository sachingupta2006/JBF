import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/bill_functions.dart';
import 'package:jbf/Utils/bill_widgets.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/Utils/text.dart';
import 'package:jbf/View/Bottom%20Bar/Bill/new_bill.dart';
import 'package:jbf/View/Bottom%20Bar/Customer/perticular_customer_details.dart';
import 'package:jbf/View/Bottom%20Bar/Bill/search_customer.dart';
import 'package:jbf/main.dart';
import 'package:screenshot/screenshot.dart';

Uint8List imageFile = Uint8List(0);
Uint8List pdfFile = Uint8List(0);
var isSaving = false.obs;

ScreenshotController screenshotController = ScreenshotController();

class Bill extends StatelessWidget {
  const Bill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(Icons.menu)),
            actions: [
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
            ],
            title: Text('Bill')),
        body: Obx(() {
          var cDetails = homeController
              .customerDetails[homeController.customerIndex.value];
          var pdfFileName =
              'billNo ${cDetails['name']} ${cDetails['code']} ${DateTime.now().toString().substring(0, 16)}';

          return SingleChildScrollView(
              child: Column(children: [
            Screenshot(
                controller: screenshotController,
                child: AspectRatio(
                    aspectRatio: 1 / 1.41,
                    child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(children: [
                          Expanded(
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        companyandCustomerDetails(
                                            cDetails, context),
                                        billTable()
                                      ]))),
                          totalTable(),
                          termsAndConditions(context)
                        ])))),
            20.h.height,
            saveAndContinue(pdfFileName),
            100.h.height
          ]));
        }));
  }

  Widget billTable() {
    return Table(
        columnWidths: {
          0: FlexColumnWidth(2.5), // Item Name
          1: FlexColumnWidth(1), // Quantity
          2: FlexColumnWidth(1), // Rate
          3: FlexColumnWidth(1.3), // Total${data[index]['billNo']}
        },
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              padText(' Item Name'),
              padCenterText('(KG)'),
              padCenterText('Rate'),
              padCenterText('Total'),
            ],
          ),
          ...List.generate(4, (indx) {
            var products = homeController.jBFproducts[indx];
            var rateCont = homeController.existingRateTEC[indx];
            var qCont = homeController.existingQuantityTEC[indx];
            double a = rateCont.text == '' ? 0 : double.parse(rateCont.text);
            double b = qCont.text == '' ? 0 : double.parse(qCont.text);
            String totalAmount = '${a * b}';
            return TableRow(
              children: [
                padText(products),
                textFieldInt(controller: qCont),
                textFieldInt(controller: rateCont),
                padCenterText(totalAmount == '0.0' || totalAmount == '0'
                    ? ''
                    : totalAmount),
                // textFieldInt(
                //     showCursor: false,
                //     keyboardType: TextInputType.none,
                //     text: totalAmount == '0.0' || totalAmount == '0'
                //         ? ''
                //         : totalAmount)
              ],
            );
          }),
          ...List.generate(homeController.selectedProductList.length, (indx) {
            var rateCont = homeController.newRateTEC[indx];
            var qCont = homeController.newQuantityTEC[indx];
            double a = rateCont.text == '' ? 0 : double.parse(rateCont.text);
            double b = qCont.text == '' ? 0 : double.parse(qCont.text);
            String totalAmount = '${a * b}';
            return TableRow(
              children: [
                padText(homeController.selectedProductList[indx]),
                textFieldInt(controller: qCont),
                textFieldInt(controller: rateCont),
                padCenterText(totalAmount == '0.0' || totalAmount == '0'
                    ? ''
                    : totalAmount)
                // textFieldInt(
                //     showCursor: false,
                //     keyboardType: TextInputType.none,
                //     text: totalAmount == '0.0' || totalAmount == '0'
                //         ? ''
                //         : totalAmount)
              ],
            );
          }),
          purana(),
        ]); 
  }

  Widget totalTable() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(2.5), // Item Name
          1: FlexColumnWidth(1), // Quantity
          2: FlexColumnWidth(1), // Rate
          3: FlexColumnWidth(1.3), // Total${data[index]['billNo']}
        },
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            GestureDetector(
                onTap: () => Get.bottomSheet(selectProduct()),
                child: Container(child: Text(''))),
            padCenterText(''),
            textFieldInt(
                showCursor: false, keyboardType: TextInputType.none, text: ''),
            padCenterText('')
          ]),
          TableRow(children: [
            padCenterText('Grand Total'),
            padCenterText('${homeController.grandTotalQuantity()}'),
            padCenterText(''),
            padCenterText('${homeController.grandTotalAll()}')
          ])
        ],
      ),
    );
  }

  Widget companyandCustomerDetails(cDetails, context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        text15BlackBold('Jay Bajrang Foods'),
        text15Black('Date: ${DateTime.now().toString().substring(0, 10)}')
      ]),
      text12Black('Kashimira || Mobile : 9699997596 / 8898200140'),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        text12BlackBold('${cDetails['area']}'),
        text12BlackBold('Bill No: 1')
      ]),
      SizedBox(
          // height: 18.h,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text12Black('Salesman Name :  '),
        Obx(() => DropdownButton(
            padding: EdgeInsets.zero,
            iconSize: 0,
            elevation: 0,
            underline: 0.0.height,
            items: homeController.salesmanNames
                .map((value) => DropdownMenuItem(
                    alignment: Alignment.topLeft,
                    value: value,
                    child: text12BlackBold(value)))
                .toList(),
            onChanged: (newValue) =>
                homeController.selectedSalesman.value = newValue.toString(),
            value: homeController.selectedSalesman.value))
      ])),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: GestureDetector(
                    onTap: () => Get.to(() => SearchCustomer()),
                    child: text15BlackBoldCenter('${cDetails['name']}'))),
            text12Black('${cDetails['phone']}')
          ]),
      text12Black('${cDetails['address']}'),
    ]);
  }

  Widget termsAndConditions(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
                padding: EdgeInsets.only(left: 6.w),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.black))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: text10Black('TERMS AND CONDITIONS')),
                      text8Black('1) MODE OF PAYMENT CASH ONLY'),
                      text8Black(
                          '2) GOOD ONCE SOLD ARE NEITHER RETURNABLE NOR EXCHANGABLE')
                    ]))),
        Container(
          padding: EdgeInsets.only(top: 2.h),
          width: MediaQuery.sizeOf(context).width / 3,
          // decoration: BoxDecoration(
          // border: Border(top: BorderSide(color: Colors.black))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text6Black('FOR JAY BAJRANG FOODS'),
              text6Black('AUTHORIZED SIGNATURE')
            ],
          ),
        )
      ],
    );
  }

  Widget saveAndContinue(String pdfFileName) {
    return Obx(() => isSaving.value
        ? const Center(child: CircularProgressIndicator())
        : CommonButton(
            hPadding: 8.w,
            ontap: () async {
              isSaving.value = true;
              await screenshotController.capture(pixelRatio: 3.0).then((value) {
                imageFile = value!;
              });
              pdfFile = await imageToPdf(imageFile);
              await saveUint8ListToFile(pdfFile, '$pdfFileName.pdf');
              isSaving.value = false;

              Get.snackbar('Success', 'pdf saved to local storage');
              Get.to(() => NewBill(
                  image: imageFile, pdfPath: homeController.newBillPath));
            },
            text: 'Save and Continue'));
  }
}
