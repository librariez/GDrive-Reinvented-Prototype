import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../standins/app_state.dart';
import '../standins/file_card.dart';
import '../standins/mock_file_item.dart';
import 'item_actions_sheet.dart';

class CleanupItemList extends StatelessWidget {
  const CleanupItemList({
    super.key,
    required this.items,
    required this.source,
    required this.emptyMessage,
  });

  final List<MockFileItem> items;
  final MenuSource source;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isGrid = context.watch<AppState>().isGridView;

    if (items.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    Widget cardFor(MockFileItem item) => FileCard(
          item: item,
          isGridView: isGrid,
          onMore: () => showItemActionsSheet(context, item, source),
        );

    if (isGrid) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => cardFor(items[i]),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemBuilder: (_, i) => cardFor(items[i]),
    );
  }
}
