import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({super.key});

  @override
  State<SharedPage> createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('SHARED PAGE'));
  } 
}