import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';
import 'mock_docs_item.dart';
import 'mock_image_item.dart';
import 'mock_folder_item.dart';
import 'mock_file_item.dart';

class FileCard extends StatelessWidget {
  const FileCard({
    super.key,
    required this.item,
    this.isGridView = false,
    this.onMore,
  });

  final MockFileItem item;
  final bool isGridView;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;
    Widget preview;

    switch (item.type) {
      case 'docs':
      case 'doc':
        preview = MockDocs(name: item.name);
        break;
      case 'image':
        preview = MockImage(name: item.name);
        break;
      case 'folder':
        preview = MockFolder(name: item.name);
        break;
      default:
        preview = ListTile(
          leading: Icon(Icons.insert_drive_file, color: scheme.secondary,),
          title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        );
    }

    final moreButton = IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: onMore,
    );

    if (isGridView) {
      return Card(
        child: Stack(
          children: [
            preview,
            Positioned(top: 0, right: 0, child: moreButton),
          ],
        ),
      );
    }

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        preview,
        Positioned(right: 0, child: moreButton),
      ],
    );
  }
}
