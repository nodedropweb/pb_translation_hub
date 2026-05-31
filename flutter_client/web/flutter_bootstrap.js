{{flutter_js}}
{{flutter_build_config}}

// Force the HTML renderer so that:
//   1. Flutter widgets are rendered as HTML/CSS — browser extensions
//      (DeepL add-on, Grammarly, etc.) can scan the page text.
//   2. Flutter modal dialogs get a high CSS z-index and appear correctly
//      above HtmlElementView platform views (no CanvasKit z-order issue).
_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    let appRunner = await engineInitializer.initializeEngine({
      renderer: 'html',
    });
    await appRunner.runApp();
  }
});
