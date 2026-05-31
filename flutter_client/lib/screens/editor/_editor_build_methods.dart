part of 'editor_screen.dart';

extension EditorBuildMethodsExt on _EditorScreenState {
  // ── Header bar ─────────────────────────────────────────────────────────────

  Widget _buildHeaderBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            border: Border(bottom: BorderSide(color: attrs.borderMain)),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.arrowLeft, color: Colors.white70),
                onPressed: () => context.go('/'),
                tooltip: 'Zurück zum Dashboard',
              ),
              const SizedBox(width: 4),

              // Source drawer toggle
              Tooltip(
                message: _sourceDrawerOpen
                    ? 'Englische Quelle schließen'
                    : 'Englische Quelle einblenden',
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _sourceDrawerOpen
                        ? attrs.brand600.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _sourceDrawerOpen
                          ? attrs.brand600.withValues(alpha: 0.2)
                          : Colors.transparent,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      LucideIcons.panelLeft,
                      color: _sourceDrawerOpen
                          ? attrs.brand600
                          : Colors.white54,
                      size: 18,
                    ),
                    onPressed: () => setState(
                        () => _sourceDrawerOpen = !_sourceDrawerOpen),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Project title + machine name badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(LucideIcons.globe,
                            size: 16, color: attrs.brand600),
                        const SizedBox(width: 8),
                        Text(
                          _englishTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor().withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: _getStatusColor()
                                    .withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            widget.machineName,
                            style: TextStyle(
                              color: _getStatusColor(),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Builder(builder: (context) {
                      final lang = ref.watch(languageProvider).targetLanguage;
                      return Text(
                        'Übersetze nach ${lang.name} (${lang.code})',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.1),
                            fontSize: 12),
                      );
                    }),
                  ],
                ),
              ),

              // Priority count
              if (_remainingPriorityCount != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.amber.withValues(alpha: 0.15)),
                  ),
                  child: Text(
                    '$_remainingPriorityCount verbleibend',
                    style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
              ],

              // "Un-publish" button — only shown for already-reviewed translations
              if (_isReviewMode) ...[
                Tooltip(
                  message: 'Veröffentlichung zurücknehmen und zurück in Review setzen',
                  child: OutlinedButton.icon(
                    onPressed: _resetReview,
                    icon: const Icon(LucideIcons.rotateCcw, size: 14),
                    label: const Text('Zurück in Review'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange,
                      side: const BorderSide(color: Colors.orange, width: 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],

              // Save button
              ElevatedButton.icon(
                onPressed: _isSaving ? null : () => _save(andNext: false),
                icon: _isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Icon(LucideIcons.save, size: 16),
                label: const Text('Speichern'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: attrs.brand600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 8),

              // Save & Next button
              ElevatedButton.icon(
                onPressed: _isSaving ? null : () => _save(andNext: true),
                icon: const Icon(LucideIcons.chevronsRight, size: 16),
                label: const Text('Speichern & Weiter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Resize handle ──────────────────────────────────────────────────────────

  Widget _buildResizeHandle() {
    return GestureDetector(
      onHorizontalDragStart: (_) => setState(() => _isResizing = true),
      onHorizontalDragUpdate: (details) {
        setState(() {
          _sourceDrawerWidth =
              (_sourceDrawerWidth + details.delta.dx)
                  .clamp(_minDrawerWidth, _maxDrawerWidth)
                  .toDouble();
        });
      },
      onHorizontalDragEnd: (_) => setState(() => _isResizing = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeColumn,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: _isResizing ? 4 : 3,
            height: _isResizing ? 64 : 40,
            decoration: BoxDecoration(
              color: _isResizing
                  ? attrs.brand600
                  : Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
              boxShadow: _isResizing
                  ? [
                      BoxShadow(
                          color: attrs.brand600.withValues(alpha: 0.2),
                          blurRadius: 8)
                    ]
                  : [],
            ),
          ),
        ),
      ),
    );
  }

  // ── English source pane ────────────────────────────────────────────────────

  Widget _buildEnglishSourcePane() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1114),
        border: Border(
          right: BorderSide(
            color: _isResizing
                ? attrs.brand600.withValues(alpha: 0.2)
                : attrs.borderMain,
            width: _isResizing ? 2 : 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pane title bar
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ENGLISCHE QUELLE',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.1),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      onPressed: () =>
                          _launchDrupalProject(widget.machineName),
                      icon: Icon(LucideIcons.externalLink,
                          size: 12, color: attrs.brand600),
                      label: Text('Drupal.org',
                          style: TextStyle(
                              color: attrs.brand600,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        backgroundColor:
                            attrs.brand600.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                          _showSourceCode
                              ? LucideIcons.eye
                              : LucideIcons.code,
                          size: 16,
                          color: Colors.white70),
                      onPressed: () =>
                          setState(() => _showSourceCode = !_showSourceCode),
                      tooltip: _showSourceCode
                          ? 'Vorschau anzeigen'
                          : 'HTML-Quellcode anzeigen',
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(LucideIcons.x,
                          size: 16, color: Colors.white54),
                      onPressed: () =>
                          setState(() => _sourceDrawerOpen = false),
                      tooltip: 'Schließen',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: _showSourceCode
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: SelectableText(
                        'ZUSAMMENFASSUNG:\n$_englishSummary\n\nHAUPTBESCHREIBUNG:\n$_englishBody',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: attrs.brand600),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _englishTitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        if (_englishSummary.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Zusammenfassung:',
                                    style: TextStyle(
                                        color: attrs.brand600,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                // ── HtmlWidget replaces HtmlElementView ───
                                HtmlWidget(
                                  _toDisplayHtml(_englishSummary),
                                  textStyle: const TextStyle(
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 14,
                                      height: 1.7),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        Text('Beschreibung:',
                            style: TextStyle(
                                color: attrs.brand600,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        // ── HtmlWidget replaces HtmlElementView ──────────
                        HtmlWidget(
                          _toDisplayHtml(_englishBody),
                          textStyle: const TextStyle(
                              color: Color(0xFFE2E8F0),
                              fontSize: 14,
                              height: 1.7),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Translation pane ───────────────────────────────────────────────────────

  Widget _buildTranslationPane() {
    return Container(
      color: const Color(0xFF14171C),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Workspace header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DEUTSCHE ÜBERSETZUNG',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.1),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                Row(
                  children: [
                    // ── Manual prompt copy ──────────────────────────────
                    Builder(builder: (context) {
                      final lang = ref.watch(languageProvider);
                      final isGerman = lang.targetLanguage.code == 'de';
                      return TextButton.icon(
                        onPressed: () {
                          final langcode = lang.targetLanguage.code;
                          final prompt = buildTranslationPrompt(
                            langcode: langcode,
                            sourceSummary: _englishSummary,
                            sourceBody: _englishBody,
                          );
                          Clipboard.setData(ClipboardData(text: prompt));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(isGerman
                                ? 'Prompt in die Zwischenablage kopiert 📋'
                                : 'Prompt copied to clipboard 📋'),
                            backgroundColor: Colors.teal,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                          ));
                        },
                        icon: const Icon(LucideIcons.clipboard, size: 14),
                        label: Text(
                          isGerman ? 'Prompt' : 'Prompt',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF374151),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    }),
                    const SizedBox(width: 8),
                    // DeepL Translate button
                    TextButton.icon(
                      onPressed: _isDeeplTranslating || _isAiTranslating
                          ? null
                          : _triggerDeeplTranslation,
                      icon: _isDeeplTranslating
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Text(
                              'D',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'serif',
                              ),
                            ),
                      label: Text(
                        _isDeeplTranslating ? 'DeepL...' : 'DeepL',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF0F62FE),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // AI Translate button (Gemini)
                    TextButton.icon(
                      onPressed: _isAiTranslating || _isDeeplTranslating
                          ? null
                          : _triggerAiTranslation,
                      icon: _isAiTranslating
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : Icon(LucideIcons.sparkles,
                              size: 14, color: Colors.white),
                      label: Text(
                        _isAiTranslating ? 'Übersetze...' : 'Gemini',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: attrs.brand600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Preview toggle
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => _showPreview = !_showPreview),
                      icon: Icon(
                          _showPreview
                              ? LucideIcons.edit
                              : LucideIcons.eye,
                          size: 14),
                      label: Text(_showPreview
                          ? 'Editor anzeigen'
                          : 'Vorschau anzeigen'),
                      style: TextButton.styleFrom(
                        foregroundColor: attrs.brand600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Form body
          Expanded(
            child: _showPreview
                ? _buildLivePreviewWidget()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Module title (read-only)
                        _buildLabel('Modul-Titel (Englisch)'),
                        TextField(
                          controller: TextEditingController(
                              text: _englishTitle),
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor:
                                Colors.white.withValues(alpha: 0.1),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.white10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.white10)),
                          ),
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5)),
                        ),
                        const SizedBox(height: 24),

                        // ── Summary editor ─────────────────────────────
                        _buildFieldModeToggle(
                          'Zusammenfassung',
                          _showSummaryHtml,
                          (val) {
                            setState(() => _showSummaryHtml = val);
                            if (val) {
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () => _syncToSourceIFrame(
                                    'summary', _summaryController.text),
                              );
                            }
                          },
                          onTidy: () {
                            final cleaned = tidyDeeplHtml(_summaryController.text);
                            setState(() => _summaryController.text = cleaned);
                            if (_showSummaryHtml) {
                              Future.delayed(const Duration(milliseconds: 50),
                                  () => _syncToSourceIFrame('summary', cleaned));
                            }
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('HTML bereinigt'),
                              duration: Duration(seconds: 2),
                            ));
                          },
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white10),
                            ),
                            // CkEditorField is ALWAYS in the tree; the
                            // `suppressed` flag hides it via CSS so that
                            // Flutter dialogs remain fully visible and
                            // interactable.  CodeMirror is still removed from
                            // the tree while suppressed (it is an iframe and
                            // cannot be hidden as gracefully).
                            child: _suppressEditors
                                ? CkEditorField(
                                    initialHtml: _summaryController.text,
                                    onChanged: (html) =>
                                        _summaryController.text = html,
                                    height: 200,
                                    isSimple: true,
                                    suppressed: true,
                                  )
                                : _showSummaryHtml
                                    ? const SizedBox(
                                        height: 200,
                                        child: HtmlElementView(
                                            viewType: 'editor-summary-source'),
                                      )
                                    : CkEditorField(
                                        initialHtml: _summaryController.text,
                                        onChanged: (html) =>
                                            _summaryController.text = html,
                                        height: 200,
                                        isSimple: true,
                                      ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ── Body editor ────────────────────────────────
                        _buildFieldModeToggle(
                          'Hauptbeschreibung',
                          _showBodyHtml,
                          (val) {
                            setState(() => _showBodyHtml = val);
                            if (val) {
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () => _syncToSourceIFrame(
                                    'body', _bodyController.text),
                              );
                            }
                          },
                          onTidy: () {
                            final cleaned = tidyDeeplHtml(_bodyController.text);
                            setState(() => _bodyController.text = cleaned);
                            if (_showBodyHtml) {
                              Future.delayed(const Duration(milliseconds: 50),
                                  () => _syncToSourceIFrame('body', cleaned));
                            }
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('HTML bereinigt'),
                              duration: Duration(seconds: 2),
                            ));
                          },
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: _suppressEditors
                                ? CkEditorField(
                                    initialHtml: _bodyController.text,
                                    onChanged: (html) =>
                                        _bodyController.text = html,
                                    height: 500,
                                    isSimple: false,
                                    suppressed: true,
                                  )
                                : _showBodyHtml
                                    ? const SizedBox(
                                        height: 500,
                                        child: HtmlElementView(
                                            viewType: 'editor-body-source'),
                                      )
                                    : CkEditorField(
                                        initialHtml: _bodyController.text,
                                        onChanged: (html) =>
                                            _bodyController.text = html,
                                        height: 500,
                                        isSimple: false,
                                      ),
                          ),
                        ),

                        ScreenshotAltsSection(
                          attrs: attrs,
                          screenshotUrls: _screenshotUrls,
                          screenshotAltControllers:
                              _screenshotAltControllers,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ── Live preview ───────────────────────────────────────────────────────────

  Widget _buildLivePreviewWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1114),
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: attrs.brand600.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.eye, size: 14, color: attrs.brand600),
                const SizedBox(width: 8),
                Text('LIVE-VORSCHAU',
                    style: TextStyle(
                        color: attrs.brand600.withValues(alpha: 0.2),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _englishTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_summaryController.text.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Zusammenfassung:',
                        style: TextStyle(
                            color: attrs.brand600,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    HtmlWidget(
                      _summaryController.text,
                      textStyle: const TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text('Beschreibung:',
                style: TextStyle(
                    color: attrs.brand600,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            HtmlWidget(
              _bodyController.text,
              textStyle: const TextStyle(
                  color: Colors.white, fontSize: 14, height: 1.65),
              customStylesBuilder: (element) {
                final tag = element.localName ?? '';
                if (tag == 'h2') {
                  return {
                    'color': '#ffffff',
                    'font-size': '1.3rem',
                    'font-weight': '700',
                    'margin-top': '18px',
                    'margin-bottom': '8px',
                  };
                }
                if (tag == 'h3') {
                  return {
                    'color': '#ffffff',
                    'font-size': '1.1rem',
                    'font-weight': '700',
                    'margin-top': '14px',
                    'margin-bottom': '6px',
                  };
                }
                if (tag == 'h4') {
                  return {
                    'color': '#CBD5E0',
                    'font-size': '0.95rem',
                    'font-weight': '700',
                    'margin-top': '10px',
                  };
                }
                if (['code', 'kbd', 'samp', 'var'].contains(tag)) {
                  return {
                    'background-color': 'rgba(104,211,145,0.15)',
                    'color': '#68D391',
                    'border': '1px solid rgba(104,211,145,0.3)',
                    'border-radius': '4px',
                    'padding': '2px 6px',
                    'font-family': 'monospace',
                    'font-size': '0.875em',
                  };
                }
                if (tag == 'blockquote') {
                  return {
                    'border-left': '3px solid #6366F1',
                    'padding-left': '10px',
                    'font-style': 'italic',
                    'color': '#A0AEC0',
                  };
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Small helpers ──────────────────────────────────────────────────────────

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFieldModeToggle(
    String label,
    bool showHtml,
    ValueChanged<bool> onChanged, {
    VoidCallback? onTidy,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              if (onTidy != null) ...[
                const SizedBox(width: 8),
                Tooltip(
                  message: 'HTML bereinigen (DeepL-Artefakte entfernen)',
                  child: InkWell(
                    onTap: onTidy,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Icon(LucideIcons.wand, size: 13, color: Colors.white38),
                    ),
                  ),
                ),
              ],
            ],
          ),
          Container(
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => onChanged(false),
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(5)),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !showHtml
                          ? attrs.brand600.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(5)),
                    ),
                    child: Text(
                      'VISUELL',
                      style: TextStyle(
                        color: !showHtml
                            ? attrs.brand600
                            : Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                Container(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.1)),
                InkWell(
                  onTap: () => onChanged(true),
                  borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(5)),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: showHtml
                          ? attrs.brand600.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(5)),
                    ),
                    child: Text(
                      'QUELLCODE (HTML)',
                      style: TextStyle(
                        color: showHtml
                            ? attrs.brand600
                            : Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
