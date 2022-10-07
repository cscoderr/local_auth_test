import 'package:flutter/material.dart';
import 'package:riverpod_2/finger_print_page.dart';

final themeMode = ValueNotifier(ThemeMode.light);
final isAuthenticated = ValueNotifier(false);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeMode,
        builder: (__, mode, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.light(
                // primarySwatch: Colors.blue,
                ),
            darkTheme: ThemeData.dark(),
            themeMode: mode,
            home: const FingerPrintPage(),
          );
        });
  }
}
