import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/screens/screens.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    nav();
  }

  nav() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Center(child: Lottie.asset("assets/splash/splash.json")),
        ],
      ),
    );
  }
}
