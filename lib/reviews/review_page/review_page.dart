import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviewer/app_settings_page/app_settings.dart';
import 'package:moviewer/boxes/user_reviews.dart';
import 'package:moviewer/providers/user_provider.dart';
import 'package:moviewer/services/tmdb_service.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  final int movieId;
  const ReviewPage({super.key, required this.movieId});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 5.0;
  String _review = '';
  late Future<Map<String, dynamic>> _movieDetailsFuture;
  late Box<UserReviews> _reviewsBox;

  @override
  void initState() {
    super.initState();
    _movieDetailsFuture = TMDBService.getShowDetails(widget.movieId);
    _reviewsBox = Hive.box<UserReviews>('reviewsBox');
  }

  void _submitReview(int userId, int movieId) {
    if (_review.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a review')),
      );
      return;
    }

    _reviewsBox.add(UserReviews(
      movieId: movieId,
      userId: userId,
      rate: _rating,
      comment: _review,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review submitted successfully')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.user?.id ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Review Page',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No movie details available'));
          }

          final movie = snapshot.data!;
          final movieName = movie['title'] ?? 'Unknown Movie';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  movieName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.purple, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Image.network(
                  TMDBService.getImageUrl(movie['poster_path']),
                  width: 200,
                  height: 300,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 100),
                ),
                const SizedBox(height: 20),
                Text(
                  movie['overview'] ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ModernRatingBar(
                  initialRating: _rating,
                  onRatingChanged: (rating) => setState(() => _rating = rating),
                ),
                const SizedBox(height: 20),
                TextFieldReview(
                  onTextChanged: (text) => setState(() => _review = text),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submitReview(userId, movie['id']),
                  child: const Text('Submit Review'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ModernRatingBar extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double>? onRatingChanged;

  const ModernRatingBar({
    super.key,
    this.initialRating = 5.0,
    this.onRatingChanged,
  });

  @override
  State<ModernRatingBar> createState() => _ModernRatingBarState();
}

class _ModernRatingBarState extends State<ModernRatingBar> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Rating:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.purple,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          height: 100,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            diameterRatio: 2.0,
            onSelectedItemChanged: (index) {
              setState(() => _currentRating = index / 10.0 + 0.5);
              widget.onRatingChanged?.call(_currentRating);
            },
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index < 0 || index > 90) return null;
                final ratingValue = index / 10.0 + 0.5;
                final isSelected = (ratingValue == _currentRating);
                return Center(
                  child: Text(
                    ratingValue.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: isSelected ? 36 : 24,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              },
              childCount: 91,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(10, (index) {
            return Icon(
              index < _currentRating.floor() ? Icons.star : Icons.star_border,
              size: 32,
              color: Colors.amber,
            );
          }),
        ),
      ],
    );
  }
}

class TextFieldReview extends StatelessWidget {
  final ValueChanged<String>? onTextChanged;

  const TextFieldReview({super.key, this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Review:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: onTextChanged,
          decoration: InputDecoration(
            hintText: 'Write your review here',
            hintStyle: TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: const Color.fromARGB(255, 0, 0, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: 5,
        ),
      ],
    );
  }
}
