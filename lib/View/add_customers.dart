import 'package:flutter/material.dart';

class AddCustomers extends StatelessWidget {
  const AddCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// bottomNavigationBar: CircleAvatar(child: Icon(Icons.add)),
      appBar: AppBar(title: Text('Add Customer')),
    );
  }
}
