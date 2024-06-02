import 'package:get/get.dart';

import '../../../../../data/db/database_helper.dart';
import '../../../../../models/product_model.dart';
import '../../../../../models/product_table.dart';
import '../../../../../models/request/product_list_request_model.dart';
import '../../../../../repositories/product_repository.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';
import '../../favorites/component/product_fav_controller.dart';

class ProductListController extends GetxController {
  final ProductRepository _productRepository;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final ProductFavController _productFavController =
      Get.find<ProductFavController>();

  ProductListController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final _products = Rx<List<ProductModel>>([]);

  List<ProductModel> get products => _products.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;

  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  final _isLoadingRetrieveCategory = false.obs;

  bool get isLoadingRetrieveCategory => _isLoadingRetrieveCategory.value;

  final _canFilterCategory = true.obs;

  bool get canFilterCategory => _canFilterCategory.value;

  final _isLastPageProduct = false.obs;

  //The number of product retrieved each time a call is made to server
  final _limit = 10;

  //The number which shows how many product already loaded to the device,
  //thus giving the command to ignore the first x number of data when retrieving
  int _skip = 0;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  //first load or after refresh.
  void getProducts() async {
    _isLoadingRetrieveProduct.value = true;
    _skip = 0;
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      // Load favorites from the database
      final favoriteProducts = await _databaseHelper.getFavoritesProduct();
      final favoriteProductIds = favoriteProducts.map((e) => e['id']).toList();

      // Update the isFavorite status based on the favorite data
      final updatedProductList = productList.data.map((product) {
        product.isFavorite = favoriteProductIds.contains(product.id);
        return product;
      }).toList();

      _products.value = updatedProductList;

      // _products.value = productList.data;
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void getMoreProducts() async {
    if (_isLastPageProduct.value || _isLoadingRetrieveMoreProduct.value) return;

    _isLoadingRetrieveMoreProduct.value = true;

    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      // Load favorites from the database
      final favoriteProducts = await _databaseHelper.getFavoritesProduct();
      final favoriteProductIds = favoriteProducts.map((e) => e['id']).toList();

      final updatedProductList = productList.data.map((product) {
        product.isFavorite = favoriteProductIds.contains(product.id);
        return product;
      }).toList();

      // _products.value.addAll(productList.data);
      _products.value.addAll(updatedProductList);
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }

    _isLoadingRetrieveMoreProduct.value = false;
  }

  void toProductDetail(ProductModel product) async {
    //TODO: finish this implementation by creating product detail page & calling it here
  }

  void setFavorite(ProductModel product) async {
    product.isFavorite = !product.isFavorite;

    final productTable = ProductTable.fromEntity(product);

    // Check if the product is marked as favorite
    if (product.isFavorite) {
      await _databaseHelper.insertFavorite(productTable);
    } else {
      await _databaseHelper.removeFavorite(productTable);
    }

    _productFavController.refreshFavorites();
    _products.refresh();
  }
}
