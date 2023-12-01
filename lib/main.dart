import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Controller/home_controller.dart';
import 'Routes/routes.dart';

HomeController homeController = Get.put(HomeController());

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 800),
        builder: (context, child) {
          return GetMaterialApp(
              title: 'JBF',
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              getPages: AppRoutes.appRoutes());
        });
  }
}
