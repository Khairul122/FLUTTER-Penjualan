import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final Color textColor;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.label,
    this.textColor = Colors.black, // Default text color is black
    this.backgroundColor = const Color(
        0xFFBA704F), // Default background color is hsba(19, 58%, 73%, 1)
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor, // Background color
        onPrimary: textColor, // Text color
        padding: EdgeInsets.all(10.sp),
        elevation: 0, // No elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.sp), // Rounded corners
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
