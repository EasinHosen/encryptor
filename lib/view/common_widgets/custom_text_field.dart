import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helper.dart';
import '../styles/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final Widget? prefixIcon, suffixIcon;
  final bool isRequired;
  final bool obscureText;
  final bool isOptional;
  final bool isEnabled;
  final bool readOnly;
  final bool showToggleVisibility;
  final bool isFilled;
  final Color fillColor;
  final void Function()? onTapTextBox;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextStyle? titleStyle;
  final void Function(String)? onTextChange;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.prefixIcon,
    this.isRequired = false,
    this.obscureText = false,
    this.isOptional = false,
    this.isEnabled = true,
    this.readOnly = false,
    this.showToggleVisibility = false,
    this.isFilled = true,
    this.fillColor = Colors.white,
    this.onTapTextBox,
    this.keyboardType,
    this.maxLines,
    this.suffixIcon,
    this.titleStyle,
    this.onTextChange,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isValidEmail = true;
  bool _showText = true;

  void _validateEmail(String value) {
    if (widget.keyboardType == TextInputType.emailAddress) {
      setState(() {
        _isValidEmail = isEmail(value);
      });
    }
    if (widget.onTextChange != null) {
      widget.onTextChange!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${widget.title}${widget.isOptional ? ' (Optional)' : ''}",
              style: widget.titleStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
            Text(
              widget.isRequired ? ' *' : '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          obscureText:
              widget.showToggleVisibility ? _showText : widget.obscureText,
          enabled: widget.isEnabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          onTap: widget.onTapTextBox,
          onChanged: _validateEmail,
          decoration: InputDecoration(
            filled: widget.isFilled,
            fillColor: widget.fillColor,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isValidEmail ? Colors.black : Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isValidEmail ? AppColors.colorPrimary : Colors.red,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isValidEmail ? Colors.black : Colors.red,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: widget.prefixIcon,
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: widget.suffixIcon,
                  )
                : widget.suffixIcon == null && widget.showToggleVisibility
                    ? GestureDetector(
                        onTap: () {
                          _showText = !_showText;
                          setState(() {});
                        },
                        child: _showText
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined))
                    : null,
          ),
          style: TextStyle(
            color: _isValidEmail ? Colors.black : Colors.red,
          ),
        ),
        if (!_isValidEmail)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Please enter a valid email address',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        SizedBox(height: Get.height * 0.01)
      ],
    );
  }
}
