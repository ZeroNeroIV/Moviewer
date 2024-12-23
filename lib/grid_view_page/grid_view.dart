import 'package:flutter/material.dart';

class Gridview extends StatelessWidget {
  // const TempBars({super.key});
  final List<Map<String, String>> items = [
    {
      'name': 'qaruti',
      'image':
          'https://as1.ftcdn.net/v2/jpg/02/82/22/38/1000_F_282223867_614Zl14w6BgmjNeMZbNn6cNnjrlF28Hy.jpg'
    },
    {
      'name': 'Ameen',
      'image':
          'https://as1.ftcdn.net/v2/jpg/02/64/49/96/1000_F_264499678_ZSxhqZrofs1MujLpJ8EGlrDmEbMqmZNB.jpg'
    },
    {
      'name': 'some one',
      'image':
          'https://as1.ftcdn.net/v2/jpg/02/06/34/42/1000_F_206344246_MMrEyvFUEwF94kiBy6mgZnHNk6tS4e8H.jpg'
    },
    {
      'name': '...',
      'image':
          'https://i.postimg.cc/4NXRJ8kP/25446972-abb3-4a66-ad02-9299c5faa6c9.jpg'
    },
    
  ];
  int itemCount = 0;

  Gridview({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:546376054.
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return MovieCard(
            name: item['name']!,
            imageUrl: item['image']!,
            onTap: () {
              // Navigate to the movie details page

            },
          );
        },
      ),
      // itemCount: items.length,
      // itemBuilder:
    ));
  }
}

class MovieCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
