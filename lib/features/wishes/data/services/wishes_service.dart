import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../products/data/models/product_model.dart';

class WishesService {
  Future<List<ProductModel>> getAllProducts() async {
    final raw = await rootBundle.loadString('assets/json/products.json');
    final List<dynamic> decoded = jsonDecode(raw);

    return decoded.map((item) {
      final json = item as Map<String, dynamic>;
      return ProductModel(
        id: json['id'],
        name: json['name'],
        brand: json['brand'],
        price: json['price'].toDouble(),
        oldPrice: json['oldPrice'].toDouble(),
        discount: json['discount'],
        rating: json['rating'].toDouble(),
        reviews: json['reviews'],
        image: json['image'],
        category: json['category'],
        subcategory: json['subcategory'], // Añadido
        isFeatured: json['isFeatured'],
      );
    }).toList();
  }
}
