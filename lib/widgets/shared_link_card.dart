import 'package:material_ui/material_ui.dart';
import '../flows/shared_link_flow.dart';

class SharedLinkCard extends StatelessWidget {
  const SharedLinkCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const Icon(Icons.link),
        title: Text(
          'Simulate opening a shared link',
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: Text(
          'Capstone_Photos',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: FilledButton(
          onPressed: () => openSharedLink(context),
          child: const Text('Open'),
        ),
      ),
    );
  }
}
