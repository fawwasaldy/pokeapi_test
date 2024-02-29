import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/inventory_item.dart';
import 'package:pokeapi_test/views/add_item_page.dart';
import 'package:pokeapi_test/views/edit_item_page.dart';

class MyInventoryPage extends StatefulWidget {
  final String uId;
  final List<InventoryItem> items;

  const MyInventoryPage({super.key, required this.uId, required this.items});

  @override
  State<MyInventoryPage> createState() => _MyInventoryPageState();
}

class _MyInventoryPageState extends State<MyInventoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Inventory')),
      body: Column(children: [
        Expanded(child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(widget.items[index].nama),
                      subtitle: Text('Count: ${widget.items[index].count.toString()}'),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditItemPage(uId: widget.uId, id: widget.items[index].id, nama: widget.items[index].nama, count: widget.items[index].count.toString(),)));
                      }, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: () {
                        Operation().deleteInventoryItem(widget.items[index].id);
                      }, icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            );
          },
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemPage(uId: widget.uId,)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}