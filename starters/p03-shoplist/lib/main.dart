import 'package:material_ui/material_ui.dart';

import 'package:shoplist/screens/home_screen.dart';

void main() {
  // TODO(task 7): WidgetsFlutterBinding.ensureInitialized(), then
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  // before runApp. (main becomes `Future<void> main() async`.)
  runApp(const ShopListApp());
}

class ShopListApp extends StatelessWidget {
  const ShopListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopList',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      // TODO(task 8): home becomes an AuthGate (lib/screens/auth_gate.dart):
      // sign-in, verify-email or HomeScreen, from userChanges().
      // TODO(task 10): MaterialApp.router with go_router and /list/:listId.
      home: const HomeScreen(),
    );
  }
}
