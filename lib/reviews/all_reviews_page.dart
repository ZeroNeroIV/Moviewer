import 'package:flutter/material.dart';
import 'package:moviewer/app_settings_page/app_settings.dart';
import 'package:moviewer/boxes/box.dart';

class AllReviewsPage extends StatelessWidget {
  final int movieId;
  final String movieTitle;

  const AllReviewsPage({
    super.key,
    required this.movieTitle,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    var reviews =
        reviewsBox.values.where((review) => review.movieId == movieId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews for "$movieTitle"'),
      ),
      body: reviews.isEmpty
          ? const Center(child: Text('No reviews available'))
          : ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return _buildReviewItem(reviews[index]);
              },
            ),
    );
  }

  Widget _buildReviewItem(review) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.purple,
                child: Text(
                  review.userId.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User ${review.userId}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(
                          10,
                          (starIndex) => Icon(
                            Icons.star,
                            color: starIndex < review.rate
                                ? Colors.yellow
                                : Colors.grey,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${review.rate}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: const TextStyle(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
