import 'package:flutter/material.dart';
import 'package:moviewer/constants/main_theme.dart';
import 'package:moviewer/constants/pagination_dots.dart';
import 'package:moviewer/constants/show_grid_view.dart';

class MovieGridScreen extends StatelessWidget {
  const MovieGridScreen({super.key});

  void _handleFilterTap() {
    // Implement filter logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(onTap: _handleFilterTap),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return MovieGridItem(
                    title: 'Movie ${index + 1}',
                  );
                },
              ),
            ),
            const PaginationDots(
              count: 5,
              currentIndex: 0,
            ),
          ],
        ),
      ),
    );
  }
}
