import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:pokeapi_test/models/inventory_item.dart';
import 'package:pokeapi_test/views/add_item_page.dart';
import 'package:pokeapi_test/views/edit_item_page.dart';

class MyInventoryPage extends StatefulWidget {
  final String uId;

  const MyInventoryPage({super.key, required this.uId});

  @override
  State<MyInventoryPage> createState() => _MyInventoryPageState();
}

class _MyInventoryPageState extends State<MyInventoryPage> {
  List<InventoryItem> items = [];

  void refresh() {
    Operation().inventoryItemsByUserId(widget.uId).then((value) {
      setState(() {
        items = value;
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
      appBar: AppBar(title: const Text('My Inventory')),
      body: Column(children: [
        // const SizedBox(height: 5.0),
        // TextButton(
        //   onPressed: () async {
        //     final items = await Operation().inventoryItemsByUserId(widget.uId);
        //     Navigator.pop(context);
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyInventoryPage(uId: widget.uId, items: items)));
        //   }, 
        //   style: TextButton.styleFrom(
        //     backgroundColor: Theme.of(context).colorScheme.primary,
        //     minimumSize: const Size(120, 30),
        //   ), 
        //   child: const Text('Refresh', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        // ),
        // const SizedBox(height: 5.0),
        Expanded(child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(items[index].nama),
                      subtitle: Text('Count: ${items[index].count.toString()}'),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditItemPage(uId: widget.uId, id: items[index].id, nama: items[index].nama, count: items[index].count.toString(),))).then((value) => refresh());
                      }, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: () {
                        Operation().deleteInventoryItem(items[index].id);
                        refresh();
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemPage(uId: widget.uId,))).then((value) => refresh());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}