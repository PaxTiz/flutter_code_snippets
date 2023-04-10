import 'package:flutter/material.dart';
import 'package:search_engine/components/custom_app_bar.dart';
import 'package:search_engine/components/sidebar.dart';
import 'package:search_engine/models/snippet.dart';
import 'package:search_engine/views/snippet_view.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await YaruWindowTitleBar.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) {
        return MaterialApp(
          darkTheme: yaru.darkTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  Snippet? _currentSnippet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(snippet: _currentSnippet),
      body: Row(
        children: [
          Sidebar(
            snippet: _currentSnippet,
            onChange: (snippet) => setState(() => _currentSnippet = snippet),
          ),
          const VerticalDivider(width: 2),
          _currentSnippet == null
              ? const Expanded(
                  child: Center(
                    child: Text(
                        'Please select a snippet to view the code and examples'),
                  ),
                )
              : SnippetView(snippet: _currentSnippet!),
        ],
      ),
    );
  }
}
