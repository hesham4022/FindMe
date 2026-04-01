import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/features/add_case/presentation/pages/add_case.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/app/presentation/pages/app.dart';
import 'package:find_me_app/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:find_me_app/features/auth/presentation/pages/forget_password.dart';
import 'package:find_me_app/features/auth/presentation/pages/sinup.dart';
import 'package:find_me_app/features/auth/presentation/pages/sinup_or_login.dart';
import 'package:find_me_app/features/case_info/presentation/pages/case_info_view.dart';
import 'package:find_me_app/features/notifications/presentation/pages/notification_settings.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/pages/help_center_view.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/pages/privacy_policy_view.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/pages/update_profile.dart';
import 'package:find_me_app/features/search_case/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/app/presentation/pages/initial_page.dart';
import 'package:find_me_app/features/auth/presentation/pages/change_password.dart';
import 'package:find_me_app/features/auth/presentation/pages/reset_password1.dart';
import 'package:find_me_app/features/auth/presentation/pages/reset_password.dart';
import 'package:find_me_app/features/auth/presentation/pages/signin.dart';
import 'package:find_me_app/features/auth/presentation/pages/verify_otp.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/pages/host.dart';
import 'package:find_me_app/features/notifications/presentation/pages/notifications_view.dart';
import 'package:find_me_app/features/profile/data/model/user_profile_model.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/pages/profile_view.dart';
import 'package:find_me_app/features/settings/presentation/pages/settings_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String initialRoute = "/";
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String singInNSignupRoute = '/singInNSignupRoute';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String resetPasswordRoute1 = '/resetPasswordRoute1';
  static const String caseInfoRoute = '/caseInfoRoute';
  static const String verifyOTPRoute = '/verifyOTP';
  static const String resetPasswordRoute = '/resetPassword';
  // static const String changePasswordRoute = '/changePassword';
  static const String hostRoute = '/host';
  static const String searchRoute = '/searchRoute';
  static const String helpCenterView = '/HelpCenterView';
  static const String addCaseView = '/addCaseView';

  static const String notificationSettingRoute = '/notificationSettingRoute';
  static const String notificationsRoute = '/notifications';
  static const String vacationRequestRoute = '/vacationRequest';
  static const String leaveRequestRoute = '/leaveRequest';
  static const String loanRequestRoute = '/loanRequest';
  static const String financialClaimRequestRoute = '/financialClaimRequest';
  static const String overtimeRequestRoute = '/overtimeRequest';
  static const String letterRequestRoute = '/letterRequest';
  static const String businessTripRequestRoute = '/businessTripRequest';
  static const String businessTripsRoute = '/businessTrips';
  static const String terminationRequestRoute = '/terminationRequestRoute';
  static const String profileRoute = '/profile';
  static const String updateProfileRoute = '/updateProfile';
  static const String privacyRoute = '/privacyRoute';
  static const String personalInfoRoute = '/personalInfo';
  static const String financialInfoRoute = '/financialInfo';
  static const String employmentInfoRoute = '/employmentInfo';
  static const String changePasswordRoute = '/changePassword';
  static const String settingsRoute = '/settings';
  static const String acknowledgementHistoryRoute = '/acknowledgementHistory';
  static const String errorPageRoute = '/errorPage';
  static const String actionDetailsPageRoute = '/actionDetails';
  static const String requestDetailsPageRoute = '/requestDetails';

  //! My Services
  // static const String myProfileRoute = '/myProfile';
  static const String myRequestsRoute = '/myRequests';
  static const String myDocumentsRoute = '/myDocuments';
  static const String myTeamRoute = '/myTeam';
  static const String myEvaluationsRoute = '/myEvaluations';
  static const String timeAttendanceRoute = '/timeAttendance';
  static const String timesheetRoute = '/timesheet';
  static const String timesheetDetailsRoute = '/timesheetDetailsRoute';
  static const String suggestionsAndComplaintsRoute =
      '/suggestionsAndComplaints';
  static const String directoryRoute = '/directory';
  static const String companyDocumentRoute = '/companyDocument';
  static const String upcomingEventsRoute = '/upcomingEvents';
  static const String calendarRoute = '/calendar';
  static const String mySalarySlipRoute = '/mySalarySlip';
  static const String myAssetsRoute = '/myAssets';
  static const String missingPunchRequestRoute = '/missingPunchRequest';
  static const String evaluationReportRoute = '/evaluationReport';
  static const String timeAttendanceDetailsRoute =
      '/TimeAttendanceDetailsViewView';
  static const String attendanceRecordDetailsRoute =
      '/attendanceRecordDetailsRoute';
  static const String rosterScheduleDetailsRoute = '/RosterScheduleDetails';
  static const String memberServicesScreen = '/memberServicesScreen';
  static const String evaluateEmployeeRoute = '/evaluateEmployeeRoute';
  static const String chatRoute = '/chatRoute';

  static Route? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (context) => const MiddlewarePage(),
          settings: settings,
        );

      case signinRoute:
        final args = settings.arguments as String?;

        return MaterialPageRoute(
          builder: (context) => SigninView(),
          settings: settings,
        );
      case signupRoute:
        final args = settings.arguments as String?;

        return MaterialPageRoute(
          builder: (context) => const SinUpView(),
          settings: settings,
        );
      case singInNSignupRoute:
        final args = settings.arguments as String?;

        return MaterialPageRoute(
          builder: (context) => const SinupOrLogin(),
          settings: settings,
        );
      case forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView(),
          settings: settings,
        );
      case resetPasswordRoute1:
        final args = settings.arguments as ResetPasswordArgs;
        return MaterialPageRoute(
          builder: (context) => ResetPassword1(args: args),
          settings: settings,
        );

      case notificationSettingRoute:
        return MaterialPageRoute(
          builder: (context) => const NotificationSettingsView(),
          settings: settings,
        );
      case AppRoutes.caseInfoRoute:
        final caseInfo = settings.arguments as CaseInfoModel;
        return MaterialPageRoute(
          builder: (_) => CaseInfoView(caseInfo: caseInfo),
          settings: settings,
        );
      case AppRoutes.searchRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AllCasesCubit(sl())..onInit(),
            child: const SearchPageView(),
          ),
        );
      // case resetPasswordRoute:
      //   assert(settings.arguments != null);
      //   final args = settings.arguments as ResetPasswordArgs;
      //   return MaterialPageRoute(
      //     builder: (context) => ResetPasswordView(args: args),
      //     settings: settings,
      //   );

      case verifyOTPRoute:
        assert(settings.arguments != null);
        final args = settings.arguments as VerifyOTPArgs;
        return MaterialPageRoute(
          builder: (context) => VerfiyOTPView(args: args),
          settings: settings,
        );
      // return CustomPageTransition(
      //   page: VerfiyOTPView(args: args),
      //   settings: settings,
      // );

      case hostRoute:
        return MaterialPageRoute(
          builder: (context) => const HostView(currentIndex: 0),
          settings: settings,
        );
      // return CustomPageTransition(
      //   page: const HostView(currentIndex: 0),
      //   settings: settings,
      // );
      case addCaseView:
        return MaterialPageRoute(
          builder: (context) => AddCaseView(),
          settings: settings,
        );
      // case addCaseView:
      //   final caseInfo = settings.arguments as CaseInfoModel;
      //   return MaterialPageRoute(
      //     builder: (context) => AddCaseView(caseInfo: caseInfo),
      //     settings: settings,
      //   );

      case notificationsRoute:
        return MaterialPageRoute(
          builder: (context) => const NotificationsView(),
          settings: settings,
        );
      // case searchRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => const SearchPageView(),
      //     settings: settings,
      //   );
      case helpCenterView:
        return MaterialPageRoute(
          builder: (context) => const HelpCenterView(),
          settings: settings,
        );

      case profileRoute:
        // assert(settings.arguments != null);
        // final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (context) => ProfileViewBody(
              // isPersonal: args['isPersonal'] as bool,
              // employeeId: args['employeeId']
              // as int?, // Ensure it's nullable if not always provided
              ),
          settings: settings,
        );

      case updateProfileRoute:
        return MaterialPageRoute(
          builder: (context) => UpdateProfileView(),
          settings: settings,
        );
      case privacyRoute:
        return MaterialPageRoute(
          builder: (context) => PrivacyPolicyView(),
          settings: settings,
        );
      // return CustomPageTransition(
      //   page: const ProfileView(),
      //   settings: settings,
      // );

      case financialInfoRoute:
        assert(settings.arguments != null);
        final profileData = settings.arguments as UserProfileModel;

      case employmentInfoRoute:
        assert(settings.arguments != null);
        final profileData = settings.arguments as UserProfileModel;

      // case changePasswordRoute:
      //   // assert(settings.arguments != null);
      //   // final args = settings.arguments as bool;
      //   return MaterialPageRoute(
      //     builder: (context) => ChangePasswordView(
      //         // isChangePassword: args,
      //         ),
      //     settings: settings,
      //   );
      case settingsRoute:
        return MaterialPageRoute(
          builder: (context) => const SettingsView(),
          settings: settings,
        );

      case errorPageRoute:
        assert(settings.arguments != null);
        final args = settings.arguments as CustomErrorPageArgs;
        return MaterialPageRoute(
          builder: (context) => CustomErrorWidget(args: args),
          settings: settings,
        );

      default:
        return null;
    }
  }
}
