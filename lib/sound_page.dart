import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

Sound play = Sound();

class Sound {
  static AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  bool isPlaying = false;
  bool isPaused = false;
  void playHandler() async {
    if (isPlaying) {
      player.pause();
    } else {
      player = await cache.loop('newS.mp3');
    }

    if (isPaused) {
      isPlaying = false;
      isPaused = false;
    } else {
      isPlaying = !isPlaying;
    }
  }
}
