import 'package:any_syntax_highlighter/any_syntax_highlighter.dart';
import 'package:any_syntax_highlighter/themes/any_syntax_highlighter_theme_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/current_snippet.dart';

class SnippetView extends ConsumerWidget {
  const SnippetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSnippet = ref.watch(currentSnippetProvider);

    return currentSnippet == null
        ? const Expanded(
            child: Center(
              child:
                  Text('Please select a snippet to view the code and examples'),
            ),
          )
        : Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Code'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Example'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AnySyntaxHighlighter(
                          '\n${currentSnippet.code}',
                          fontSize: 12,
                          softWrap: true,
                          lineNumbers: true,
                          hasCopyButton: true,
                          isSelectableText: true,
                          theme: AnySyntaxHighlighterThemeCollection
                              .githubWebTheme(),
                          useGoogleFont: 'JetBrains Mono',
                        ),
                        const Center(
                          child: Text('Tab #2'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
