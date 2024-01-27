import 'package:flutter/material.dart';
import 'package:jokes_app/model/jokes_model.dart';
import 'package:provider/provider.dart';
import '../../jokes provider/joke_provider.dart';
import 'package:share/share.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<JokeProvider>().init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildScaffold(context);
        } else {
          return _buildLoadingIndicator();
        }
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Chuck Norris Jokes"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 5,
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFef9904),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("Neel Kalariya"),
                accountEmail: Text("kalarianeel249@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://lh3.googleusercontent.com/a/ACg8ocIbB3Msrb90avMuPrxnRp0gI_9YGwHGiVVr-XrzR55l7w=s96-c-rg-br100",
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFBE71),
                ),
              ),
              ListTile(
                title: const Text("Home"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Liked Jokes"),
                onTap: () {
                  Navigator.of(context).pushNamed('liked_jokes');
                },
              ),
              ListTile(
                title: const Text("Settings"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("About"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: const _JokeWidget(),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _JokeWidget extends StatelessWidget {
  const _JokeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/laughing_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<JokeProvider>(
              builder: (context, jokeProvider, _) {
                return _buildJokeCard(jokeProvider.currentJoke);
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRoundButton(
                  onPressed: () =>
                      context.read<JokeProvider>().showPreviousJoke(),
                  icon: Icons.arrow_back,
                  color: const Color(0xFFef9904),
                ),
                _buildRoundButton(
                  onPressed: () async {
                    await context.read<JokeProvider>().showNextJoke();
                  },
                  icon: Icons.arrow_forward,
                  color: const Color(0xFFef9904),
                ),
                _buildRoundButton(
                  onPressed: () => context.read<JokeProvider>().toggleLike(),
                  icon: context.watch<JokeProvider>().currentJoke.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: context.watch<JokeProvider>().currentJoke.isLiked
                      ? Colors.red
                      : const Color(0xFFef9904),
                ),
                _buildRoundButton(
                  onPressed: () => _shareJoke(
                      context, context.read<JokeProvider>().currentJoke),
                  icon: Icons.share,
                  color: const Color(0xFFef9904),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoundButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildJokeCard(Joke joke) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200]?.withOpacity(0.7) ?? Colors.grey[200],
      ),
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: 400,
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(
                    joke.value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _shareJoke(BuildContext context, Joke joke) {
  final String text = joke.value;
  Share.share(text);
}
