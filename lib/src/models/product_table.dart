import 'package:equatable/equatable.dart';

import 'product_image_model.dart';
import 'product_model.dart';

class ProductTable extends Equatable {
  final String? id;
  final String? name;
  final int? price;
  final int? discountPrice;
  final String? image;
  final bool isFavorite;

  ProductTable({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.image,
    required this.isFavorite,
  });

  // final _isFavorite = false.obs;
  // bool get isFavorite => _isFavorite.value;
  // set isFavorite(bool newValue) => _isFavorite.value = newValue;

  factory ProductTable.fromEntity(ProductModel product) {
    String? imageUrlSmall =
        product.images?.isNotEmpty == true ? product.images![0].urlSmall : null;

    return ProductTable(
      id: product.id,
      name: product.name,
      price: product.price,
      discountPrice: product.discountPrice,
      image: imageUrlSmall,
      isFavorite: product.isFavorite,
    );
  }

  factory ProductTable.fromMap(Map<String, dynamic> map) {
    return ProductTable(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      discountPrice: map['discount_price'],
      image: map['image'],
      isFavorite: map['is_favorite'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discount_price': discountPrice,
      'image': image,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  ProductModel toEntity() {
    return ProductModel(
      id: id!,
      name: name!,
      price: price!,
      discountPrice: discountPrice!,
      images: [ProductImageModel(urlSmall: image)],
    )..isFavorite = isFavorite;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        discountPrice,
        image,
        isFavorite,
      ];
}
