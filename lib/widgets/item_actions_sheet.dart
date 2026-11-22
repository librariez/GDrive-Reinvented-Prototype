import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../standins/app_state.dart';
import '../standins/mock_file_item.dart';

enum MenuSource { shared, recents }

Future<void> showItemActionsSheet(
  BuildContext context,
  MockFileItem item,
  MenuSource source,
) {
  final messenger = ScaffoldMessenger.of(context);
  final state = context.read<AppState>();
  final theme = Theme.of(context);
  final isShared = source == MenuSource.shared;

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              item.type == 'folder'
                  ? Icons.folder_outlined
                  : Icons.insert_drive_file_outlined,
            ),
            title: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge,
            ),
            subtitle: Text(
              '${item.sizeMb} MB',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(
              isShared
                  ? Icons.visibility_off_outlined
                  : Icons.history_toggle_off,
            ),
            title: Text(
              isShared ? 'Remove from view' : 'Remove from recents',
              style: theme.textTheme.bodyMedium,
            ),
            onTap: () {
              Navigator.pop(sheetContext);
              if (isShared) {
                state.hideFromShared(item.id);
              } else {
                state.removeFromRecents(item.id);
              }
              messenger
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      isShared
                          ? 'Removed from view'
                          : 'Removed from recents',
                    ),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () => isShared
                          ? state.restoreToShared(item.id)
                          : state.restoreToRecents(item.id),
                    ),
                  ),
                );
            },
          ),
        ],
      ),
    ),
  );
}
