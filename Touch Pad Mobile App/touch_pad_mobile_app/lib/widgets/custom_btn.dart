import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    this.onPressed,
    required this.text,
    this.bkColor,
  });

  final void Function()? onPressed;
  final String text;
  final Color? bkColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bkColor,
        elevation: 2,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(text, style: TextStyle(fontSize: 18)),
    );
  }
}
