import 'package:flutter/material.dart';
import 'package:moviewer/constants/main_theme.dart';

class MovieHeader extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onBack;

  const MovieHeader({
    super.key,
    this.imageUrl,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hero Image
        Container(
          height: 300,
          width: double.infinity,
          color: AppColors.grey,
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        // Back Button
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack,
          ),
        ),
        // Poster
        Positioned(
          bottom: -50,
          left: 16,
          child: MoviePoster(imageUrl: imageUrl),
        ),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String? imageUrl;

  const MoviePoster({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            )
          : null,
    );
  }
}
