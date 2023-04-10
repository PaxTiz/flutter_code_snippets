import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../stores/current_snippet.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  void notImplemented(BuildContext context) {
    const snackbar = SnackBar(content: Text('Warning: Not yet implemented'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSnippet = ref.watch(currentSnippetProvider);

    return YaruWindowTitleBar(
      title: const Text('My app bar'),
      actions: currentSnippet == null
          ? []
          : [
              YaruIconButton(
                icon: const Icon(Icons.share),
                onPressed: () => notImplemented(context),
              ),
              YaruIconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => notImplemented(context),
              ),
              YaruIconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => notImplemented(context),
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size(0, kYaruTitleBarHeight);
}
