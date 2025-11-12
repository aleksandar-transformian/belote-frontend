import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belote_mobile/features/auth/domain/repositories/auth_repository.dart';

@GenerateMocks([
  Dio,
  FlutterSecureStorage,
  SharedPreferences,
  AuthRepository,
])
void main() {}
