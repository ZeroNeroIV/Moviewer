import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = dotenv.env['FILM_SHOW_RATING_API_URL'];
  final _apiKey = dotenv.env['FILM_SHOW_RATING_API_KEY']!;

  Future<Map<String, dynamic>> fetchShowDetails(String showId) async {
    final url = Uri.parse('$_baseUrl/?id=$showId');

    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': 'film-show-ratings.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return parsed JSON data
    } else {
      throw Exception(
          'Failed to fetch show details. Status code: ${response.statusCode}');
    }
  }
}
