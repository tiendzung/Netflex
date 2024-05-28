import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets.dart';
import 'package:mobile/screens/screens.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpButton extends StatefulWidget {
  final String email;
  final String password;
  final bool status;

  const SignUpButton(
      {Key? key,
      required this.email,
      required this.password,
      required this.status})
      : super(key: key);

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
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
                    final credential = await _auth.createUserWithEmailAndPassword(email: widget.email, password: widget.password);
                    final user = _auth.currentUser;
                    if (user != null) {
                      final userRef = FirebaseDatabase.instance.reference().child('list-users').child(user.uid);

                      // Tạo một Map chứa thông tin của người dùng mới
                      final userData = {
                        'email': widget.email,
                        'list': {'film1': false},
                        'rating': {'film0': 5},
                      };

                      // Cập nhật thông tin của người dùng mới lên database
                      await userRef.set(userData);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NavScreen()));


                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      alertDialogSignUp(context,
                          "The account already exists for that email.");
                    } else if (e.code == 'invalid-email') {
                      // print("invalid-email");
                      alertDialogSignUp(
                          context, "The email address is invalid.");
                    } else if (e.code == 'weak-password') {
                      // print('The password provided is too weak.');
                      alertDialogSignUp(
                          context, "The password provided is too weak.");
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
            "Sign Up",
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
