import 'package:http/http.dart' as http;

import 'package:bookshelf/models/book.dart';

/// Talks to the Open Library API. Screens never call `http` themselves.
///
/// The [client] is passed in so that tests can give it a fake
/// (`MockClient` from `package:http/testing.dart`).
class BookRepository {
  BookRepository({http.Client? client}) : _client = client ?? http.Client();

  // ignore: unused_field
  final http.Client _client;

  /// Searches Open Library and returns up to 20 books.
  ///
  /// TODO(task 7): build the URL with Uri.https('openlibrary.org',
  /// '/search.json', {...}) with `q`, `fields` and `limit: '20'`; send the
  /// `User-Agent` header from the kit's data/books/README.md; throw an
  /// Exception when the status is not 200; parse `docs` into books.
  /// TODO(task 8): a 10-second timeout, and BookShelfException messages for
  /// no internet, too slow, 429 and 500.
  /// TODO(task 16): network first, then the SearchCache; return a SearchResult.
  /// TODO(task 20): a `page` parameter.
  Future<List<Book>> search(String query) {
    throw UnimplementedError('TODO(task 7): search');
  }

  // TODO(task 9): Future<WorkDetail> work(String workId) for /works/<id>.json.
}
