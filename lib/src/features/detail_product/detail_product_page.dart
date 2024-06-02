import 'package:cached_network_image/cached_network_image.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/utils/number_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/icon.dart';
import 'component/detail_product_controller.dart';

class DetailProductPage extends GetView<DetailProductController> {
  const DetailProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.id = Get.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Center(
            child: Obx(() {
              // Menggunakan Obx untuk mendengarkan perubahan pada _products
              return controller.products == null
                  ? const Text('Error loading data')
                  : buildProductDetail(controller);
            }),
          ),
        ),
      ),
    );
  }

  Widget buildProductDetail(DetailProductController controller) {
    final product = controller.products;

    if (product == null) {
      return const Text('Error loading data');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display product image
        AspectRatio(
          aspectRatio: 1 / 1,
          child: CachedNetworkImage(
            imageUrl: product.images?.isNotEmpty == true
                ? product.images![0].urlSmall ?? ''
                : '',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
              ic_error_image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            product.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            product.price.inRupiah(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(children: [
            Image.asset(ic_star),
            const SizedBox(width: 4),
            Text(
              product.ratingAverage ?? '0',
              style: const TextStyle(
                fontSize: 14,
                color: gray900,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(${product.reviewCount ?? '0'} Reviews) ',
              style: const TextStyle(
                fontSize: 14,
                color: gray600,
              ),
            ),
          ]),
        ),
        const Divider(
          thickness: 4,
          color: gray200,
        ),
        const SizedBox(height: 18),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Product Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: gray900,
            ),
          ),
        ),
        const SizedBox(height: 8), // Check if description is not null
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            product.description ?? '-',
            style: const TextStyle(
              fontSize: 12,
              color: gray900,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Divider(
          thickness: 4,
          color: gray200,
        ),
        const SizedBox(height: 18),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Terms & Conditions of Return / Refund',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: gray900,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            product.returnTerms ?? '-',
            style: const TextStyle(
              fontSize: 12,
              color: gray900,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Divider(
          thickness: 4,
          color: gray200,
        ),
        // Add more widgets to display other product details as needed
      ],
    );
  }
}
