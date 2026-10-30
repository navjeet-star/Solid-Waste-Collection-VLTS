import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: colorScheme.onSurfaceVariant)
            : null,
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
