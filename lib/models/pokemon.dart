class Pokemon {
  final String id;
  final String nama;
  final int level;
  final String uId;

  Pokemon({
    required this.id,
    required this.nama,
    required this.level,
    required this.uId,
  });

  // Pokemon.fromMap(dynamic obj) :
  //   id = obj['p_id'],
  //   nama = obj['p_nama'],
  //   level = obj['p_level'],
  //   uId = obj['u_id'];

  Map<String, Object?> toMap() {
    return {
      'p_id': id,
      'p_nama': nama,
      'p_level': level,
      'u_id': uId,
    };
  }
}