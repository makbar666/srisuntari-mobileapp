class DataAnak {
  // final int id;
  final String name;
  // final DateTime birthDate;

  DataAnak({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      // 'birthDate':
      //     birthDate.toIso8601String(), // Ubah tanggal menjadi string ISO8601
    };
  }
}
