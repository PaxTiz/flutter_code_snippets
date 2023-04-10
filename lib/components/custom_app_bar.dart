import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../stores/current_snippet.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

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
                onPressed: () {},
              ),
              YaruIconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              YaruIconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size(0, kYaruTitleBarHeight);
}
