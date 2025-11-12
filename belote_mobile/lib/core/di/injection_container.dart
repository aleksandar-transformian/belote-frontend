import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

import '../constants/app_constants.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: AppConstants.baseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
