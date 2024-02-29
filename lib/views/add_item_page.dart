import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/inventory_item.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatefulWidget {
  final String uId;
  const AddItemPage({super.key, required this.uId});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final namaController = TextEditingController();
  final countController = TextEditingController();

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
              controller: countController,
              decoration: InputDecoration(
                labelText: 'Count',
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
                Operation().insertInventoryItem(InventoryItem(id: pId, nama: namaController.text, count: int.parse(countController.text), uId: widget.uId));
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