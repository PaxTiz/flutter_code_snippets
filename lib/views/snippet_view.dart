import 'package:any_syntax_highlighter/any_syntax_highlighter.dart';
import 'package:any_syntax_highlighter/themes/any_syntax_highlighter_theme_collection.dart';
import 'package:flutter/material.dart';
import 'package:search_engine/models/snippet.dart';

class SnippetView extends StatelessWidget {
  final Snippet snippet;

  const SnippetView({
    super.key,
    required this.snippet,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    '\n${snippet.code}',
                    fontSize: 12,
                    softWrap: true,
                    lineNumbers: true,
                    hasCopyButton: true,
                    isSelectableText: true,
                    theme: AnySyntaxHighlighterThemeCollection.githubWebTheme(),
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
