import 'package:flutter/material.dart';
import 'package:pokeapi_test/database/database_service.dart';
import 'package:pokeapi_test/models/inventory_item.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/views/my_inventory_page.dart';
import 'package:pokeapi_test/views/my_pokemon_page.dart';

class NavBar extends StatelessWidget {
  final String uId;
  final String email;
  const NavBar({super.key, required this.uId, required this.email});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: Text(email), accountEmail: Text('uId: $uId'), decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('My Pokemon'),
            onTap: () async {
              final db = await DatabaseService().database;
              final query = await db.query('pokemon', where: 'u_id = ?', whereArgs: [uId]);
              final pokemons = [
                for (final {
                  'p_id': id as String,
                  'p_nama': nama as String,
                  'p_level': level as int,
                  'u_id': uId as String,
                } in query)
                  Pokemon(id: id, nama: nama, level: level, uId: uId)
              ];
              // final pokemons = await Operation().pokemons();
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyPokemonPage(uId: uId, pokemons: pokemons)));
            },
          ),
          ListTile(
            title: const Text('My Inventory'),
            onTap: () async {
              final db = await DatabaseService().database;
              final query = await db.query('inventoryItem', where: 'u_id = ?', whereArgs: [uId]);
              final items = [
                for (final {
                  'ii_id': id as String,
                  'ii_nama': nama as String,
                  'ii_count': count as int,
                  'u_id': uId as String,
                } in query)
                  InventoryItem(id: id, nama: nama, count: count, uId: uId)
              ];
              // final items = await Operation().inventoryItems();
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyInventoryPage(uId: uId, items: items)));
            },
          )
        ]
      )
    );
  }
}