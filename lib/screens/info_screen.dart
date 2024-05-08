import 'package:flutter/material.dart';
class Showmodalinfo {
  late BuildContext context;
  Showmodalinfo(this.context);

  void showmodalinfo() {
    showModalBottomSheet(
        context: context, builder: (context) {
      return Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.ac_unit),
            title: const Text('Cooling'),
            onTap: () => print('tap'),
          )
        ],
      );
    });
}



}