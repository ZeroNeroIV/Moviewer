import 'package:flutter/material.dart';
import 'package:moviewer/constants/main_theme.dart';

class MovieGridItem extends StatelessWidget {
  final String title;
  final String? imageUrl;

  const MovieGridItem({
    super.key,
    required this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Movie Image
            Container(
              color: AppColors.darkGrey,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : null,
            ),
            // Title Gradient
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TitleGradient(title: title),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleGradient extends StatelessWidget {
  final String title;

  const TitleGradient({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
