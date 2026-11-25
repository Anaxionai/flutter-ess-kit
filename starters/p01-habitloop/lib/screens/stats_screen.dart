import 'package:material_ui/material_ui.dart';

/// Each habit's current streak, longest streak and last seven days.
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      // TODO(task 22): read HabitsModel and show, per habit, the current
      // streak, the longest streak and how many of the last 7 days are ticked.
      body: const Center(child: Text('No stats yet')),
    );
  }
}
