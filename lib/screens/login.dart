import 'package:flutter/material.dart';
import 'package:mobile/assets.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  bool status = false;
  Widget _signupButton() {
    return FlatButton(
      onPressed: () => {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()))
      },
      child: const Text(
        'New to Netflix? Sign up now.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => print("back"),
        ),
        title: Image.asset(
          Assets.netflixLogo1,
          width: 106,
          height: 33,
          fit: BoxFit.cover,
        ),
      ),
      body: Container(
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
                      if (email.contains("@") && password.length > 6)
                        status = true
                      else
                        status = false,
                    });
              },
            ),
            PasswordField(
              onChange: (value) {
                setState(() => {
                      password = value,
                      if (email.contains("@") && password.length > 6)
                        status = true
                      else
                        status = false,
                    });
              },
            ),
            SignInButton(
              email: email,
              password: password,
              status: status,
            ),
            const NeedHelpButton(),
            _signupButton(),
            const Text(
              'Sign in is protected by Google reCAPTCHA to ensure you\'re not a bot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
