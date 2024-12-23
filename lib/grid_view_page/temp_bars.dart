import 'package:flutter/material.dart';
import 'package:moviewer/grid_view_page/grid_view.dart';

class TempBars extends StatelessWidget {
  const TempBars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temp Till ameen do somthing"),
      
        backgroundColor: const Color.fromARGB(255, 112, 19, 6),
        
      ),
      body: Gridview(),
    );
  }
}