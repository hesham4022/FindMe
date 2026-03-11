import 'package:find_me_app/core/app_secured_data/app_data.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/features/app/data/source/app_local.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';

class ApiConstants {
  //! headers
  static headers({
    String? token,
    String contentType = 'application/json',
  }) =>
      {
        'Accept': 'application/json',
        'Content-Type': contentType,
        "lang": sl<AppLocal>().getCachedLanguage(),
        if (token != null) 'Authorization': 'Bearer $token',
      };

  //----------------------------------------------------------------------------
  static String get _baseUrl => sl<AppEnvironmentData>().baseUrl;

  //! Auth Endpoints -----------------------------------------------------------
  static String getBaseUrlForCompany(int token) =>
      // "http://dev.hrlink.com.sa/linkmain/customer/secure/$token";
      "https://test.hrlink.com.sa/linkmain/customer/secure/$token";
  static final String _authUrl = "$_baseUrl/api/auth";
  static final String refreshTokenUrl = "$_authUrl/refresh";
  static final String resetPasswordUrl = "$_authUrl/reset-password";
  static final String forgetPasswordUrl = "$_authUrl/forgot-password";
  static final String signinUrl = "$_authUrl/login";
  static final String sinUpUrl = "$_authUrl/register";
  static final String allReportsUrl = "$_baseUrl/api/reports";
  static final String getCaseByIdUrl = "$_baseUrl/api/reports/";
  static final String searchByImageUrl = "$_baseUrl/api/search";
  static final String likeInPostUrl = "$_baseUrl/api/reports/like/";
  static final String updateReportUrl = "$_baseUrl/api/reports/";
  static final String activateAccountUrl = "$_baseUrl/api/verify-email";
  static final String deleteAccountUrl = "$_baseUrl/api/deleteAcount";
  static final String resendOTP = "$_authUrl/resend-code";

  static final String changePasswordUrl = "$_authUrl/change-password";
  static String sendOtp(String email) => "$_authUrl/otp/resend/$email";
  static String verifyOtp(String email) => "$_authUrl/otp/resend/$email";

  //! Community Endpoints ------------------------------------------------------

  static final String createReportURL = "$_baseUrl/api/reports";

  static final String _communityUrl = "$_baseUrl/api/community";

  static final String getPostsUrl = "$_communityUrl/post?";
  static final String addPostUrl = "$_communityUrl/post";
  static final String editPostUrl = "$_communityUrl/post";
  static final String deletePostUrl = "$_communityUrl/post/deletePost?";

  static final String getPostReplyUrl = "$_communityUrl/post/reply?";
  static final String addPostReplyUrl = "$_communityUrl/post/reply";
  static final String editReplyPostUrl = "$_communityUrl/post/reply/edit";
  static final String deletePostReplyUrl = "$_communityUrl/post/reply?";

  //! Likes/Dislike Endpoints --------------------------------------------------
  static final String likeReplyUrl = "$_baseUrl/api/like/reply?";
  static final String likePostUrl = "$_baseUrl/api/like/post?";
  static final String dislikeReplyUrl = "$_baseUrl/api/dislike/reply?";

  //! Attendance Endpoints -----------------------------------------------------
  static final String _attendanceUrl = "$_baseUrl/api/employee";
  static String getEmployeeAttendanceData = "$_attendanceUrl/org-location";
  static String postEmployeeAttendance = "$_attendanceUrl/attendance/log";

  //! Requests Endpoints -------------------------------------------------------
  static final String _requestsUrl = "$_baseUrl/api/employee/requests";
  static final String addVacationRequestUrl = "$_requestsUrl/vacation";
  static final String getVacationTypesUrl = "$_requestsUrl/vacation/types";
  static final String getAlternativesUrl = "$_requestsUrl/alternatives";
  static final String addLeaveRequestUrl = "$_requestsUrl/leave";
  static final String getLeaveTypesUrl = "$_requestsUrl/leave/types";
  static final String addLoanRequestUrl = "$_requestsUrl/loan";
  static final String getLoanTypesUrl = "$_requestsUrl/loan/types";
  static String getMyRequestsUrl(int? employeeId) =>
      "$_requestsUrl?employeeId=${employeeId ?? sl<AuthLocal>().getUserId()}";

  static String getRequestDetails(String type, num id, int? employeeId) =>
      "$_baseUrl/api/employee/requests/${type.toLowerCase()}/$id?employeeId=${employeeId ?? sl<AuthLocal>().getUserId()}"; //

  //! Actions Endpoints --------------------------------------------------------
  static final String _actionsUrl = "$_baseUrl/api/actions";
  static final String getActionsUrl = "$_actionsUrl/getTasks?"; //
  static final String getActionDetailsUrl = "$_actionsUrl/getTaskDetails?";
  static final String takeActionUrl = "$_actionsUrl/takeAction?";
  static String cancelRequestUrl(num flowId, String reason) =>
      "$_actionsUrl/withdraw?flowId=$flowId&comment=$reason";

  //! Notifications Endpoints --------------------------------------------------
  static final String _notificationsUrl = "$_baseUrl/notifications";
  static final String getNotificationsUrl = "$_notificationsUrl?";
  static final String getNotificationsCountUrl = "$_notificationsUrl/count";
  static String markNotificationsAsReadUrl(num id) => "$_notificationsUrl/$id";

  //! Evaluation Endpoints ----------------------------------------------------
  static final String _evaluationUrl = "$_baseUrl/api/appraisal";
  static String postEvaluationUrl(int employeeId, int evaluationId) =>
      "$_evaluationUrl/manager/evaluation?employeeId=$employeeId&evaluationId=$evaluationId";

  //----------------------------------------------------------------------------
  //! Cached data
  static const String cachedLanguageKey = 'cachedLanguage';
  static const String cachedIsUserLoggedIn = 'cachedIsUserLoggedIn';
  static const String cachedAuthedUser = 'cachedAuthedUser';
  static const String cachedUserId = 'cachedUserId';
  static const String cachedBaseUrl = 'cachedBaseUrl';

  static const String cachedAccessToken = 'cached_access_token';
  static const String cachedRefreshToken = 'cached_refresh_token';

  static String get cachedNotificationsUnReadedCount =>
      'cachedNotificationsUnReadedCount';

  //! Community Endpoints ------------------------------------------------------
  static String profileData(int employeeId) =>
      "$_baseUrl/api/employee/profile?employeeId=$employeeId";
  static final String getClaimTypes =
      "$_baseUrl/api/employee/requests/claim/types";
  static final String addFinancialClaimRequestUrl = "$_requestsUrl/claim";

  static final String getOvertimeTypes =
      "$_baseUrl/api/employee/requests/overtime/types";
  static final String addOvertimeRequestUrl = "$_requestsUrl/overtime";

  static final String getLetterTypes =
      "$_baseUrl/api/employee/requests/letter/types";
  static final String addLetterRequestUrl = "$_requestsUrl/letter";

  static final String getBanks = "$_baseUrl/api/common/banks";
  static final String getBankBranches = "$_baseUrl/api/common/bank-branches";
  static String getAttachment(String url) => url;
  static String postCommonAttachmentUrl(int id) =>
      "$_baseUrl/api/common/attachments/$id";
  static String getTimeAttendanceHistoryUrl(
          int year, int month, int? employeeId) =>
      "$_baseUrl/api/employee/attendance/history?year=$year&month=$month&employeeId=${employeeId ?? sl<AuthLocal>().getUserId()}";
  static String getTimeAttendanceRecordsUrl(int year, int month) =>
      "$_baseUrl/api/employee/attendance/records?year=$year&month=$month";
  static String getRosterScheduleHistoryUrl(int year, int month) =>
      "$_baseUrl/api/employee/attendance/schedule?year=$year&month=$month";
  static final String addMissingPunchRequestUrl =
      "$_baseUrl/api/employee/attendance/missing-punch";

  static String getMyDocsUrl(int? employeeId) =>
      "$_baseUrl/api/employee/personal-documents?employeeId=${employeeId ?? sl<AuthLocal>().getUserId()}";

  static String getMyAssetsUrl(int? employeeId) =>
      "$_baseUrl/api/employee/assets?employeeId=${employeeId ?? sl<AuthLocal>().getUserId()}";
  // static String getMyTeamsUrl = "$_baseUrl/api/manager/my-team/${sl<AuthLocal>().getUserId()}";
  static String getMyTeamUrl = "$_baseUrl/api/manager/my-team";
  static String getMyEvaluationUrl(int? employeeId) =>
      "$_baseUrl/api/appraisal/employee/evaluations?employeeId=${employeeId ?? sl<AuthLocal>().getUserId()}";
  static String getEvaluationDetailsUrl(int? employeeId, int? evaluationId) =>
      "$_baseUrl/api/appraisal/employee/evaluation?evaluationId=$evaluationId&employeeId=${employeeId ?? sl<AuthLocal>().getUserId()}";
  static final String addContractTerminationRequestUrl =
      "$_requestsUrl/termination";
  static final String allAcknowledgementRequestUrl = "$_requestsUrl/allAck";
  static final String businessTripRequestUrl = "$_requestsUrl/business-trip";
}
