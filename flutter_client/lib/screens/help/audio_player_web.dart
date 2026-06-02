// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web implementation — uses dart:html AudioElement.
class AudioWebPlayer {
  static void play({
    required String url,
    required void Function() onEnded,
    required void Function() onError,
    required void Function(dynamic audio) setAudio,
  }) {
    final audio = html.AudioElement(url)
      ..onEnded.listen((_) => onEnded())
      ..onError.listen((_) => onError());
    setAudio(audio);
    audio.play();
  }

  static void pause(dynamic audio) {
    if (audio is html.AudioElement) {
      audio.pause();
    }
  }
}
