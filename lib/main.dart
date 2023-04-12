import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/widgets.dart';

import 'constants.dart';
import 'ui/components/custom_app_bar.dart';
import 'ui/components/resizable_widget.dart';
import 'ui/components/sidebar.dart';
import 'ui/views/snippet_view.dart';

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

  void _onResize(double width) {
    final windowWidth = MediaQuery.of(context).size.width / 2;
    if (width <= windowWidth) {
      setState(() => _sidebarWidth = width);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          ResizableWidget(
            onDrag: _onResize,
            child: Sidebar(width: _sidebarWidth),
          ),
          const SnippetView(),
        ],
      ),
    );
  }
}
