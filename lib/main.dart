import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/widgets.dart';

import 'components/custom_app_bar.dart';
import 'components/sidebar.dart';
import 'views/snippet_view.dart';

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
    return ProviderScope(
      child: YaruTheme(
        builder: (context, yaru, child) {
          return MaterialApp(
            darkTheme: yaru.darkTheme,
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: const [
          Sidebar(),
          VerticalDivider(width: 2),
          SnippetView(),
        ],
      ),
    );
  }
}
