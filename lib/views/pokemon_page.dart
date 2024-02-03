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

  Container containerDataPokemon(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${pokemon != null ? pokemon!.name : ''}', style: Theme.of(context).textTheme.bodyLarge),
            Text('Tinggi: ${pokemon != null ? '${pokemon!.height.toDouble()/10} m' : ''}', style: Theme.of(context).textTheme.bodyLarge),
            Text('Berat: ${pokemon != null ? '${pokemon!.weight.toDouble()/10} kg' : ''}', style: Theme.of(context).textTheme.bodyLarge),
            Text('Base Experience: ${pokemon != null ? '${pokemon!.baseExperience} EXP.' : ''}', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
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
          child: ListView(
            children: [
              MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(pokemon != null ? pokemon!.sprites.frontDefault : '', width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth, filterQuality: FilterQuality.none)
                    ),
                  ),
                  containerDataPokemon(context),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(pokemon != null ? pokemon!.sprites.frontDefault : '', height: MediaQuery.of(context).size.height, fit: BoxFit.fitHeight, filterQuality: FilterQuality.none)
                    ),
                  ),
                  containerDataPokemon(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}