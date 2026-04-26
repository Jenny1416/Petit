import 'package:flutter/material.dart';
import '../../data/services/wishes_service.dart';
import '../../../products/data/models/product_model.dart';
import '../../../../core/models/sort_option.dart';
import '../../../auth/data/services/auth_service.dart';

class WishesController extends ChangeNotifier {
  final WishesService _service = WishesService();
  final AuthService _authService = AuthService();

  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredWishes = [];
  bool _isLoading = true;
  String _selectedCategory = 'Todos';
  String _searchQuery = '';
  SortOption _currentSort = SortOption.none;

  List<ProductModel> get filteredWishes => _filteredWishes;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  SortOption get currentSort => _currentSort;

  Future<void> loadWishes() async {
    _isLoading = true;
    notifyListeners();

    // Cargamos todos los productos del JSON
    _allProducts = await _service.getAllProducts();
    _applyFilters();

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _currentSort = option;
    _applyFilters();
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _authService.currentUser?.favorites.contains(productId) ?? false;
  }

  Future<void> toggleFavorite(int productId) async {
    await _authService.toggleFavorite(productId);
    _applyFilters(); // Re-aplicamos filtros para que desaparezca si se quita de favoritos
    notifyListeners();
  }

  void _applyFilters() {
    final userFavorites = _authService.currentUser?.favorites ?? [];
    final query = _searchQuery.toLowerCase();

    // Filtramos: 
    // 1. Que esté en la lista de favoritos del usuario
    // 2. Que coincida con la búsqueda
    // 3. Que coincida con la categoría
    List<ProductModel> filtered = _allProducts.where((product) {
      final isFav = userFavorites.contains(product.id);
      
      final matchesSearch =
          product.name.toLowerCase().contains(query) ||
          product.brand.toLowerCase().contains(query);
          
      final matchesCategory =
          _selectedCategory == 'Todos' || product.category == _selectedCategory;

      return isFav && matchesSearch && matchesCategory;
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

    _filteredWishes = filtered;
  }

  List<String> getPetCategories() {
    return ['Todos', 'Perro', 'Gato', 'Aves', 'Peces'];
  }
}
