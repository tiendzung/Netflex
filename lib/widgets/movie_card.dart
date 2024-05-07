import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final Content movie;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      color: const Color(0xff221f1f),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(widget.movie.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.movie.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
