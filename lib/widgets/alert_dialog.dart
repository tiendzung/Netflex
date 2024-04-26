import 'package:flutter/material.dart';

alertDialogSignIn(BuildContext context, bool _invalidEmail) {
  Widget tryAgainButton = TextButton(
    child: const Text(
      "TRY AGAIN",
      style: TextStyle(color: Colors.tealAccent),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget recoverPassButton = TextButton(
    child: const Text(
      "RECOVER PASSWORD",
      style: TextStyle(color: Colors.tealAccent),
    ),
    onPressed: () {},
  );
  Widget createANewAccountButton = TextButton(
    child: const Text(
      "CREATE A NEW ACCOUNT",
      style: TextStyle(color: Colors.tealAccent),
    ),
    onPressed: () {},
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      _invalidEmail ? "Invalid Email" : "Incorrect Password",
      style: const TextStyle(color: Colors.white),
    ),
    content: Text(
      _invalidEmail
          ? "Sorry, we can't find an account with this email address. Please try again or create a new account."
          : "Incorrect password. Please try again or you can reset your password.",
      style: const TextStyle(color: Colors.grey),
    ),
    actions: [
      _invalidEmail ? createANewAccountButton : recoverPassButton,
      tryAgainButton,
    ],
    backgroundColor: const Color(0xff333333),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

alertDialogSignUp(BuildContext context, String al) {
  Widget tryAgainButton = TextButton(
    child: const Text(
      "TRY AGAIN",
      style: TextStyle(color: Colors.tealAccent),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text(
      "Sign Up false",
      style: TextStyle(color: Colors.white),
    ),
    content: Text(
      al,
      style: const TextStyle(color: Colors.grey),
    ),
    actions: [tryAgainButton],
    backgroundColor: const Color(0xff333333),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
