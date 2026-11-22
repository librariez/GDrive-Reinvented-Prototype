import 'package:flutter/foundation.dart';

import 'mock_file_item.dart';

class AppState extends ChangeNotifier {
  AppState() {
    files = _seed();
  }

  late List<MockFileItem> files;
  bool isGridView = false;
  int currentTabIndex = 0;
  bool showHiddenShared = false;

  static List<MockFileItem> _seed() => [
    MockFileItem(
      id: '1',
      name: 'GROUP 5_BSCS_Final_Report_v3.docx',
      type: 'docs',
      sizeMb: 4,
      isShared: true,
      isRecent: true,
    ),
    MockFileItem(
      id: '2',
      name: 'Screenshot_213208.jpg',
      type: 'image',
      sizeMb: 2,
      isShared: true,
      isRecent: true,
    ),
    MockFileItem(
      id: '3',
      name: 'Project_Video_Final.mp4',
      type: 'file',
      sizeMb: 80,
      isRecent: true,
    ),
    MockFileItem(
      id: '4',
      name: 'Lecture_Notes.pdf',
      type: 'file',
      sizeMb: 6,
      isShared: true,
    ),
    MockFileItem(
      id: '5',
      name: 'Thesis_Draft_Chapter_1.docx',
      type: 'docs',
      sizeMb: 3,
      isShared: true,
      isRecent: true,
    ),
    MockFileItem(
      id: 'link-folder-1',
      name: 'Capstone_Photos',
      type: 'folder',
      sizeMb: 0,
    ),
  ];

  void setTab(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  void toggleGrid() {
    isGridView = !isGridView;
    notifyListeners();
  }

  void resetDemo() {
    files = _seed();
    showHiddenShared = false;
    notifyListeners();
  }

  List<MockFileItem> get sharedItems => files
      .where((item) => item.isShared && (showHiddenShared || !item.isHidden))
      .toList();

  List<MockFileItem> get recentItems =>
      files.where((item) => item.isRecent).toList();

  MockFileItem? _find(String id) {
    final index = files.indexWhere((item) => item.id == id);
    return index == -1 ? null : files[index];
  }

  void addSharedFile({required String name, required String type}) {
    files.add(
      MockFileItem(
        id: 'shared-${DateTime.now().microsecondsSinceEpoch}',
        name: name,
        type: type,
        sizeMb: 1,
        isShared: true,
        isRecent: true,
      ),
    );
    notifyListeners();
  }

  void hideFromShared(String id) {
    final item = _find(id);
    if (item == null) return;
    item.isHidden = true;
    notifyListeners();
  }

  void restoreToShared(String id) {
    final item = _find(id);
    if (item == null) return;
    item.isHidden = false;
    notifyListeners();
  }

  void removeFromRecents(String id) {
    final item = _find(id);
    if (item == null) return;
    item.isRecent = false;
    notifyListeners();
  }

  void restoreToRecents(String id) {
    final item = _find(id);
    if (item == null) return;
    item.isRecent = true;
    notifyListeners();
  }

  void setShowHiddenShared(bool value) {
    showHiddenShared = value;
    notifyListeners();
  }

  void simulateOpenSharedLink(String id) {
    final item = _find(id);
    if (item == null) return;
    item.isShared = true;
    item.isHidden = false;
    item.openedViaLink = true;
    item.isRecent = true;
    notifyListeners();
  }
}
