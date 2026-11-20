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

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}