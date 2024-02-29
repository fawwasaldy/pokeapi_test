import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/views/add_pokemon_page.dart';
import 'package:pokeapi_test/views/edit_pokemon_page.dart';

class MyPokemonPage extends StatefulWidget {
  final String uId;
  final String email;
  final List<Pokemon> pokemons;

  const MyPokemonPage({super.key, required this.uId, required this.email, required this.pokemons});

  @override
  State<MyPokemonPage> createState() => _MyPokemonPageState();
}

class _MyPokemonPageState extends State<MyPokemonPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Pokemon')),
      body: Column(children: [
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