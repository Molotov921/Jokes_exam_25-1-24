import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jokes_app/views/splash_screen/splash.dart';
import 'jokes provider/joke_provider.dart';
import 'views/Home Page/homepage.dart';
import 'views/Liked jokes/liked_jokes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => JokeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => const HomePage(),
          'splash_screen': (context) => const Splash(),
          'liked_jokes': (context) => const LikedJokesScreen(),
        },
      ),
    ),
  );
}
