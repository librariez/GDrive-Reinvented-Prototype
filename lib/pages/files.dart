import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../mockfile/app_state.dart';
import '../widgets/cleanup_item_list.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final items = state.files
        .where((item) => !item.isShared || item.isShared)
        .toList()
      ..sort((a, b) {
        final aIsFolder = a.type == 'folder';
        final bIsFolder = b.type == 'folder';

        if (aIsFolder && !bIsFolder) return -1;
        if (!aIsFolder && bIsFolder) return 1;

        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

    return CleanupItemList(
      items: items,
      emptyMessage: 'No files',
      crossAxisCount: 2,
    );
  }
}
