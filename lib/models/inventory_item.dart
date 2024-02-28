class InventoryItem {
  final String id;
  final String nama;
  final int count;
  final String uId;

  InventoryItem({
    required this.id,
    required this.nama,
    required this.count,
    required this.uId,
  });

  // InventoryItem.fromMap(dynamic obj) :
  //   id = obj['ii_id'],
  //   nama = obj['ii_nama'],
  //   count = obj['ii_count'],
  //   uId = obj['u_id'];

  Map<String, Object?> toMap() {
    return {
      'ii_id': id,
      'ii_nama': nama,
      'ii_count': count,
      'u_id': uId,
    };
  }
}