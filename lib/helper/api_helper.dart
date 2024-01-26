// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:jokes_app/model/jokes_model.dart';
import 'package:http/http.dart' as http;

Future<Joke?> fetchChuckNorrisJokes() async {
  String api = "https://api.chucknorris.io/jokes/random";

  try {
    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;

      Map<String, dynamic> decodedData = jsonDecode(data);

      Joke joke = Joke.fromJson(decodedData);

      return joke;
    }
  } catch (e) {
    print("Error fetching Chuck Norris joke: $e");
  }

  return null;
}
