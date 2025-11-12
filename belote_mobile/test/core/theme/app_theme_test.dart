import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:belote_mobile/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('light theme should have correct primary color', () {
      expect(
        AppTheme.lightTheme.colorScheme.primary,
        AppTheme.primaryGreen,
      );
    });

    test('dark theme should have dark background', () {
      expect(
        AppTheme.darkTheme.brightness,
        Brightness.dark,
      );
    });
  });
}
