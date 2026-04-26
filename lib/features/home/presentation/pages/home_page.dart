import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import '../../../../core/widgets/home_header.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../../../core/widgets/filter_sort_bar.dart';
import '../widgets/categories_list.dart';
import '../widgets/promo_banner.dart';
import '../widgets/offer_card.dart';
import '../../../../core/widgets/product_card.dart';
import '../widgets/brands_section.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerUpdate);
    _controller.loadProducts();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const HomeHeader(),
                const SizedBox(height: 18),
                SearchBarWidget(
                  onChanged: (value) => _controller.setSearchQuery(value),
                ),
                const SizedBox(height: 20),

                FilterSortBar(
                  title: 'Todas Destacadas',
                  currentSort: _controller.currentSort,
                  onSortChanged: (option) => _controller.setSortOption(option),
                  selectedCategory: _controller.selectedCategory,
                  categories: _controller.getPetCategories(),
                  onCategoryChanged: (cat) => _controller.setCategory(cat),
                ),

                const SizedBox(height: 18),
                const CategoriesList(),
                const SizedBox(height: 22),
                const PromoBanner(),
                const SizedBox(height: 22),
                const OfferCard(),
                const SizedBox(height: 18),

                if (_controller.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_controller.filteredProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: Text('No se encontraron productos')),
                  )
                else
                  ProductSection(
                    title: '',
                    products: _controller.filteredProducts
                        .map(
                          (product) => ProductModel(
                            id: product.id,
                            image: product.image,
                            name: product.name,
                            brand: product.brand,
                            price: '\$${product.price.toStringAsFixed(0)}',
                            oldPrice: '\$${product.oldPrice.toStringAsFixed(0)}',
                            discount: '${product.discount}%Off',
                            rating: product.rating,
                            reviews: product.reviews.toString(),
                          ),
                        )
                        .toList(),
                    isFavorite: (id) => _controller.isFavorite(id),
                    onFavoriteToggle: (id) => _controller.toggleFavorite(id),
                  ),

                const SizedBox(height: 18),
                const SpecialOfferInfoCard(),
                const SizedBox(height: 20),
                const BrandsSection(),
                const SizedBox(height: 22),
                const NewArrivalsSection(),
                const SizedBox(height: 22),
                const UpcomingSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
