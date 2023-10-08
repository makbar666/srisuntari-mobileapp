class UserData {
  late final String name;
  late final DateTime tanggalLahir;

  UserData({required this.name, required this.tanggalLahir});

  UserData.fromMap(Map<String, dynamic> result)
      : name = result['name'],
        tanggalLahir = DateTime.parse(result['tanggalLahir']);

  Map<String, Object> toMap() {
    return {'name': name, 'tanggalLahir': tanggalLahir.toIso8601String()};
  }
}
