import 'package:eyego_task/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, this.onSaved});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
  final void Function(String?)? onSaved;
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onSaved: widget.onSaved,
      lable: "Password",
      obscureText: obscureText,
      suffixIcon: GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: Icon(obscureText ? Icons.remove_red_eye : Icons.visibility_off),
      ),
    );
  }
}
