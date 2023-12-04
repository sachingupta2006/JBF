import 'package:get/get.dart';

class HomeController extends GetxController {
  var customerIndex = 0.obs;
  RxList<String> selectedProductList = <String>[].obs;
  Set<String> productsSelectedSet = {};
  addProductToTableFunc() {
    selectedProductList.value = productsSelectedSet.toList();
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
