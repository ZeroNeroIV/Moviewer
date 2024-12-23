import 'package:flutter/material.dart';
import 'package:moviewer/home_page/home_page_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {
                // Handle search button press
              },
            ),
          ],
        ),
        body: ListView(
          children: const [
            HomePageSection(
              title: 'Upnext',
            ),
            SizedBox(
              height: 30,
            ),
            HomePageSection(
              title: 'Trending',
            ),
            SizedBox(
              height: 30,
            ),
            HomePageSection(
              title: 'Recommended',
            ),
            SizedBox(
              height: 30,
            ),
            HomePageSection(
              title: 'Latest',
            ),
            SizedBox(
              height: 30,
            ),
            HomePageSection(
              title: 'Recently Reviewed',
            ),
          ],
        ),
        // Movies | Series | HOME | Fav | Settings
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 25, 250, 5),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_movies),
              label: 'Series',
            ),
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
        ));
  }
}
