/// Desktop stub — all web platform operations are no-ops.

typedef WebEventCallback = void Function(dynamic event);

/// Adds a DOM event listener. No-op on desktop.
void webAddEventListener(
    String type, WebEventCallback listener, [bool useCapture = false]) {}

/// Removes a DOM event listener. No-op on desktop.
void webRemoveEventListener(
    String type, WebEventCallback listener, [bool useCapture = false]) {}

/// Registers a platform view factory. No-op on desktop.
void webRegisterViewFactory(
    String viewType, dynamic Function(int) factory) {}

/// Posts a message to an iframe's contentWindow. No-op on desktop.
void webPostMessageToIFrame(dynamic iFrame, dynamic message) {}

/// Returns whether an event is a MessageEvent with string data.
bool isMessageEvent(dynamic event) => false;

/// Returns whether an event is a KeyboardEvent.
bool isKeyboardEvent(dynamic event) => false;

/// Returns the message event data as String, or null.
String? getMessageEventData(dynamic event) => null;

/// KeyboardEvent helpers.
bool getCtrlKey(dynamic event) => false;
bool getMetaKey(dynamic event) => false;
bool getAltKey(dynamic event) => false;
String getKey(dynamic event) => '';
void preventDefaultEvent(dynamic event) {}

/// Creates an IFrameElement with the given srcdoc. Returns null on desktop.
dynamic createIFrameElement(String srcdoc) => null;
