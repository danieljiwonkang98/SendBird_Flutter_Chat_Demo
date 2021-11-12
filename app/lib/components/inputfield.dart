import 'package:app/themes/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? label;
  final String? hintText;
  final double? height;
  final double? width;
  final double paddingHorizontal;
  final Icon? trailingIcon;
  final Function? trailingFunction;
  final bool isExpand;
  final int maxLine;
  final int minLine;

  const InputField(
      {Key? key,
      required this.textEditingController,
      this.label,
      this.height,
      this.width = double.infinity,
      this.paddingHorizontal = 20,
      this.hintText,
      this.trailingIcon,
      this.trailingFunction,
      this.isExpand = false,
      this.minLine = 1,
      this.maxLine = 1})
      : super(key: key);

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
        child: Row(
          children: [
            Flexible(
              child: TextField(
                minLines: widget.minLine,
                maxLines: widget.maxLine,
                expands: widget.isExpand,
                style: const TextStyle(color: ThemeColors.primaryLight),
                controller: widget.textEditingController,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ThemeColors.primary)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeColors.primaryLight),
                    ),
                    hintText: widget.hintText,
                    hintStyle:
                        const TextStyle(color: ThemeColors.primaryLight2),
                    labelText: widget.label,
                    labelStyle:
                        const TextStyle(color: ThemeColors.primaryLight2)),
              ),
            ),
            widget.trailingIcon != null
                ? GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: widget.trailingIcon,
                    ),
                    onTap: () => {
                      if (widget.trailingFunction != null)
                        widget.trailingFunction!()
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
