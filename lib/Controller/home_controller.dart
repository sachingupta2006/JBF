import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var customerIndex = 0.obs;
  RxList<String> selectedProductList = <String>[].obs;
  Set<String> productsSelectedSet = {};
  addProductToTableFunc() {
    selectedProductList.value = productsSelectedSet.toList();
  }

  List<TextEditingController> existingRateTEC = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<TextEditingController> existingQuantityTEC = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<TextEditingController> newRateTEC = [];
  List<TextEditingController> newQuantityTEC = [];

  newRateNquantityTecAdd() async {
    print('1st :${newQuantityTEC.length}');
    newQuantityTEC = await [];
    newRateTEC = await [];
    var count = productsSelectedSet.length;
    for (int i = 0; i < count; i++) {
      newRateTEC.add(TextEditingController());
      newQuantityTEC.add(TextEditingController());
    }
    print('2st :${newQuantityTEC.length}');
  }

  grandTotalQuantity() {
    var total = 0.0.obs;
    for (var i = 0; i < existingQuantityTEC.length; i++) {
      var a = existingQuantityTEC[i].text == ''
          ? 0
          : double.parse(existingQuantityTEC[i].text);
      total.value += a;
    }
    for (var i = 0; i < newQuantityTEC.length; i++) {
      var b = newQuantityTEC[i].text == ''
          ? 0
          : double.parse(newQuantityTEC[i].text);
      total.value += b;
    }

    return total.value.toString();
  }

  grandTotalRate() {
    var total = 0.0.obs;
    for (var i = 0; i < existingQuantityTEC.length; i++) {
      var a = existingQuantityTEC[i].text == ''
          ? 0
          : double.parse(existingQuantityTEC[i].text);
      total.value += a;
    }
    for (var i = 0; i < newQuantityTEC.length; i++) {
      var b = newQuantityTEC[i].text == ''
          ? 0
          : double.parse(newQuantityTEC[i].text);
      total.value += b;
    }

    return total.value;
  }

  grandTotalAll() {
    List existingQDouble = [];
    for (var i = 0; i < existingQuantityTEC.length; i++) {
      existingQDouble.add(existingQuantityTEC[i].text == ''
          ? 0
          : double.parse(existingQuantityTEC[i].text));
    }
    List existingRDouble = [];
    for (var i = 0; i < existingRateTEC.length; i++) {
      existingRDouble.add(existingRateTEC[i].text == ''
          ? 0
          : double.parse(existingRateTEC[i].text));
    }
    double gT = 0.0;
    for (var i = 0; i < existingQDouble.length; i++) {
      gT += existingQDouble[i] * existingRDouble[i];
    }



  List newQDouble = [];
    for (var i = 0; i < newQuantityTEC.length; i++) {
      newQDouble.add(newQuantityTEC[i].text == ''
          ? 0
          : double.parse(newQuantityTEC[i].text));
    }
    List newRDouble = [];
    for (var i = 0; i < newRateTEC.length; i++) {
      newRDouble.add(newRateTEC[i].text == ''
          ? 0
          : double.parse(newRateTEC[i].text));
    }
    for (var i = 0; i < newQDouble.length; i++) {
      gT += newQDouble[i] * newRDouble[i];
    }




      return gT.toString();

  }

  var customerDetails = [
    {
      'name': 'Sachin',
      'address': 'manali, kashimira, mira road, thane 401107',
      'area': 'Mumbai',
      'phone': '9004353155',
      'code': 'M Sac'
    },
    {
      'name': 'Shubham',
      'address': 'om mani tower, hatkesh, mira road, thane 401107',
      'area': 'Mira Bhayander',
      'phone': '7666564623',
      'code': 'MB Shu'
    },
    {
      'name': 'Amit',
      'address': 'shiv shakti chawl, kashimira, mira road, thane 401107',
      'area': 'Virar',
      'phone': '9820579288',
      'code': 'V Ami'
    }
  ].obs;

  var jBFproducts = [
    'JBF-SEV (20KG)',
    'JBF BUNDLE SEV (5KG)',
    'JBF SPECIAL SEV (20KG)',
    'FRY NOODLES',
    'SPECIAL PURI',
    'LEHAR DAL',
    'FRY DAL',
    'FRY NOODLES 900g',
    'RAJAT SEV',
    'CHANNA BESAN SEV',
    'PURANA'
  ];
  editCustomerDetails(
      int index, String name, String address, String area, String phone) {
    customerDetails[index]['name'] = name;
    customerDetails[index]['address'] = address;
    customerDetails[index]['area'] = area;
    customerDetails[index]['phone'] = phone;
    update();
  }
}
