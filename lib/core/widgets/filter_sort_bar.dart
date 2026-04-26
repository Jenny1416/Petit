import 'package:flutter/material.dart';
import '../models/sort_option.dart';

class FilterSortBar extends StatelessWidget {
  final String title;
  final SortOption currentSort;
  final Function(SortOption) onSortChanged;
  final String selectedCategory;
  final List<String> categories;
  final Function(String) onCategoryChanged;

  const FilterSortBar({
    super.key,
    required this.title,
    required this.currentSort,
    required this.onSortChanged,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
  });

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ordenar por',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...SortOption.values.map((option) {
                final isSelected = currentSort == option;
                return ListTile(
                  title: Text(
                    option.label,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF32B56A) : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: Color(0xFF32B56A)) : null,
                  onTap: () {
                    onSortChanged(option);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filtrar por Categoría',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...categories.map((category) {
                final isSelected = selectedCategory == category;
                return ListTile(
                  title: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF32B56A) : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: Color(0xFF32B56A)) : null,
                  onTap: () {
                    onCategoryChanged(category);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ),
        _actionButton(
          icon: Icons.swap_vert,
          text: 'Sort',
          onTap: () => _showSortOptions(context),
        ),
        const SizedBox(width: 8),
        _actionButton(
          icon: Icons.filter_alt_outlined,
          text: 'Filter',
          onTap: () => _showFilterOptions(context),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE8E8E8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
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
      ),
    );
  }
}
