import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final Function(int) onRatingSelected;

  const RatingBar({Key? key, required this.onRatingSelected}) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: _rating >= 1 ? const Icon(Icons.star, color: Colors.amber) : const Icon(Icons.star_border),
          onPressed: () {
            setState(() {
              _rating = 1;
              widget.onRatingSelected(_rating);
            });
          },
        ),
        IconButton(
          icon: _rating >= 2 ? const Icon(Icons.star, color: Colors.amber) : const Icon(Icons.star_border),
          onPressed: () {
            setState(() {
              _rating = 2;
              widget.onRatingSelected(_rating);
            });
          },
        ),
        IconButton(
          icon: _rating >= 3 ? const Icon(Icons.star, color: Colors.amber) : const Icon(Icons.star_border),
          onPressed: () {
            setState(() {
              _rating = 3;
              widget.onRatingSelected(_rating);
            });
          },
        ),
        IconButton(
          icon: _rating >= 4 ? const Icon(Icons.star, color: Colors.amber) : const Icon(Icons.star_border),
          onPressed: () {
            setState(() {
              _rating = 4;
              widget.onRatingSelected(_rating);
            });
          },
        ),
        IconButton(
          icon: _rating >= 5 ? const Icon(Icons.star, color: Colors.amber) : const Icon(Icons.star_border),
          onPressed: () {
            setState(() {
              _rating = 5;
              widget.onRatingSelected(_rating);
            });
          },
        ),
      ],
    );
  }
}
