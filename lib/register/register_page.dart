import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/user_data.dart';
import 'package:srisuntari_mobileapp/register/validate_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> daftarWilayah = [
    "Wilayah A",
    "Wilayah B",
    "Wilayah C",
    "Wilayah A (lainnya)"
  ];

  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _wilayahController = TextEditingController();

  // fungsi tanggal lahir
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Tanggal awal yang ditampilkan
      firstDate: DateTime(1900), // Tanggal pertama yang dapat dipilih
      lastDate: DateTime.now(), // Tanggal terakhir yang dapat dipilih
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  DatabaseHelper dbHelper = DatabaseHelper();

  Future<int> addUser() async {
    UserData userData = UserData(
      name: _namaLengkapController.text,
      tanggalLahir: DateTime.parse(_tanggalLahirController.text),
      // wilayah: _wilayahController.text,
    );
    int result = await dbHelper.insertUserdata(userData);
    return result;
  }

  void _onPressed() async {
    int result = await addUser();
    if (result > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValidatePage(),
        ),
      );
    }
  }

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
                          shadows: [
                            Shadow(
                              blurRadius: 50.0,
                              color: Colors.grey,
                              offset: Offset(3.0, 3.0),
                            ),
                          ],
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
                        controller: _namaLengkapController,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _tanggalLahirController.text,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
                            hint: Text("Pilih Wilayah"),
                            value: _wilayahController.text.isEmpty
                                ? null
                                : _wilayahController.text,
                            isExpanded: true,
                            items: daftarWilayah.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _wilayahController.text = value.toString();
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
                        onTap: () {},
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
                          onPressed: () async {
                            _onPressed();
                          },
                          child: Text('Simpan'),
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

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _tanggalLahirController.dispose();
    _wilayahController.dispose();
    super.dispose();
  }
}
