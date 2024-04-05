import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final ValueChanged<String> onChange;
  const PasswordField({Key? key, required this.onChange}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Column(
        children: [
          const SizedBox(
            height: 2,
          ),
          TextField(
            cursorColor: Colors.white,
            // textAlign: TextAlign.justify,
            obscureText: _isObscure,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black12,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final ValueChanged<String> onChange;

  const InputField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        cursorColor: Colors.white,
        onChanged: onChange,
        decoration: const InputDecoration(
          hintText: "Email or phone number",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
