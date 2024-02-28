class PokemonTeam {
  final String id;
  final String nama;
  final int pokemonCount;
  final String uId;

  PokemonTeam({
    required this.id,
    required this.nama,
    required this.pokemonCount,
    required this.uId,
  });

  // PokemonTeam.fromMap(dynamic obj) :
  //   id = obj['pt_id'],
  //   nama = obj['pt_nama'],
  //   pokemonCount = obj['pt_pokemonCount'],
  //   uId = obj['u_id'];

  Map<String, Object?> toMap() {
    return {
      'pt_id': id,
      'pt_nama': nama,
      'pt_pokemonCount': pokemonCount,
      'u_id': uId,
    };
  }
}