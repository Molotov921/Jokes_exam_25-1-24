import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jokes_app/helper/api_helper.dart';
import 'package:jokes_app/model/jokes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JokeProvider with ChangeNotifier {
  final List<Joke> _jokeHistory = [];
  int _currentIndex = 0;
  Timer? _likeButtonTimer;
  Completer<void>? _fetchingNewJokeCompleter;

  List<Joke> get jokeHistory => _jokeHistory;

  int get currentIndex => _currentIndex;

  Joke get currentJoke {
    return _currentIndex < _jokeHistory.length
        ? _jokeHistory[_currentIndex]
        : Joke(
            value: 'Default Joke',
            categories: [],
            createdAt: '',
            iconUrl: '',
            id: '',
            updatedAt: '',
            url: '',
          );
  }

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    List<String>? likedJokes = _prefs.getStringList('liked_jokes');
    if (likedJokes != null) {
      _jokeHistory.addAll(
        likedJokes.map(
          (json) => Joke.fromJson(
            jsonDecode(json),
          ),
        ),
      );
    }

    await _fetchNewJoke();
  }

  Future<void> _fetchNewJoke() async {
    if (_fetchingNewJokeCompleter != null &&
        !_fetchingNewJokeCompleter!.isCompleted) {
      return _fetchingNewJokeCompleter!.future;
    }

    _fetchingNewJokeCompleter = Completer<void>();

    try {
      final newJoke = await fetchChuckNorrisJokes();
      if (newJoke != null) {
        _jokeHistory.add(newJoke);
        _currentIndex = _jokeHistory.length - 1;
        notifyListeners();
      }
    } finally {
      _fetchingNewJokeCompleter!.complete();
      _fetchingNewJokeCompleter = null;
    }
  }

  void _toggleLike() {
    _jokeHistory[_currentIndex].isLiked = !_jokeHistory[_currentIndex].isLiked;

    _prefs.setStringList(
      'liked_jokes',
      _jokeHistory
          .where((joke) => joke.isLiked)
          .map((joke) => jsonEncode(joke.toJson()))
          .toList(),
    );

    notifyListeners();
  }

  void toggleLike() {
    if (_jokeHistory.isNotEmpty) {
      if (_likeButtonTimer != null && _likeButtonTimer!.isActive) {
        _likeButtonTimer!.cancel();
      }

      _likeButtonTimer = Timer(const Duration(milliseconds: 500), _toggleLike);
    }
  }

  void showPreviousJoke() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  Future<void> showNextJoke() async {
    if (_currentIndex < _jokeHistory.length - 1) {
      _currentIndex++;
    } else {
      await _fetchNewJoke();

      if (_currentIndex < _jokeHistory.length - 1) {
        _currentIndex++;
      }
    }
    notifyListeners();
  }

  List<Joke> getLikedJokes() {
    return _jokeHistory.where((joke) => joke.isLiked).toList();
  }
}
