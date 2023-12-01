import 'package:get/get.dart';

class HomeController extends GetxController {
  var edit = false.obs;
  var customerIndex = 0.obs;

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
