import 'package:get/get.dart';

class HomeController extends GetxController {
  var edit = false.obs;
  var customerDetails = [
    {
      'name': 'Sachin',
      'address': 'manali, kashimira, mira road, thane 401107',
      'area': 'Mumbai',
      'phone': '9004353155',
      'code': 'MR1'
    },
    {
      'name': 'Shubham',
      'address': 'om mani tower, hatkesh, mira road, thane 401107',
      'area': 'Mira Bhayander',
      'phone': '7666564623',
      'code': 'MR2'
    },
    {
      'name': 'Amit',
      'address': 'shiv shakti chawl, kashimira, mira road, thane 401107',
      'area': 'Virar',
      'phone': '9820579288',
      'code': 'MR3'
    }
  ].obs;

  editCustomerDetails(
      int index, String name, String address, String area, String phone) {
    customerDetails[index]['name'] = name;
    customerDetails[index]['address'] = address;
    customerDetails[index]['area'] = area;
    customerDetails[index]['phone'] = phone;
    update();
  }
}
