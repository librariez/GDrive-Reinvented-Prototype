import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../pages/link_preview_page.dart';
import '../mockfile/app_state.dart';

const kSampleLinkItemId = 'link-folder-1';
const kSharedTabIndex = 1;

Future<void> openSharedLink(
  BuildContext context, {
  String itemId = kSampleLinkItemId,
}) async {
  final state = context.read<AppState>();
  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);

  state.simulateOpenSharedLink(itemId);
  await navigator.push(
    MaterialPageRoute(builder: (_) => LinkPreviewPage(itemId: itemId)),
  );

  state.setTab(kSharedTabIndex);
  messenger
    ..clearSnackBars()
    ..showSnackBar(const SnackBar(content: Text('Added to Shared')));
}
