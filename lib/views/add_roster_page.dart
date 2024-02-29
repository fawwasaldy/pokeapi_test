import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/models/pokemon_roster.dart';

class AddRosterPage extends StatefulWidget {
  final String ptId;
  final List<Pokemon> pokemonCandidates;

  const AddRosterPage({super.key, required this.ptId, required this.pokemonCandidates});

  @override
  State<AddRosterPage> createState() => _AddRosterPageState();
}

class _AddRosterPageState extends State<AddRosterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Pokemon')),
      body: Column(children: [
        Expanded(child: ListView.builder(
          itemCount: widget.pokemonCandidates.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(widget.pokemonCandidates[index].nama),
                      subtitle: Text('Level ${widget.pokemonCandidates[index].level.toString()}'),
                      onTap: () {
                        Operation().insertPokemonRoster(PokemonRoster(ptId: widget.ptId, pId: widget.pokemonCandidates[index].id,));
                        Operation().increasePokemonTeamCount(widget.ptId);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      ]),
    );
  }
}