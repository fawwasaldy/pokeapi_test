import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon_team.dart';

class EditTeamPage extends StatefulWidget {
  final String uId;
  final String id;
  final String nama;
  final String pokemonCount;

  const EditTeamPage({super.key, required this.id, required this.uId, required this.nama, required this.pokemonCount});

  @override
  State<EditTeamPage> createState() => _EditTeamPageState();
}

class _EditTeamPageState extends State<EditTeamPage> {
  final namaController = TextEditingController();

  @override
  void initState() {
    super.initState();    
    namaController.value = TextEditingValue(text: widget.nama);
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
                Operation().updatePokemonTeam(PokemonTeam(id: widget.id, nama: namaController.text, pokemonCount: int.parse(widget.pokemonCount), uId: widget.uId));
                Navigator.pop(context);
              }, 
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}