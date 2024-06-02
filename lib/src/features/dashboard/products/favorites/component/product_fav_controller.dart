import 'package:get/get.dart';

import '../../../../../data/db/database_helper.dart';
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
}
