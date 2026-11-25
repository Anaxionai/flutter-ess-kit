import 'package:material_ui/material_ui.dart';

/// HabitLoop's home screen: today's habits, ticked off one by one.
///
/// The layout is done. The data and the logic are yours.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO(task 9): keep `List<Habit> habits` (start with three habits from the
  // kit's data/habits/sample-habits.json) and `List<CheckIn> checkIns`.
  // Write `DateTime today()` and `bool isDoneToday(Habit habit)`.
  // TODO(task 20): load both lists from the HabitStore in initState, with a
  // loading indicator and an error message, and save every change.
  // TODO(task 22): move the lists and the change methods into HabitsModel,
  // then read it here with context.watch and context.read.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitLoop'),
        // TODO(task 22): an icon button that opens StatsScreen with Navigator.push.
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            // TODO(task 9): show '<done> of <total> done today'.
            child: Text('Today'),
          ),
          Expanded(
            // TODO(task 9): when there are habits, a ListView.builder with a
            // CheckboxListTile per habit, keyed by ValueKey(habit.id).
            // TODO(task 11): wrap each row in Dismissible, with a SnackBar Undo.
            // TODO(task 21): show 'Streak: <n>' under each habit's name.
            child: Center(child: Text('No habits yet')),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        // TODO(task 10): open showHabitDialog and add the new habit.
        onPressed: null,
        tooltip: 'Add habit',
        child: Icon(Icons.add),
      ),
    );
  }
}
