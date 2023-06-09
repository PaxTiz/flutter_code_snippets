import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru_widgets/widgets.dart';

import '../../constants.dart';
import '../../core/models/snippet.dart';
import '../../core/stores/current_snippet.dart';
import 'modals/snippets/create_snippet_modal.dart';

class Sidebar extends ConsumerStatefulWidget {
  final double? width;

  const Sidebar({super.key, required this.width});

  @override
  createState() => _Sidebar();
}

class _Sidebar extends ConsumerState<Sidebar> {
  String _search = '';
  Language? _language;

  Iterable<Snippet> get _snippets => kSnippets.where((e) {
        final filter = e.name.toLowerCase().contains(_search.toLowerCase());
        return _language == null ? filter : filter && e.language == _language;
      });

  bool _isSelected(Snippet? currentSnippet, Snippet snippet) {
    return currentSnippet != null &&
        currentSnippet.name == snippet.name &&
        currentSnippet.language == snippet.language;
  }

  void _onSnippetSelected(Snippet? snippet) {
    ref.read(currentSnippetProvider.notifier).state = snippet;
  }

  void _showNewSnippetModal() {
    showDialog(
      context: context,
      builder: (_) => const CreateSnippetModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSnippet = ref.watch(currentSnippetProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: kSidebarMaxWidth,
      ),
      child: SizedBox(
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      onChanged: (value) => setState(() => _search = value),
                      decoration: const InputDecoration(hintText: 'Search..'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: YaruPopupMenuButton(
                      initialValue: null,
                      child: Text(_language?.view() ?? 'All'),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: null,
                          height: 32,
                          child: const Text('All'),
                          onTap: () => setState(() => _language = null),
                        ),
                        ...Language.values
                            .map(
                              (e) => PopupMenuItem<Language>(
                                value: e,
                                height: 32,
                                child: Text(e.view()),
                                onTap: () => setState(() => _language = e),
                              ),
                            )
                            .toList()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_snippets.isEmpty)
              const ListTile(dense: true, title: Text('No results found')),
            if (_snippets.isNotEmpty)
              ..._snippets
                  .map(
                    (e) => ListTile(
                      dense: true,
                      enabled: true,
                      onTap: () => _onSnippetSelected(e),
                      title: Text(e.name),
                      selected: _isSelected(currentSnippet, e),
                      trailing: Badge(label: Text(e.language.view())),
                    ),
                  )
                  .toList(),
            Expanded(
              child: GestureDetector(
                onTap: () => _onSnippetSelected(null),
              ),
            ),
            Container(
              width: kSidebarMaxWidth,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: _showNewSnippetModal,
                icon: const Icon(Icons.add),
                label: const Text('New'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
