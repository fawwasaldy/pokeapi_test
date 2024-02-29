import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:uuid/uuid.dart';

class AddPokemonPage extends StatefulWidget {
  final String uId;

  const AddPokemonPage({super.key, required this.uId});

  @override
  State<AddPokemonPage> createState() => _AddPokemonPageState();
}

class _AddPokemonPageState extends State<AddPokemonPage> {
  final namaController = TextEditingController();
  final levelController = TextEditingController();

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
                var uuid = const Uuid();
                String pId = uuid.v4();
                Operation().insertPokemon(Pokemon(id: pId, nama: namaController.text, level: int.parse(levelController.text), uId: widget.uId));
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