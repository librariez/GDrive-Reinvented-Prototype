import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class MockImage extends StatelessWidget {
  const MockImage({super.key, this.name = 'Untitled Image'});

  final String name;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;

    return ListTile(
      leading: Icon(Icons.image, color: Color.fromARGB(255, 255, 94, 0)),
      title: Text(
        name,
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
      ),
    );
  }
}
