import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../mockfile/app_state.dart';
import '../mockfile/filecard.dart';
import '../mockfile/mock_file_item.dart';
import 'item_actions_sheet.dart';
import '../theme/app_theme.dart';

class CleanupItemList extends StatelessWidget {
  const CleanupItemList({
    super.key,
    required this.items,
    this.source,
    required this.emptyMessage,
    this.crossAxisCount = 2,
  });

  final List<MockFileItem> items;
  final MenuSource? source;
  final String emptyMessage;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;
    final textTheme = AppTheme.lightTheme.textTheme;
    final isGrid = context.watch<AppState>().isGridView;
    

    if (items.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
      );
    }

    Widget cardFor(MockFileItem item) => FileCard(
      item: item,
      isGridView: isGrid,
      onMore: source == null
          ? null
          : () => showItemActionsSheet(context, item, source!),
    );

    if (isGrid) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (_, index) => cardFor(items[index]),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemBuilder: (_, index) => cardFor(items[index]),
    );
  }
}
