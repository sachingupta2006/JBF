import 'package:get/get.dart';
import 'package:jbf/View/dashboard.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteName.onboarding,
            page: () => const Dashboard(),
            transition: Transition.leftToRight)
      ];
}
