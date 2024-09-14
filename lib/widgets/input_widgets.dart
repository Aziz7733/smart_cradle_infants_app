import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool obscureText;
  final bool editable;
  final String hintText;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final double width;
  final IconData? prefixIcon;
  final TextInputType? inputType;
  final TextInputAction? action;
  final String? Function(String?)? validator; // For validation
  final FocusNode? focusNode; // For managing focus
  final void Function(String)?
      onFieldSubmitted; // For handling field submission

  const CustomTextField({
    super.key,
    this.obscureText = false,
    required this.hintText,
    this.textAlign = TextAlign.start,
    this.controller,
    this.decoration,
    this.width = 300.0,
    this.prefixIcon,
    this.inputType,
    this.editable = true,
    this.action = TextInputAction.next,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        enabled: widget.editable,
        controller: widget.controller,
        obscureText: _obscureText,

        keyboardType: widget.inputType,
        textInputAction: widget.action,
        validator: widget.validator,
        focusNode: widget.focusNode,
        // Assign the focus node
        onFieldSubmitted: widget.onFieldSubmitted,
        // Handle field submission
        decoration: widget.decoration?.copyWith(
              hintText: widget.hintText,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : Icon(widget.prefixIcon),
            ) ??
            InputDecoration(
              label: Text(widget.hintText),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              hintText: widget.hintText,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : Icon(widget.prefixIcon),
            ),
      ),
    );
  }
}
