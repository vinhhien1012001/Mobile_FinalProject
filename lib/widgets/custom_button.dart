import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color buttonColor;
  final double width;
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width = 120,
    this.textColor = Colors.white,
    this.buttonColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(buttonColor),
          foregroundColor: MaterialStateProperty.all(textColor),
        ),
        child: Text(text),
      ),
    );
  }
}
