import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/views/add_pokemon_page.dart';
import 'package:pokeapi_test/views/edit_pokemon_page.dart';

class MyTeamPage extends StatefulWidget {
  final String uId;
  final List<Pokemon> pokemons;

  const MyTeamPage({super.key, required this.uId, required this.pokemons});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {

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
                      subtitle: Text('Pokemon Count: ${widget.pokemons[index].level.toString()}'),
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