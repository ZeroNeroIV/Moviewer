import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviewer/boxes/favorite_model.dart';
import 'package:moviewer/favorites/error_tile.dart';
import 'package:moviewer/favorites/favorites_helper.dart';
import 'package:moviewer/favorites/loading_tile.dart';
import 'package:moviewer/services/tmdb_service.dart';

class FavoriteItem extends StatelessWidget {
  final FavoriteModel favorite;
  final Box<FavoriteModel> box;

  const FavoriteItem({super.key, required this.favorite, required this.box});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: TMDBService.getShowDetails(favorite.showId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingTile();
        } else if (snapshot.hasError) {
          return const ErrorTile();
        }

        final showDetails = snapshot.data!;
        final showName =
            showDetails['title'] ?? showDetails['name'] ?? 'Unknown Show';
        final showImage = showDetails['poster_path'];

        return GestureDetector(
          onTap: () => navigateToShowDetails(context, showDetails),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    TMDBService.getImageUrl(showImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        showName,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                        size: 20,
                      ),
                      onPressed: () => removeFavorite(context, box, favorite),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
