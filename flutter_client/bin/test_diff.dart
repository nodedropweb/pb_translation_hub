import 'package:diff_match_patch/diff_match_patch.dart';

void main() {
  final dmp = DiffMatchPatch();
  final diffs = dmp.diff('Hello World!', 'Hello Brave New World!');
  for (final d in diffs) {
    print('${d.operation}: ${d.text}');
  }
}
