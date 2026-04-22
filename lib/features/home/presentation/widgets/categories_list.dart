import 'package:flutter/material.dart';
import '../pages/dog_category_page.dart';

class CategoryItem {
  final String title;
  final String image;
  final VoidCallback? onTap;

  const CategoryItem({
    required this.title,
    required this.image,
    this.onTap,
  });
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> categories = [
      const CategoryItem(
        title: 'Accesorios',
        image: 'assets/categories/accesorios_home.png',
      ),
      const CategoryItem(
        title: 'Pájaros',
        image: 'assets/categories/pajaros_home.png',
      ),
      CategoryItem(
        title: 'Perros',
        image: 'assets/categories/perros_home.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DogCategoryPage(),
            ),
          );
        },
      ),
      const CategoryItem(
        title: 'Gatos',
        image: 'assets/categories/gatos_home.png',
      ),
      const CategoryItem(
        title: 'Pescados',
        image: 'assets/categories/pescados_home.png',
      ),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final category = categories[index];

          return InkWell(
            onTap: category.onTap,
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              width: 70,
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Image.asset(
                          category.image,
                          fit: BoxFit.cover,
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
                      fontWeight: FontWeight.w500,
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