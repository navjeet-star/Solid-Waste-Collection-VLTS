import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, currentLocale, _) {
        return DropdownButton<Locale>(
          value: currentLocale,
          hint: Text(context.l10n.language),
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
              appLocale.value = locale;
            }
          },
        );
      },
    );
  }
}
