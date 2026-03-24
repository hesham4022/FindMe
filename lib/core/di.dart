import 'package:find_me_app/core/app_secured_data/app_data.dart';
import 'package:find_me_app/core/error_management/exception_handler.dart';
import 'package:find_me_app/core/networking/http_interceptors.dart';
import 'package:find_me_app/core/networking/network_info.dart';
import 'package:find_me_app/core/services/local_notifications/notifications_service_cubit.dart';
import 'package:find_me_app/core/services/location/location_service.dart';
import 'package:find_me_app/features/add_case/data/repo/add_case_repo.dart';
import 'package:find_me_app/features/add_case/data/repo/update_case_repo.dart';
import 'package:find_me_app/features/add_case/data/source/add_case_remote.dart';
import 'package:find_me_app/features/add_case/data/source/update_case_remote.dart';
import 'package:find_me_app/features/all_cases/data/repo/all_cases_repo.dart';
import 'package:find_me_app/features/all_cases/data/source/all_cases_remote.dart';
import 'package:find_me_app/features/app/data/repo/app_repo.dart';
import 'package:find_me_app/features/app/data/source/app_local.dart';
import 'package:find_me_app/features/app/data/source/app_remote.dart';
import 'package:find_me_app/features/auth/data/repo/auth_repo.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/data/source/auth_remote.dart';
import 'package:find_me_app/features/case_info/data/repo/single_case_repo.dart';
import 'package:find_me_app/features/case_info/data/source/single_case_remote.dart';
import 'package:find_me_app/features/likes/data/repo/like_repo.dart';
import 'package:find_me_app/features/likes/data/source/like_remote.dart';
import 'package:find_me_app/features/notifications/data/repo/notification_repo.dart';
import 'package:find_me_app/features/notifications/data/source/notification_remote.dart';
import 'package:find_me_app/features/profile/data/repo/profile_repo.dart';
import 'package:find_me_app/features/profile/data/repo/update_profile_repo.dart';
import 'package:find_me_app/features/profile/data/source/profile_remote.dart';
import 'package:find_me_app/features/profile/data/source/update_profile_remote.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Instance from GetIT
final sl = GetIt.instance;

/// Inject all dependencies using GetIt package
Future<void> init() async {
  //! Core
  sl.registerLazySingleton<AppEnvironmentData>(() => AppEnvironmentData());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl()));

  //! external packages
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton(() => AppHttpClient().client);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  // sl.registerLazySingleton(() => AppFunctions());
  sl.registerLazySingleton(() => ExceptionHandler());
  sl.registerLazySingleton<LocationService>(() => LocationService());

  //! App
  sl.registerLazySingleton<AppRepo>(() => AppRepo());
  sl.registerLazySingleton<AppLocal>(() => AppLocal(sl()));
  sl.registerLazySingleton<AppRemote>(() => AppRemote());

  //! Auth
  sl.registerLazySingleton<AuthRepo>(() => AuthRepo(sl(), sl()));
  sl.registerLazySingleton<AppInterceptor>(() => AppInterceptor());

  sl.registerLazySingleton<AppHttpClient>(() => AppHttpClient());

  sl.registerLazySingleton<AuthRemote>(() => AuthRemote(
        sl(),
      ));
  sl.registerLazySingleton<AuthLocal>(
      () => AuthLocal(StoreRef.main(), sl(), sl()));

  //! Notifications
  sl.registerLazySingleton<LocalNotificationsService>(
      () => LocalNotificationsService());

  sl.registerLazySingleton<NotificationsRemote>(
      () => NotificationsRemote(sl()));
  sl.registerLazySingleton<NotificationRepo>(() => NotificationRepo(sl()));

  //! Profile
  sl.registerLazySingleton<UpdateProfileRepo>(() => UpdateProfileRepo(sl()));
  sl.registerLazySingleton<UpdateProfileRemote>(() => UpdateProfileRemote());

  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepo(sl()));
  sl.registerLazySingleton<ProfileRemote>(() => ProfileRemote(sl()));

  //! All Cases
  sl.registerLazySingleton<AllCasesRemote>(() => AllCasesRemote());
  sl.registerLazySingleton<AllCasesRepo>(() => AllCasesRepo(sl()));

  sl.registerLazySingleton<SingleCaseRemote>(() => SingleCaseRemote());
  sl.registerLazySingleton<SingleCaseRepo>(() => SingleCaseRepo(sl()));

  sl.registerLazySingleton<AddCaseRemote>(() => AddCaseRemote());
  sl.registerLazySingleton<AddCasesRepo>(() => AddCasesRepo(sl()));

  // sl.registerLazySingleton<UpdateReportRemote>(() => UpdateReportRemote());
  // sl.registerLazySingleton<UpdateReportRepo>(() => UpdateReportRepo(sl()));

  sl.registerLazySingleton<LikeRemote>(() => LikeRemote());
  sl.registerLazySingleton<LikeRepo>(() => LikeRepo(sl()));
}

//! Sembast Local DB
late final String _databasePath;

Future initSembast() async {
  final appDir = await getApplicationDocumentsDirectory();
  await appDir.create(recursive: true);
  _databasePath = join(appDir.path, "sembast.db");
  final database = await databaseFactoryIo.openDatabase(_databasePath);

  sl.registerLazySingleton<Database>(() => database);
}

Future<void> kDeleteSembastDB() async {
  // Delete the database file
  await databaseFactoryIo.deleteDatabase(_databasePath);
}
