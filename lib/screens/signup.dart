import 'package:flutter/material.dart';
import 'package:mobile/assets.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool status = false;

  bool checkAccount() {
    int count = 0;
    if (email.trim().isNotEmpty) count++;
    if (password.trim().isNotEmpty) count++;
    if (password.compareTo(confirmPassword) == 0) count++;
    if (count == 3) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          Assets.netflixLogo1,
          width: 106,
          height: 33,
          fit: BoxFit.cover,
        ),
        actions: [
          Row(
            children: [
              // GestureDetector(
              //   onTap: () => {},
              //   child: const Text(
              //     "HELP",
              //     style: TextStyle(color: Colors.white70),
              //   ),
              // ),
              // const SizedBox(
              //   width: 20,
              // ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                },
                child: const Text(
                  " ",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.14,
              ),
              InputField(
                onChange: (value) {
                  setState(() => {
                        email = value,
                        if (checkAccount()) status = true else status = false,
                      });
                },
              ),
              PasswordField(
                onChange: (value) {
                  setState(() => {
                        password = value,
                        if (checkAccount()) status = true else status = false,
                      });
                },
              ),
              _ConfirmPassword(
                onChange: (value) {
                  setState(() => {
                        confirmPassword = value,
                        if (checkAccount()) status = true else status = false,
                      });
                },
              ),
              SignUpButton(
                email: email,
                password: password,
                status: status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmPassword extends StatelessWidget {
  const _ConfirmPassword({Key? key, required this.onChange}) : super(key: key);

  final ValueChanged<String> onChange;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        cursorColor: Colors.white,
        onChanged: onChange,
        style: const TextStyle(color: Colors.white70),
        decoration: const InputDecoration(
          hintText: "Confirm password",
          hintStyle: TextStyle(color: Colors.white70, fontSize: 17),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
