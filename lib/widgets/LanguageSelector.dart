import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/main.dart';
import 'package:solid_waste_collection_vlts/l10n/app_localizations.dart';
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return DropdownButton<Locale>(
      value: appLocale.value,
      hint: Text(strings.language),
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
  }
}