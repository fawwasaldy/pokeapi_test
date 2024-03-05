import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/views/add_pokemon_page.dart';
import 'package:pokeapi_test/views/edit_pokemon_page.dart';
import 'package:pokeapi_test/views/pokemon_page.dart';

class MyPokemonPage extends StatefulWidget {
  final String uId;

  const MyPokemonPage({super.key, required this.uId});

  @override
  State<MyPokemonPage> createState() => _MyPokemonPageState();
}

class _MyPokemonPageState extends State<MyPokemonPage> {
  List<Pokemon> pokemons = [];

  void refresh() {
    Operation().pokemonsByUserId(widget.uId).then((value) {
      setState(() {
        pokemons = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Pokemon')),
      body: Column(children: [
        // const SizedBox(height: 5.0),
        // TextButton(
        //   onPressed: refresh,
        //   style: TextButton.styleFrom(
        //     backgroundColor: Theme.of(context).colorScheme.primary,
        //     minimumSize: const Size(120, 30),
        //   ), 
        //   child: const Text('Refresh', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        // ),
        // const SizedBox(height: 5.0),
        Expanded(child: ListView.builder(
          itemCount:pokemons.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(pokemons[index].nama),
                      subtitle: Text('Level ${pokemons[index].level.toString()}'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonPage(index: pokemons[index].nama))).then((value) => refresh());
                      },
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPokemonPage(uId: widget.uId, id: pokemons[index].id, nama: pokemons[index].nama, level: pokemons[index].level.toString(),))).then((value) => refresh());
                      }, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: () {
                      Operation().deletePokemon(pokemons[index].id);
                      Operation().updatePokemonTeamByPokemonId(pokemons[index].id);
                      refresh();
                      }, icon: const Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
            );
          },
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPokemonPage(uId: widget.uId))).then((value) => refresh());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}