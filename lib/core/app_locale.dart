import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';

/// Single source of truth for app locale state, default is always English ('en')
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

/// Updates app locale globally across ValueNotifier and GetX
void updateAppLocale(Locale locale) {
  if (appLocale.value == locale) return;
  appLocale.value = locale;
  try {
    Get.updateLocale(locale);
  } catch (_) {}
}

/// Centralized InheritedNotifier that wraps the app widget tree.
/// Any widget calling `context.l10n` automatically registers as a dependent
/// and rebuilds whenever [appLocale] changes.
class AppLocaleScope extends InheritedNotifier<ValueNotifier<Locale>> {
  const AppLocaleScope({
    super.key,
    required ValueNotifier<Locale> notifier,
    required super.child,
  }) : super(notifier: notifier);

  /// Retrieves the active Locale and registers the calling [BuildContext]
  /// to rebuild when the locale changes.
  static Locale of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppLocaleScope>();
    return scope?.notifier?.value ?? appLocale.value;
  }
}

/// Convenient extension on [BuildContext] to access [AppLocalizations].
/// Automatically subscribes the calling widget to locale changes via [AppLocaleScope].
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n {
    final locale = AppLocaleScope.of(this);
    return lookupAppLocalizations(locale);
  }
}
