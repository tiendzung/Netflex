import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/models/profile.dart';
// import 'package:mobile/authentication/authentication.dart';
import 'package:mobile/screens/screens.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.profiles}) : super(key: key);

  final Profile profiles;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late List<Map<String, dynamic>> items;
  String? userEmail;  

  @override
  void initState() {
    super.initState();
    _getCurrentUserEmail();
    items = [
      {
        'title': 'My List',
        'function': () => () {},
      },
      {
        'title': 'App Settings',
        'function': () => () {},
      },
      {
        'title': 'Account',
        'function': () {},
      },
      {
        'title': 'Help',
        'function': () => _launchURL(),
      },
      {
        'title': 'Sign Out',
        'function': () => _signOut(context),
      },
    ];
  }

  Future<void> _getCurrentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email ?? "tiendung050803@gmail.com";
    });
  }

  Future<void> _launchURL() async {
    const url = 'https://www.facebook.com/tiendzungg';
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen after sign out
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Profiles & More',
          style: TextStyle(
            color: Color(0XFFe6e6e6),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(demoProfile[0].imgPath)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userEmail ?? 'Loading...',
                    style: const TextStyle(
                      color: Color(0XFFe6e6e6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color(0XFF262626),
                          width: 1.2,
                        )),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 40,
                        color: Color(0XFF808080),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Add Profile",
                    style: TextStyle(
                      color: Color(0XFF7f7f7f),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.edit,
              size: 20,
              color: Color(0XFF808080),
            ),
            label: const Text(
              'Manage Profiles',
              style: TextStyle(
                color: Color(0XFFb3b3b3),
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  items[index]['function']();
                },
                title: Text(
                  items[index]['title'],
                  style: const TextStyle(
                    color: Color(0XFFb3b3b3),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
