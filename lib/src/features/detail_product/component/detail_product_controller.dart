import 'package:get/get.dart';

import '../../../models/product_model.dart';
import '../../../repositories/product_repository.dart';

class DetailProductController extends GetxController {
  final ProductRepository _productRepository;

  String id = Get.arguments as String;

  final _products = Rx<ProductModel?>(null);
  ProductModel? get products => _products.value;

  DetailProductController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  @override
  void onInit() {
    super.onInit();
    _getDetailProduct();
  }

  void _getDetailProduct() async {
    try {
      final result = await _productRepository.getProductDetail(id);
      _products.value = result.data;
    } catch (e) {
      throw e;
    }
  }
}
