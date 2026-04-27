import 'package:flutter/material.dart';
import '../../../../core/widgets/home_header.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/filter_sort_bar.dart';
import '../../../../core/models/sort_option.dart';
import '../controllers/offer_controller.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  final OfferController _controller = OfferController();
  final List<String> _discounts = ['Todos', '10%', '20%', '30%', '40%', '50%'];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onUpdate);
    _controller.loadProducts();
  }

  @override
  void dispose() {
    _controller.removeListener(_onUpdate);
    super.dispose();
  }

  void _onUpdate() {
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
                const SizedBox(height: 20),
                
                // Timer Seccion
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer_outlined, color: Color(0xFF27B36A), size: 28),
                    const SizedBox(width: 12),
                    _buildTimerUnit('22'),
                    const SizedBox(width: 6),
                    _buildTimerUnit('55'),
                    const SizedBox(width: 6),
                    _buildTimerUnit('20'),
                  ],
                ),
                const SizedBox(height: 20),

                // Descuentos Horizontal List
                SizedBox(
                  height: 65,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _discounts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final discount = _discounts[index];
                      final isSelected = _controller.selectedDiscount == discount;
                      return GestureDetector(
                        onTap: () => _controller.setDiscountFilter(discount),
                        child: _buildDiscountTab(discount, isSelected),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),

                FilterSortBar(
                  title: 'Oferta del Día',
                  currentSort: SortOption.none,
                  onSortChanged: (_) {},
                  selectedCategory: 'Todos',
                  categories: const ['Todos', 'Perro', 'Gato'],
                  onCategoryChanged: (_) {},
                ),
                const SizedBox(height: 18),

                if (_controller.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (_controller.filteredProducts.isEmpty)
                  const Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No hay productos con este descuento'),
                  ))
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.54, // Proporción ajustada para evitar overflow
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: _controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final p = _controller.filteredProducts[index];
                      return ProductCard(
                        product: ProductModel(
                          id: p.id,
                          image: p.image,
                          name: p.name,
                          brand: p.brand,
                          price: '\$${p.price.toStringAsFixed(0)}',
                          oldPrice: '\$${p.oldPrice.toStringAsFixed(0)}',
                          discount: '-${p.discount}%',
                          rating: p.rating,
                          reviews: p.reviews.toString(),
                          subcategory: p.subcategory,
                        ),
                        isFavorite: _controller.isFavorite(p.id),
                        onFavoriteToggle: () => _controller.toggleFavorite(p.id),
                      );
                    },
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerUnit(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF135A38),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDiscountTab(String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFF27B36A) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF27B36A) : const Color(0xFF666666),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        if (isSelected)
          const Icon(Icons.arrow_drop_down, color: Color(0xFF27B36A), size: 20)
        else
          const SizedBox(height: 20),
      ],
    );
  }
}
