import 'package:flutter/material.dart';
import 'package:moviewer/constants/main_theme.dart';
import 'package:moviewer/review_page/reviewing_page.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String title;
  final String posterUrl;
  final String bannerUrl;
  final String description;
  final double rating;
  final int episodes;

  const MovieDetailsScreen({
    super.key,
    required this.title,
    required this.posterUrl,
    required this.bannerUrl,
    required this.description,
    required this.rating,
    required this.episodes,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isFavorite = false;
  String watchStatus = 'Plan to Watch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: _MovieDetailsSliverDelegate(
              context: context,
              expandedHeight: 400,
              title: widget.title,
              posterUrl: widget.posterUrl,
              bannerUrl: widget.bannerUrl,
              rating: widget.rating,
              episodes: widget.episodes,
              isFavorite: isFavorite,
              onFavoritePressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkGrey.withOpacity(0.6),
                    AppColors.darkGrey,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildInfoBoxes(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  _buildReviews(),
                  _buildSimilarMovies(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoBox('Episodes', '${widget.episodes}'),
        _buildWatchStatusBox(),
        _buildRatingBox(widget.rating),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchStatusBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: watchStatus,
        dropdownColor: AppColors.grey,
        style: const TextStyle(color: Colors.white),
        underline: Container(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        onChanged: (String? newValue) {
          setState(() {
            watchStatus = newValue!;
          });
        },
        items: <String>[
          'Watching',
          'Completed',
          'On Hold',
          'Dropped',
          'Plan to Watch'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRatingBox(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.yellow, size: 20),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reviews',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            behavior: HitTestBehavior.opaque, // Add this line
            // Added GestureDetector
            onTap: _navigateToReviewPage, // Call the navigation method
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: List.generate(
                  3,
                  (index) => _buildReviewItem(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.purple,
            child: Text(
              'U${index + 1}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Great movie! Highly recommended.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarMovies() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Similar Movies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToReviewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(movieTitle: widget.title),
      ),
    );
  }
}

class _MovieDetailsSliverDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final double expandedHeight;
  final String title;
  final String posterUrl;
  final String bannerUrl;
  final double rating;
  final int episodes;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  _MovieDetailsSliverDelegate({
    required this.context,
    required this.expandedHeight,
    required this.title,
    required this.posterUrl,
    required this.bannerUrl,
    required this.rating,
    required this.episodes,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final double tempVal = (shrinkOffset / expandedHeight);
    final double opacity = 1 - tempVal;
    final double posterScale = 0.8 + (0.2 * opacity);

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        // Banner image with gradient overlay
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Image.network(
            bannerUrl,
            fit: BoxFit.cover,
          ),
        ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.darkGrey.withOpacity(0.6),
                AppColors.darkGrey,
              ],
            ),
          ),
        ),
        // Movie poster
        Positioned(
          top: expandedHeight / 4 - shrinkOffset,
          left: size.width / 2 - (100 * posterScale),
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: posterScale,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        posterUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: Colors.yellow,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + MediaQuery.of(context).padding.top;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
