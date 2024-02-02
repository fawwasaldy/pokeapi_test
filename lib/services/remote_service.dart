import 'package:pokeapi_test/models/pokemon.dart';
import 'package:pokeapi_test/models/pokemon_list.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapi_test/models/simple_pokemon.dart';

class RemoteService {
  Future<SimplePokemon?> fetchSimplePokemon(int offset, int index) async {
    var client = http.Client();
    String url = 'https://pokeapi.co/api/v2/pokemon/${offset+index}';



    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return simplePokemonFromJson(json);
    }
    return null;
  }

  Future<Pokemon?> fetchPokemon(int offset, int index) async {
    var client = http.Client();
    String url = 'https://pokeapi.co/api/v2/pokemon/${offset+index}';



    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return pokemonFromJson(json);
    }
    return null;
  }

  Future<PokemonList?> fetchPokemonList(int offset, int limit) async {
    var client = http.Client();
    String url = 'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit/';



    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return pokemonListFromJson(json);
    }
    return null;
  }
}