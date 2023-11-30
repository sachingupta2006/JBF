import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'JBF',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: AppRoutes.appRoutes());
  }
}
