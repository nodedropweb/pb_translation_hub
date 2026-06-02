/// Desktop stubs for dart:html / dart:ui_web types.
/// These are never actually *used* at runtime on desktop (all callers are
/// guarded by kIsWeb), but they must exist so the analyzer / compiler
/// can resolve the type references.

typedef EventListener = void Function(Event);

class Event {
  void preventDefault() {}
}

class KeyboardEvent extends Event {
  final bool ctrlKey;
  final bool metaKey;
  final bool altKey;
  final String? key;
  KeyboardEvent({
    this.ctrlKey = false,
    this.metaKey = false,
    this.altKey = false,
    this.key,
  });
}

class MessageEvent extends Event {
  final dynamic data;
  MessageEvent({this.data});
}

class IFrameElement {
  String? style_border;
  String? srcdoc;
  _ContentWindow? get contentWindow => null;
  _Style get style => _Style();
}

class _Style {
  String border = '';
  String width = '';
  String height = '';
}

class _ContentWindow {
  void postMessage(dynamic message, String targetOrigin) {}
}

class _Window {
  void addEventListener(String type, EventListener listener,
      [bool useCapture = false]) {}
  void removeEventListener(String type, EventListener listener,
      [bool useCapture = false]) {}
}

final _Window window = _Window();

/// Stub for ui_web.platformViewRegistry.
class _PlatformViewRegistry {
  void registerViewFactory(String viewType, dynamic Function(int) factory) {}
}

class _UiWeb {
  _PlatformViewRegistry get platformViewRegistry => _PlatformViewRegistry();
}

final _UiWeb platformViewRegistry_helper = _UiWeb();
