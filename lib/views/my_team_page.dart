import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon_team.dart';

class MyTeamPage extends StatefulWidget {
  final String uId;
  final List<PokemonTeam> teams;

  const MyTeamPage({super.key, required this.uId, required this.teams});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Team')),
      body: Column(children: [
        Expanded(child: ListView.builder(
          itemCount: widget.teams.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(widget.teams[index].nama),
                      subtitle: Text('Pokemon Count: ${widget.teams[index].pokemonCount.toString()}'),
                      onTap: () {

                      },
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => EditTeamPage(uId: widget.uId, id: widget.teams[index].id, nama: widget.teams[index].nama, level: widget.teams[index].level.toString(),)));
                      }, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: () {
                      Operation().deletePokemon(widget.teams[index].id);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTeamPage(uId: widget.uId)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}