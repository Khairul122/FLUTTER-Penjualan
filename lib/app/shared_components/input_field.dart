import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final bool obscure;

  const InputField({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h), // Add some space between label and TextFormField
        SizedBox(
          width: 1.sw, // Set width to screen width
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200], // Set background color to grey
              borderRadius: BorderRadius.circular(8.sp), // Add border radius
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscure,
              style: TextStyle(fontSize: 12.sp, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none, // Remove border
                prefixIcon: icon != null ? Icon(icon) : null,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.sp, vertical: 12.sp), // Add padding
              ),
            ),
          ),
        ),
      ],
    );
  }
}
