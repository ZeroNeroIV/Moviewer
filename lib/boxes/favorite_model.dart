import 'package:hive_flutter/hive_flutter.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 3)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  int userId;

  @HiveField(1)
  int showId;

  FavoriteModel({
    required this.userId,
    required this.showId,
  });
}
