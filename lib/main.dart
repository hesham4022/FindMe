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

  // 🔹 إجبار التطبيق على الوضع الرأسي فقط
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 🔹 تهيئة الـ Dependency Injection و EasyLocalization و Sembast
  await Future.wait([
    di.init(),
    EasyLocalization.ensureInitialized(),
    di.initSembast(),
  ]);

  // 🔹 احصل على إحداثيات المستخدم
  await sl<LocationService>().getUserLocationCoordinates();

  // 🔹 تهيئة AppEnvironmentData مباشرة من .env
  await sl<AppEnvironmentData>().init(kAppEnvironment);
  log('Env.baseDevUrl (raw) = ${Env.baseDevUrl}');
  print(
      'AppEnvironmentData.baseUrl (before cache) = ${sl<AppEnvironmentData>().baseUrl}');

  // 🔹 SharedPreferences + AuthLocal
  final sharedPrefs = await SharedPreferences.getInstance();
  final authLocal =
      AuthLocal(StoreRef.main(), sharedPrefs, FlutterSecureStorage());

  // 🔹 Override HTTP (لتخطي مشاكل SSL في dev)
  HttpOverrides.global = MyHttpOverrides();

  // 🔹 مسح أي baseUrl قديم
  // await authLocal.clearBaseUrlCache();

  // 🔹 حذف "/api" إذا موجود قبل التخزين
  String cleanedBaseUrl = Env.baseDevUrl.replaceAll(RegExp(r'/api$'), '');
  print('Cleaned baseUrl = $cleanedBaseUrl');

  // 🔹 تخزين baseUrl الجديد بعد التنظيف
  await authLocal.cacheBaseUrl(cleanedBaseUrl);

  // 🔹 تحديث AppEnvironmentData singleton بعد التخزين
  sl<AppEnvironmentData>().setNewUrl(cleanedBaseUrl);

  // 🔹 تحقق من التخزين بنجاح
  final cachedBaseUrl = await authLocal.getBaseUrl();
  print('✅ Cached baseUrl = $cachedBaseUrl');
  print(
      'AppEnvironmentData.baseUrl (after cache) = ${sl<AppEnvironmentData>().baseUrl}');

  // 🔹 Load cached BaseUrlResponse إذا موجود
  await authLocal.getBaseUrlResponse();

  log("📦 Loaded base URL from storage: $cachedBaseUrl");

  // 🔹 تشغيل التطبيق مع EasyLocalization
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: AppLanguage.values.map((e) => e.locale).toList(),
      fallbackLocale: AppLanguage.english.locale,
      child: const MainApp(),
    ),
  );
}
