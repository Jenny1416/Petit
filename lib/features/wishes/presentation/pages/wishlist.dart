import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/home_header.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../../../core/widgets/filter_sort_bar.dart';
import '../../../../core/widgets/product_card.dart' as ui;
import '../controllers/wishes_controller.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishesController _controller = WishesController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerUpdate);
    _controller.loadWishes();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const HomeHeader(),
                  const SizedBox(height: 18),
                  SearchBarWidget(
                    hintText: 'Buscar en mis deseos...',
                    onChanged: (value) => _controller.setSearchQuery(value),
                  ),
                  const SizedBox(height: 20),

                  FilterSortBar(
                    title: 'Mis Deseos',
                    currentSort: _controller.currentSort,
                    onSortChanged: (option) =>
                        _controller.setSortOption(option),
                    selectedCategory: _controller.selectedCategory,
                    categories: _controller.getPetCategories(),
                    onCategoryChanged: (cat) => _controller.setCategory(cat),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: _controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _controller.filteredWishes.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.54, // Ajustado para evitar overflow
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                          ),
                      itemCount: _controller.filteredWishes.length,
                      itemBuilder: (context, index) {
                        final product = _controller.filteredWishes[index];
                        return ui.ProductCard(
                          product: ui.ProductModel(
                            id: product.id,
                            image: product.image,
                            name: product.name,
                            brand: product.brand,
                            price: '\$${product.price.toStringAsFixed(0)}',
                            oldPrice: '\$${product.oldPrice.toStringAsFixed(0)}',
                            discount: '${product.discount}%Off',
                            rating: product.rating,
                            reviews: product.reviews.toString(),
                            subcategory: product.subcategory, // Añadido subcategory
                          ),
                          isFavorite: true, // Siempre es true en la Wishlist
                          onFavoriteToggle: () => _controller.toggleFavorite(product.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'No hay productos en tus deseos',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
