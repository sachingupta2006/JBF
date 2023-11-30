import 'package:get/get.dart';
import 'package:jbf/View/bottombar.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteName.onboarding,
            page: () => const CustomBottomBar(),
            transition: Transition.leftToRight)
      ];
}
