import 'package:flutter/material.dart';

class BackBar extends StatelessWidget {
  const BackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () => print("Back"),
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            const SizedBox(
              width: 240.0,
            ),
            IconButton(
              onPressed: () => print("Search"),
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
            const SizedBox(
              width: 7.0,
            ),
            IconButton(
              onPressed: () => print("Back"),
              icon: Icon(Icons.man),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
