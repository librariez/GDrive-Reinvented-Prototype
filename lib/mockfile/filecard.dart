import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import 'mock_file_item.dart';
import 'mock_docs_item.dart';
import 'mock_folder_item.dart';
import 'mock_image_item.dart';

class FileCard extends StatelessWidget {
  FileCard({
    super.key,
    required this.item,
    required this.isGridView,
    this.onMore,
  });

  final MockFileItem item;
  final bool isGridView;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case 'docs':
        return MockDocs(
          name: item.name,
          isGridView: isGridView,
          onMore: onMore,
        );
      case 'folder':
        return MockFolder(
          name: item.name,
          isGridView: isGridView,
          onMore: onMore,
        );
      case 'image':
        return MockImage(
          name: item.name,
          isGridView: isGridView,
          onMore: onMore,
        );
      default:
        return _MockFileShell(
          name: item.name,
          isGridView: isGridView,
          onMore: onMore,
        );
    }
  }
}

class _MockFileShell extends StatelessWidget {
  const _MockFileShell({
    required this.name,
    required this.isGridView,
    required this.onMore,
  });

  final String name;
  final bool isGridView;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;
    final theme = AppTheme.lightTheme;
    final icon = Icon(
      Icons.insert_drive_file,
      color: theme.colorScheme.onSurfaceVariant,
    );
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
            const Spacer(),
            Center(
              child: Image.asset('lib/assets/preview.png', fit: BoxFit.fill),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
