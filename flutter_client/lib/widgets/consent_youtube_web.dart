// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

/// Web implementation — registers a YouTube iframe factory.
void registerYouTubeViewFactory(String viewType, String videoId) {
  ui_web.platformViewRegistry.registerViewFactory(
    viewType,
    (int viewId) {
      return html.IFrameElement()
        ..src = 'https://www.youtube-nocookie.com/embed/$videoId'
            '?autoplay=1&rel=0&modestbranding=1'
        ..allow = 'autoplay; fullscreen; encrypted-media; picture-in-picture'
        ..allowFullscreen = true
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
    },
  );
}
