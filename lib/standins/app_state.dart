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
          sizeMb: 4,
          isShared: true,
          isRecent: true,
        ),
        MockFileItem(
          id: '2',
          name: 'Screenshot_213208.jpg',
          sizeMb: 2,
          isShared: true,
          isRecent: true,
        ),
        MockFileItem(
          id: '3',
          name: 'Project_Video_Final.mp4',
          sizeMb: 80,
          isRecent: true,
        ),
        MockFileItem(
          id: '4',
          name: 'Lecture_Notes.pdf',
          sizeMb: 6,
          isShared: true,
        ),
        MockFileItem(
          id: '5',
          name: 'Thesis_Draft_Chapter_1.docx',
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
      .where((f) => f.isShared && (showHiddenShared || !f.isHidden))
      .toList();

  List<MockFileItem> get recentItems =>
      files.where((f) => f.isRecent).toList();

  MockFileItem? _find(String id) {
    final i = files.indexWhere((f) => f.id == id);
    return i == -1 ? null : files[i];
  }

  void hideFromShared(String id) {
    final f = _find(id);
    if (f == null) return;
    f.isHidden = true;
    notifyListeners();
  }

  void restoreToShared(String id) {
    final f = _find(id);
    if (f == null) return;
    f.isHidden = false;
    notifyListeners();
  }

  void removeFromRecents(String id) {
    final f = _find(id);
    if (f == null) return;
    f.isRecent = false;
    notifyListeners();
  }

  void restoreToRecents(String id) {
    final f = _find(id);
    if (f == null) return;
    f.isRecent = true;
    notifyListeners();
  }

  void setShowHiddenShared(bool value) {
    showHiddenShared = value;
    notifyListeners();
  }

  void simulateOpenSharedLink(String id) {
    final f = _find(id);
    if (f == null) return;
    f.isShared = true;
    f.isHidden = false;
    f.openedViaLink = true;
    f.isRecent = true;
    notifyListeners();
  }
}
