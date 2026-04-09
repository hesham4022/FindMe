import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

final pusher = PusherChannelsFlutter.getInstance();

Future<void> initPusher() async {
  await pusher.init(
    apiKey: "a118360ad1a87f1ee1ae",
    cluster: "mt1",
    onEvent: (event) {
      print("🔥 EVENT: ${event.data}");
    },
  );

  await pusher.subscribe(channelName: "private-user-1");
  await pusher.connect();
}
