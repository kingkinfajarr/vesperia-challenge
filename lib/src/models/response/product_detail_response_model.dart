import '../product_model.dart';

class ProductDetailResponseModel {
  ProductDetailResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final ProductModel
      data; // Perubahan pada tipe data dari List<ProductModel> menjadi ProductModel

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponseModel(
        status: json['status'],
        message: json['message'],
        data: ProductModel.fromJson(
          json['data'],
        ), // Menggunakan ProductModel.fromJson untuk mengurai data produk
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data
            .toJson(), // Menggunakan toJson() dari ProductModel untuk menyusun kembali data produk
      };
}
