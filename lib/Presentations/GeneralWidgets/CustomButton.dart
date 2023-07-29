import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.textColor,
    this.backColor,
    this.height,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final Color? backColor;
  final Color textColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(300),
          border: backColor == null ? Border.all(color: Colors.black26): null,
          color: backColor ?? Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor ,
          ),
        ),
      ),
    );
  }
}
