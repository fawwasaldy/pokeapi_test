import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon_team.dart';
import 'package:pokeapi_test/views/add_team_page.dart';
import 'package:pokeapi_test/views/edit_team_page.dart';
import 'package:pokeapi_test/views/my_roster_page.dart';

class MyTeamPage extends StatefulWidget {
  final String uId;

  const MyTeamPage({super.key, required this.uId});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  List<PokemonTeam> teams = [];

  void refresh() {
    Operation().pokemonTeamsByUserId(widget.uId).then((value) {
      setState(() {
        teams = value;
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
      appBar: AppBar(title: const Text('My Team')),
      body: Column(children: [
        // const SizedBox(height: 5.0),
        // TextButton(
        //   onPressed: () async {
        //     final teams = await Operation().pokemonTeamsByUserId(widget.uId);
        //     Navigator.pop(context);
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyTeamPage(uId: widget.uId, teams: teams)));
        //   }, 
        //   style: TextButton.styleFrom(
        //     backgroundColor: Theme.of(context).colorScheme.primary,
        //     minimumSize: const Size(120, 30),
        //   ), 
        //   child: const Text('Refresh', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        // ),
        // const SizedBox(height: 5.0),
        Expanded(child: ListView.builder(
          itemCount: teams.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(teams[index].nama),
                      subtitle: Text('Pokemon Count: ${teams[index].pokemonCount.toString()}'),
                      onTap: () async {
                        // final rostersJoinPokemon = await Operation().prJoinPTable(teams[index].id);
                        // final pokemons = await Operation().pokemons();                        
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyRosterPage(ptId: teams[index].id))).then((value) => refresh());
                      },
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditTeamPage(uId: widget.uId, id: teams[index].id, nama: teams[index].nama, pokemonCount: teams[index].pokemonCount.toString(),))).then((value) => refresh());
                      }, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: () {
                        Operation().deletePokemonTeam(teams[index].id);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTeamPage(uId: widget.uId))).then((value) => refresh());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}