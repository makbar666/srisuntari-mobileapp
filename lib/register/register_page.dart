import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String namaLengkap = "";
  DateTime tanggalLahir = DateTime.now();
  String wilayah = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != tanggalLahir) {
      setState(() {
        tanggalLahir = picked;
      });
    }
  }

  Future<void> _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      // Di sini, Anda dapat mengambil file yang dipilih dan mengunggahnya
      print('Path file: ${file.path}');
    } else {
      // User membatalkan pemilihan file
    }

    if (result != null) {
      PlatformFile file = result.files.first;
      // Di sini, Anda dapat mengambil file yang dipilih dan mengunggahnya
      print('Path file: ${file.path}');
    } else {
      // User membatalkan pemilihan file
    }
  }

  List<String> daftarWilayah = [
    "Wilayah A",
    "Wilayah B",
    "Wilayah C",
    "Wilayah A (lainnya)"
  ];

  // FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF6B81DE),
        body: Stack(
          children: [
            // button back & text Daftar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 32.0, top: 52.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Mengatur ikon dan teks sejajar ke kiri
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Daftar",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white, // Warna latar belakang putih
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(20.0), // Ubah radius sesuai keinginan
                    topRight:
                        Radius.circular(20.0), // Ubah radius sesuai keinginan
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data Lengkap",
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Silahkan Lengkapi Data Kamu Terlebih Dahulu.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Nama Lengkap ",
                              style: TextStyle(
                                  color: Colors.black), // Warna teks sebelum *
                            ),
                            TextSpan(
                              text: "*",
                              style: TextStyle(
                                  color: Colors.red), // Warna teks asterisk (*)
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        onChanged: (value) {
                          // ...
                        },
                        decoration: InputDecoration(
                          hintText: "Masukkan Nama Lengkap",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),
                          fillColor: Color(0xFFF0F0F0),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        ),
                      ),
                      SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Tanggal Lahir ",
                              style: TextStyle(
                                  color: Colors.black), // Warna teks sebelum *
                            ),
                            TextSpan(
                              text: "*",
                              style: TextStyle(
                                  color: Colors.red), // Warna teks asterisk (*)
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF0F0F0),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          ),
                          child: Text(
                            tanggalLahir == null
                                ? "Pilih tanggal lahir"
                                : "${tanggalLahir.toLocal()}".split(' ')[0],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Distrik / Wilayah ",
                              style: TextStyle(
                                  color: Colors.black), // Warna teks sebelum *
                            ),
                            TextSpan(
                              text: "*",
                              style: TextStyle(
                                  color: Colors.red), // Warna teks asterisk (*)
                            ),
                          ],
                        ),
                      ),
                      // dropdown wilayah
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            value: wilayah.isNotEmpty ? wilayah : null,
                            hint: Text("Pilih Wilayah"),
                            isExpanded: true,
                            items: daftarWilayah.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                wilayah = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Foto ",
                              style: TextStyle(
                                  color: Colors.black), // Warna teks sebelum *
                            ),
                            TextSpan(
                              text: "*",
                              style: TextStyle(
                                  color: Colors.red), // Warna teks asterisk (*)
                            ),
                          ],
                        ),
                      ),
                      // field upload foto file picker
                      GestureDetector(
                        onTap: () {
                          _pickAndUploadFile();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Text("Upload Foto"),
                              // Icon(Icons.upload_file),
                            ],
                          ),
                        ),
                      ),
                      // button daftar
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            // ...
                          },
                          child: Text("Lanjutkan",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6B81DE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
