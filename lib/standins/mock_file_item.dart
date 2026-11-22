class MockFileItem {
  MockFileItem({
    required this.id,
    required this.name,
    this.type = 'file',
    this.sizeMb = 1,
    this.isShared = false,
    this.isRecent = false,
    this.isHidden = false,
    this.openedViaLink = false,
  });

  final String id;
  final String name;
  final String type;
  final int sizeMb;

  bool isShared;
  bool isRecent;
  bool isHidden;
  bool openedViaLink;
}
