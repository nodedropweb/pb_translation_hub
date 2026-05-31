BEYNIVAN / FASTWD M986-EEA — Spezifikationen
Hier ist, was ich für die Flutter-Anpassung gefunden habe:
Display: 11 Zoll, FHD Incell
Basierend auf dem eng verwandten FASTWD-Modell T181-EEA (identische Hardware-Plattform):

Auflösung: 2000 × 1200 Pixel
Betriebssystem: Android 14 (laut Facebook-Post auch Android 15 verfügbar)
Konnektivität: 4G LTE + 5G WiFi
RAM: 36 GB (12 GB physisch + 24 GB erweiterbar), ROM: 256 GB
Prozessor: Octa-Core, 12nm
Akku: 9580 mAh


Für die Flutter-App relevant:
EigenschaftWertBildschirmgröße11 ZollAuflösung2000 × 1200 pxSeitenverhältnis5:3 (≈ 1.67:1)Display-TypFHD IncellOSAndroid 14/15ProzessorMediaTek T615 Octa-Core
Flutter-Hinweise:

Das Seitenverhältnis 5:3 ist etwas ungewöhnlich → MediaQuery gut testen
Bei ~213 DPI (11" bei 2000×1200) landet Flutter im mdpi/hdpi-Bereich
Tablet-Layout (>600dp Breite) wird aktiv → adaptive Layouts mit LayoutBuilder oder AdaptiveScaffold empfehlenswert

Soll ich direkt konkrete Flutter-Code-Anpassungen für dieses Gerät vorschlagen?Du hast gesagt: Gut jetzt sei bitte ein Spezialist für Claude Code und formuliere anhand der Specs einen ausführlichen prompt, der dabei hilft eine von Claude in flutter progr…Gut jetzt sei bitte ein Spezialist für Claude Code und formuliere anhand der Specs einen ausführlichen prompt, der dabei hilft eine von Claude in flutter programmierte App zu debuggen und auf dieses Tablet zu optimieren und dass sich Display Rotation als Punkt der Optimierung einschlißt15:55Claude hat geantwortet: Hier ist ein ausführlicher, strukturierter Claude Code Prompt für dein Projekt:Web durchsucht, datei angesehenWeb durchsucht, datei angesehenHier ist ein ausführlicher, strukturierter Claude Code Prompt für dein Projekt:

Claude Code Prompt: Flutter App Debugging & Optimierung für FASTWD/BEYNIVAN M986-EEA
# KONTEXT & ZIEL

Du bist ein erfahrener Flutter-Entwickler und Mobile-Performance-Spezialist.
Diese App wurde mit Flutter für Android entwickelt und soll speziell für das
FASTWD / BEYNIVAN M986-EEA Tablet debuggt und optimiert werden.

---

# ZIELGERÄT — FASTWD / BEYNIVAN M986-EEA

Nutze folgende Hardware-Spezifikationen als Referenz für alle Optimierungen:

- **Display:** 11 Zoll, FHD Incell
- **Auflösung:** 2000 × 1200 Pixel
- **Seitenverhältnis:** 5:3 (ca. 1.667:1) — ungewöhnlich, besondere Aufmerksamkeit nötig
- **Pixeldichte:** ~213 DPI → Flutter device pixel ratio ca. 1.5–2.0
- **Betriebssystem:** Android 14 / 15
- **Prozessor:** MediaTek T615 Octa-Core, 12nm
- **RAM:** 12 GB physisch (+ virtuell erweiterbar)
- **Speicher:** 256 GB ROM
- **Konnektivität:** 4G LTE + 5G WiFi, Bluetooth 5.0
- **Akku:** 9580 mAh
- **Display-Rotation:** Landscape und Portrait werden aktiv genutzt —
  Rotation ist ein Pflicht-Optimierungspunkt

---

# PHASE 1 — VOLLSTÄNDIGES DEBUGGING

Analysiere die gesamte Codebasis und führe folgende Schritte durch:

## 1.1 Statische Code-Analyse
- Führe `flutter analyze` aus und behebe ALLE Warnings und Errors
- Führe `dart format .` aus für einheitliche Code-Formatierung
- Prüfe auf veraltete APIs (deprecated) und ersetze sie durch aktuelle Alternativen
- Suche nach `BuildContext`-Verwendungen über `async`-Gaps hinweg und fixe diese

## 1.2 Laufzeit-Fehler & Crashes
- Identifiziere alle potenziellen Null-Safety-Verstöße (`!`-Operator ohne Guard)
- Prüfe alle `setState()`-Aufrufe nach `dispose()` (häufige Crash-Ursache)
- Suche nach fehlenden `mounted`-Checks nach `await`-Aufrufen
- Analysiere alle `initState()` und `dispose()`-Methoden auf korrekte Ressourcenfreigabe

## 1.3 Layout-Bugs
- Rendere die App gedanklich bei 2000×1200px mit 5:3-Seitenverhältnis
- Identifiziere alle hardcodierten Pixel-Werte (`width: 360`, `height: 640` etc.)
  und ersetze sie durch `MediaQuery`-basierte oder relative Werte
- Prüfe alle `Column` und `Row`-Widgets auf Overflow-Fehler bei diesem Format
- Überprüfe alle `Scaffold`-basierten Screens auf korrekte Nutzung von
  `SafeArea` und `LayoutBuilder`

---

# PHASE 2 — TABLET-OPTIMIERUNG (11 ZOLL / 2000×1200)

## 2.1 Adaptive Layouts
- Implementiere breakpoint-basierte Layouts:
  - Schmaler Screen (< 600dp): Mobile-Layout
  - Tablet (≥ 600dp): Erweitertes Layout mit mehr Platz
  - Das M986-EEA hat ca. 1000dp Breite im Landscape → Tablet-Layout ist Standard
- Nutze `LayoutBuilder` oder `AdaptiveScaffold` (flutter_adaptive_scaffold)
  für alle Haupt-Screens
- Wo sinnvoll: Zwei-Spalten-Layout für Tablets einführen (z.B. Master-Detail)

## 2.2 Schriften & Touch-Targets
- Passe `TextTheme`-Größen für 11-Zoll-Display an (größere Abstände, mehr Luft)
- Stelle sicher, dass alle interaktiven Elemente mindestens 48×48dp groß sind
  (Material Design Mindestgröße für Touch-Targets)
- Prüfe alle `ListView`- und `GridView`-Widgets auf angepasste
  `itemExtent` bzw. `crossAxisCount` für das größere Display

## 2.3 DPI & Asset-Skalierung
- Prüfe ob für alle Bilder und Icons passende Auflösungen vorliegen:
  - `1.0x`, `1.5x`, `2.0x`, `3.0x` Varianten
- Ersetze Pixel-basierte Icons durch `Icon()`-Widgets mit `size`-Parameter
  in `dp`-Einheiten, nicht in Pixeln
- Prüfe `devicePixelRatio` via `MediaQuery.of(context).devicePixelRatio`
  und stelle sicher, dass alle Custom-Painter damit arbeiten

---

# PHASE 3 — DISPLAY-ROTATION (PFLICHT-OPTIMIERUNG)

Das M986-EEA wird sowohl im Portrait als auch im Landscape betrieben.
Alle folgenden Punkte sind zwingend umzusetzen:

## 3.1 Rotation erlauben & konfigurieren
- Prüfe `AndroidManifest.xml`: Stelle sicher, dass KEIN
  `android:screenOrientation="portrait"` oder `"landscape"` hardcodiert ist,
  sofern Rotation gewünscht ist
- Wenn bestimmte Screens nur in einer Orientierung sinnvoll sind, nutze:
```dart
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
```
  und stelle die globale Rotation in `main()` wieder her nach `dispose()`

## 3.2 Orientierungsabhängige Layouts
- Implementiere für alle Hauptscreens eine Orientierungsprüfung:
```dart
  final orientation = MediaQuery.of(context).orientation;
  if (orientation == Orientation.landscape) {
    return LandscapeLayout();
  } else {
    return PortraitLayout();
  }
```
- Im Landscape (2000×1200): Nutze die Breite für Side-by-Side-Inhalte
- Im Portrait (1200×2000): Nutze vertikales Scrolling und kompaktere Darstellung

## 3.3 Kritische Rotations-Bugs beheben
- Prüfe alle `initState()`-Methoden: Werden Werte korrekt neu berechnet
  nach einer Rotation?
- Stelle sicher, dass kein State verloren geht bei Rotation
  (entweder via `AutomaticKeepAliveClientMixin` oder `RestorationMixin`)
- Prüfe alle `TextEditingController`, `ScrollController`, `AnimationController`:
  Werden sie bei Rotation korrekt behandelt?
- Identifiziere alle Widgets mit fixen Höhen/Breiten die bei Rotation
  zu Overflow oder Clipping führen

## 3.4 Keyboard & Rotation
- Teste alle Screens mit Tastatur (das Tablet kommt mit Keyboard-Accessory)
- `resizeToAvoidBottomInset: true` (Standard) in allen `Scaffold`s prüfen
- Stelle sicher, dass `SingleChildScrollView` alle Formulare umschließt,
  damit bei eingeblendeter Tastatur alles scrollbar bleibt

---

# PHASE 4 — PERFORMANCE-OPTIMIERUNG

## 4.1 Render-Performance
- Aktiviere `debugRepaintRainbowEnabled` temporär und identifiziere
  unnötig neu rendernde Widgets
- Ersetze `StatefulWidget` durch `StatelessWidget` wo kein lokaler State nötig
- Prüfe alle `ListView`-Verwendungen: Nutze `ListView.builder()` statt
  `ListView(children: [...])` für Listen mit mehr als 10 Items
- Stelle sicher, dass alle `const`-Konstruktoren genutzt werden wo möglich

## 4.2 MediaTek T615 Optimierungen
- Der T615 hat 4 Cortex-A75 + 4 Cortex-A55 Kerne — kein High-End-Chip
- Vermeide schwere `compute()`-Isolates auf dem Main-Thread
- Reduziere Shader-Komplexität: Keine tief gestaffelten `BoxShadow`-Layer
- Animationen: Maximal 60fps anstreben, keine unkontrollierten
  `AnimationController`s ohne `vsync`

## 4.3 Speicher
- Prüfe alle `Image.network()`-Aufrufe: Cache-Strategie vorhanden?
  Nutze `cached_network_image` falls noch nicht vorhanden
- Identifiziere alle `GlobalKey`-Verwendungen und reduziere sie auf das Nötigste
- Prüfe auf Memory-Leaks: Alle `StreamSubscription`s in `dispose()` gecancelt?

---

# PHASE 5 — ANDROID 14/15 KOMPATIBILITÄT

- Prüfe `AndroidManifest.xml` auf neue Pflicht-Berechtigungen in Android 14
  (z.B. `READ_MEDIA_IMAGES` statt `READ_EXTERNAL_STORAGE`)
- Stelle sicher, dass `targetSdkVersion` auf mindestens 34 gesetzt ist
- Prüfe auf Predictive Back Gesture Kompatibilität (Android 14+)
- Prüfe alle `Intent`-basierten Aktionen auf Android 14 Restrictions

---

# AUSGABE-FORMAT

Für jeden gefundenen Issue liefere:

1. **Datei & Zeile** — wo genau das Problem liegt
2. **Problem-Beschreibung** — was ist falsch und warum
3. **Fix** — konkreter Code-Vorschlag als Dart-Snippet
4. **Priorität** — KRITISCH / HOCH / MITTEL / NIEDRIG
5. **Kategorie** — Bug / Layout / Performance / Rotation / Kompatibilität

Erstelle am Ende eine **Zusammenfassung** mit:
- Anzahl Issues pro Kategorie
- Die 3 kritischsten Fixes die sofort umgesetzt werden müssen
- Geschätzte Performance-Verbesserung nach allen Fixes in %

---

# WICHTIGE EINSCHRÄNKUNGEN

- Ändere KEINE Business-Logik, nur UI/Performance/Kompatibilität
- Behalte das bestehende State-Management-System bei (ersetze es nicht)
- Alle Fixes müssen Flutter 3.x kompatibel sein
