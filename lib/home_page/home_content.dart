import 'package:flutter/material.dart';
import 'package:moviewer/boxes/box.dart';
import 'package:moviewer/home_page/home_page_section.dart';
import 'package:moviewer/services/tmdb_service.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final sections = [
    ('Trending', () => TMDBService.getMostTrendingShows(limit: 500)),
    ('Popular', () => TMDBService.getPopularShows(page: 100)),
    ('Latest', () => TMDBService.getMostRecentShows(limit: 500)),
    (
      'Recently Reviewed',
      () {
        final reviews = reviewsBox.values.toList();

        return Future.wait(reviews
            .map((review) {
              return TMDBService.getShowDetails(review.movieId);
            })
            .toList()
            .reversed);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: sections.length * 2 - 1,
        itemBuilder: (context, index) {
          if (index.isEven) {
            final sectionIndex = index ~/ 2;
            final (title, fetchFunction) = sections[sectionIndex];
            return HomePageSection(
              title: title,
              fetchData: () => fetchFunction(),
            );
          } else {
            return const SizedBox(height: 30);
          }
        },
      ),
    );
  }
}
