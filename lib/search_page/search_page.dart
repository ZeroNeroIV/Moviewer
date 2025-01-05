import 'package:flutter/material.dart';
import 'package:moviewer/services/tmdb_service.dart';
import 'package:moviewer/search_page/search_page_input.dart';
import 'package:moviewer/search_page/search_results.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  String _query = '';
  String _selectedGenre = '';
  String _releaseDate = '';
  List<dynamic> _searchResults = [];

  void _performSearch() async {
    final results = await TMDBService.searchShows(
      _query,
      genre: _selectedGenre.isNotEmpty ? _selectedGenre : null,
      releaseYear:
          _releaseDate.isNotEmpty ? _releaseDate.substring(0, 4) : null,
    );
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SearchPageInput(
                    query: _query,
                    selectedGenre: _selectedGenre,
                    releaseDate: _releaseDate,
                    onQueryChanged: (value) => setState(() => _query = value),
                    onGenreSelected: (genre) =>
                        setState(() => _selectedGenre = genre),
                    onReleaseDateChanged: (value) =>
                        setState(() => _releaseDate = value),
                    onSearch: _performSearch,
                  ),
                  SearchResults(searchResults: _searchResults),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
