import 'package:material_ui/material_ui.dart';

/// BookShelf's first screen: a search box and the results.
///
/// The layout is done. Searching and showing the results are yours.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  // TODO(task 7): a BookRepository and the books from the last search.
  // TODO(task 8): `Future<List<Book>>? _results`, set in the Search
  // handler inside setState, never in build; a FutureBuilder with the hint,
  // loading, error (with Try again) and "No books found" states.
  // TODO(task 17): search as you type with a 400 ms debounce, 3 letters
  // or more, and drop late answers; cancel the timer in dispose.
  // TODO(task 20): pull to refresh and load more pages as the user scrolls.

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchPressed() {
    // TODO(task 7): search Open Library for _controller.text and show the results.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookShelf'),
        // TODO(task 10): an icon button that opens the reading list (/list).
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _onSearchPressed(),
                    decoration: const InputDecoration(
                      labelText: 'Search books',
                      hintText: 'Title or author',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _onSearchPressed,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          const Expanded(
            // TODO(task 7): a ListView.builder of ListTiles: title, first
            // author and year. TODO(task 9): tapping one opens /book/<workId>.
            // TODO(task 19): labels, large text and contrast.
            child: Center(child: Text('Search for a book to start')),
          ),
        ],
      ),
    );
  }
}
