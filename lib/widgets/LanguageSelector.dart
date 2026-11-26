// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, currentLocale, _) {
        final selectedLocale = currentLocale.languageCode == 'hi'
            ? const Locale('hi')
            : const Locale('en');
        return DropdownButton<Locale>(
          value: selectedLocale,
          underline: const SizedBox(),
          items: const [
            DropdownMenuItem(
              value: Locale('en'),
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: Locale('hi'),
              child: Text('हिन्दी'),
            ),
          ],
          onChanged: (Locale? locale) {
            if (locale != null) {
              updateAppLocale(locale);
            }
          },
        );
      },
    );
  }
}
