import '../product_model.dart';

class RatingRequestModel {
  RatingRequestModel({
    ProductSort? sort,
    int? limit,
    int? skip,
    String? productId,
  })  : _sortBy = SortType.getSortByValue(sort ?? ProductSort.newest),
        _sortOrder = SortType.getSortColumnValue(sort ?? ProductSort.newest),
        _limit = limit ?? 10,
        _skip = skip ?? 0,
        _productId = '';

  final String _sortBy;
  final String _sortOrder;
  final int _limit;
  final int _skip;
  final String _productId;

  Map<String, dynamic> toJson() => {
        'sort_column': _sortBy,
        'sort_order': _sortOrder,
        'limit': _limit,
        'skip': _skip,
        'product_id': _productId,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
