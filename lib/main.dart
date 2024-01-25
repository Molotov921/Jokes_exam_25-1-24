import 'package:flutter/material.dart';
import 'package:jokes_app/splash_screen/splash.dart';
import 'Home Page/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const HomePage(),
        'splash_screen': (context) => const Splash(),
      },
    ),
  );
}
