import 'package:flutter/material.dart';
import 'package:moviewer/review_page/rating.dart';

class ReviewPage extends StatelessWidget {
  final String movieTitle;
  const ReviewPage({
    super.key,
    required this.movieTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        titleTextStyle: const TextStyle(color: Color.fromARGB(255, 101, 185, 147) , fontSize: 25),
        title: Text(movieTitle , selectionColor: Colors.white,),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 32, 3, 79),
      ),
      body: const RatingSection(movieTitle: 'aa'),
    );
  }
}
