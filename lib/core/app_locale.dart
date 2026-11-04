import 'package:flutter/material.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';

/// Single source of truth for app locale state
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

/// Convenient extension on BuildContext to access AppLocalizations
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
