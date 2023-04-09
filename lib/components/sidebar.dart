import 'package:flutter/material.dart';
import 'package:search_engine/models/snippet.dart';
import 'package:yaru_widgets/widgets.dart';

class Sidebar extends StatefulWidget {
  final Snippet? snippet;
  final ValueSetter<Snippet?> onChange;

  const Sidebar({
    super.key,
    required this.snippet,
    required this.onChange,
  });

  @override
  createState() => _Sidebar();
}

class _Sidebar extends State<Sidebar> {
  String _search = '';
  Language? _language;

  Iterable<Snippet> get snippets => kSnippets.where((e) {
        final filter = e.name.toLowerCase().contains(_search.toLowerCase());
        return _language == null ? filter : filter && e.language == _language;
      });

  bool isSelected(Snippet snippet) {
    return widget.snippet != null &&
        widget.snippet?.name == snippet.name &&
        widget.snippet?.language == snippet.language;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 328),
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
                    child: Text(_language?.view() ?? "All"),
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
          if (snippets.isEmpty)
            const ListTile(dense: true, title: Text('No results found')),
          if (snippets.isNotEmpty)
            ...snippets
                .map(
                  (e) => ListTile(
                    dense: true,
                    enabled: true,
                    onTap: () => widget.onChange(e),
                    title: Text(e.name),
                    selected: isSelected(e),
                    trailing: Badge(label: Text(e.language.view())),
                  ),
                )
                .toList(),
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onChange(null),
            ),
          )
        ],
      ),
    );
  }
}
