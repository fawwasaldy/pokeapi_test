import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/inventory_item.dart';

class EditItemPage extends StatefulWidget {
  final String uId;
  final String id;
  final String nama;
  final String count;

  const EditItemPage({super.key, required this.id, required this.uId, required this.nama, required this.count});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final namaController = TextEditingController();
  final countController = TextEditingController();

  @override
  void initState() {
    super.initState();    
    namaController.value = TextEditingValue(text: widget.nama);
    countController.value = TextEditingValue(text: widget.count);
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
                Operation().updateInventoryItem(InventoryItem(id: widget.id, nama: namaController.text, count: int.parse(countController.text), uId: widget.uId));
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