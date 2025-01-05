import 'package:flutter/material.dart';
import 'package:moviewer/app_settings_page/app_settings.dart';
import 'package:moviewer/boxes/box.dart';
import 'package:moviewer/boxes/favorite_model.dart';
import 'package:moviewer/details_page/movie_details_sliver_delegate.dart';
import 'package:moviewer/reviews/all_reviews_page.dart';
import 'package:moviewer/providers/theme_provider.dart';
import 'package:moviewer/providers/user_provider.dart';
import 'package:moviewer/reviews/review_page/review_page.dart';
import 'package:moviewer/services/tmdb_service.dart';
import 'package:provider/provider.dart';

class ShowDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> showData;

  const ShowDetailsScreen({
    super.key,
    required this.showData,
  });

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  String watchStatus = 'Plan to Watch';

  @override
  void initState() {
    super.initState();
  }

  void _checkIfFavorite(int userId) {
    final isFav = favoriteBox.values.any(
      (favorite) =>
          favorite.showId == widget.showData['id'] && favorite.userId == userId,
    );
    setState(() {
      isFavorite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    int userId = userProvider.user?.id ?? 0;
    _checkIfFavorite(userId);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: MovieDetailsSliverDelegate(
              expandedHeight: 400,
              title: widget.showData['title'],
              posterUrl: widget.showData['poster_path'],
              bannerUrl: widget.showData['backdrop_path'],
              rating:
                  widget.showData['vote_average'] ?? widget.showData['rating'],
              duration: widget.showData['duration'] ?? 0,
              isFavorite: isFavorite,
              onFavoritePressed: () => _toggleFavorite(userId),
              context: context,
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
                    widget.showData['title'],
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
                  _buildSimilarMovies(widget.showData['id']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(int userId) {
    setState(
      () {
        if (isFavorite) {
          // Find and delete the favorite
          final favoriteToDelete = favoriteBox.values.firstWhere(
            (favorite) =>
                favorite.showId == widget.showData['id'] &&
                favorite.userId == userId,
            orElse: () => FavoriteModel(
              userId: userId,
              showId: widget.showData['id'],
            ),
          );
          favoriteBox.delete(favoriteToDelete.key);
        } else {
          // Add new favorite
          favoriteBox.add(FavoriteModel(
            userId: userId,
            showId: widget.showData['id'],
          ));
        }
        isFavorite = !isFavorite;
      },
    );
  }

  Widget _buildInfoBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoBox('Duration',
            '${widget.showData['duration'] ?? widget.showData['runtime'] ?? 0}'),
        _buildWatchStatusBox(),
        _buildRatingBox(
            widget.showData['vote_average'] ?? widget.showData['rating']),
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
            widget.showData['overview'] ??
                widget.showData['description'] ??
                'No data...',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reviews',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // NavigationBar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(
                        movieId: widget.showData['id'],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Add Review'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onLongPress: _onLongPress,
            onTap: _navigateToReviewPage,
            child: Stack(
              children: [
                Container(
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
                const Positioned(
                  bottom: 15,
                  right: 25,
                  child: Text(
                    'More...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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

  Widget _buildSimilarMovies(int movieId) {
    return FutureBuilder<List<dynamic>>(
      future: TMDBService.getSimilarMovies(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Failed to load similar movies.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'No similar movies found.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          final similarMovies = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
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
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: similarMovies.length,
                    itemBuilder: (context, index) {
                      final item = similarMovies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ShowDetailsScreen(
                                  showData: item,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 2 / 3,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    TMDBService.getImageUrl(
                                        item['poster_path']),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.error,
                                      size: 50,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['title'] ?? item['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _navigateToReviewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllReviewsPage(
          movieId: widget.showData['id'],
          movieTitle: widget.showData['title'],
        ),
      ),
    );
  }

  void _onLongPress() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Press to show all reviews.'),
              // button to navigate to review page
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllReviewsPage(
                        movieId: widget.showData['id'],
                        movieTitle: widget.showData['title'],
                      ),
                    ),
                  );
                },
                child: const Text('Show All Reviews'),
              ),
            ],
          ),
        );
      },
      useSafeArea: true,
    );
  }
}
