import 'package:flutter/material.dart';
import '../../../../core/models/sort_option.dart';
import '../../../products/data/models/product_model.dart';
import '../../data/services/home_service.dart';
import '../../../auth/data/services/auth_service.dart';

class HomeController extends ChangeNotifier {
  final HomeService _service = HomeService();
  final AuthService _authService = AuthService();
  
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;
  String _searchQuery = '';
  SortOption _currentSort = SortOption.none;
  String _selectedCategory = 'Todos';

  List<ProductModel> get filteredProducts => _filteredProducts;
  bool get isLoading => _isLoading;
  SortOption get currentSort => _currentSort;
  String get selectedCategory => _selectedCategory;

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

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _currentSort = option;
    _applyFilters();
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  List<String> getPetCategories() {
    return ['Todos', 'Perro', 'Gato', 'Aves', 'Peces'];
  }

  bool isFavorite(int productId) {
    return _authService.currentUser?.favorites.contains(productId) ?? false;
  }

  Future<void> toggleFavorite(int productId) async {
    await _authService.toggleFavorite(productId);
    notifyListeners();
  }

  void _applyFilters() {
    final query = _searchQuery.toLowerCase();
    List<ProductModel> filtered = _allProducts.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(query) || 
                           product.brand.toLowerCase().contains(query);
      
      final matchesCategory = _selectedCategory == 'Todos' || product.category == _selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();

    switch (_currentSort) {
      case SortOption.nameAsc:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.nameDesc:
        filtered.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortOption.priceAsc:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDesc:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.none:
        break;
    }

    _filteredProducts = filtered;
  }
}
