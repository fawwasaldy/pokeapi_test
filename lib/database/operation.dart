import 'package:sqflite/sqflite.dart';
import 'package:pokeapi_test/database/database_service.dart';
import 'package:pokeapi_test/models/user.dart';
import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/models/pokemon_team.dart';
import 'package:pokeapi_test/models/pokemon_roster.dart';
import 'package:pokeapi_test/models/inventory_item.dart';

class Operation {
  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE inventoryItem (
          ii_id character(36) NOT NULL CONSTRAINT inventoryItem_pk PRIMARY KEY,
          ii_nama varchar(64) NOT NULL,
          ii_count integer NOT NULL,
          u_id character(36) NOT NULL,
          CONSTRAINT inventoryItem_user FOREIGN KEY (u_id)
          REFERENCES user (u_id)
      );
    ''');
    await database.execute('''
      -- Table: pokemon
      CREATE TABLE pokemon (
          p_id character(36) NOT NULL CONSTRAINT pokemon_pk PRIMARY KEY,
          p_nama varchar(64) NOT NULL,
          p_level integer NOT NULL,
          u_id character(36) NOT NULL,
          CONSTRAINT pokemon_user FOREIGN KEY (u_id)
          REFERENCES user (u_id)
      );
    ''');
    await database.execute('''
      -- Table: pokemonRoster
      CREATE TABLE pokemonRoster (
          pr_pt_id character(36) NOT NULL,
          pr_p_id character(36) NOT NULL,
          CONSTRAINT pokemonTeam_pokemon_pk PRIMARY KEY (pr_pt_id,pr_p_id),
          CONSTRAINT pokemonTeam_pokemon_pokemonTeam FOREIGN KEY (pr_pt_id)
          REFERENCES pokemonTeam (pt_id),
          CONSTRAINT pokemonTeam_pokemon_pokemon FOREIGN KEY (pr_p_id)
          REFERENCES pokemon (p_id)
      );
    ''');
    await database.execute('''
      -- Table: pokemonTeam
      CREATE TABLE pokemonTeam (
          pt_id character(36) NOT NULL CONSTRAINT pokemonTeam_pk PRIMARY KEY,
          pt_nama varchar(64) NOT NULL,
          pt_pokemonCount integer NOT NULL,
          u_id character(36) NOT NULL,
          CONSTRAINT pokemonTeam_user FOREIGN KEY (u_id)
          REFERENCES user (u_id)
      );
    ''');
    await database.execute('''
      -- Table: user
      CREATE TABLE user (
          u_id character(36) NOT NULL CONSTRAINT user_pk PRIMARY KEY,
          u_email varchar(64) NOT NULL,
          u_password varchar(64) NOT NULL
      );
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await DatabaseService().database;
    return await db.insert(
      'user', 
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    final db = await DatabaseService().database;

    final List<Map<String, Object?>> userMaps = await db.query('user');

    return [
      for (final {
        'u_id': id as String,
        'u_email': email as String,
        'u_password': password as String,
      } in userMaps)
        User(
          id: id,
          email: email,
          password: password,
        ),
    ];
  }

  Future<int> updateUser(User user) async {
    final db = await DatabaseService().database;
    return await db.update(
      'user',
      user.toMap(),
      where: 'u_id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(String id) async {
    final db = await DatabaseService().database;
    await db.delete(
      'user',
      where: 'u_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertPokemon(Pokemon pokemon) async {
    final db = await DatabaseService().database;
    return await db.insert(
      'pokemon',
      pokemon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Pokemon>> pokemons() async {
    final db = await DatabaseService().database;

    final List<Map<String, Object?>> pokemonMaps = await db.query('pokemon');

    return [
      for (final {
        'p_id': id as String,
        'p_nama': nama as String,
        'p_level': level as int,
        'u_id': uId as String,
      } in pokemonMaps)
        Pokemon(
          id: id,
          nama: nama,
          level: level,
          uId: uId,
        ),
    ];
  }

  Future<int> updatePokemon(Pokemon pokemon) async {
    final db = await DatabaseService().database;
    return await db.update(
      'pokemon',
      pokemon.toMap(),
      where: 'p_id = ?',
      whereArgs: [pokemon.id],
    );
  }

  Future<void> deletePokemon(String id) async {
    final db = await DatabaseService().database;
    await db.delete(
      'pokemon',
      where: 'p_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertPokemonTeam(PokemonTeam pokemonTeam) async {
    final db = await DatabaseService().database;
    return await db.insert(
      'pokemonTeam',
      pokemonTeam.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PokemonTeam>> pokemonTeams() async {
    final db = await DatabaseService().database;

    final List<Map<String, Object?>> pokemonTeamMaps = await db.query('pokemonTeam');

    return [
      for (final {
        'pt_id': id as String,
        'pt_nama': nama as String,
        'pt_pokemonCount': pokemonCount as int,
        'u_id': uId as String,
      } in pokemonTeamMaps)
        PokemonTeam(
          id: id,
          nama: nama,
          pokemonCount: pokemonCount,
          uId: uId,
        ),
    ];
  }

  Future<int> updatePokemonTeam(PokemonTeam pokemonTeam) async {
    final db = await DatabaseService().database;
    return await db.update(
      'pokemonTeam',
      pokemonTeam.toMap(),
      where: 'pt_id = ?',
      whereArgs: [pokemonTeam.id],
    );
  }

  Future<void> deletePokemonTeam(String id) async {
    final db = await DatabaseService().database;
    await db.delete(
      'pokemonTeam',
      where: 'pt_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertPokemonRoster(PokemonRoster pokemonRoster) async {
    final db = await DatabaseService().database;
    return await db.insert(
      'pokemonRoster',
      pokemonRoster.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PokemonRoster>> pokemonRosters() async {
    final db = await DatabaseService().database;

    final List<Map<String, Object?>> pokemonRosterMaps = await db.query('pokemonRoster');

    return [
      for (final {
        'pr_pt_id': ptId as String,
        'pr_p_id': pId as String,
      } in pokemonRosterMaps)
        PokemonRoster(
          ptId: ptId,
          pId: pId,
        ),
    ];
  }

  Future<int> updatePokemonRoster(PokemonRoster pokemonRoster) async {
    final db = await DatabaseService().database;
    return await db.update(
      'pokemonRoster',
      pokemonRoster.toMap(),
      where: 'pr_pt_id = ? AND pr_p_id = ?',
      whereArgs: [pokemonRoster.ptId, pokemonRoster.pId],
    );
  }

  Future<void> deletePokemonRoster(String ptId, String pId) async {
    final db = await DatabaseService().database;
    await db.delete(
      'pokemonRoster',
      where: 'pr_pt_id = ? AND pr_p_id = ?',
      whereArgs: [ptId, pId],
    );
  }

  Future<int> insertInventoryItem(InventoryItem inventoryItem) async {
    final db = await DatabaseService().database;
    return await db.insert(
      'inventoryItem',
      inventoryItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<InventoryItem>> inventoryItems() async {
    final db = await DatabaseService().database;

    final List<Map<String, Object?>> inventoryItemMaps = await db.query('inventoryItem');

    return [
      for (final {
        'ii_id': id as String,
        'ii_nama': nama as String,
        'ii_count': count as int,
        'u_id': uId as String,
      } in inventoryItemMaps)
        InventoryItem(
          id: id,
          nama: nama,
          count: count,
          uId: uId,
        ),
    ];
  }

  Future<int> updateInventoryItem(InventoryItem inventoryItem) async {
    final db = await DatabaseService().database;
    return await db.update(
      'inventoryItem',
      inventoryItem.toMap(),
      where: 'ii_id = ?',
      whereArgs: [inventoryItem.id],
    );
  }

  Future<void> deleteInventoryItem(String id) async {
    final db = await DatabaseService().database;
    await db.delete(
      'inventoryItem',
      where: 'ii_id = ?',
      whereArgs: [id],
    );
  }

  items() {}
}