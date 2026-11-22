import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../widgets/shared_link_card.dart';
import '../widgets/cleanup_item_list.dart';
import '../widgets/item_actions_sheet.dart';
import '../mockfile/app_state.dart';

class SharedPage extends StatelessWidget {
  const SharedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<AppState>().sharedItems;
    return Column(
      children: [
        const SharedLinkCard(),
        Expanded(
          child: CleanupItemList(
            items: items,
            source: MenuSource.shared,
            emptyMessage: 'Nothing shared with you yet',
          ),
        ),
      ],
    );
  }
}
