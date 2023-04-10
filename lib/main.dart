import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/widgets.dart';

import 'components/custom_app_bar.dart';
import 'components/sidebar.dart';
import 'constants.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sidebarWidth = kSidebarMaxWidth;

  void _onResize(DragUpdateDetails details) {
    final windowWidth = MediaQuery.of(context).size.width / 2;
    final sidebarWidth = details.globalPosition.dx;
    if (sidebarWidth <= windowWidth) {
      setState(() => _sidebarWidth = sidebarWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          Sidebar(width: _sidebarWidth),
          MouseRegion(
            cursor: SystemMouseCursors.resizeColumn,
            child: GestureDetector(
              onPanUpdate: _onResize,
              child: const VerticalDivider(width: 2),
            ),
          ),
          const SnippetView(),
        ],
      ),
    );
  }
}
