// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web implementation — triggers a Blob download in the browser.
void downloadLogBytes(List<int> bytes, String filename) {
  try {
    final blob = html.Blob([bytes], 'text/plain');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = filename;
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  } catch (_) {}
}
