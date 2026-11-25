import 'package:material_ui/material_ui.dart';

/// ShopList's home screen: the lists you are a member of.
///
/// The layout is done. The data, sign-in and sharing are yours.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopList'),
        actions: const [
          IconButton(
            // TODO(task 8): sign out with FirebaseAuth.instance.signOut().
            onPressed: null,
            tooltip: 'Sign out',
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      // TODO(task 7): show Firebase.app().options.projectId while you connect.
      // TODO(task 9): a StreamBuilder of myLists(email), sorted by name, each
      // with a Share button; this text is the empty state.
      body: const Center(child: Text('No lists yet')),
      floatingActionButton: const FloatingActionButton.extended(
        // TODO(task 9): ask for a name and createList.
        onPressed: null,
        icon: Icon(Icons.add),
        label: Text('New list'),
      ),
    );
  }
}
