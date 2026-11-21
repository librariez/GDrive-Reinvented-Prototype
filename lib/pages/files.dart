import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('FILE PAGE'));
  } 
}