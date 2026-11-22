import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

class MockFolder extends StatelessWidget {
  const MockFolder({super.key, this.name = 'Untitled Folder'});

  final String name;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;

    return ListTile(
      leading: Icon(Icons.folder, color: scheme.onSurfaceVariant),
      title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
