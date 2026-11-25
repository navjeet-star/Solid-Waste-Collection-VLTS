// ignore_for_file: file_names

/// Useful string extensions across the VLTS SWC application.
extension StringExtensions on String {
  /// Derives 2-letter uppercase initials from officer/user's name (first and last name).
  ///
  /// Examples:
  /// - `"Rajesh Kumar Sharma".getInitials()` -> `"RS"`
  /// - `"Amit Verma".getInitials()` -> `"AV"`
  /// - `"Priya".getInitials()` -> `"PR"`
  /// - `"".getInitials()` -> `"SW"`
  String getInitials({String fallback = 'SW'}) {
    if (trim().isEmpty) return fallback;
    final parts =
        trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first
        .substring(0, parts.first.length >= 2 ? 2 : 1)
        .toUpperCase();
  }

  /// Convenience getter alias for [getInitials].
  String get initials => getInitials();
}

/// Extensions on nullable [String?] to handle null-safe initials.
extension NullableStringExtensions on String? {
  /// Derives 2-letter uppercase initials on nullable strings, defaulting to [fallback] ('SW') when null or empty.
  String getInitialsOrFallback({String fallback = 'SW'}) {
    final str = this;
    if (str == null || str.trim().isEmpty) return fallback;
    return str.getInitials(fallback: fallback);
  }

  /// Convenience getter alias for [getInitialsOrFallback].
  String get initialsOrFallback => getInitialsOrFallback();
}
