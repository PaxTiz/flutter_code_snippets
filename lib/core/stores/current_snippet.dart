import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/snippet.dart';

final currentSnippetProvider = StateProvider<Snippet?>((ref) => null);
