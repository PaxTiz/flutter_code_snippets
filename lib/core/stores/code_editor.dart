import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodeEditorConfiguration {
  CodeEditorConfiguration(this.fontSize);

  double fontSize;
}

class CodeEditorNotifier extends StateNotifier<CodeEditorConfiguration> {
  CodeEditorNotifier() : super(CodeEditorConfiguration(12));

  void increment() {
    state = CodeEditorConfiguration(state.fontSize + 1);
  }

  void decrement() {
    state = CodeEditorConfiguration(state.fontSize - 1);
  }
}

final codeEditorProvider =
    StateNotifierProvider<CodeEditorNotifier, CodeEditorConfiguration>(
        (ref) => CodeEditorNotifier());
