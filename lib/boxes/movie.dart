import 'package:hive_flutter/hive_flutter.dart';

part 'movie.g.dart';

@HiveType(typeId: 2)
class Movie {
  Movie({
    required this.movieId,
    required this.movieName,
    required this.imgURL,
  });

  @HiveField(0)
  int movieId;

  @HiveField(1)
  String movieName;

  @HiveField(2)
  String imgURL;
}
