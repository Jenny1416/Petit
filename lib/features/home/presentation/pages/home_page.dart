import 'package:flutter/material.dart';

import '../../data/models/home_product.dart';
import '../../data/services/home_service.dart';
import '../widgets/home_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/categories_list.dart';
import '../widgets/promo_banner.dart';
import '../widgets/offer_card.dart';
import '../widgets/product_card.dart';
import '../widgets/brands_section.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<HomeProduct>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = HomeService().loadProducts();
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
                const SearchBarWidget(),
                const SizedBox(height: 20),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Todas Destacadas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                    _smallActionButton(
                      icon: Icons.swap_vert,
                      text: 'Sort',
                    ),
                    const SizedBox(width: 8),
                    _smallActionButton(
                      icon: Icons.filter_alt_outlined,
                      text: 'Filter',
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                const CategoriesList(),
                const SizedBox(height: 22),
                const PromoBanner(),
                const SizedBox(height: 22),
                const OfferCard(),
                const SizedBox(height: 18),

                FutureBuilder<List<HomeProduct>>(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'Error al cargar productos',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }

                    final products = snapshot.data ?? [];

                    return ProductSection(
                      title: '',
                      products: products
                          .map(
                            (product) => ProductModel(
                          image: product.image,
                          name: product.name,
                          brand: product.brand,
                          price: '\$${product.price}',
                          oldPrice: '\$${product.oldPrice}',
                          discount: '${product.discount}%Off',
                          rating: product.rating,
                          reviews: product.reviews.toString(),
                        ),
                      )
                          .toList(),
                    );
                  },
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

  static Widget _smallActionButton({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF444444),
            ),
          ),
          const SizedBox(width: 4),
          Icon(icon, size: 16, color: const Color(0xFF444444)),
        ],
      ),
    );
  }
}