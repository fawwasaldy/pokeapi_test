import "package:flutter/material.dart";
import 'package:pokeapi_test/models/pokemon_list.dart';
import "package:pokeapi_test/services/remote_service.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokemonList? pokemonList;
  var isLoaded = false;
  var offset = 0;
  var limit = 20;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoaded = false;
    });
    pokemonList = await RemoteService().fetchPokemonList(offset, limit);
    if(pokemonList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("PokeAPI Test", style: Theme.of(context).textTheme.titleLarge), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: GridView.builder(
            itemCount: pokemonList != null ? pokemonList!.results.length : 0,
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Text(pokemonList!.results[index].name, style: Theme.of(context).textTheme.bodyLarge),
                    Text('ID: ${pokemonList!.results[index].url.substring(34, pokemonList!.results[index].url.length - 1)}', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              );
            }, 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
              crossAxisCount: 2,
            ),
          )
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 140,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if(offset > 0) {
                  offset -= limit;
                  getData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text("Previous", style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: Center(child: Text((offset/limit+1).toInt().toString(), style: Theme.of(context).textTheme.titleSmall)),
          ),
          SizedBox(
            width: 140,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if(offset < pokemonList!.count - limit) {
                  offset += limit;
                  getData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text("Next", style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ],
      )
    );
  }
}