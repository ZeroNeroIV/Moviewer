import 'package:flutter/material.dart';

class RatingSection extends StatefulWidget {
  final String movieTitle;
  const RatingSection({
    super.key,
    required this.movieTitle,
  });

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  double therating = 5.0;
  String TextReview = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ModernRatingBar(
              initialRating: 5.0,
              onRatingChanged: (rating) {
                // print('New rating: $rating');
                setState(() {
                  therating = rating;
                });
              },
            ),
            TextFieldReview(
              onTextChanged: (newText) {
                setState(() {
                  TextReview = newText;
                });
              },
            ),
            Container(
            
            child : ElevatedButton(
              onPressed: () {
                print('Rating: $therating');
                print('Review: $TextReview');
              },
              child: const Text('Submit'),
            ),

            ),
          ],
        ));
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 1.0), // Small space on the left
            child: Text(
              'Please Add your Review:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 183, 8, 78),
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
              height: 100,
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
          const SizedBox(
            height: 10,
            width: 20,
          ),
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
      ),
    );
  }
}

// Suggested code may be subject to a license. Learn more: ~LicenseLog:653658030.
class TextFieldReview extends StatefulWidget {
   final ValueChanged<String>? onTextChanged;
 const TextFieldReview({super.key , this.onTextChanged});

  @override
  State<TextFieldReview> createState() => _TextFieldReviewState();
}

class _TextFieldReviewState extends State<TextFieldReview> {
  String _currentText = '';
 
  // @override
  // void intialState() {
  //   super.initState();
  //   _currentText = '';
  // }

  void _updateCurrentText(String newText) {
    setState(() {
      _currentText = newText;
    });
     // Notify the parent widget of the text change
    if (widget.onTextChanged != null) {
      widget.onTextChanged!(newText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        width: 300,
        height: 100,
        child: TextField(
          onChanged: _updateCurrentText,
          decoration: InputDecoration(
            hintText: 'write your review here',
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 128, 109, 109)),
            filled: true,
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: null,
        ),
      ),
    );
  }
}
