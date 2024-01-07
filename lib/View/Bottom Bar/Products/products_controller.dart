import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetProducts extends GetxController {
  var isLoading = false.obs;

  List<String> products = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  fetchProducts() async {
    isLoading.value = true;
    products = [];
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Products').get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        String productName = data['Products Name'];
        products.add(productName);
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      loading();
    }
  }

  Future<void> deleteProductAtIndex(int index) async {
    if (index >= 0 && index < products.length) {
      String productNameToDelete = products[index];

      // Delete from Firestore
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('Products')
            .where('Products Name', isEqualTo: productNameToDelete)
            .get();

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference.delete();
        }
      } catch (e) {
        print('Error deleting product: $e');
      }
    }
  }

  Future<void> editProductAtIndex(int index, String newProductName) async {
    if (index >= 0 && index < products.length) {
      String productNameToReplace = products[index];

      // Delete from Firestore
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('Products')
            .where('Products Name', isEqualTo: productNameToReplace)
            .get();

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference
              .update({'Products Name': newProductName});
        }
      } catch (e) {
        print('Error deleting product: $e');
      }
    }
  }

  loading() {
    isLoading.value = !isLoading.value;
    update();
  }
}
