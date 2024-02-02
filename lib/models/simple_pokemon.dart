// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';

SimplePokemon simplePokemonFromJson(String str) => SimplePokemon.fromJson(json.decode(str));

String simplePokemonToJson(SimplePokemon data) => json.encode(data.toJson());

class SimplePokemon {
    String name;
    Sprites sprites;

    SimplePokemon({
        required this.name,
        required this.sprites,
    });

        factory SimplePokemon.fromJson(Map<String, dynamic> json) => SimplePokemon(
        name: json["name"],
        sprites: Sprites.fromJson(json["sprites"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "sprites": sprites.toJson(),
    };
}



class Sprites {
    String backDefault;
    dynamic backFemale;
    String backShiny;
    dynamic backShinyFemale;
    String frontDefault;
    dynamic frontFemale;
    String frontShiny;
    dynamic frontShinyFemale;
    Sprites? animated;

    Sprites({
        required this.backDefault,
        required this.backFemale,
        required this.backShiny,
        required this.backShinyFemale,
        required this.frontDefault,
        required this.frontFemale,
        required this.frontShiny,
        required this.frontShinyFemale,
        this.animated,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        backFemale: json["back_female"],
        backShiny: json["back_shiny"],
        backShinyFemale: json["back_shiny_female"],
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
        animated: json["animated"] == null ? null : Sprites.fromJson(json["animated"]),
    );

    Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
        "animated": animated?.toJson(),
    };
}