import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/const.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.text,
    this.isSecure = false,
    this.errorText,
    this.onChanged,
    this.controller,
  });

  final String text;
  final bool isSecure;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late bool secure = widget.isSecure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      height: widget.errorText != null ? height * 0.08 : height * 0.06,
      child: TextFormField(
        controller: widget.controller,
        obscureText: secure,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.text,
          errorText: widget.errorText,
          filled: true,
          suffixIcon: widget.isSecure
              ? IconButton(
            onPressed: () {
              setState(() {
                secure = !secure;
              });
            },
            icon: secure
                ? Icon(
              CupertinoIcons.eye_slash,
              size: width * 0.06,
              color: customGrey,
            )
                : Icon(
              CupertinoIcons.eye,
              size: width * 0.06,
              color: customGrey,
            ),
          )
              : null,
          fillColor: secondaryColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(width * 0.1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(width * 0.1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(width * 0.1),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(width * 0.1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(width * 0.1),
          ),
        ),
      ),
    );
  }
}