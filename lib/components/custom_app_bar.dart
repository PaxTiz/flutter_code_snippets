import 'package:flutter/material.dart';
import 'package:search_engine/models/snippet.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Snippet? snippet;

  const CustomAppBar({
    super.key,
    required this.snippet,
  });

  @override
  Widget build(BuildContext context) {
    return YaruWindowTitleBar(
      title: const Text('My app bar'),
      actions: snippet == null
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
