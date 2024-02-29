import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';

class EditPokemonPage extends StatefulWidget {
  final String uId;
  final String id;
  final String nama;
  final String level;

  const EditPokemonPage({super.key, required this.id, required this.uId, required this.nama, required this.level});

  @override
  State<EditPokemonPage> createState() => _EditPokemonPageState();
}

class _EditPokemonPageState extends State<EditPokemonPage> {
  final namaController = TextEditingController();
  final levelController = TextEditingController();

  @override
  void initState() {
    super.initState();    
    namaController.value = TextEditingValue(text: widget.nama);
    levelController.value = TextEditingValue(text: widget.level);
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
            TextField(
              controller: levelController,
              decoration: InputDecoration(
                labelText: 'Level',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                Operation().updatePokemon(Pokemon(id: widget.id, nama: namaController.text, level: int.parse(levelController.text), uId: widget.uId));
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