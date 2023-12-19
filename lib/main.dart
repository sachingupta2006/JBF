import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/home_controller.dart';
import 'Routes/routes.dart';

HomeController homeController = Get.put(HomeController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardDone = prefs.getBool("onBoardDone") ?? false;

  runApp(MyApp(onboardDone: onboardDone));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onboardDone});
  final bool onboardDone;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 800),
        builder: (context, child) {
          return GetMaterialApp(
              title: 'JBF',
              debugShowCheckedModeBanner: false,
              initialRoute: onboardDone ? RouteName.customBottomBar : '/',
              getPages: AppRoutes.appRoutes());
        });
  }
}
