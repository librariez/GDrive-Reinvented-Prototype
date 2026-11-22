import 'package:material_ui/material_ui.dart';
import 'mock_file_item.dart';

class FileCard extends StatelessWidget {
  const FileCard({
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
    final theme = Theme.of(context);
    final icon = Icon(
      item.type == 'folder'
          ? Icons.folder_outlined
          : Icons.insert_drive_file_outlined,
    );
    final more = IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: onMore,
    );

    if (isGridView) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [icon, more],
              ),
              const Spacer(),
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    return ListTile(
      leading: icon,
      title: Text(
        item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: more,
    );
  }
}
