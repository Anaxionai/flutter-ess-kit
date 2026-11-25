import 'package:material_ui/material_ui.dart';

/// Shows a dialog to add or rename a habit.
///
/// Returns the trimmed name on Save, or `null` on Cancel.
///
/// TODO(task 10): an AlertDialog with a Form and one TextFormField,
/// prefilled with [initialName]. The validator's three rules and messages:
/// - empty after trimming: 'Enter a name'
/// - longer than 40 characters: 'Use 40 characters or fewer'
/// - already in [existingNames], ignoring capitals: 'You already have this habit'
Future<String?> showHabitDialog(
  BuildContext context, {
  String? initialName,
  List<String> existingNames = const [],
}) {
  throw UnimplementedError('TODO(task 10): showHabitDialog');
}
