import 'package:material_ui/material_ui.dart';

import 'package:bookshelf/screens/search_screen.dart';

void main() {
  // TODO(task 9): provide one BookRepository with Provider and switch to
  // MaterialApp.router with the routes in lib/router.dart.
  // TODO(task 10): open the ReadingListStore when kIsWeb is false.
  runApp(const BookShelfApp());
}

class BookShelfApp extends StatelessWidget {
  const BookShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookShelf',
      // TODO(task 21): theme and darkTheme from ColorScheme.fromSeed, and
      // themeMode: ThemeMode.system.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const SearchScreen(),
    );
  }
}
