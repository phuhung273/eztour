import 'package:eztour_traveller/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _showPwd = false;

  void _togglePwd () {
    setState((){
      _showPwd = !_showPwd;
    });
  }

  @override
  Widget build(BuildContext context) {

    return TextFieldContainer(
      child: TextField(
        obscureText: !_showPwd,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
          ),
          suffixIcon: GestureDetector(
            onTap: _togglePwd,
            child: Icon(
              _showPwd ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
