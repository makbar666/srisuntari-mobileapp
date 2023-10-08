class UserData {
  late final String name;
  late final DateTime tanggalLahir;
  late final String wilayah;

  UserData(
      {required this.name, required this.tanggalLahir, required this.wilayah});

  UserData.fromMap(Map<String, dynamic> result)
      : name = result['name'] as String,
        tanggalLahir = DateTime.parse(result['tanggalLahir'] as String),
        wilayah = result['wilayah'] as String;
  Map<String, Object> toMap() {
    return {'name': name, 'tanggalLahir': tanggalLahir, 'wilayah': wilayah};
  }
}
