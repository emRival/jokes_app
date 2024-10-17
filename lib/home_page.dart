import 'package:flutter/material.dart';
import 'package:jokes_app/detail_page.dart';
import 'package:jokes_app/detail_widget.dart';
import 'package:jokes_app/joke.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Joke? selectedJoke;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width > 600 &&
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes App'),
        backgroundColor: Colors.blue,
      ),
      body: isTablet
          ? Row(
              children: [
                Flexible(
                  child: ListJoke(
                    onTap: (joke) => setState(() => selectedJoke = joke),
                    selectedJoke: selectedJoke,
                  ),
                ),
                Flexible(child: DetailWidget(joke: selectedJoke)),
              ],
            )
          : ListJoke(
              onTap: (joke) {
                setState(() {
                  selectedJoke = joke;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(joke: joke),
                  ),
                );
              },
              selectedJoke: selectedJoke,
            ),
    );
  }
}

class ListJoke extends StatelessWidget {
  final Function(Joke joke) onTap;
  final Joke? selectedJoke;

  const ListJoke({super.key, required this.onTap, this.selectedJoke});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokesList.length,
      itemBuilder: (context, index) {
        final joke = jokesList[index];
        return ListTile(
          title: Text(joke.setup),
          onTap: () => onTap(joke),
          selected: selectedJoke == joke,
          selectedColor: Colors.red,
        );
      },
    );
  }
}
