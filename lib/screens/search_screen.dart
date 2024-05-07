import 'package:flutter/material.dart';
import 'package:mobile/data/data.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../Database.dart';
import 'screens.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 15.0),
            icon: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                    image: AssetImage('assets/images/netflix-avatar.png')),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    profiles: demoProfile[0],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenSize.width,
            decoration: const BoxDecoration(
              color: Color(0xff333333),
            ),
            child: TextField(
              cursorColor: Colors.white,
              onChanged: (value) => print(value),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Search for a movie, TV show, etc.",
                hintStyle: TextStyle(
                  color: Color(0xff7f7f7f),
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xff7f7f7f),
                ),
                suffixIcon: Icon(
                  Icons.mic,
                  color: Color(0xff7f7f7f),
                ),
              ),
            ),
          ),
          // Top Searches text
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Text(
                    "Top Searches",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: context.watch<Database>().content.length,
                  itemBuilder: (context, index) => MovieCard(
                    movie: context.watch<Database>().content[index],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
