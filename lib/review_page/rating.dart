import 'package:flutter/material.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ModernRatingBar(
          initialRating: 5.0,
          onRatingChanged: (rating) {
            // print('New rating: $rating');
          },
        ),
      ),
    );
  }
}

class ModernRatingBar extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double>? onRatingChanged;

  const ModernRatingBar({
    super.key,
    this.initialRating = 0.0,
    this.onRatingChanged,
  });

  @override
  State<ModernRatingBar> createState() => _ModernRatingBarState();
}

class _ModernRatingBarState extends State<ModernRatingBar> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SizedBox(
            height: 150,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              diameterRatio: 2.0,
              onSelectedItemChanged: (index) {
                setState(() {
                  _currentRating = index / 10.0; // Convert to floating point
                });
                widget.onRatingChanged?.call(_currentRating);
              },
              physics: const FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index > 100) {
                    return null; // Limit range to 0.0-10.0
                  }
                  final ratingValue = index / 10.0;
                  final isSelected = (ratingValue == _currentRating);
                  return Center(
                    child: Text(
                      ratingValue.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: isSelected ? 36 : 24,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  );
                },
                childCount: 101, // 0.0 to 10.0 with 0.1 steps
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(10, (index) {
            return Icon(
              index < _currentRating.floor()
                  ? Icons.star
                  : Icons.star_border_outlined,
              size: 32,
              color: Colors.amber,
            );
          }),
        ),
      ],
    );
  }
}
