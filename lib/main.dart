import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'pages/recents_page.dart';
import 'pages/shared_page.dart';
import 'pages/uploads.dart';
import 'standins/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const GDrive(),
    ),
  );
}

class GDrive extends StatelessWidget {
  const GDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gdrive Reinvented',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Grid / List',
            icon: Icon(state.isGridView ? Icons.list : Icons.grid_view),
            onPressed: state.toggleGrid,
          ),
          IconButton(
            tooltip: 'Reset data',
            icon: const Icon(Icons.restart_alt),
            onPressed: state.resetDemo,
          ),
        ],
      ),
      body: IndexedStack(
        index: state.currentTabIndex,
        children: const [
          Center(child: Text('HOME PAGE')), // 0
          SharedPage(), // 1
          Center(child: Text('Files (Ara)')), // 2
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'G',
                    style: TextStyle(
                      color: Color(0xFF4285F4),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    'o',
                    style: TextStyle(
                      color: Color(0xFFEA4335),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    'o',
                    style: TextStyle(
                      color: Color(0xFFFBBC05),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    'g',
                    style: TextStyle(
                      color: Color(0xFF4285F4),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    'l',
                    style: TextStyle(
                      color: Color(0xFF34A853),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    'e',
                    style: TextStyle(
                      color: Color(0xFFEA4335),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(' Drive'),
                ],
              ),
            ),
            Divider(color: Color(0xFF18171C)),
            ListTile(
              leading: Icon(Icons.schedule),
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
            ListTile(
              leading: Icon(Icons.upload),
              title: const Text('Uploads'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>UploadPage())
                  );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.currentTabIndex < 3 ? state.currentTabIndex : 0,
        onDestinationSelected: state.setTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined), 
            selectedIcon: Icon(Icons.home),
            label: 'Home'
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline_rounded),
            selectedIcon: Icon(Icons.people_rounded),
            label: 'Shared',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'File',
          ),
        ],
      ),
    );
  }
}






