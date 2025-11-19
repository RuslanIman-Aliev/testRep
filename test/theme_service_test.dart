import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/services/theme_service.dart'; 

void main() {
  group('ThemeService Tests', () {
        setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('За замовчуванням тема має бути світла (false)', () async {
      final service = ThemeService();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(service.isDark, false);
    });

    test('Метод toggleTheme() має змінювати тему на темну', () async {
      final service = ThemeService();
      await Future.delayed(const Duration(milliseconds: 50));

      service.toggleTheme();

      expect(service.isDark, true);
    });

    test('Метод toggleTheme() має зберігати значення в SharedPreferences', () async {
      final service = ThemeService();
      await Future.delayed(const Duration(milliseconds: 50));
      service.toggleTheme(); 

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('is_dark_mode'), true);
    });

    test('Має завантажувати збережену тему при старті', () async {
      SharedPreferences.setMockInitialValues({'is_dark_mode': true});
      final service = ThemeService();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(service.isDark, true);
    });
  });
}