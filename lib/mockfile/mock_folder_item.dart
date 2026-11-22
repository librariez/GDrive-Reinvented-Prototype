import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class MockFolder extends StatelessWidget {
  const MockFolder({
    super.key,
    this.name = 'Untitled Folder',
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
    final icon = Icon(Icons.folder, color: scheme.onSurfaceVariant);
    final more = IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: onMore,
    );

    if (!isGridView) {
      return ListTile(
        leading: icon,
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium,
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
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                more,
              ],
            ),
            Expanded(
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  child: Icon(Icons.folder, color: scheme.onSurfaceVariant),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
