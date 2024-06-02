import 'package:entrance_test/src/features/detail_product/component/detail_product_controller.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:get/get.dart';

class DetailProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailProductController(
      productRepository: Get.find<ProductRepository>(),
    ));
  }
}
