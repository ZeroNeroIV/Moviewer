// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:moviewer/details_page/show_details_page.dart';
import 'package:moviewer/home_page/show_more_page.dart';
import 'package:moviewer/services/tmdb_service.dart';

class HomePageSection extends StatefulWidget {
  final String title;
  final Future<List<dynamic>> Function() fetchData;

  const HomePageSection({
    super.key,
    required this.title,
    required this.fetchData,
  });

  @override
  State<HomePageSection> createState() => _HomePageSectionState();
}

class _HomePageSectionState extends State<HomePageSection> {
  List<dynamic>? _items;
  bool _isLoading = true;
  bool _hasError = false;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void refresh() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await widget.fetchData();
      if (!mounted) return;
      setState(() {
        _items = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  List<List<dynamic>> _getPages(List<dynamic> items, int itemsPerPage) {
    return List.generate(
      (items.length / itemsPerPage).ceil(),
      (index) => items.skip(index * itemsPerPage).take(itemsPerPage).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowMorePage(
                          title: widget.title,
                          fetchData: widget.fetchData,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Show All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                IconButton(
                  onPressed: refresh,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _hasError
                  ? const Center(child: Text('Error loading data'))
                  : Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {});
                            },
                            itemCount: _getPages(_items!, 6).length,
                            itemBuilder: (context, pageIndex) {
                              final pageItems =
                                  _getPages(_items!, 6)[pageIndex];
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: pageItems.length,
                                itemBuilder: (context, index) {
                                  final item = pageItems[index];
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: SizedBox(
                                        width: 100,
                                        child: Column(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 3 / 5,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                  top: Radius.circular(8),
                                                ),
                                                child: Image.network(
                                                  TMDBService.getImageUrl(
                                                      item['poster_path']),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Icon(
                                                    Icons.error,
                                                    size: 50,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                item['title'] ?? item['name'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .fontSize,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
        ),
      ],
    );
  }
}
