import 'package:flutter/material.dart';
import '../constants/colors.dart';


SnackBar customSnackBar({required String text, Color color= mainColor}) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}