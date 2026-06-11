import 'package:flutter/material.dart';

enum DiffOp { equal, insert, delete }

class DiffSpan {
  final DiffOp op;
  final String text;
  const DiffSpan(this.op, this.text);
}

/// Strips HTML tags and decodes common entities.
String stripHtml(String html) {
  if (html.isEmpty) return html;
  return html
      .replaceAll(RegExp(r'<[^>]+>'), ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

/// Splits text into tokens (words + whitespace/punctuation preserved).
List<String> _tokenize(String text) {
  if (text.isEmpty) return [];
  return RegExp(r'\S+|\s+').allMatches(text).map((m) => m.group(0)!).toList();
}

/// Computes a word-level diff between [oldText] and [newText].
/// HTML is stripped before comparison.
/// Returns a list of [DiffSpan]s with [DiffOp.delete], [DiffOp.insert], [DiffOp.equal].
List<DiffSpan> computeWordDiff(String oldText, String newText) {
  final a = _tokenize(stripHtml(oldText));
  final b = _tokenize(stripHtml(newText));
  if (a.isEmpty && b.isEmpty) return [];
  if (a.isEmpty) return b.map((t) => DiffSpan(DiffOp.insert, t)).toList();
  if (b.isEmpty) return a.map((t) => DiffSpan(DiffOp.delete, t)).toList();

  // Cap to avoid O(n²) blowup on huge texts
  const maxTokens = 800;
  final aSlice = a.length > maxTokens ? a.sublist(0, maxTokens) : a;
  final bSlice = b.length > maxTokens ? b.sublist(0, maxTokens) : b;

  final m = aSlice.length;
  final n = bSlice.length;

  // LCS table
  final dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (aSlice[i - 1] == bSlice[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1];
      }
    }
  }

  // Backtrack
  final result = <DiffSpan>[];
  int i = m, j = n;
  while (i > 0 || j > 0) {
    if (i > 0 && j > 0 && aSlice[i - 1] == bSlice[j - 1]) {
      result.add(DiffSpan(DiffOp.equal, aSlice[i - 1]));
      i--;
      j--;
    } else if (j > 0 && (i == 0 || dp[i][j - 1] >= dp[i - 1][j])) {
      result.add(DiffSpan(DiffOp.insert, bSlice[j - 1]));
      j--;
    } else {
      result.add(DiffSpan(DiffOp.delete, aSlice[i - 1]));
      i--;
    }
  }

  // Append overflow if capped
  if (a.length > maxTokens) {
    result.add(DiffSpan(DiffOp.delete, ' … [${a.length - maxTokens} weitere Tokens]'));
  }
  if (b.length > maxTokens) {
    result.add(DiffSpan(DiffOp.insert, ' … [${b.length - maxTokens} weitere Tokens]'));
  }

  return result.reversed.toList();
}

/// Builds a [TextSpan] tree for one side of the diff.
/// [side] = 'left' shows deletes (red), 'right' shows inserts (green).
TextSpan buildDiffTextSpan(List<DiffSpan> spans, String side, BuildContext context) {
  final defaultColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white;

  final children = <TextSpan>[];
  for (final s in spans) {
    if (s.op == DiffOp.equal) {
      children.add(TextSpan(text: s.text, style: TextStyle(color: defaultColor)));
    } else if (s.op == DiffOp.delete && side == 'left') {
      children.add(TextSpan(
        text: s.text,
        style: TextStyle(
          color: Colors.red.shade300,
          backgroundColor: Colors.red.withOpacity(0.15),
          decoration: TextDecoration.lineThrough,
          decorationColor: Colors.red.shade300,
        ),
      ));
    } else if (s.op == DiffOp.insert && side == 'right') {
      children.add(TextSpan(
        text: s.text,
        style: TextStyle(
          color: Colors.green.shade300,
          backgroundColor: Colors.green.withOpacity(0.15),
        ),
      ));
    }
    // Skip inserts on left side and deletes on right side (they don't exist there)
  }
  return TextSpan(children: children);
}
