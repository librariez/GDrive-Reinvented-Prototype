import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'pages/recents_page.dart';
import 'pages/shared_page.dart';
import 'standins/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const RonilDemoApp(),
    ),
  );
}

class RonilDemoApp extends StatelessWidget {
  const RonilDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const _DemoShell(),
    );
  }
}

class _DemoShell extends StatelessWidget {
  const _DemoShell();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ronil demo'),
        actions: [
          IconButton(
            tooltip: 'Grid / List',
            icon: Icon(state.isGridView ? Icons.list : Icons.grid_view),
            onPressed: state.toggleGrid,
          ),
          IconButton(
            tooltip: 'Reset demo',
            icon: const Icon(Icons.restart_alt),
            onPressed: state.resetDemo,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Recent'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: const Text('Recent')),
                      body: const RecentsPage(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: state.currentTabIndex,
        children: const [
          Center(child: Text('Home (Ara)')),
          SharedPage(),
          Center(child: Text('Files (Ara)')),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.currentTabIndex,
        onDestinationSelected: state.setTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            label: 'Shared',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            label: 'Files',
          ),
        ],
      ),
    );
  }
}
