import 'package:material_ui/material_ui.dart';

import 'package:habitloop/screens/home_screen.dart';

void main() {
  // TODO(task 20): call WidgetsFlutterBinding.ensureInitialized(), open the
  // HabitStore at join(await getDatabasesPath(), 'habitloop.db') and pass it on.
  // (main becomes `Future<void> main() async`.)
  // TODO(task 22): wrap the app in ChangeNotifierProvider(create: ... HabitsModel).
  runApp(const HabitLoopApp());
}

class HabitLoopApp extends StatelessWidget {
  const HabitLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitLoop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomeScreen(),
    );
  }
}
