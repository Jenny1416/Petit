import 'package:flutter/material.dart';
import '../../../../core/widgets/home_header.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/filter_sort_bar.dart';
import '../controllers/pet_category_controller.dart';

class PetCategoryPage extends StatefulWidget {
  final String categoryName; // 'Perro', 'Gato', 'Aves', 'Peces', 'Hamster'

  const PetCategoryPage({
    super.key,
    required this.categoryName,
  });

  @override
  State<PetCategoryPage> createState() => _PetCategoryPageState();
}

class _PetCategoryPageState extends State<PetCategoryPage> {
  final PetCategoryController _controller = PetCategoryController();

  // Textos personalizados según la mascota
  String get _subtitle {
    switch (widget.categoryName) {
      case 'Perro': return 'Los mejores productos para tu mejor amigo.';
      case 'Gato': return 'Los mejores productos para tu michi.';
      case 'Aves': return 'Lo mejor para tus plumíferos.';
      case 'Peces': return 'Todo para tu acuario.';
      case 'Hamster': return 'Pequeños amigos, grandes cuidados.';
      default: return 'Los mejores productos para tu mascota.';
    }
  }

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.setCategory(widget.categoryName);
      _controller.loadProducts();
    });
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
                  hintText: 'Buscar para ${widget.categoryName.toLowerCase()}s...',
                ),
                const SizedBox(height: 20),
                
                FilterSortBar(
                  title: 'Categoría ${widget.categoryName}s',
                  currentSort: _controller.currentSort,
                  onSortChanged: (option) => _controller.setSortOption(option),
                  selectedCategory: _controller.selectedCategory,
                  categories: _controller.getPetCategories(),
                  onCategoryChanged: (cat) {
                    _controller.setCategory(cat);
                  },
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
                    return _CategoryCard(
                      title: sub['title']!,
                      image: sub['image']!,
                      isSelected: isSelected,
                      onTap: () => _controller.setSubcategory(sub['title']!),
                    );
                  },
                ),

                const SizedBox(height: 24),
                _buildSectionHeader(),
                const SizedBox(height: 20),

                if (_controller.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (_controller.filteredProducts.isEmpty)
                  const Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('No hay productos en esta categoría'),
                  ))
                else
                  _buildProductList(),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/categories/ofertas_especiales.png', width: 52, height: 52),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _controller.selectedSubcategory == 'Todos' 
                  ? 'Productos para ${widget.categoryName}s'
                  : 'Resultados para ${_controller.selectedSubcategory}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(_subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    return SizedBox(
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
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
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
          border: Border.all(color: isSelected ? const Color(0xFF32B56A) : Colors.transparent, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(image, fit: BoxFit.contain)),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
