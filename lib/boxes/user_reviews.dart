
import 'package:hive_flutter/hive_flutter.dart';

part 'user_reviews.g.dart';

@HiveType(typeId: 4)
class UserReviews {
  UserReviews({
    required this.userId,
    required this.movieId,
    required this.comment,
    required this.rate,
  });

  @HiveField(0)
  int userId;

  @HiveField(1)
  int movieId;

  @HiveField(2)
  String comment;

  @HiveField(3)
  double rate;
}
