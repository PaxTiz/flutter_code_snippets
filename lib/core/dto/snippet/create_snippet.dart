import '../../../models/snippet.dart';

class CreateSnippetDTO {
  final String name;
  final String code;
  final Language language;

  const CreateSnippetDTO({
    required this.name,
    required this.code,
    required this.language,
  });
}
