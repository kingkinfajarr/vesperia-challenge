import 'package:dio/dio.dart';
import 'package:entrance_test/src/features/dashboard/component/dashboard_controller.dart';
import 'package:entrance_test/src/features/dashboard/products/list/component/product_list_controller.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../profile/component/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(ProductRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(
      DashboardController(),
    );

    Get.put(ProfileController(
      userRepository: Get.find<UserRepository>(),
    ));

    Get.put(ProductListController(
      productRepository: Get.find<ProductRepository>(),
    ));
  }
}
