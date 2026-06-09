import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../theme/app_theme.dart';
import '../services/api_client.dart';

// ─────────────────────────────────── Model ───────────────────────────────────

class AutocompleteSuggestion {
  final String machineName;
  final String title;
  final String status;

  const AutocompleteSuggestion({
    required this.machineName,
    required this.title,
    required this.status,
  });

  factory AutocompleteSuggestion.fromJson(Map<String, dynamic> json) {
    return AutocompleteSuggestion(
      machineName: json['machine_name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      status: json['status'] as String? ?? 'missing',
    );
  }
}

// ─────────────────────────────────── Widget ──────────────────────────────────

/// Search field with live autocomplete dropdown from /api/autocomplete.
///
/// - Debounces autocomplete requests (300 ms).
/// - Debounces onSearchChanged calls (800 ms) for the project list.
/// - Supports keyboard navigation: ↑ ↓ Enter Escape.
/// - Navigates directly to the editor when a suggestion is selected.
class SearchWithAutocomplete extends ConsumerStatefulWidget {
  /// Current search value (used as initial text).
  final String initialValue;

  /// Called with the search string after 800 ms debounce or on Enter.
  final void Function(String value) onSearchChanged;

  /// Optional active filter – passed to /api/autocomplete for smarter results.
  final String? activeFilter;

  /// Optional override for what happens when a suggestion is tapped or
  /// confirmed with Enter. When null, the default behaviour is to navigate
  /// to `/edit/<machineName>`.
  final void Function(AutocompleteSuggestion suggestion)? onSuggestionSelected;

  const SearchWithAutocomplete({
    super.key,
    required this.onSearchChanged,
    this.initialValue = '',
    this.activeFilter,
    this.onSuggestionSelected,
  });

  @override
  ConsumerState<SearchWithAutocomplete> createState() =>
      _SearchWithAutocompleteState();
}

class _SearchWithAutocompleteState
    extends ConsumerState<SearchWithAutocomplete> {
  final ApiClient _api = ApiClient();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();

  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  /// Shared notifier so both the main widget and the overlay react to changes.
  final ValueNotifier<int> _selectedIndex = ValueNotifier(-1);

  OverlayEntry? _overlayEntry;
  Timer? _autocompleteDebounce;
  Timer? _searchDebounce;
  List<AutocompleteSuggestion> _suggestions = [];

  // ──────────────────────────────── Lifecycle ──────────────────────────────

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _autocompleteDebounce?.cancel();
    _searchDebounce?.cancel();
    _focusNode.removeListener(_onFocusChange);
    _hideOverlay();
    _selectedIndex.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Brief delay so a tap on a suggestion registers before the overlay hides.
      Future.delayed(const Duration(milliseconds: 200), _hideOverlay);
    }
  }

  // ──────────────────────────────── API ────────────────────────────────────

  Future<void> _fetchSuggestions(String q) async {
    if (q.length < 2) {
      _suggestions = [];
      _hideOverlay();
      return;
    }
    try {
      final langcode = ref.read(languageProvider).targetLanguage.code;
      final res = await _api.dio.get('/autocomplete', queryParameters: {
        'q': q,
        'langcode': langcode,
        if (widget.activeFilter != null && widget.activeFilter!.isNotEmpty)
          'filter': widget.activeFilter,
      });

      final raw = res.data as List<dynamic>;
      _suggestions = raw
          .map((e) =>
              AutocompleteSuggestion.fromJson(e as Map<String, dynamic>))
          .toList();

      if (mounted && _suggestions.isNotEmpty && _focusNode.hasFocus) {
        _selectedIndex.value = -1;
        _showOverlay();
      } else {
        _hideOverlay();
      }
    } catch (_) {}
  }

  // ──────────────────────────────── Overlay ────────────────────────────────

  void _showOverlay() {
    _hideOverlay();
    if (!mounted) return;

    final overlay = Overlay.of(context);
    final renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final fieldWidth = renderBox?.size.width ?? 440.0;
    final attrs = AppTheme.getAttributes(ref.read(themeProvider).themeId);

    _overlayEntry = OverlayEntry(
      builder: (ctx) => ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (ctx, selIdx, _) {
          return Positioned(
            width: fieldWidth,
            child: CompositedTransformFollower(
              link: _layerLink,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 4),
              showWhenUnlinked: false,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 380),
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(
                      Colors.black.withOpacity(0.5),
                      attrs.bgCard,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: attrs.borderMain),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: _suggestions.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                        color: attrs.borderMain.withOpacity(0.5),
                      ),
                      itemBuilder: (_, i) =>
                          _buildSuggestionTile(_suggestions[i], i == selIdx, attrs, i),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // ──────────────────────────────── Suggestion tile ────────────────────────

  Widget _buildSuggestionTile(
    AutocompleteSuggestion s,
    bool isSelected,
    ThemeAttributes attrs,
    int index,
  ) {
    Color statusColor;
    switch (s.status) {
      case 'translated':
      case 'released':
        statusColor = Colors.greenAccent;
        break;
      case 'stale':
        statusColor = Colors.amberAccent;
        break;
      case 'review':
        statusColor = Colors.purpleAccent;
        break;
      default:
        statusColor = Colors.grey;
    }

    return MouseRegion(
      onEnter: (_) => _selectedIndex.value = index,
      onExit: (_) {
        if (_selectedIndex.value == index) _selectedIndex.value = -1;
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _hideOverlay();
          if (!mounted) return;
          if (widget.onSuggestionSelected != null) {
            widget.onSuggestionSelected!(s);
          } else {
            context.go(Uri(
              path: '/edit/${s.machineName}',
              queryParameters: {'filter': widget.activeFilter ?? 'all'},
            ).toString());
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: isSelected
                ? attrs.brand600.withOpacity(0.2)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected ? attrs.brand600 : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              // Status dot
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),

              // Title + machine name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      s.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isSelected ? attrs.brand600 : attrs.textMain,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      s.machineName,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: attrs.textMuted,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: statusColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  s.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────── Keyboard ───────────────────────────────

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    if (_overlayEntry == null || _suggestions.isEmpty) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      final next = _selectedIndex.value < _suggestions.length - 1
          ? _selectedIndex.value + 1
          : _selectedIndex.value;
      _selectedIndex.value = next;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      final prev =
          _selectedIndex.value > 0 ? _selectedIndex.value - 1 : -1;
      _selectedIndex.value = prev;
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      final idx = _selectedIndex.value;
      if (idx >= 0 && idx < _suggestions.length) {
        _hideOverlay();
        final s = _suggestions[idx];
        if (widget.onSuggestionSelected != null) {
          widget.onSuggestionSelected!(s);
        } else {
          context.go(Uri(
            path: '/edit/${s.machineName}',
            queryParameters: {'filter': widget.activeFilter ?? 'all'},
          ).toString());
        }
      } else {
        widget.onSearchChanged(_controller.text.trim());
        _hideOverlay();
      }
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      _hideOverlay();
    }
  }

  // ──────────────────────────────── Build ──────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final attrs = AppTheme.getAttributes(ref.watch(themeProvider).themeId);

    return CompositedTransformTarget(
      link: _layerLink,
      child: KeyboardListener(
        focusNode: FocusNode(skipTraversal: true),
        onKeyEvent: _handleKeyEvent,
        child: Container(
          key: _fieldKey,
          height: 48,
          decoration: BoxDecoration(
            color: attrs.bgInput.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: attrs.borderMain),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            style: TextStyle(color: attrs.textMain, fontSize: 14),
            onSubmitted: (val) {
              widget.onSearchChanged(val.trim());
              _hideOverlay();
            },
            decoration: InputDecoration(
              hintText: 'Suche nach Modulen (z. B. token, views)…',
              hintStyle: TextStyle(
                color: attrs.textMuted.withOpacity(0.8),
                fontSize: 14,
              ),
              prefixIcon:
                  Icon(LucideIcons.search, color: attrs.textMuted, size: 18),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(LucideIcons.x, color: attrs.textMuted, size: 18),
                      onPressed: () {
                        _controller.clear();
                        widget.onSearchChanged('');
                        setState(() {});
                        _hideOverlay();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (val) {
              setState(() {}); // rebuild suffixIcon

              // Autocomplete: 300 ms debounce
              _autocompleteDebounce?.cancel();
              _autocompleteDebounce = Timer(
                const Duration(milliseconds: 300),
                () => _fetchSuggestions(val),
              );

              // Project list search: 800 ms debounce
              _searchDebounce?.cancel();
              _searchDebounce = Timer(
                const Duration(milliseconds: 800),
                () => widget.onSearchChanged(val.trim()),
              );
            },
          ),
        ),
      ),
    );
  }
}
