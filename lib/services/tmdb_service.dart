// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TMDBService {
  static final String _baseUrl =
      dotenv.env['TMDB_BASE_URL'] ?? 'https://api.themoviedb.org/3';
  static final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
  static final String _imageBaseUrl =
      dotenv.env['TMDB_IMAGE_BASE_URL'] ?? 'https://image.tmdb.org/t/p/';

  static String getImageUrl(String? path,
      {String size = 'w500',
      String defaultImageUrl =
          'https://coffective.com/wp-content/uploads/2018/06/default-featured-image.png.jpg?text=No+Image'}) {
    if (path == null || path.isEmpty) {
      return defaultImageUrl;
    }
    return '$_imageBaseUrl$size$path';
  }

  static Future<Map<String, dynamic>> getShowDetails(int showId) async {
    final url = '$_baseUrl/movie/$showId?include_adult=false&api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load show details: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getPopularShows({int page = 1}) async {
    final url =
        '$_baseUrl/movie/popular?include_adult=false&api_key=$_apiKey&page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body is Map && body['results'] is List) {
          return body['results'];
        } else {
          throw Exception('Unexpected response format: ${response.body}');
        }
      } else {
        throw Exception(
            'Failed to load popular movies. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      print('Error in getPopularShows: $e');
      rethrow;
    }
  }

  static Future<List<dynamic>> getMostRecentShows({int limit = 6}) async {
    final url =
        '$_baseUrl/movie/now_playing?include_adult=false&api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'] as List;
      final limitedResults = results.take(limit).toList();
      for (var show in limitedResults) {
        final details = await getShowDetails(show['id']);
        show['duration'] = details['runtime'];
      }
      return limitedResults;
    } else {
      throw Exception(
          'Failed to load most recent movies: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getMostTrendingShows({int limit = 6}) async {
    final url =
        '$_baseUrl/trending/movie/week?include_adult=false&api_key=$_apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body is Map && body['results'] is List) {
          final results = _checkMediaTypeAndFix(body['results'] as List);
          return results.take(limit).toList();
        } else {
          throw Exception('Unexpected response format: ${response.body}');
        }
      } else {
        throw Exception(
            'Failed to load trending shows. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      print('Error in getMostTrendingShows: $e');
      rethrow;
    }
  }

  static Future<List<dynamic>> getRecentlyReviewedShows({int limit = 6}) async {
    final url =
        '$_baseUrl/movie/top_rated?include_adult=false&api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final results = _checkMediaTypeAndFix(
        json.decode(response.body)['results'] as List,
      );
      final limitedResults = results.take(limit).toList();
      for (var show in limitedResults) {
        final details = await getShowDetails(show['id']);
        show['duration'] = details['runtime'];
      }
      return limitedResults;
    } else {
      throw Exception(
          'Failed to load recently reviewed shows: ${response.statusCode}');
    }
  }

  static Future<bool> submitReview(
      int showId, double rating, String text) async {
    final url = '$_baseUrl/movie/$showId/rating?api_key=$_apiKey';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: json.encode({'value': rating}),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to submit review: ${response.statusCode}');
    }
  }

  static int? _getGenreId(String genre) {
    switch (genre.toLowerCase()) {
      case 'action':
        return 28;
      case 'comedy':
        return 35;
      case 'drama':
        return 18;
      // Add more genres as needed
      default:
        return null;
    }
  }

  static Future<List<dynamic>> searchShows(String query,
      {String? genre, String? releaseYear}) async {
    var url =
        '$_baseUrl/search/movie?include_adult=false&api_key=$_apiKey&query=$query';
    if (genre != null && genre.isNotEmpty) {
      final genreId = _getGenreId(genre);
      if (genreId != null) {
        url += '&with_genres=$genreId';
      }
    }
    if (releaseYear != null && releaseYear.isNotEmpty) {
      url += '&primary_release_year=$releaseYear';
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List? ?? [];
      return results;
    } else {
      throw Exception('Failed to load search results: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getSimilarMovies(int movieId) async {
    final url =
        '$_baseUrl/movie/$movieId/similar?include_adult=false&api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body is Map && body['results'] is List) {
        return body['results'];
      } else {
        throw Exception('Unexpected response format: ${response.body}');
      }
    } else {
      throw Exception(
          'Failed to load similar movies. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }

  static Future<List<dynamic>> getMovieVideos(int movieId) async {
    final url = '$_baseUrl/movie/$movieId/videos?api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body is Map && body['results'] is List) {
        return body['results'];
      } else {
        throw Exception('Unexpected response format: ${response.body}');
      }
    } else {
      throw Exception(
          'Failed to load movie videos. Status code: ${response.statusCode}');
    }
  }

  static List _checkMediaTypeAndFix(List results) {
    for (var element in results) {
      if (element['media_type'] == null) {
        element['media_type'] = 'movie';
      }
    }
    return results;
  }
}
