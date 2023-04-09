enum Language {
  typescript,
  javascript,
  dart,
  php,
}

extension LanguageString on Language {
  String view() {
    switch (this) {
      case Language.javascript:
        return 'JS';
      case Language.typescript:
        return 'TS';
      case Language.dart:
        return name;
      case Language.php:
        return name;
    }
  }
}

class Snippet {
  final String name;

  final String description;

  final String code;

  final Language language;

  final List<String> examples;

  const Snippet({
    required this.name,
    required this.description,
    required this.language,
    required this.code,
    required this.examples,
  });
}

final kSnippets = [
  const Snippet(
    name: 'Read a file',
    description: 'How to read a file in Javascript',
    language: Language.javascript,
    code:
        'import { readFile } from \'fs/promises\'\nimport { join } from \'path\'\n\nconst file = readFile(join(\'example\', \'package.json\'), \'utf-8\')',
    examples: [],
  ),
  const Snippet(
    name: 'Read a file',
    description: 'How to read a file in PHP',
    language: Language.php,
    code: '<?php\n\n\$file = file_get_contents(\'https://google.fr\')',
    examples: [],
  ),
];
