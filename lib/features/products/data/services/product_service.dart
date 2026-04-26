import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

class ProductService {
  // Singleton para no recargar el JSON innecesariamente
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  List<ProductModel>? _cachedProducts;

  Future<List<ProductModel>> getAllProducts() async {
    if (_cachedProducts != null) return _cachedProducts!;

    try {
      final String response = await rootBundle.loadString('assets/json/products.json');
      final List<dynamic> data = json.decode(response);
      _cachedProducts = data.map((json) => ProductModel.fromJson(json)).toList();
      return _cachedProducts!;
    } catch (e) {
      print('Error cargando productos: $e');
      return [];
    }
  }

  Future<List<ProductModel>> getFeaturedProducts() async {
    final all = await getAllProducts();
    return all.where((p) => p.isFeatured).toList();
  }
}
