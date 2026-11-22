import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class MockImage extends StatelessWidget {
  const MockImage({
    super.key,
    this.name = 'Untitled Image',
    this.isGridView = false,
    this.onMore,
  });

  final String name;
  final bool isGridView;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.lightTheme.colorScheme;
    final theme = AppTheme.lightTheme;
    final icon = Icon(Icons.image, color: Color.fromARGB(255, 255, 75, 4));
    final more = IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: onMore,
    );

    if (!isGridView) {
      return ListTile(
        leading: icon,
        title: Text(
          name,
          style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
        ),
        trailing: more,
      );
    }

    return Card(
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                more,
              ],
            ),
            const Spacer(),
            Center(
              child: Image.asset('lib/assets/preview.png', fit: BoxFit.fill),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
