import '../dto/snippet/create_snippet.dart';

class SnippetService {
  static Future<void> create(CreateSnippetDTO dto) async {
    await Future.delayed(const Duration(seconds: 1));
    throw UnimplementedError();
  }
}
