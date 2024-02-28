import "package:flutter/material.dart";
import 'package:pokeapi_test/models_pokeapi/pokemon_list.dart';
import "package:pokeapi_test/services/remote_service.dart";
import "package:pokeapi_test/views/pokemon_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokemonList? pokemonList;
  bool isLoaded = false;
  int offset = 0;
  int limit = 20;

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
            child: CircularProgressIndicator(backgroundColor: Colors.white,),
          ),
          child: GridView.builder(
            itemCount: pokemonList != null ? pokemonList!.results.length : 0,
            itemBuilder: (context, index) {
              String id = pokemonList!.results[index].url.substring(34, pokemonList!.results[index].url.length - 1);
              return TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonPage(index: int.parse(id))));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Text(pokemonList!.results[index].name, style: Theme.of(context).textTheme.bodyLarge),
                    Text('ID: $id', style: Theme.of(context).textTheme.bodySmall),
                    Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png', filterQuality: FilterQuality.none,)
                  ],
                ),
              );
            }, 
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
              maxCrossAxisExtent: WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width / 4,
            ),
          )
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
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
        ),
      )
    );
  }
}