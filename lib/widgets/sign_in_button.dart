import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets.dart';
import 'package:mobile/screens/screens.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInButton extends StatefulWidget {
  final String email;
  final String password;
  final bool status;

  const SignInButton(
      {Key? key,
      required this.email,
      required this.password,
      required this.status})
      : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  final myController = TextEditingController();
  bool submit = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: size.width * 0.9,
        height: 60,
        child: OutlinedButton(
          onPressed: widget.status
              ? () async {
                  try {
                    final credential = await _auth.signInWithEmailAndPassword(
                        email: widget.email, password: widget.password);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavScreen()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      // print('No user found for that email.');
                      alertDialogSignIn(context, true);
                    } else if (e.code == 'wrong-password') {
                      // print('Wrong password provided for that user.');
                      alertDialogSignIn(context, false);
                    }
                  }
                }
              : null,
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: widget.status ? const Color(0xFFD32F2F) : Colors.grey,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
            backgroundColor: widget.status
                ? MaterialStateProperty.all(Colors.red[700])
                : null,
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
