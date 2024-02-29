import "package:flutter/material.dart";
import 'package:pokeapi_test/models_pokeapi/pokemon.dart';
import "package:pokeapi_test/services/remote_service.dart";

class PokemonPage extends StatefulWidget {
  final dynamic index;

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

  Column listViewDataPokemon(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 300.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama: ${pokemon != null ? pokemon!.name : ''}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Tinggi: ${pokemon != null ? '${pokemon!.height.toDouble()/10} m' : ''}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Berat: ${pokemon != null ? '${pokemon!.weight.toDouble()/10} kg' : ''}', style: Theme.of(context).textTheme.bodySmall),
                  // Text('Base Experience: ${pokemon != null ? '${pokemon!.baseExperience} EXP.' : ''}', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 300.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text('Stat Dasar', style: Theme.of(context).textTheme.titleSmall),
                  ),
                  Text('HP: ${pokemon != null ? pokemon!.stats[0].baseStat : ''}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Attack: ${pokemon != null ? pokemon!.stats[1].baseStat : ''}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Defense: ${pokemon != null ? pokemon!.stats[2].baseStat : ''}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Special Attack: ${pokemon != null ? pokemon!.stats[3].baseStat : ''}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Special Defense: ${pokemon != null ? pokemon!.stats[4].baseStat : ''}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Speed: ${pokemon != null ? pokemon!.stats[5].baseStat : ''}', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      replacement: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(pokemon != null ? pokemon!.name : '', style: Theme.of(context).textTheme.titleLarge), 
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MediaQuery.of(context).orientation == Orientation.portrait
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(pokemon != null ? pokemon!.sprites.frontDefault ?? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png' : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png', width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth, filterQuality: FilterQuality.none)
                ),
              ),
              listViewDataPokemon(context),
            ],
          )
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(pokemon != null ? pokemon!.sprites.frontDefault ?? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png' : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png', height: MediaQuery.of(context).size.height - (kToolbarHeight + kBottomNavigationBarHeight), fit: BoxFit.fitHeight, filterQuality: FilterQuality.none)
                ),
              ),
              listViewDataPokemon(context),
            ],
          ),
        ),
      ),
    );
  }
}