import 'package:flutter/material.dart';

class DogCategoryPage extends StatelessWidget {
  const DogCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {
        'title': 'Alimentos',
        'image': 'assets/categories/alimentos.png',
      },
      {
        'title': 'Higiente y Estética',
        'image': 'assets/categories/higiene_estetica.png',
      },
      {
        'title': 'Accesorios',
        'image': 'assets/categories/accesorios_home.png',
      },
      {
        'title': 'Salud',
        'image': 'assets/categories/salud.png',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TopHeader(),
                const SizedBox(height: 16),
                const _SearchBox(),
                const SizedBox(height: 20),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Categoría Perros',
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

                const SizedBox(height: 20),

                GridView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return _DogCategoryCard(
                      title: category['title']!,
                      image: category['image']!,
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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ofertas Especiales',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Nos aseguramos de que obtengas la oferta que necesitas a los mejores precios.',
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

                SizedBox(
                  height: 260,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _DogProductCard(
                        image: 'assets/categories/product_1.png',
                        name: 'Alimento Húmedo Para Perro Wow Can Cerdo',
                        brand: 'Wow Can',
                        price: '\$1500',
                        oldPrice: '\$3500',
                        discount: '60%Off',
                      ),
                      SizedBox(width: 12),
                      _DogProductCard(
                        image: 'assets/categories/product_2.png',
                        name: 'Kit Arnés y Correa para Gato Puppis Nylon Fucsia',
                        brand: 'Puppis',
                        price: '\$7999',
                        oldPrice: '\$9999',
                        discount: '50%Off',
                      ),
                    ],
                  ),
                ),
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

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        const Text(
          'PETIT',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E7D45),
          ),
        ),
        const Spacer(),
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFFFE1EA),
          child: Icon(Icons.person, color: Colors.black),
        ),
      ],
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Busque cualquier producto.',
          hintStyle: TextStyle(
            color: Color(0xFFB4B4B4),
            fontSize: 14,
          ),
          prefixIcon: Icon(Icons.search, color: Color(0xFFB4B4B4)),
          suffixIcon: Icon(Icons.mic_none, color: Color(0xFFB4B4B4)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _DogCategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const _DogCategoryCard({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF222222),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DogProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String brand;
  final String price;
  final String oldPrice;
  final String discount;

  const _DogProductCard({
    required this.image,
    required this.name,
    required this.brand,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            brand,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7A7A7A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
          Row(
            children: [
              Text(
                oldPrice,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA0A0A0),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                discount,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF69B96B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}