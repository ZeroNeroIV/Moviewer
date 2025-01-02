import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviewer/boxes/user_reviews.dart';
import 'package:moviewer/details_page/show_details_page.dart';
import 'package:moviewer/providers/user_provider.dart';
import 'package:moviewer/services/tmdb_service.dart';
import 'package:provider/provider.dart';

class Reviews extends StatefulWidget {
  const Reviews({
    super.key,
  });

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  late Box<UserReviews> reviewsBox;
  final List<Map<String, dynamic>> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    reviewsBox = Hive.box<UserReviews>('reviewsBox');
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final moviesIds = <int>{};
    for (var review in reviewsBox.values) {
      if (!moviesIds.contains(review.movieId) &&
          review.userId == context.read<UserProvider>().user?.id) {
        moviesIds.add(review.movieId);
      }
    }

    for (var id in moviesIds) {
      final movieDetails = await TMDBService.getShowDetails(id);
      _movies.add(movieDetails);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    int userId = userProvider.user?.id ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Reviews", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ValueListenableBuilder(
                valueListenable: reviewsBox.listenable(),
                builder: (context, Box<UserReviews> box, _) {
                  final reviews = box.values
                      .where((review) => review.userId == userId)
                      .toList();

                  if (reviews.isEmpty) {
                    return const Center(
                      child: Text(
                        'No reviews available!',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      final movie = _movies.firstWhere(
                          (m) => m['id'] == review.movieId,
                          orElse: () => {});

                      if (movie.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return GestureDetector(
                        onTap: () async => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowDetailsScreen(
                              showData: movie,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 150,
                                child: Image.network(
                                  TMDBService.getImageUrl(
                                      movie['poster_path'] ?? ''),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error, size: 100),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie['title'] ?? 'Unknown Movie',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      review.comment,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
