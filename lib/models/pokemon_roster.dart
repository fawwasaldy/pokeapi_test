class PokemonRoster {
    final String ptId;
    final String pId;

    PokemonRoster({
      required this.ptId, 
      required this.pId
    });

    // PokemonRoster.fromMap(dynamic obj) :
    //   ptId = obj['pt_id'],
    //   pId = obj['p_id'];

    Map<String, Object?> toMap() {
      return {
        'pt_id': ptId,
        'p_id': pId
      };
    }
}