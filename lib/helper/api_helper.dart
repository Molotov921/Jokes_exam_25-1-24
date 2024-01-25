import 'dart:convert';
import 'package:jokes_app/model/jokes_model.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Joke>?> fetchChuckNorrisJokes() async {
    String api = "https://api.chucknorris.io/jokes/random";

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;

      Map<String, dynamic> decodedData = jsonDecode(data);

      Joke joke = Joke.fromJson(decodedData);

      return [joke];
    }
    return null;
  }
}
