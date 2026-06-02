// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../services/api_client.dart';

/// Lädt das Glossar für [langcode] vom Server und übergibt es
/// via window._ckBridge.setGlobalGlossary() an alle aktiven CKEditor-Instanzen.
Future<void> loadCkEditorGlossary(ApiClient api, String langcode) async {
  if (!kIsWeb) return;
  try {
    final res = await api.dio.get('/glossary', queryParameters: {'langcode': langcode});
    final terms = res.data as List<dynamic>;
    final bridge = js.context['_ckBridge'] as js.JsObject?;
    if (bridge == null) return;
    bridge.callMethod('setGlobalGlossary', [jsonEncode(terms)]);
  } catch (e) {
    debugPrint('[CkGlossary] $e');
  }
}

/// Passt Tooltip- und Glossar-Highlight-Farben ans aktive Flutter-Theme an,
/// indem CSS-Variablen direkt im DOM gesetzt werden.
/// themeId: 'dark' | 'light' | 'glassy' | 'nature' | 'liquid'
void setCkEditorTheme(String themeId) {
  if (!kIsWeb) return;

  const themes = {
    'dark':   _ThemeVars(bg:'#1A1D22',        border:'rgba(139,92,246,0.55)',  shadow:'rgba(0,0,0,0.65)',   brand:'#8B5CF6', brandLo:'rgba(139,92,246,0.18)',  text:'#F8FAFC', muted:'rgba(255,255,255,0.62)',  divider:'rgba(255,255,255,0.08)', hlBg:'rgba(251,191,36,0.22)',    hlBorder:'#F59E0B'),
    'light':  _ThemeVars(bg:'#FFFFFF',         border:'rgba(127,86,217,0.35)',  shadow:'rgba(0,0,0,0.12)',   brand:'#7F56D9', brandLo:'rgba(127,86,217,0.08)',  text:'#0F172A', muted:'rgba(15,23,42,0.60)',     divider:'rgba(0,0,0,0.08)',       hlBg:'rgba(127,86,217,0.12)',    hlBorder:'#7F56D9'),
    'glassy': _ThemeVars(bg:'rgba(10,22,56,0.96)', border:'rgba(0,156,222,0.55)', shadow:'rgba(0,0,0,0.65)', brand:'#009CDE', brandLo:'rgba(0,156,222,0.18)',   text:'#F8FAFC', muted:'rgba(206,237,249,0.80)', divider:'rgba(0,156,222,0.15)',   hlBg:'rgba(0,156,222,0.18)',     hlBorder:'#009CDE'),
    'nature': _ThemeVars(bg:'#0A130A',         border:'rgba(16,185,129,0.55)',  shadow:'rgba(0,0,0,0.65)',   brand:'#10B981', brandLo:'rgba(16,185,129,0.18)',  text:'#F8FAFC', muted:'rgba(255,255,255,0.62)',  divider:'rgba(255,255,255,0.08)', hlBg:'rgba(16,185,129,0.18)',    hlBorder:'#10B981'),
    'liquid': _ThemeVars(bg:'#0F172A',         border:'rgba(14,165,233,0.55)',  shadow:'rgba(0,0,0,0.65)',   brand:'#0EA5E9', brandLo:'rgba(14,165,233,0.18)',  text:'#F8FAFC', muted:'rgba(148,163,184,0.90)', divider:'rgba(56,189,248,0.12)',  hlBg:'rgba(14,165,233,0.18)',    hlBorder:'#0EA5E9'),
  };

  final t = themes[themeId] ?? themes['dark']!;
  final root = html.document.documentElement;
  final tip  = html.document.getElementById('_ck_glossary_tip');

  root?.style.setProperty('--ck-hl-bg',     t.hlBg);
  root?.style.setProperty('--ck-hl-border', t.hlBorder);
  tip?.style.setProperty('--tip-bg',        t.bg);
  tip?.style.setProperty('--tip-border',    t.border);
  tip?.style.setProperty('--tip-shadow',    t.shadow);
  tip?.style.setProperty('--tip-brand',     t.brand);
  tip?.style.setProperty('--tip-brand-lo',  t.brandLo);
  tip?.style.setProperty('--tip-text',      t.text);
  tip?.style.setProperty('--tip-muted',     t.muted);
  tip?.style.setProperty('--tip-divider',   t.divider);
}

class _ThemeVars {
  final String bg, border, shadow, brand, brandLo, text, muted, divider, hlBg, hlBorder;
  const _ThemeVars({required this.bg, required this.border, required this.shadow, required this.brand, required this.brandLo, required this.text, required this.muted, required this.divider, required this.hlBg, required this.hlBorder});
}
