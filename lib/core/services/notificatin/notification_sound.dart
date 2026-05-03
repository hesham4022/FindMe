import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playNotificationSound() async {
    await _player.play(AssetSource('sounds/oringz-w427-371.mp3'));
  }
}
