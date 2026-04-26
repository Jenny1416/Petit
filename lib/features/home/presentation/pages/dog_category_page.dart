import 'package:flutter/material.dart';
import '../../../../core/widgets/home_header.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/filter_sort_bar.dart';
import '../controllers/dog_category_controller.dart';

class DogCategoryPage extends StatefulWidget {
  const DogCategoryPage({super.key});

  @override
  State<DogCategoryPage> createState() => _DogCategoryPageState();
}

class _DogCategoryPageState extends State<DogCategoryPage> {
  final DogCategoryController _controller = DogCategoryController();

  final List<Map<String, String>> _subcategories = [
    {'title': 'Alimentos', 'image': 'assets/categories/alimentos.png'},
    {'title': 'Higiene y Estética', 'image': 'assets/categories/higiene_estetica.png'},
    {'title': 'Accesorios', 'image': 'assets/categories/accesorios_home.png'},
    {'title': 'Salud', 'image': 'assets/categories/salud.png'},
  ];

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
                  hintText: 'Buscar productos...',
                ),
                const SizedBox(height: 20),
                
                FilterSortBar(
                  title: 'Categoría ${_controller.selectedCategory}',
                  currentSort: _controller.currentSort,
                  onSortChanged: (option) => _controller.setSortOption(option),
                  selectedCategory: _controller.selectedCategory,
                  categories: _controller.getPetCategories(),
                  onCategoryChanged: (cat) => _controller.setCategory(cat),
                ),

                const SizedBox(height: 20),

                GridView.builder(
                  itemCount: _subcategories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final sub = _subcategories[index];
                    final isSelected = _controller.selectedSubcategory == sub['title'];
                    return _DogCategoryCard(
                      title: sub['title']!,
                      image: sub['image']!,
                      isSelected: isSelected,
                      onTap: () => _controller.setSubcategory(sub['title']!),
                    );
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/categories/ofertas_especiales.png',
                      width: 52,
                      height: 52,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _controller.selectedSubcategory == 'Todos' 
                              ? 'Productos para ${_controller.selectedCategory}'
                              : 'Resultados para ${_controller.selectedSubcategory}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Los mejores productos seleccionados para tu mejor amigo.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                if (_controller.isLoading)
                  const Center(child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(),
                  ))
                else if (_controller.filteredProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.search_off, size: 60, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No encontramos lo que buscas',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: 310,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _controller.filteredProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final product = _controller.filteredProducts[index];
                        return ProductCard(
                          product: ProductModel(
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
                          isFavorite: _controller.isFavorite(product.id),
                          onFavoriteToggle: () => _controller.toggleFavorite(product.id),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DogCategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const _DogCategoryCard({
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF32B56A) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                ? const Color(0xFF32B56A).withOpacity(0.1) 
                : const Color(0x14000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(image, fit: BoxFit.contain),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? const Color(0xFF32B56A) : const Color(0xFF222222),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
