import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'pages/recent.dart';
import 'pages/files.dart';
import 'pages/home.dart';
import 'pages/shared.dart';
import 'pages/uploads.dart';
import 'mockfile/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AppState(), child: const GDrive()),
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
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final scheme = AppTheme.lightTheme.colorScheme;
    final isGrid = state.isGridView;
    

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
          Material(
            child: Ink(
              width: 55,
              height: 40,
              decoration: ShapeDecoration(
                color: !isGrid
                    ? scheme.tertiaryContainer
                    : scheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              child: IconButton(
                tooltip: 'List',
                icon: Icon(
                  color: !isGrid ? scheme.surface : scheme.onSurface,
                  Icons.list,
                  size: 25,
                ),
                onPressed: () {
                  state.setGridView(false);
                },
              ),
            ),
          ),
          Padding(padding: EdgeInsetsGeometry.all(2.5)),
          Material(
            child: Ink(
              width: 55,
              height: 40,
              decoration: ShapeDecoration(
                color: isGrid
                    ? scheme.tertiaryContainer
                    : scheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              child: IconButton(
                tooltip: 'Grid',
                icon: Icon(
                  color: isGrid ? scheme.surface : scheme.onSurface,
                  Icons.grid_view,
                  size: 25,
                ),
                onPressed: () {
                  state.setGridView(true);
                },
              ),
            ),
          ),
          IconButton(
            tooltip: 'Reset data',
            icon: const Icon(Icons.restart_alt),
            onPressed: state.resetDemo,
          ),
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
                      body: const RecentPage(),
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
                  MaterialPageRoute(builder: (context) => UploadPage()),
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
            label: 'Home',
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
      body: IndexedStack(
        index: state.currentTabIndex,
        children: const [
          HomePage(), // 0
          SharedPage(), // 1
          FilePage(), // 2
        ],
      ),
      
    );
  }
}
