import 'package:flutter/material.dart';
import 'package:pokeapi_test/views/my_inventory_page.dart';
import 'package:pokeapi_test/views/my_pokemon_page.dart';
import 'package:pokeapi_test/views/my_team_page.dart';

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
              // final pokemons = await Operation().pokemonsByUserId(uId);
              // final pokemons = await Operation().pokemons();
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyPokemonPage(uId: uId)));
            },
          ),
          ListTile(
            title: const Text('My Inventory'),
            onTap: () async {
              // final items = await Operation().inventoryItemsByUserId(uId);
              // final items = await Operation().inventoryItems();
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyInventoryPage(uId: uId)));
            },
          ),
          ListTile(
            title: const Text('My Team'),
            onTap: () async {
              // final teams = await Operation().pokemonTeamsByUserId(uId);
              // final items = await Operation().PokemonTeams();
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyTeamPage(uId: uId)));
            },
          )
        ]
      )
    );
  }
}