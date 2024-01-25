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
        title: const Text("Jokes App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                getData(searchedText: val);
              },
              decoration: const InputDecoration(
                hintText: "Search Jokes",
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: (data == null)
                  ? const Center(child: CircularProgressIndicator())
                  : (data!.isEmpty)
                      ? const Center(child: Text("No jokes found"))
                      : ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: ListTile(
                                title: Text(
                                  data![index].value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
