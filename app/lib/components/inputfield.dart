import 'package:app/themes/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? label;
  final String? hintText;
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
    this.hintText,
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
          style: const TextStyle(color: ThemeColors.primaryLight),
          controller: widget.textEditingController,
          decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.primary)),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ThemeColors.primaryLight),
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: ThemeColors.primaryLight),
              labelText: widget.label,
              labelStyle: const TextStyle(color: ThemeColors.primaryLight)),
        ),
      ),
    );
  }
}
