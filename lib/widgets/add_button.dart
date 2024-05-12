import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/widgets/vertical_icon_button.dart';

class AddListButton extends StatefulWidget {
  final Content movie;
  const AddListButton({Key? key, required this.movie}) : super(key: key);

  @override
  State<AddListButton> createState() => _AddListButtonState();

  static bool checkInList(myList, movie) {
    for (Content i in myList) {
      if (i.name == movie.name) {
        return true;
      }
    }
    return false;
  }
}

class _AddListButtonState extends State<AddListButton> {
  List<Content> myList = [];

  late bool _isInList = AddListButton.checkInList(myList, widget.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: !_isInList
          ? VerticalIconButton(
              icon: Icons.add,
              title: 'List',
              onTap: () => {
                myList.add(widget.movie),
                setState(() {
                  _isInList = true;
                })
              },
            )
          : VerticalIconButton(
              icon: Icons.check,
              title: 'List',
              onTap: () => {
                myList.remove(widget.movie),
                setState(() {
                  _isInList = false;
                })
              },
            ),
    );
  }
}
