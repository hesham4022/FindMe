import 'dart:convert';

import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/notifications/data/model/notification.dart';
import 'package:http/http.dart' as http;

class NotificationsRemote {
  NotificationsRemote(this._client);

  final http.Client _client;

  // ✅ get notifications
  Future<NotificationResponseModel> getNotifications({
    required int page,
    required int size,
  }) async {
    final queryParams = {
      "page": page.toString(),
      "size": size.toString(),
    };

    final response = await makeHttpRequest(
      url: ApiConstants.getNotificationsUrl,
      requestType: HttpRequestType.get,
      queryParams: queryParams,
      needParsedResponse: true,
    );

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));

    return NotificationResponseModel.fromJson(decoded);
  }

  // ✅ count
  Future<int> getNotificationsCount() async {
    final response = await makeHttpRequest(
      url: ApiConstants.getNotificationsCountUrl,
      requestType: HttpRequestType.get,
      needParsedResponse: true,
    );

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));

    return decoded['total'] ?? 0;
  }

  // ✅ mark as read
  Future<void> markNotificationsAsRead(num id) async {
    await makeHttpRequest(
      url: ApiConstants.markNotificationsAsReadUrl(id),
      requestType: HttpRequestType.put,
      needParsedResponse: false,
    );
  }
}

// import 'dart:convert';

// import 'package:find_me_app/core/helpers/enums/request_type.dart';
// import 'package:find_me_app/core/networking/api_constants.dart';
// import 'package:find_me_app/core/networking/functions.dart';
// import 'package:http/http.dart' as http;

// class NotificationsRemote {
//   NotificationsRemote(
//     this._client,
//   );

//   final http.Client _client;

//   Future<String> getNotifications({
//     required int page,
//     required int size,
//   }) async {
//     final queryParams = {"page": page.toString(), "size": size.toString()};
//     final response = await makeHttpRequest(
//       url: ApiConstants.getNotificationsUrl,
//       requestType: HttpRequestType.get,
//       // client: _client,
//       queryParams: queryParams,
//       needParsedResponse: true,
//     );

//     return utf8.decode(response.bodyBytes);
//   }

//   Future<String> getNotificationsCount() async {
//     final response = await makeHttpRequest(
//       url: ApiConstants.getNotificationsCountUrl,
//       requestType: HttpRequestType.get,
//       // client: _client,
//       needParsedResponse: true,
//     );

//     return utf8.decode(response.bodyBytes);
//   }

//   Future<String> markNotificationsAsRead(num id) async {
//     final response = await makeHttpRequest(
//       url: ApiConstants.markNotificationsAsReadUrl(id),
//       requestType: HttpRequestType.put,
//       // client: _client,
//       needParsedResponse: false,
//     );

//     return utf8.decode(response.bodyBytes);
//   }
// }
