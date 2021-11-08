import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? label;
  final double? height;
  final double? width;
  final double paddingHorizontal;

  const InputField({
    Key? key,
    required this.textEditingController,
    this.label,
    this.height,
    this.width = double.infinity,
    this.paddingHorizontal = 20,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextField(
          controller: widget.textEditingController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "User ID",
          ),
        ),
      ),
    );
  }
}
