import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/data/data.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../Database.dart';
import '../models/content_model.dart';
import 'screens.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Content> searchResult = [];
  bool _isSearching = false;

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
              autofocus: true,
              cursorColor: Colors.white,
              onChanged: (value) {
                // search from List<Content>
                setState(() {
                  searchResult.clear();
                });
                if (value.isNotEmpty) {
                  setState(() {
                    _isSearching = true;
                  });
                  // print(value);
                  for (Content content in previews) {
                    if (content.name
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      // print(content.name);
                      searchResult.add(content);
                    }
                  }
                } else {
                  setState(() {
                    _isSearching = false;
                  });
                }
              },
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
                !_isSearching
                    ? const Padding(
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
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: Text(
                          "Movies",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                !_isSearching
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: trending.length,
                        itemBuilder: (context, index) => MovieCard(
                          movie: trending[index],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) => MovieCard(
                          movie: searchResult[index],
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
