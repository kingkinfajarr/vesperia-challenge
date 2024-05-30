import 'package:get/get.dart';

import 'product_image_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.images,
    this.description,
    this.returnTerms,
    this.isPrescriptionDrugs,
    this.ratingAverage,
    this.ratingCount,
    this.reviewCount,
  });

  final String id;
  final String name;
  final int price;
  final int discountPrice;
  final List<ProductImageModel>? images;
  final bool? isPrescriptionDrugs;
  final String? description;
  final String? returnTerms;
  final String? ratingAverage;
  final int? ratingCount;
  final int? reviewCount;

  final _isFavorite = false.obs;
  bool get isFavorite => _isFavorite.value;
  set isFavorite(bool newValue) => _isFavorite.value = newValue;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    name: json['name'],
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => ProductImageModel.fromJson(e))
        .toList(),
    price: json['price'],
    discountPrice: json['price_after_discount'],
    isPrescriptionDrugs: json['is_prescription_drugs'],
    description: json['description'],
    returnTerms: json['refund_terms_and_condition'],
    ratingAverage: json['rating_average'],
    ratingCount: json['rating_count'],
    reviewCount: json['review_count'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'images': images,
    'price': price,
    'price_after_discount': discountPrice,
    if (isPrescriptionDrugs != null)
      'is_prescription_drugs': isPrescriptionDrugs,
    if (description != null) 'description': description,
    if (returnTerms != null) 'refund_terms_and_condition': returnTerms,
    if (ratingAverage != null) 'rating_average': ratingAverage,
    if (ratingCount != null) 'rating_count': ratingCount,
    if (reviewCount != null) 'review_count': reviewCount,
  };
}

enum ProductSort {
  newest,
  priceAscending,
  priceDescending,
  nameAscending,
  nameDescending,
}

extension SortExtension on ProductSort {
  String get name {
    switch (this) {
      case ProductSort.newest:
        return 'Newest';
      case ProductSort.priceAscending:
        return 'Price: Low to High';
      case ProductSort.priceDescending:
        return 'Price: High to Low';
      case ProductSort.nameAscending:
        return 'Alphabet: A to Z';
      case ProductSort.nameDescending:
        return 'Alphabet: Z to A';
      default:
        return 'Newest';
    }
  }
}

class SortType {
  static String getSortByValue(ProductSort sort) {
    switch(sort){
      case ProductSort.newest: return 'created_at';
      case ProductSort.nameAscending: return 'name';
      case ProductSort.nameDescending: return 'name';
      case ProductSort.priceAscending: return 'price';
      case ProductSort.priceDescending: return 'price';
      default: return 'id';
    }
  }

  static String getSortColumnValue(ProductSort sort) {
    switch(sort){
      case ProductSort.newest: return 'desc';
      case ProductSort.nameAscending: return 'asc';
      case ProductSort.nameDescending: return 'desc';
      case ProductSort.priceAscending: return 'asc';
      case ProductSort.priceDescending: return 'desc';
      default: return 'asc';
    }
  }
}