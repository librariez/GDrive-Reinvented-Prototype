import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class MockDocs extends StatelessWidget {
  const MockDocs({
    super.key,
    this.name = 'Untitled Docs',
    this.isGridView = false,
    this.onMore,
  });

  final String name;
  final bool isGridView;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;
    final theme = AppTheme.lightTheme;
    final icon = Image.asset('lib/assets/docs.png', width: 24, height: 24);
    final more = IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: onMore,
    );

    if (!isGridView) {
      return ListTile(
        leading: icon,
        title: Text(
          name,
          style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
        ),
        trailing: more,
      );
    }

    return Card(
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                more,
              ],
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'lib/assets/preview.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
