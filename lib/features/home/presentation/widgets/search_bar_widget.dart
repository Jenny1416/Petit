import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: Color(0xFFB7B7B7)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Busque cualquier producto..',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFB7B7B7),
              ),
            ),
          ),
          Icon(Icons.mic_none_rounded, color: Color(0xFFB7B7B7)),
        ],
      ),
    );
  }
}