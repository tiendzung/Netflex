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
        Navigator.push(context,
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
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(Assets.netflixLogo1),
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

        ));

  }


}





class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(width: 12.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            ),
          ),
        ],
      ),
    );
  }
}

