import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../standins/app_state.dart';
import '../widgets/cleanup_item_list.dart';
import '../widgets/item_actions_sheet.dart';

class RecentsPage extends StatelessWidget {
  const RecentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<AppState>().recentItems;
    return CleanupItemList(
      items: items,
      source: MenuSource.recents,
      emptyMessage: 'No recent files',
    );
  }
}
