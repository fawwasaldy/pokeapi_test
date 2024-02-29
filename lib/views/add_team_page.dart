import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon_team.dart';
import 'package:uuid/uuid.dart';

class AddTeamPage extends StatefulWidget {
  final String uId;

  const AddTeamPage({super.key, required this.uId});

  @override
  State<AddTeamPage> createState() => _AddTeamPageState();
}

class _AddTeamPageState extends State<AddTeamPage> {
  final namaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("PokeAPI Test", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                var uuid = const Uuid();
                String ptId = uuid.v4();
                Operation().insertPokemonTeam(PokemonTeam(id: ptId, nama: namaController.text, pokemonCount: 0, uId: widget.uId));
                Navigator.pop(context);
              }, 
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}