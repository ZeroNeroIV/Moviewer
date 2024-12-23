import 'package:flutter/material.dart';
import 'package:moviewer/constants/main_theme.dart';

class PaginationDots extends StatelessWidget {
  final int count;
  final int currentIndex;

  const PaginationDots({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentIndex ? AppColors.purple : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
