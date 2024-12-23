import 'package:flutter/material.dart';
import 'package:moviewer/constants/shows_page.dart';
// import 'package:moviewer/review_page/reviewing_page.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  // WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moviewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          //  const ReviewPage(movieTitle: 'Bleach',),
          const MovieDetailsScreen(
        title: 'TITLE',
        bannerUrl: '',
        posterUrl: '',
        rating: 8.30,
        episodes: 9,
        description: '',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
