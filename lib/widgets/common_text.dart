import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;

  const CommonText({super.key, required this.text, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, size: 20, color: colorScheme.onSurface),
          const SizedBox(width: 10),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
