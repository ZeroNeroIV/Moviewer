import 'package:flutter/material.dart';
import 'package:moviewer/default_widget.dart/default.dart';

class HomePageSection extends StatelessWidget {
  final String title;

  const HomePageSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 20, bottom: 50),
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: Colors.amber,
            child: Scrollbar(
              controller: scrollController,
              child: ListView(
                padding: const EdgeInsets.all(5),
                scrollDirection: Axis.horizontal,
                children: [
                  const Default(),
                  const Default(
                    width: 100,
                    height: 125,
                    color: Colors.blue,
                  ),
                  const Default(
                    width: 100,
                    height: 125,
                    color: Colors.red,
                  ),
                  const Default(
                    width: 100,
                    height: 125,
                    color: Colors.blue,
                  ),
                  const Default(
                    width: 100,
                    height: 125,
                    color: Colors.red,
                  ),
                  const Default(
                    width: 100,
                    height: 125,
                    color: Colors.blue,
                  ),
                  const Default(
                    width: 100,
                    height: 125,
                    color: Colors.red,
                  ),
                  Positioned(
                    width: 30,
                    height: 30,
                    top: 60,
                    left: 215,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Handle button press here
                      },
                      child: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  )
                ],
              ),
            )
            // Stack(
            //   children: [
            //     Positioned(
            //       width: 30,
            //       height: 30,
            //       top: 60,
            //       left: 215,
            //       child: FloatingActionButton(
            //         onPressed: () {
            //           // Handle button press here
            //         },
            //         child:
            //             const Icon(Icons.arrow_forward_ios_rounded),
            //       ),
            //     )
            //   ],
            // ),
            ),
      ],
    );
  }
}
