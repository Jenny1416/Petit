import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../features/products/data/models/product_model.dart';

class WishesService {
  static final WishesService _instance = WishesService._internal();
  factory WishesService() => _instance;
  WishesService._internal();

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/products.json',
      );
      final List<dynamic> data = json.decode(response);

      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      print('Error al cargar productos: $e');
      return [];
    }
  }
}
