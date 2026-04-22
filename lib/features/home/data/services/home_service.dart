import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/home_product.dart';

class HomeService {
  Future<List<HomeProduct>> loadProducts() async {
    final raw = await rootBundle.loadString('assets/json/products.json');
    final List<dynamic> decoded = jsonDecode(raw);

    return decoded
        .map((item) => HomeProduct.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}