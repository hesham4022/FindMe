import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/core/app_secured_data/app_data.dart';
import 'package:find_me_app/core/app_secured_data/env.dart';
import 'package:find_me_app/core/helpers/override_http.dart';
import 'package:find_me_app/core/resources/languages.dart';
import 'package:find_me_app/features/app/presentation/pages/app.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/notifications/data/source/pusher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:find_me_app/core/di.dart' as di;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppEnvironment = AppEnvironments.dev;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await pusher.init(
    apiKey: "a118360ad1a87f1ee1ae",
    cluster: "mt1",
    authEndpoint: "https://your-domain.com/broadcasting/auth",
    onConnectionStateChange: (currentState, previousState) {
      print("STATE: $currentState");
    },
    onSubscriptionSucceeded: (channelName, data) {
      print("SUBSCRIBED: $channelName");
    },
    onSubscriptionError: (message, e) {
      print("SUB ERROR: $message , $e");
    },
    onEvent: (event) {
      print("EVENT: ${event.eventName}");
      print("DATA: ${event.data}");
    },
    onError: (message, code, e) {
      print("ERROR: $message | $code | $e");
    },
  );

  await pusher.subscribe(channelName: "private-user-1");
  await pusher.connect();

  final dir = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(dir.path),
  );

  await Future.wait([
    di.init(),
    EasyLocalization.ensureInitialized(),
    di.initSembast(),
  ]);

  await di.sl<AppEnvironmentData>().init(kAppEnvironment);

  final sharedPrefs = await SharedPreferences.getInstance();
  final authLocal =
      AuthLocal(StoreRef.main(), sharedPrefs, FlutterSecureStorage());
  HttpOverrides.global = MyHttpOverrides();

  String cleanedBaseUrl = Env.baseDevUrl.replaceAll(RegExp(r'/api$'), '');

// ✅ اكتب بس لو الـ URL اتغير
  final existingUrl = await authLocal.getBaseUrl();
  if (existingUrl != cleanedBaseUrl) {
    await authLocal.cacheBaseUrl(cleanedBaseUrl);
  }

  di.sl<AppEnvironmentData>().setNewUrl(cleanedBaseUrl);
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: AppLanguage.values.map((e) => e.locale).toList(),
      fallbackLocale: AppLanguage.english.locale,
      child: const MainApp(),
    ),
  );
}





// import 'dart:developer';
// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:find_me_app/core/app_secured_data/app_data.dart';
// import 'package:find_me_app/core/app_secured_data/env.dart';
// import 'package:find_me_app/core/di.dart';
// import 'package:find_me_app/core/helpers/override_http.dart';
// import 'package:find_me_app/core/resources/languages.dart';
// import 'package:find_me_app/features/app/presentation/pages/app.dart';
// import 'package:find_me_app/features/auth/data/source/auth_local.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:find_me_app/core/di.dart' as di;
// import 'package:find_me_app/core/di.dart';
// import 'package:sembast/sembast.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// //! App Version
// // Change it when you want to switch between App Versions
// const kAppEnvironment = AppEnvironments.dev;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   await Future.wait([
//     di.init(),
//     EasyLocalization.ensureInitialized(),
//     di.initSembast(),
//   ]);

//   // await sl<LocationService>().getUserLocationCoordinates();

//   await sl<AppEnvironmentData>().init(kAppEnvironment);
//   log('Env.baseDevUrl (raw) = ${Env.baseDevUrl}');
//   print(
//       'AppEnvironmentData.baseUrl (before cache) = ${sl<AppEnvironmentData>().baseUrl}');

//   // 🔹 SharedPreferences + AuthLocal
//   final sharedPrefs = await SharedPreferences.getInstance();
//   final authLocal =
//       AuthLocal(StoreRef.main(), sharedPrefs, FlutterSecureStorage());

//   HttpOverrides.global = MyHttpOverrides();

//   String cleanedBaseUrl = Env.baseDevUrl.replaceAll(RegExp(r'/api$'), '');
//   print('Cleaned baseUrl = $cleanedBaseUrl');

//   await authLocal.cacheBaseUrl(cleanedBaseUrl);

//   sl<AppEnvironmentData>().setNewUrl(cleanedBaseUrl);

//   final cachedBaseUrl = await authLocal.getBaseUrl();
//   print('✅ Cached baseUrl = $cachedBaseUrl');
//   print(
//       'AppEnvironmentData.baseUrl (after cache) = ${sl<AppEnvironmentData>().baseUrl}');

//   // await authLocal.getBaseUrlResponse();

//   log("📦 Loaded base URL from storage: $cachedBaseUrl");

//   runApp(
//     EasyLocalization(
//       path: 'assets/translations',
//       supportedLocales: AppLanguage.values.map((e) => e.locale).toList(),
//       fallbackLocale: AppLanguage.english.locale,
//       child: const MainApp(),
//     ),
//   );
// }

