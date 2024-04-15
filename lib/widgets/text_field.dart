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
            onChanged: widget.onChange,
            cursorColor: Colors.grey,
            obscureText: _isObscure,
            style: const TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(color: Colors.white70, fontSize: 17),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
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
        style: const TextStyle(color: Colors.white70),
        decoration: const InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.white70, fontSize: 17),
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
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff333333),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
