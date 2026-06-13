// Self-hosted CKEditor 5 build for PB Translation Hub.
//
// Why this file exists:
//   The app previously loaded ClassicEditor from cdn.ckeditor.com. That is a
//   third-party request on every page load (DSGVO-relevant) AND the predefined
//   CDN "classic" build does not include the Code / CodeBlock / SourceEditing /
//   GeneralHtmlSupport plugins — so inline <code> and <pre><code> were stripped
//   on setData() and the toolbar "code" button silently disappeared.
//
//   This bundle includes those plugins and exposes the SAME `window.ClassicEditor`
//   global that the existing _ckBridge in web/index.html already calls, so the
//   bridge keeps working unchanged.
//
// Build:  npm install && npm run build   (outputs to ../web/vendor/ckeditor/)

import {
  ClassicEditor as BaseClassicEditor,
  Essentials,
  Paragraph,
  Heading,
  Bold,
  Italic,
  Link,
  List,
  BlockQuote,
  Code,
  CodeBlock,
  SourceEditing,
  GeneralHtmlSupport,
  Autoformat,
  PasteFromOffice,
  TextTransformation,
} from 'ckeditor5';

import 'ckeditor5/ckeditor5.css';

// Subclass so we can attach builtinPlugins without mutating the shared base.
class ClassicEditor extends BaseClassicEditor {}

// These are loaded for every editor instance. The toolbar (which buttons are
// actually shown) and htmlSupport config are still controlled per-instance from
// the _ckBridge.init() call in web/index.html.
ClassicEditor.builtinPlugins = [
  Essentials,
  Paragraph,
  Heading,
  Bold,
  Italic,
  Link,
  List,
  BlockQuote,
  Code,          // inline <code>
  CodeBlock,     // <pre><code> blocks
  SourceEditing, // raw HTML source view
  GeneralHtmlSupport, // preserve arbitrary tags/attributes (e.g. listicle <div>/<span>)
  Autoformat,
  PasteFromOffice,
  TextTransformation,
];

window.ClassicEditor = ClassicEditor;
