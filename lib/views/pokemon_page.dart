import "package:flutter/material.dart";
import "package:pokeapi_test/models/pokemon.dart";
import "package:pokeapi_test/services/remote_service.dart";

class PokemonPage extends StatefulWidget {
  final int index;

  const PokemonPage({super.key, required this.index});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  Pokemon? pokemon;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoaded = false;
    });
    pokemon = await RemoteService().fetchPokemon(widget.index);
    if(pokemon != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(pokemon != null ? pokemon!.name : '', style: Theme.of(context).textTheme.titleLarge), 
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Image.network(pokemon != null ? pokemon!.sprites.frontDefault : ''),
              Text('Name: ${pokemon != null ? pokemon!.name : ''}', style: Theme.of(context).textTheme.bodyLarge),
              Text('Height: ${pokemon != null ? pokemon!.height : ''}', style: Theme.of(context).textTheme.bodyLarge),
              Text('Weight: ${pokemon != null ? pokemon!.weight : ''}', style: Theme.of(context).textTheme.bodyLarge),
              Text('Base Experience: ${pokemon != null ? pokemon!.baseExperience : ''}', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}