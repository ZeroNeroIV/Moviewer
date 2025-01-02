import 'package:flutter/material.dart';
import 'package:moviewer/app_settings_page/app_settings.dart';
import 'package:moviewer/search_page/search_page.dart';
import 'package:moviewer/favorites/favorites_page.dart';
import 'package:moviewer/home_page/home_content.dart';
import 'package:moviewer/providers/theme_provider.dart';
import 'package:moviewer/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const FavoritesScreen(),
    AppSettingsScreen(),
  ];

  void changeIndex(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    Provider.of<UserProvider>(context);

    // Titles for each page
    final List<String> titles = ['Home Page', 'Favorites', 'Settings'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentIndex],
        ),
        actions: _currentIndex == 1 || _currentIndex == 2
            ? [] // No search icon on Favorites or Settings
            : [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (int index) {
          changeIndex(index);
        },
      ),
    );
  }
}
