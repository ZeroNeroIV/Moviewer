import 'package:flutter/material.dart';
import 'package:moviewer/constants/main_theme.dart';

class SearchBar extends StatelessWidget {
  final VoidCallback onFilterTap;

  const SearchBar({
    super.key,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search movies...',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.7)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          FilterButton(onTap: onFilterTap),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }
}
