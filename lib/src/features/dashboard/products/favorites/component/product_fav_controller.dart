import 'package:get/get.dart';

import '../../../../../../app/routes/route_name.dart';
import '../../../../../data/db/database_helper.dart';
import '../../../../../models/product_model.dart';
import '../../../../../models/product_table.dart';

class ProductFavController extends GetxController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final _listProduct = <ProductTable>[].obs;

  List<ProductTable> get listProduct => _listProduct;

  ProductFavController();

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favoriteProducts = await _databaseHelper.getFavoritesProduct();
    _listProduct.value =
        favoriteProducts.map((map) => ProductTable.fromMap(map)).toList();
  }

  void refreshFavorites() async {
    await _loadFavorites();
  }

  void toProductDetail(String id) async {
    //TODO: finish this implementation by creating product detail page & calling it here
    Get.toNamed(RouteName.productDetail, arguments: id);
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

    refreshFavorites();
    _listProduct.refresh();
  }
}
