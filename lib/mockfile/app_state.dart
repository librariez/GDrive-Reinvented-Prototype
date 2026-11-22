import 'dart:async';

import 'package:flutter/foundation.dart';

import 'mock_file_item.dart';

class AppState extends ChangeNotifier {
  late List<MockFileItem> files;
  bool isGridView = false;
  int maxStorageMb = 15000;
  int usedStorageMb = 0;
  bool isWifiConnected = true;
  Timer? _activeTimer;
  int currentTabIndex = 0;
  bool showHiddenShared = false;

  AppState() {
    files = _seed();
    usedStorageMb = files.fold<int>(0, (sum, item) => sum + item.sizeMb);
  }

  void addFile({
    required String name,
    required String type,
    required int sizeMb,
    required bool isShared,
  }) {
    final newItem = MockFileItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      type: type,
      sizeMb: sizeMb,
      isShared: isShared,
      isRecent: true,
    );

    files.insert(0, newItem);
    usedStorageMb = (usedStorageMb + sizeMb).clamp(0, maxStorageMb);
    notifyListeners();
  }

  void setGridView(bool value) {
    isGridView = value;
    notifyListeners();
  }

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
      isShared: true,
    ),
    MockFileItem(
      id: 'link-folder-2',
      name: 'Z_Photos',
      type: 'folder',
      sizeMb: 0,
      isShared: true,
    ),
  ];

  void setTab(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  void resetDemo() {
    _activeTimer?.cancel();
    _activeTimer = null;

    files = _seed();
    usedStorageMb = files.fold<int>(0, (sum, item) => sum + item.sizeMb);
    isWifiConnected = true;
    showHiddenShared = false;
    currentTabIndex = 0;
    isGridView = false;
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

  void addSharedFile({
    required String name,
    required String type,
    required int sizeMb,
  }) {
    files.add(
      MockFileItem(
        id: 'shared-${DateTime.now().microsecondsSinceEpoch}',
        name: name,
        type: type,
        sizeMb: sizeMb,
        isShared: true,
        isRecent: true,
      ),
    );
    usedStorageMb = (usedStorageMb + sizeMb).clamp(0, maxStorageMb);
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
  //not yet connected
  void deleteFile(String id) {
    final index = files.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final removed = files.removeAt(index);
    usedStorageMb = (usedStorageMb - removed.sizeMb).clamp(0, maxStorageMb);
    notifyListeners();
  }

  void setStorageNearFull() {
    usedStorageMb = 14900;
    notifyListeners();
  }

  void setWifiConnected(bool value) {
    isWifiConnected = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _activeTimer?.cancel();
    super.dispose();
  }
}