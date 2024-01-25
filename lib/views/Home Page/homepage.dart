import 'package:flutter/material.dart';
import 'package:jokes_app/helper/api_helper.dart';
import 'package:jokes_app/model/jokes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Joke>? data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData({String searchedText = ""}) async {
    await APIHelper.apiHelper.fetchChuckNorrisJokes().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chuck Norris Jokes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            if (data == null)
              const CircularProgressIndicator()
            else if (data!.isEmpty)
              const Text("No jokes found")
            else
              _buildJokeCard(data![0]),
          ],
        ),
      ),
    );
  }

  Widget _buildJokeCard(Joke joke) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              joke.value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Category: ${joke.categories.join(', ')}",
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "ID: ${joke.id}",
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: const Text("Get Another Joke"),
            ),
          ],
        ),
      ),
    );
  }
}
