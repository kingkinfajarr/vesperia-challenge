import 'package:equatable/equatable.dart';

import 'product_image_model.dart';
import 'product_model.dart';

class ProductTable extends Equatable {
  final String? id;
  final String? name;
  final int? price;
  final int? discountPrice;
  final String? image;

  const ProductTable({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.image,
  });

  factory ProductTable.fromEntity(ProductModel product) {
    String? imageUrlSmall =
        product.images?.isNotEmpty == true ? product.images![0].urlSmall : null;

    return ProductTable(
      id: product.id,
      name: product.name,
      price: product.price,
      discountPrice: product.discountPrice,
      image: imageUrlSmall,
    );
  }

  factory ProductTable.fromMap(Map<String, dynamic> map) {
    return ProductTable(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      discountPrice: map['discount_price'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discount_price': discountPrice,
      'image': image,
    };
  }

  ProductModel toEntity() {
    return ProductModel(
      id: id!,
      name: name!,
      price: price!,
      discountPrice: discountPrice!,
      images: [ProductImageModel(urlSmall: image)],
    );
  }

  @override
  List<Object?> get props => [id, name, price, discountPrice, image];
}
