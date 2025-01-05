import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviewer/boxes/favorite_model.dart';
import 'package:moviewer/boxes/user.dart';
import 'package:moviewer/boxes/user_reviews.dart';
import 'package:moviewer/loading_page/page.dart';
import 'package:moviewer/providers/theme_provider.dart';
import 'package:moviewer/providers/user_provider.dart';
import 'package:moviewer/services/auth_service.dart';
import 'package:moviewer/theme/app_theme.dart';
import 'package:moviewer/widgets/custom_error_widget.dart';
import 'package:provider/provider.dart';
import 'package:moviewer/boxes/box.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserReviewsAdapter());
  Hive.registerAdapter(FavoriteModelAdapter());

  // Open necessary Hive boxes
  await Hive.openBox<User>('usersBox');
  await Hive.openBox<UserReviews>('reviewsBox');
  await Hive.openBox<FavoriteModel>('favoriteBox');

  userBox = Hive.box<User>('usersBox');
  reviewsBox = Hive.box<UserReviews>('reviewsBox');
  favoriteBox = Hive.box<FavoriteModel>('favoriteBox');

  // await userBox.clear();
  // await reviewsBox.clear();
  // await favoritesBox.clear();

  userBox.put(
      'adminUser',
      User(
        id: 1,
        username: 'admin',
        password: 'admin',
        email: 'admin',
      ));

  // reviewsBox.add(UserReviews(
  //     userId: 1,
  //     movieId: 1,
  //     comment: 'what a movie , it was great.. etc',
  //     rate: 5));

  // error widget
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(ErrorWidgetClass(details));
  };
  await AuthService().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) {
          final userProvider = UserProvider();
          userProvider.loadAdminUser();
          return userProvider;
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Moviewer',
          theme: AppTheme.lightTheme(),
          darkTheme:
              AppTheme.darkTheme(isPureBlack: themeProvider.pureBlackMode),
          themeMode: themeProvider.themeMode,
          home: const LoadingScreen(),
          // const HomePage(),
          // ReviewPage(movieTitle: 'Bleach'),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
