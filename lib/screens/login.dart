import 'package:flutter/material.dart';
import 'package:mobile/assets.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Widget _helpButton() {
    return FlatButton(
      onPressed: () => {print("need help")},
      child: const Text(
        'Need help?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _signupButton() {
    return FlatButton(
      onPressed: () => {print("sign up")},
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
          icon: const Icon(Icons.arrow_back_ios),
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
              onChange: (value) {},
            ),
            PasswordField(
              onChange: (value) {},
            ),
            const SignInButton(),
            _helpButton(),
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

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: size.width * 0.9,
        height: 60,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavScreen(),
              ),
            );
          },
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Colors.grey,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
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
