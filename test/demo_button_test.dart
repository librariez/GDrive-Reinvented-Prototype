import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:gdrive_reinvent/mockfile/app_state.dart';
import 'package:gdrive_reinvent/pages/link_preview_page.dart';
import 'package:gdrive_reinvent/widgets/demo_button.dart';

Widget _demoButtonApp(AppState state, {double height = 500}) {
  return ChangeNotifierProvider<AppState>.value(
    value: state,
    child: MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 360,
            height: height,
            child: DemoButton(),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('shared-link control opens the shared-link preview', (
    tester,
  ) async {
    final state = AppState();
    await tester.pumpWidget(_demoButtonApp(state));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Simulate opening a shared link'));
    await tester.tap(find.text('Simulate opening a shared link'));
    await tester.pumpAndSettle();

    expect(find.byType(LinkPreviewPage), findsOneWidget);
    expect(state.files.firstWhere((item) => item.id == 'link-folder-1').openedViaLink, isTrue);
  });

  testWidgets('demo controls can scroll when their panel is short', (
    tester,
  ) async {
    await tester.pumpWidget(_demoButtonApp(AppState(), height: 180));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final scrollView = find.byType(SingleChildScrollView);
    expect(scrollView, findsOneWidget);
    final scrollable = find.descendant(
      of: scrollView,
      matching: find.byType(Scrollable),
    );
    expect(
      tester.state<ScrollableState>(scrollable).position.maxScrollExtent,
      greaterThan(0),
    );
  });

  testWidgets('Reset Data resets demo state', (tester) async {
    final state = AppState()
      ..setWifiConnected(false)
      ..setStorageNearFull()
      ..setTab(2)
      ..setGridView(true);

    await tester.pumpWidget(_demoButtonApp(state));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Reset Data'));
    await tester.tap(find.text('Reset Data'));
    await tester.pumpAndSettle();

    expect(state.isWifiConnected, isTrue);
    expect(state.usedStorageMb, 95);
    expect(state.currentTabIndex, 0);
    expect(state.isGridView, isFalse);
  });
}
