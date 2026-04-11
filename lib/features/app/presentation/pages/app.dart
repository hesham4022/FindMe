import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/networking/network_info.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/custom_behavior.dart';
import 'package:find_me_app/core/shared/widgets/dismiss_keyboard.dart';
import 'package:find_me_app/features/app/presentation/cubit/app_cubit.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/cubit/signin/signin_cubit.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/cubit/host_cubit.dart';
import 'package:find_me_app/features/notifications/presentation/cubit/notifications_button/notification_btn_cubit.dart';
import 'package:find_me_app/features/profile/presentation/cubit/profile_cubit.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // UI design model for Adjusting Pixel ratio for screens
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, __) {
        return DismissKeyboard(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AppCubit(sl())..onInit(),
                lazy: false,
              ),
              // BlocProvider(
              //   create: (_) => AllCasesCubit(sl())..onInit(),
              // ),

              // BlocProvider(
              //   create: (_) => AuthCubit(sl())..loadCachedUser(),
              // ),

              // BlocProvider(
              //   create: (_) => HostCubit(0, sl())..getUserData(),
              //   // create: (_) => HostCubit(0, sl()),
              // ),
              BlocProvider(
                create: (_) => HostCubit(0, sl(), sl())..loadCachedUser(),
              ),
              BlocProvider(
                create: (_) => NetworkInfo(sl())..listenToConnection(),
              ),
              BlocProvider(
                create: (context) => NotificationBtnCubit(sl())..onInit(),
              ),
              // BlocProvider(
              //   create: (_) => FCMCubit(sl())..onInit(),
              //   lazy: false,
              // ),
              BlocProvider(
                create: (_) => SignInCubit(
                  sl(),
                  sl(),
                  sl(),
                ),
                lazy: false,
              ),
              // BlocProvider(create: (context) => HostCubit(0)),
              BlocProvider(
                create: (context) => ProfileCubit(sl())
                  ..getProfile(int.tryParse(sl<AuthLocal>().getUserId()) ?? -1),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              scrollBehavior: CustomBehavior(),
              theme: AppThemes.lightTheme(context),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              onGenerateRoute: AppRoutes.routeGenerator,
            ),
          ),
        );
      },
    );
  }
}
