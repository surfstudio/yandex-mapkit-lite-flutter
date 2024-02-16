import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/theme/theme.dart';
import 'package:yandex_mapkit_example/presentation/screens/root_screen.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: generateLightTheme(),
      darkTheme: generateDarkTheme(),
      routes: {
        '/': (context) => const RootScreen(),
      },
      initialRoute: '/',
    );
  }
}
