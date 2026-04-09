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

      authEndpoint:
          "https://web-production-2673c.up.railway.app/api/broadcasting/auth",

      // ✅ أهم تعديل هنا
      authParams: {
        'headers': {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }
      },

      onConnectionStateChange: (currentState, previousState) {
        print("🟢 STATE: $currentState");
      },

      onSubscriptionSucceeded: (channelName, data) {
        print("✅ SUBSCRIBED: $channelName");
      },

      onSubscriptionError: (message, e) {
        print("❌ SUB ERROR: $message , $e");
      },

      onEvent: (event) {
        print("🔥 EVENT: ${event.eventName}");
        print("🔥 CHANNEL: ${event.channelName}");
        print("🔥 DATA: ${event.data}");
      },

      onError: (message, code, e) {
        print("❌ ERROR: $message | $code | $e");
      },
    );

    // ✅ connect الأول
    await _pusher.connect();

    // ✅ بعدين subscribe
    await _pusher.subscribe(
      channelName: "private-App.Models.User.$userId",
    );
  }
}
