import 'package:flutter/material.dart';
import '../../../products/data/models/product_model.dart';
import '../../data/services/home_service.dart';
import '../../../auth/data/services/auth_service.dart';

class OfferController extends ChangeNotifier {
  final HomeService _service = HomeService();
  final AuthService _authService = AuthService();
  
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;
  String _selectedDiscount = 'Todos';

  List<ProductModel> get filteredProducts => _filteredProducts;
  bool get isLoading => _isLoading;
  String get selectedDiscount => _selectedDiscount;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    
    final products = await _service.loadProducts();
    _allProducts = products.map((p) => ProductModel(
      id: p.id,
      name: p.name,
      brand: p.brand,
      price: p.price.toDouble(),
      oldPrice: p.oldPrice.toDouble(),
      discount: p.discount,
      rating: p.rating.toDouble(),
      reviews: p.reviews,
      image: p.image,
      category: p.category,
      subcategory: p.subcategory,
      isFeatured: p.isFeatured,
    )).toList();
    
    _applyFilters();
    
    _isLoading = false;
    notifyListeners();
  }

  void setDiscountFilter(String discount) {
    _selectedDiscount = discount;
    _applyFilters();
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _authService.currentUser?.favorites.contains(productId) ?? false;
  }

  Future<void> toggleFavorite(int productId) async {
    await _authService.toggleFavorite(productId);
    notifyListeners();
  }

  void _applyFilters() {
    if (_selectedDiscount == 'Todos') {
      _filteredProducts = _allProducts.where((p) => p.discount > 0).toList();
    } else {
      final int targetDiscount = int.parse(_selectedDiscount.replaceAll('%', ''));
      _filteredProducts = _allProducts.where((p) => p.discount == targetDiscount).toList();
    }
  }
}
