import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviewer/boxes/favorite_model.dart';
import 'package:moviewer/favorites/favorite_item.dart';

class FavoritesList extends StatelessWidget {
  final int? currentUserId;

  const FavoritesList({super.key, this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final favoriteBox = Hive.box<FavoriteModel>('favoriteBox');

    return ValueListenableBuilder(
      valueListenable: favoriteBox.listenable(),
      builder: (context, Box<FavoriteModel> box, _) {
        final favoriteItems = box.values
            .where((favorite) => favorite.userId == currentUserId)
            .toList();

        if (favoriteItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border,
                    size: 64, color: Theme.of(context).primaryColor),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Start adding shows to your favorites.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            final favorite = favoriteItems[index];
            return FavoriteItem(favorite: favorite, box: box);
          },
        );
      },
    );
  }
}
