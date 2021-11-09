import 'package:app/themes/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String textLabel;
  final double height;
  final double width;
  final double borderRadius;
  final double paddingHorizontal;
  final VoidCallback? onTap;
  final Color primaryBackgroundColor;
  final Color textColor;
  final bool isButtonEnabled;

  const Button(
      {Key? key,
      required this.textLabel,
      this.onTap,
      this.height = 52,
      this.width = double.infinity,
      this.primaryBackgroundColor = ThemeColors.primary,
      this.textColor = Colors.white,
      this.borderRadius = 26,
      this.paddingHorizontal = 20,
      this.isButtonEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: InkWell(
        child: Container(
          height: height,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  textLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: textColor, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: primaryBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
