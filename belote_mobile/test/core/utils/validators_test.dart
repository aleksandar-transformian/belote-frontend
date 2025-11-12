import 'package:flutter_test/flutter_test.dart';
import 'package:belote_mobile/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('should return null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), null);
        expect(Validators.validateEmail('user.name@domain.co'), null);
      });

      test('should return error for invalid email', () {
        expect(Validators.validateEmail('invalid'), isNotNull);
        expect(Validators.validateEmail('test@'), isNotNull);
        expect(Validators.validateEmail('@example.com'), isNotNull);
      });

      test('should return error for empty email', () {
        expect(Validators.validateEmail(''), isNotNull);
        expect(Validators.validateEmail(null), isNotNull);
      });
    });

    group('validatePassword', () {
      test('should return null for valid password', () {
        expect(Validators.validatePassword('password123'), null);
        expect(Validators.validatePassword('123456'), null);
      });

      test('should return error for short password', () {
        expect(Validators.validatePassword('12345'), isNotNull);
        expect(Validators.validatePassword('abc'), isNotNull);
      });

      test('should return error for empty password', () {
        expect(Validators.validatePassword(''), isNotNull);
        expect(Validators.validatePassword(null), isNotNull);
      });
    });

    group('validateUsername', () {
      test('should return null for valid username', () {
        expect(Validators.validateUsername('john_doe'), null);
        expect(Validators.validateUsername('user123'), null);
        expect(Validators.validateUsername('Player1'), null);
      });

      test('should return error for short username', () {
        expect(Validators.validateUsername('ab'), isNotNull);
      });

      test('should return error for long username', () {
        expect(Validators.validateUsername('a' * 21), isNotNull);
      });

      test('should return error for invalid characters', () {
        expect(Validators.validateUsername('user name'), isNotNull);
        expect(Validators.validateUsername('user@name'), isNotNull);
        expect(Validators.validateUsername('user-name'), isNotNull);
      });

      test('should return error for empty username', () {
        expect(Validators.validateUsername(''), isNotNull);
        expect(Validators.validateUsername(null), isNotNull);
      });
    });

    group('validateConfirmPassword', () {
      test('should return null when passwords match', () {
        expect(Validators.validateConfirmPassword('password', 'password'), null);
      });

      test('should return error when passwords do not match', () {
        expect(Validators.validateConfirmPassword('password1', 'password2'), isNotNull);
      });

      test('should return error for empty confirmation', () {
        expect(Validators.validateConfirmPassword('', 'password'), isNotNull);
        expect(Validators.validateConfirmPassword(null, 'password'), isNotNull);
      });
    });
  });
}
