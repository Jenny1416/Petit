import 'package:flutter/material.dart';
import '../pages/pet_category_page.dart';

class CategoryItem {
  final String title;
  final String image;
  final String categoryKey;

  const CategoryItem({
    required this.title,
    required this.image,
    required this.categoryKey,
  });
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  static const List<CategoryItem> _categories = [
    CategoryItem(
      title: 'Aves',
      image: 'assets/categories/aves_home.png',
      categoryKey: 'Aves',
    ),
    CategoryItem(
      title: 'Perros',
      image: 'assets/categories/perros_home.png',
      categoryKey: 'Perro',
    ),
    CategoryItem(
      title: 'Gatos',
      image: 'assets/categories/gatos_home.png',
      categoryKey: 'Gato',
    ),
    CategoryItem(
      title: 'Pescados',
      image: 'assets/categories/pescados_home.png',
      categoryKey: 'Peces',
    ),
    CategoryItem(
      title: 'Hamsters',
      image: 'assets/categories/hamsters_home.png',
      categoryKey: 'Hamster',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = _categories[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetCategoryPage(
                    categoryName: category.categoryKey,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              width: 72,
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.asset(
                          category.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.pets, color: Colors.grey, size: 30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF222222),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
