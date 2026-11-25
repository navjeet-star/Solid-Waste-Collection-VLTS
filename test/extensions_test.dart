import 'package:flutter_test/flutter_test.dart';
import 'package:vlts_swc/extensions/Extensions.dart';

void main() {
  group('StringExtensions.getInitials tests', () {
    test('derives first and last name initials for multi-word names', () {
      expect('Rajesh Kumar Sharma'.getInitials(), 'RS');
      expect('Rajesh Kumar Sharma'.initials, 'RS');
      expect('Amit Verma'.getInitials(), 'AV');
      expect('Amit Verma'.initials, 'AV');
    });

    test('derives 2-letter uppercase initials for single-word names', () {
      expect('Priya'.getInitials(), 'PR');
      expect('Priya'.initials, 'PR');
    });

    test('handles single character strings', () {
      expect('A'.getInitials(), 'A');
    });

    test('handles multiple spaces between words', () {
      expect('  Sunil   Bisht  '.getInitials(), 'SB');
    });

    test('falls back to default fallback "SW" for null and empty strings', () {
      const String? nullString = null;
      expect(nullString.getInitialsOrFallback(), 'SW');
      expect(nullString.initialsOrFallback, 'SW');
      expect(''.getInitials(), 'SW');
      expect('   '.getInitials(), 'SW');
    });

    test('supports custom fallback string', () {
      const String? nullString = null;
      expect(nullString.getInitialsOrFallback(fallback: 'NA'), 'NA');
      expect(''.getInitials(fallback: 'EX'), 'EX');
    });
  });
}
