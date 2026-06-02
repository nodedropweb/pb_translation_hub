/// Desktop stub — audio playback not supported.
class AudioWebPlayer {
  static void play({
    required String url,
    required void Function() onEnded,
    required void Function() onError,
    required void Function(dynamic audio) setAudio,
  }) {
    // No-op on desktop.
  }

  static void pause(dynamic audio) {
    // No-op on desktop.
  }
}
