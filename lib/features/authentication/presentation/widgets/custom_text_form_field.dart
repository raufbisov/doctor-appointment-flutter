import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.theme,
    required this.label,
    required this.controller,
    this.isObscure = false,
  }) : super(key: key);

  final ThemeData theme;
  final String label;
  final bool isObscure;
  final TextEditingController controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.isObscure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: isObscure
                      ? Colors.grey
                      : widget.theme.colorScheme.secondary,
                ))
            : null,
        label: Text(widget.label, style: widget.theme.textTheme.labelLarge),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }
}

class CustomTextPasswordField extends StatefulWidget {
  const CustomTextPasswordField({
    Key? key,
    required this.theme,
    required this.label,
    required this.controller,
  }) : super(key: key);

  final ThemeData theme;
  final String label;
  final TextEditingController controller;

  @override
  State<CustomTextPasswordField> createState() =>
      _CustomTextPasswordFieldState();
}

class _CustomTextPasswordFieldState extends State<CustomTextPasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            icon: Icon(
              Icons.remove_red_eye,
              color:
                  isObscure ? Colors.grey : widget.theme.colorScheme.secondary,
            )),
        label: Text(widget.label, style: widget.theme.textTheme.labelLarge),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }
}
