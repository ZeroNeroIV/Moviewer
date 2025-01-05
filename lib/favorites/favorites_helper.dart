import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviewer/boxes/favorite_model.dart';
import 'package:moviewer/details_page/show_details_page.dart';

void navigateToShowDetails(BuildContext context, Map<String, dynamic> details) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ShowDetailsScreen(showData: details),
    ),
  );
}

void removeFavorite(
    BuildContext context, Box<FavoriteModel> box, FavoriteModel favorite) {
  box.delete(favorite.key);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Removed from favorites'),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
