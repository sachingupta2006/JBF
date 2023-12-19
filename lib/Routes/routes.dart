import 'package:get/get.dart';
import 'package:jbf/View/Bottom%20Bar/bottombar.dart';
import 'package:jbf/View/On%20Boarding/login.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteName.onboarding,
            page: () => const Login(),
            transition: Transition.leftToRight),
        GetPage(
            name: RouteName.customBottomBar,
            page: () => const CustomBottomBar(),
            transition: Transition.leftToRight)
      ];
}
