import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/database_service.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/models/pr_join_p.dart';
import 'package:pokeapi_test/views/add_roster_page.dart';

class MyRosterPage extends StatefulWidget {
  final String ptId;
  final List<PrJoinP> rostersJoinPokemon;

  const MyRosterPage({super.key, required this.ptId, required this.rostersJoinPokemon});

  @override
  State<MyRosterPage> createState() => _MyRosterPageState();
}

class _MyRosterPageState extends State<MyRosterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Roster')),
      body: Column(children: [
        const SizedBox(height: 5.0),
        TextButton(
          onPressed: () async {
            final team = await Operation().pokemonTeamById(widget.ptId);
            final rostersJoinPokemon = await Operation().prJoinPTable(widget.ptId);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyRosterPage(ptId: team.id, rostersJoinPokemon: rostersJoinPokemon)));
          }, 
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            minimumSize: const Size(120, 30),
          ), 
          child: const Text('Refresh', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        ),
        const SizedBox(height: 5.0),
        Expanded(child: ListView.builder(
          itemCount: widget.rostersJoinPokemon.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(widget.rostersJoinPokemon[index].nama),
                      subtitle: Text('Level ${widget.rostersJoinPokemon[index].level.toString()}'),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Operation().deletePokemonRoster(widget.rostersJoinPokemon[index].ptId, widget.rostersJoinPokemon[index].pId);
                        Operation().decreasePokemonTeamCount(widget.ptId);
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
        onPressed: () async {
          final db = await DatabaseService().database;
          final query = await db.rawQuery('''
            SELECT * FROM pokemon
            WHERE p_id NOT IN (
              SELECT pr_p_id FROM pokemonRoster
              WHERE pr_pt_id = "${widget.ptId}"
            );
            ''');
          final pokemonCandidates = [
            for (final {
              'p_id': id as String,
              'p_nama': nama as String,
              'p_level': level as int,
              'u_id': uId as String,
            } in query)
              Pokemon(
                id: id,
                nama: nama,
                level: level,
                uId: uId,
              ),
          ];
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddRosterPage(ptId: widget.ptId, pokemonCandidates: pokemonCandidates)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}