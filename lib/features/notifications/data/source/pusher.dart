// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class PusherService {
//   static final PusherChannelsFlutter _pusher =
//       PusherChannelsFlutter.getInstance();

//   static Future<void> init({
//     required int userId,
//     required String token,
//   }) async {
//     await _pusher.init(
//       apiKey: "a118360ad1a87f1ee1ae",
//       cluster: "mt1",
//       authEndpoint:
//           "https://web-production-2673c.up.railway.app/api/broadcasting/auth",
//       authParams: {
//         'headers': {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         }
//       },
//       onConnectionStateChange: (currentState, previousState) {
//         print("STATE: $currentState");
//       },
//       onSubscriptionSucceeded: (channelName, data) {
//         print("SUBSCRIBED: $channelName");
//       },
//       onSubscriptionError: (message, e) {
//         print("SUB ERROR: $message , $e");
//       },
//       onEvent: (event) {
//         print("EVENT: ${event.eventName}");
//         print("DATA: ${event.data}");
//       },
//       onError: (message, code, e) {
//         print("ERROR: $message | $code | $e");
//       },
//     );

//     await _pusher.connect();

//     await _pusher.subscribe(
//       channelName: "private-App.Models.User.$userId",
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherChannelsFlutter _pusher =
      PusherChannelsFlutter.getInstance();

  static Future<void> init({
    required int userId,
    required String token,
  }) async {
    await _pusher.init(
      apiKey: "a118360ad1a87f1ee1ae",
      cluster: "mt1",

      // ❌ امسح authEndpoint و authParams
      // ✅ استخدم onAuthorizer بدلهم
      onAuthorizer: (channelName, socketId, options) async {
        try {
          final response = await http.post(
            Uri.parse(
              "https://web-production-2673c.up.railway.app/api/broadcasting/auth",
            ),
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded",
            },
            body: {
              "channel_name": channelName,
              "socket_id": socketId,
            },
          );

          if (response.statusCode == 200) {
            return jsonDecode(response.body);
          } else {
            print("AUTH FAILED: ${response.statusCode} - ${response.body}");
            return null;
          }
        } catch (e) {
          print("AUTH ERROR: $e");
          return null;
        }
      },

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

    await _pusher.connect();

    await _pusher.subscribe(
      channelName: "private-App.Models.User.$userId",
    );
  }
}
