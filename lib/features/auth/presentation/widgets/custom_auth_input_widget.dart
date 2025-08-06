import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/const.dart';

class CustomAuthInputWidget extends StatefulWidget {
  const CustomAuthInputWidget({
    super.key,
    this.isSecure = false,
    required this.title,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.errorText,
    this.isNum = false, this.controller,
  });

  final bool isNum;
  final bool isSecure;
  final String title;
  final String hint;
  final IconData icon;
  final Function(String) onChanged;
  final String? errorText;
  final TextEditingController? controller;

  @override
  State<CustomAuthInputWidget> createState() => _CustomAuthWidgetState();
}

class _CustomAuthWidgetState extends State<CustomAuthInputWidget> {
  late bool secure = widget.isSecure;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onChanged(_controller.text);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: _controller,
          obscureText: secure,
          keyboardType: widget.isNum ? TextInputType.number : null,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
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
                size: 20,
                color: customGrey,
              )
                  : Icon(
                CupertinoIcons.eye,
                size: 20,
                color: customGrey,
              ),
            )
                : null,
            prefixIcon: Container(
              margin: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 20,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 15,
                    ),
                  ),
                ],
              ),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          style: const TextStyle(color: Color(0xFF616161)),
        ),
      ],
    );
  }
}