import 'package:flutter/material.dart';

class SearchPageInput extends StatelessWidget {
  final String query;
  final String selectedGenre;
  final String releaseDate;
  final Function(String) onQueryChanged;
  final Function(String) onGenreSelected;
  final Function(String) onReleaseDateChanged;
  final VoidCallback onSearch;

  const SearchPageInput({
    super.key,
    required this.query,
    required this.selectedGenre,
    required this.releaseDate,
    required this.onQueryChanged,
    required this.onGenreSelected,
    required this.onReleaseDateChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter movie title',
            prefixIcon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.onSurface),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            fillColor: Theme.of(context).colorScheme.surface,
            filled: true,
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          onChanged: onQueryChanged,
        ),
        const SizedBox(height: 16),
        Text('Genre',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            for (final genre in ['Action', 'Comedy', 'Drama', 'Sci-Fi'])
              ChoiceChip(
                label: Text(genre),
                selected: selectedGenre == genre,
                selectedColor: Theme.of(context).colorScheme.primary,
                labelStyle: TextStyle(
                  color: selectedGenre == genre
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
                onSelected: (selected) =>
                    onGenreSelected(selected ? genre : ''),
              ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter release date (YYYY-MM-DD)',
            prefixIcon: Icon(Icons.calendar_today,
                color: Theme.of(context).colorScheme.onSurface),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            fillColor: Theme.of(context).colorScheme.surface,
            filled: true,
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          onChanged: onReleaseDateChanged,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onSearch,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text('Search',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        ),
      ],
    );
  }
}
