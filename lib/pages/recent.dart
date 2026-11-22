import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../mockfile/app_state.dart';
import '../widgets/cleanup_item_list.dart';
import '../widgets/item_actions_sheet.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPage();
}

class _RecentPage extends State<RecentPage> {
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
