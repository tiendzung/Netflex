import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';

class DownloadMovieCard extends StatefulWidget {
  const DownloadMovieCard({Key? key, required this.movie}) : super(key: key);

  final Content movie;

  @override
  State<DownloadMovieCard> createState() => _DownloadMovieCardState();
}

class _DownloadMovieCardState extends State<DownloadMovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 15,
        right: 15,
      ),
      // color: const Color(0xff221f1f),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 75,
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
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
