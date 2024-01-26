import 'package:flutter/material.dart';
import 'package:jokes_app/jokes%20provider/joke_provider.dart';
import 'package:provider/provider.dart';

class LikedJokesScreen extends StatelessWidget {
  const LikedJokesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Jokes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: jokeProvider.getLikedJokes().length,
        itemBuilder: (context, index) {
          final likedJoke = jokeProvider.getLikedJokes()[index];
          return ListTile(
            title: Text(likedJoke.value),
          );
        },
      ),
    );
  }
}
