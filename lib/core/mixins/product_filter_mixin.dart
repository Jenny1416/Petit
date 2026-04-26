import '../models/sort_option.dart';
import '../../features/products/data/models/product_model.dart';

mixin ProductFilterMixin {
  List<ProductModel> applyBaseFilters({
    required List<ProductModel> allProducts,
    required String searchQuery,
    required String selectedCategory,
    required SortOption sortOption,
  }) {
    List<ProductModel> filtered = allProducts.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory == 'Todos' || product.category == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();

    switch (sortOption) {
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

    return filtered;
  }
}
