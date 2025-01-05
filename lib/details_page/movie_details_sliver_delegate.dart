import 'package:flutter/material.dart';
import 'package:moviewer/app_settings_page/app_settings.dart';
import 'package:moviewer/services/tmdb_service.dart';

class MovieDetailsSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String title;
  final String? posterUrl;
  final String? bannerUrl;
  final double rating;
  final int? duration;
  final bool isFavorite;
  final void Function() onFavoritePressed;
  final BuildContext context;

  MovieDetailsSliverDelegate({
    required this.expandedHeight,
    required this.title,
    required this.posterUrl,
    required this.bannerUrl,
    required this.rating,
    required this.duration,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.context,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double fadePercent = shrinkOffset / expandedHeight;
    final double posterOpacity = (1 - fadePercent).clamp(0.0, 1.0);
    final double centerOffset = (expandedHeight - shrinkOffset) / 2;

    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: (1 - fadePercent).clamp(0.0, 1.0),
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              TMDBService.getImageUrl(bannerUrl),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 5,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.darkGrey.withOpacity(0.6),
                AppColors.darkGrey,
              ],
            ),
          ),
        ),
        Positioned(
          top: centerOffset - 150,
          left: MediaQuery.of(context).size.width / 2 - 100,
          child: Opacity(
            opacity: posterOpacity,
            child: Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    TMDBService.getImageUrl(posterUrl),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: centerOffset - 175,
          right: MediaQuery.of(context).size.width / 2 - 125,
          child: IconButton(
            splashColor: Colors.grey.withAlpha(40),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 40,
              semanticLabel: 'Add to Favorites',
            ),
            onPressed: onFavoritePressed,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + MediaQuery.of(context).padding.top;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
