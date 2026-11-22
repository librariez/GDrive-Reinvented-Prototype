import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../flows/shared_link_flow.dart';
import '../mockfile/app_state.dart';

class DemoButton extends StatefulWidget {
  const DemoButton({super.key, this.onExpandedChanged});

  final ValueChanged<bool>? onExpandedChanged;

  @override
  State<DemoButton> createState() => _DemoButtonState();
}

class _DemoButtonState extends State<DemoButton> {
  bool _isMinimized = true;
  final ScrollController _controlsScrollController = ScrollController();

  @override
  void dispose() {
    _controlsScrollController.dispose();
    super.dispose();
  }

  Future<void> _openCreateFileDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final mbController = TextEditingController();
    final scrollController = ScrollController();
    String selectedType = 'docs';
    bool isShared = false;

    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: const Text('Create Mock File'),
                content: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: 'File Name',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: mbController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'MB file',
                            suffixText: 'MB',
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: selectedType,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'File Type',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'docs',
                              child: Text('Docs (docs)'),
                            ),
                            DropdownMenuItem(
                              value: 'folder',
                              child: Text('Folder (folder)'),
                            ),
                            DropdownMenuItem(
                              value: 'image',
                              child: Text('Image (image)'),
                            ),
                            DropdownMenuItem(
                              value: 'file',
                              child: Text('File (file)'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() {
                                selectedType = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Shared'),
                          value: isShared,
                          onChanged: (value) {
                            setDialogState(() {
                              isShared = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final mbText = mbController.text.trim();
                      if (name.isEmpty || mbText.isEmpty) return;

                      final parsedMb = double.tryParse(mbText);
                      if (parsedMb == null || parsedMb < 0) return;

                      context.read<AppState>().addFile(
                        name: name,
                        type: selectedType,
                        isShared: isShared,
                        sizeMb: parsedMb.round(),
                      );
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      );
    } finally {
      scrollController.dispose();
      nameController.dispose();
      mbController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isMinimized) {
      return FloatingActionButton.small(
        onPressed: () {
          setState(() {
            _isMinimized = false;
          });
          widget.onExpandedChanged?.call(true);
        },
        child: const Icon(Icons.tune),
      );
    }

    final appState = context.watch<AppState>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Demo Controls',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  tooltip: 'Minimize',
                  icon: const Icon(Icons.expand_circle_down),
                  onPressed: () {
                    setState(() {
                      _isMinimized = true;
                    });
                    widget.onExpandedChanged?.call(false);
                  },
                ),
              ],
            ),
            Expanded(
              child: Scrollbar(
                controller: _controlsScrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _controlsScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton.icon(
                        onPressed: () => _openCreateFileDialog(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Mock File'),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            context.read<AppState>().setStorageNearFull(),
                        icon: const Icon(Icons.storage),
                        label: const Text('Set storage to almost full'),
                      ),
                      TextButton.icon(
                        onPressed: () => context
                            .read<AppState>()
                            .setWifiConnected(!appState.isWifiConnected),
                        icon: Icon(
                          appState.isWifiConnected ? Icons.wifi : Icons.wifi_off,
                        ),
                        label: Text(
                          appState.isWifiConnected
                              ? 'Wi-Fi: On'
                              : 'Wi-Fi: Off',
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context.read<AppState>().resetDemo();
                          setState(() {
                            _isMinimized = true;
                          });
                          widget.onExpandedChanged?.call(false);
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset Data'),
                      ),
                      TextButton.icon(
                        onPressed: () => openSharedLink(context),
                        icon: const Icon(Icons.link),
                        label: const Text('Simulate opening a shared link'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}