import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/splash_page.dart';
import 'package:entrance_test/src/features/dashboard/component/dashboard_binding.dart';
import 'package:entrance_test/src/features/dashboard/dashboard_page.dart';
import 'package:entrance_test/src/features/dashboard/profile/edit/edit_profile_page.dart';
import 'package:entrance_test/src/features/detail_product/component/detail_product_binding.dart';
import 'package:entrance_test/src/features/detail_product/detail_product_page.dart';
import 'package:entrance_test/src/features/onboarding/component/onboarding_binding.dart';
import 'package:entrance_test/src/features/onboarding/onboarding_page.dart';
import 'package:get/get.dart';

import '../../src/features/dashboard/profile/edit/component/edit_profile_binding.dart';
import '../../src/features/login/component/login_binding.dart';
import '../../src/features/login/login_page.dart';
import '../../src/features/web_view/web_view_page.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: RouteName.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.onboarding,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: RouteName.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RouteName.editProfile,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: RouteName.webView,
      page: () => const WebViewPage(),
    ),
    GetPage(
      name: RouteName.productDetail,
      page: () => const DetailProductPage(),
      binding: DetailProductBinding(),
    ),
  ];
}
