import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/Utils/text.dart';
import 'package:jbf/View/Bottom%20Bar/Bill/new_bill.dart';
import 'package:jbf/View/Bottom%20Bar/Customer/perticular_customer_details.dart';
import 'package:jbf/View/Bottom%20Bar/Bill/search_customer.dart';
import 'package:jbf/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;

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

          return SingleChildScrollView(
              child: Column(children: [
            Screenshot(
                controller: screenshotController,
                child: AspectRatio(
                    aspectRatio: 1 / 1.41,
                    child: Container(
                        margin: EdgeInsets.all(6.w),
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    text15BlackBold('Jay Bajrang Foods'),
                                    text15Black(
                                        'Date: ${DateTime.now().toString().substring(0, 10)}')
                                  ]),
                              5.h.height,
                              text12Black(
                                  'Kashimira, Navin Gaothan, S No.82 Part 1, St.Xavier School Road, Mira Road(E) Maharashtra Thane - 401107 Mobile : 9699997596/8898200140'),
                              5.h.height,
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    text12BlackBold('${cDetails['area']}'),
                                    text12BlackBold('Bill No: 1')
                                  ]),
                              SizedBox(
                                height: 18.h,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      text12Black('Salesman Name :  '),
                                      Obx(() => DropdownButton(
                                          iconSize: 0,
                                          elevation: 0,
                                          underline: 0.0.height,
                                          items: homeController.salesmanNames
                                              .map((value) => DropdownMenuItem(
                                                  alignment: Alignment.topLeft,
                                                  value: value,
                                                  child:
                                                      text12BlackBold(value)))
                                              .toList(),
                                          onChanged: (newValue) =>
                                              homeController.selectedSalesman
                                                  .value = newValue.toString(),
                                          value: homeController
                                              .selectedSalesman.value))
                                    ]),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: GestureDetector(
                                            onTap: () =>
                                                Get.to(() => SearchCustomer()),
                                            child: text15BlackBoldCenter(
                                                '${cDetails['name']}'))),
                                    text12Black('${cDetails['phone']}')
                                  ]),
                              // 4.h.height,
                              text12Black('${cDetails['address']}'),
                              4.h.height,
                              Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2.5), // Item Name
                                    1: FlexColumnWidth(1), // Quantity
                                    2: FlexColumnWidth(1), // Rate
                                    3: FlexColumnWidth(
                                        1.3), // Total${data[index]['billNo']}
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
                                      var products =
                                          homeController.jBFproducts[indx];
                                      var rateCont =
                                          homeController.existingRateTEC[indx];
                                      var qCont = homeController
                                          .existingQuantityTEC[indx];
                                      double a = rateCont.text == ''
                                          ? 0
                                          : double.parse(rateCont.text);
                                      double b = qCont.text == ''
                                          ? 0
                                          : double.parse(qCont.text);
                                      String totalAmount = '${a * b}';
                                      return TableRow(
                                        children: [
                                          padText(products),
                                          textFieldInt(controller: qCont),
                                          textFieldInt(controller: rateCont),
                                          textFieldInt(
                                              showCursor: false,
                                              keyboardType: TextInputType.none,
                                              text: totalAmount == '0.0' ||
                                                      totalAmount == '0'
                                                  ? ''
                                                  : totalAmount)
                                        ],
                                      );
                                    }),
                                    ...List.generate(
                                        homeController.selectedProductList
                                            .length, (indx) {
                                      var rateCont =
                                          homeController.newRateTEC[indx];
                                      var qCont =
                                          homeController.newQuantityTEC[indx];
                                      double a = rateCont.text == ''
                                          ? 0
                                          : double.parse(rateCont.text);
                                      double b = qCont.text == ''
                                          ? 0
                                          : double.parse(qCont.text);
                                      String totalAmount = '${a * b}';
                                      return TableRow(
                                        children: [
                                          padText(homeController
                                              .selectedProductList[indx]),
                                          textFieldInt(controller: qCont),
                                          textFieldInt(controller: rateCont),
                                          textFieldInt(
                                              showCursor: false,
                                              keyboardType: TextInputType.none,
                                              text: totalAmount == '0.0' ||
                                                      totalAmount == '0'
                                                  ? ''
                                                  : totalAmount)
                                        ],
                                      );
                                    }),
                                    purana(),
                                    TableRow(children: [
                                      GestureDetector(
                                          onTap: () =>
                                              Get.bottomSheet(selectProduct()),
                                          child: Container(child: Text(''))),
                                      padCenterText(''),
                                      textFieldInt(
                                          showCursor: false,
                                          keyboardType: TextInputType.none,
                                          text: ''),
                                      padCenterText('')
                                    ]),
                                    TableRow(children: [
                                      padCenterText('Grand Total'),
                                      padCenterText(
                                          '${homeController.grandTotalQuantity()}'),
                                      padCenterText(''),
                                      padCenterText(
                                          '${homeController.grandTotalAll()}')
                                    ])
                                  ])
                            ])))),
            20.h.height,
            Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(
                () => isSaving.value
                    ? const Center(child: CircularProgressIndicator())
                    : CommonButton(
                        ontap: () async {
                          isSaving.value = true;
                          await screenshotController.capture().then((value) {
                            imageFile = value!;
                            Get.snackbar('Success', 'image created');
                          });

                          pdfFile = await imageToPdf(imageFile);
                          await saveUint8ListToFile(pdfFile, 'fileName.pdf');
                          isSaving.value = false;

                          Get.to(() => NewBill(
                              image: imageFile,
                              pdfPath: homeController.newBillPath));
                        },
                        text: 'Save and Continue'),
              ),
            ),
            100.h.height
          ]));
        }));
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

  Future<void> saveUint8ListToFile(Uint8List data, String fileName) async {
    try {
      // Get the external storage directory
      Directory? externalDirectory = await getExternalStorageDirectory();

      if (externalDirectory != null) {
        // Specify the file path within the external storage directory
        String filePath = '${externalDirectory.path}/$fileName';

        // Write the Uint8List data to the file
        await File(filePath).writeAsBytes(data);

        print('File saved to: $filePath');
        homeController.newBillPath = filePath;
      } else {
        print('External storage directory not available');
      }
    } catch (e) {
      print('Error saving file: $e');
    }
  }

  Future<Uint8List> imageToPdf(Uint8List imageBytes) async {
    final pdf = pw.Document();

    // Add a single page to the PDF document
    pdf.addPage(pw.Page(
      build: (context) {
        final image = pw.MemoryImage(imageBytes);
        return pw.Center(child: pw.Image(image));
      },
    ));

    // Save the PDF document as a Uint8List
    return pdf.save();
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
            10.h.height,
            Row(
              children: [
                30.w.width,
                Text('Select Product',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(color: Colors.black, thickness: 1, height: 10.h),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: homeController.puranaCheckBox.value,
                    onChanged: (value) {
                      homeController.puranaCheckBox.value =
                          !homeController.puranaCheckBox.value;
                    },
                  ),
                ),
                Text('Purana', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    ),
                  );
                })
              ],
            ),
            50.h.height
          ],
        ),
      ),
    );
  }

  Widget padText(txt) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: EdgeInsets.all(4.h),
          child: text10Black('$txt'),
        ));
  }

  Widget padCenterText(txt) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(4.h),
          child: text12Black('$txt'),
        )));
  }
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
        keyboardType:
            keyboardType ?? TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
        ],
        decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
      ),
    ),
  );
}
