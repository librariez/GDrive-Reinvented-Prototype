import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../mockfile/app_state.dart';
import '../widgets/cleanup_item_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final items = state.files.take(10).toList();

    return CleanupItemList(
      items: items,
      emptyMessage: 'No files',
      crossAxisCount: 1,
    );
  }
}
