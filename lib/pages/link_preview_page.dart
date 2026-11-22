import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../mockfile/app_state.dart';

class LinkPreviewPage extends StatelessWidget {
  const LinkPreviewPage({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;
    final textTheme = AppTheme.lightTheme.textTheme;
    final item =
        context.watch<AppState>().files.firstWhere((f) => f.id == itemId);
    final isFolder = item.type == 'folder';

    return Scaffold(
      appBar: AppBar(title: Text(item.name, overflow: TextOverflow.ellipsis)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isFolder ? Icons.folder_outlined : Icons.image_outlined,
                size: 96,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Chip(
                avatar: const Icon(Icons.link, size: 18),
                label: Text(
                  'Opened via link',
                  style: textTheme.bodySmall,
                ),
                backgroundColor: scheme.secondaryContainer,
                side: BorderSide.none,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to app'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
