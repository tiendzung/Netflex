// import 'package:flutter/material.dart';
// import 'package:mobile/models/models.dart';
// import 'package:mobile/widgets/vertical_icon_button.dart';
//
// class AddListButton extends StatefulWidget {
//   final Content movie;
//   const AddListButton({Key? key, required this.movie}) : super(key: key);
//
//   @override
//   State<AddListButton> createState() => _AddListButtonState();
//
//   static bool checkInList(myList, movie) {
//     for (Content i in myList) {
//       if (i.name == movie.name) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
//
// class _AddListButtonState extends State<AddListButton> {
//   List<Content> myList = [];
//
//   late bool _isInList = AddListButton.checkInList(myList, widget.movie);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: !_isInList
//           ? VerticalIconButton(
//               icon: Icons.add,
//               title: 'List',
//               onTap: () => {
//                 myList.add(widget.movie),
//                 setState(() {
//                   _isInList = true;
//                 })
//               },
//             )
//           : VerticalIconButton(
//               icon: Icons.check,
//               title: 'List',
//               onTap: () => {
//                 myList.remove(widget.movie),
//                 setState(() {
//                   _isInList = false;
//                 })
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/widgets/vertical_icon_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddListButton extends StatefulWidget {
  final Content movie;
  const AddListButton({Key? key, required this.movie}) : super(key: key);

  @override
  State<AddListButton> createState() => _AddListButtonState();

  static bool checkInList(Map<String, bool> myList, Content movie) {
    return myList.containsKey(movie.id);
  }
}

class _AddListButtonState extends State<AddListButton> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final user = FirebaseAuth.instance.currentUser;

  late Map<String, bool> myList = {};
  late bool _isInList = false;

  @override
  void initState() {
    super.initState();
    _fetchUserList();
  }

  Future<void> _fetchUserList() async {
    if (user != null) {
      final userId = user!.uid;
      final userSnapshot = await databaseReference.child('list-users/$userId/list').get();
      final userMap = Map<String, dynamic>.from(userSnapshot.value as Map);
      setState(() {
        myList = userMap.map((key, value) => MapEntry(key, value == true));
        _isInList = AddListButton.checkInList(myList, widget.movie);
        if (myList.isEmpty) {
          myList['film1'] = false;
        }
      });
    }
  }

  Future<void> _updateUserList() async {
    if (user != null) {
      final userId = user!.uid;
      await databaseReference.child('list-users/$userId/list').set(myList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: !_isInList
          ? VerticalIconButton(
        icon: Icons.add,
        title: 'List',
        onTap: () async {
          setState(() {
            myList[widget.movie.id] = true;
            _isInList = true;
          });
          await _updateUserList();
        },
      )
          : VerticalIconButton(
        icon: Icons.check,
        title: 'List',
        onTap: () async {
          setState(() {
            myList.remove(widget.movie.id);
            if (myList.isEmpty) {
              myList['film1'] = false;
            }
            _isInList = false;
          });
          await _updateUserList();
        },
      ),
    );
  }
}
