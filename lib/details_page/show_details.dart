import 'package:flutter/material.dart';

class ShowDetails extends StatelessWidget {
  final int showId;

  const ShowDetails({required this.showId})
      : super(key: const Key("ShowDetails"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchShowDetails(showId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Header Section
              Container(
                height: 200,
                color: Colors.green,
                child: Center(
                  child: Image.network(
                    data['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title, Rating, and Episode Number
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['title'],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Column(
                    children: [
                      const Text('Rating'),
                      Text(
                        data['rating'].toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description Section
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(data['description']),
              const SizedBox(height: 16),

              // Reviews Section
              Text(
                'Reviews',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ...data['reviews'].map<Widget>((review) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(review),
                  ),
                );
              }).toList(),
              const SizedBox(height: 16),

              // Similar Shows Section
              Text(
                'Similar Shows',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: data['similar'].map<Widget>((show) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            show['imageUrl'],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(show['title']),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchShowDetails(int id) async {
    return {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Sample Show',
      'rating': 4.5,
      'description': 'This is a sample show description.',
      'reviews': ['Great show!', 'Loved it!', 'Amazing performance!'],
      'similar': [
        {
          'imageUrl': 'https://via.placeholder.com/100',
          'title': 'Similar Show 1'
        },
        {
          'imageUrl': 'https://via.placeholder.com/100',
          'title': 'Similar Show 2'
        },
      ],
    };
  }
}
