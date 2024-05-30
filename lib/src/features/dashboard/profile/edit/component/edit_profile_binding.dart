import 'package:dio/dio.dart';
import 'package:entrance_test/src/features/dashboard/profile/edit/component/edit_profile_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../repositories/user_repository.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(EditProfileController(
      userRepository: Get.find<UserRepository>(),
    ));
  }
}