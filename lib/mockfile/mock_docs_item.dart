import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

class MockDocs extends StatelessWidget {
  const MockDocs({super.key, this.name = 'Untitled Docs'});

  final String name;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;

    return ListTile(
      leading: Image.asset('lib/assets/docs.png', width: 24, height: 24),
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
