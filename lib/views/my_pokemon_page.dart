import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/views/add_pokemon_page.dart';
import 'package:pokeapi_test/views/edit_pokemon_page.dart';
import 'package:pokeapi_test/views/pokemon_page.dart';

class MyPokemonPage extends StatefulWidget {
  final String uId;
  final List<Pokemon> pokemons;

  const MyPokemonPage({super.key, required this.uId, required this.pokemons});

  @override
  State<MyPokemonPage> createState() => _MyPokemonPageState();
}

class _MyPokemonPageState extends State<MyPokemonPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Pokemon')),
      body: Column(children: [
        const SizedBox(height: 5.0),
        TextButton(
          onPressed: () async {
            final pokemons = await Operation().pokemonsByUserId(widget.uId);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyPokemonPage(uId: widget.uId, pokemons: pokemons)));
          }, 
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            minimumSize: const Size(120, 30),
          ), 
          child: const Text('Refresh', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        ),
        const SizedBox(height: 5.0),
        Expanded(child: ListView.builder(
          itemCount: widget.pokemons.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(widget.pokemons[index].nama),
                      subtitle: Text('Level ${widget.pokemons[index].level.toString()}'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonPage(index: widget.pokemons[index].nama)));
                      },
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPokemonPage(uId: widget.uId, id: widget.pokemons[index].id, nama: widget.pokemons[index].nama, level: widget.pokemons[index].level.toString(),)));
                      }, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: () {
                      Operation().deletePokemon(widget.pokemons[index].id);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPokemonPage(uId: widget.uId)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}