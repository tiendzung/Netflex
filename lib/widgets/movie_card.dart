import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/widgets/widgets.dart';

import '../screens/details.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final Content movie;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Go to movie detail page
        showModalBottomSheet(
          // enableDrag: false,
          // isDismissible: false,
          backgroundColor: const Color(0xff292929),
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (context) => ModalBottomInfo(item: widget.movie),
        );
      },
      child: Container(
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
      ),
    );
  }
}
