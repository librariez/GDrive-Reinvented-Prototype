import 'package:material_ui/material_ui.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GDrive());
}

class GDrive extends StatelessWidget {
  const GDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gdrive Reinvented',
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

class SharedPage extends StatefulWidget {
  const SharedPage({super.key});

  @override
  State<SharedPage> createState() => _SharedPageState();
}

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: IndexedStack(
        index: pageIndex,
        children: const [
          Center(child: Text('HOME PAGE')), //0
          SharedPage(),//1
          FilePage(), //2
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
                  MaterialPageRoute(builder: (context)=>RecentPage())
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
        selectedIndex: pageIndex < 3 ? pageIndex : 0,
        onDestinationSelected: (int index) {
          _onItemTapped(index);
        },
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

class _SharedPageState extends State<SharedPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('SHARED PAGE'));
  } 
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('FILE PAGE'));
  } 
}

class _RecentPageState extends State<RecentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
       
      body: Center
      (child: Text('RECENT PAGE'),),
    );
  } 
}
class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
       
      body: Center
      (child: Text('UPLOAD PAGE'),),
    );

  } 
}