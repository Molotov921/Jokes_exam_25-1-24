import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../jokes provider/joke_provider.dart';

class LikedJokesScreen extends StatelessWidget {
  const LikedJokesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Jokes"),
        centerTitle: true,
        backgroundColor: const Color(0xFFf4ac08),
      ),
      backgroundColor: const Color(0xFFf4ac08),
      body: ListView.builder(
        itemCount: jokeProvider.getLikedJokes().length,
        itemBuilder: (context, index) {
          final likedJoke = jokeProvider.getLikedJokes()[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildLikedJokeCard(likedJoke.value),
          );
        },
      ),
    );
  }

  Widget _buildLikedJokeCard(String jokeText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        jokeText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
