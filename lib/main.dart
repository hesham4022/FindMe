import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/app_secured_data/app_data.dart';
import 'package:find_me_app/core/app_secured_data/env.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/helpers/override_http.dart';
import 'package:find_me_app/core/resources/languages.dart';
import 'package:find_me_app/core/services/location/location_service.dart';
import 'package:find_me_app/features/app/presentation/pages/app.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:find_me_app/core/di.dart' as di;
import 'package:find_me_app/core/di.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! App Version
// Change it when you want to switch between App Versions
const kAppEnvironment = AppEnvironments.dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Future.wait([
    di.init(),
    EasyLocalization.ensureInitialized(),
    di.initSembast(),
  ]);

  await sl<LocationService>().getUserLocationCoordinates();

  await sl<AppEnvironmentData>().init(kAppEnvironment);
  log('Env.baseDevUrl (raw) = ${Env.baseDevUrl}');
  print(
      'AppEnvironmentData.baseUrl (before cache) = ${sl<AppEnvironmentData>().baseUrl}');

  // 🔹 SharedPreferences + AuthLocal
  final sharedPrefs = await SharedPreferences.getInstance();
  final authLocal =
      AuthLocal(StoreRef.main(), sharedPrefs, FlutterSecureStorage());

  HttpOverrides.global = MyHttpOverrides();

  String cleanedBaseUrl = Env.baseDevUrl.replaceAll(RegExp(r'/api$'), '');
  print('Cleaned baseUrl = $cleanedBaseUrl');

  await authLocal.cacheBaseUrl(cleanedBaseUrl);

  sl<AppEnvironmentData>().setNewUrl(cleanedBaseUrl);

  final cachedBaseUrl = await authLocal.getBaseUrl();
  print('✅ Cached baseUrl = $cachedBaseUrl');
  print(
      'AppEnvironmentData.baseUrl (after cache) = ${sl<AppEnvironmentData>().baseUrl}');

  await authLocal.getBaseUrlResponse();

  log("📦 Loaded base URL from storage: $cachedBaseUrl");

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: AppLanguage.values.map((e) => e.locale).toList(),
      fallbackLocale: AppLanguage.english.locale,
      child: const MainApp(),
    ),
  );
}
