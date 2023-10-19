import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/user_data.dart';
import 'package:srisuntari_mobileapp/quiz/mulai_quiz_page.dart';
import 'package:srisuntari_mobileapp/register/list_puskesmas.dart';
import 'package:srisuntari_mobileapp/register/validate_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedPuskesmas;

  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();

  final dbHelper = DatabaseHelper();

  void registerUser() async {
    final String nama = _namaLengkapController.text;
    final DateTime? tanggalLahir = _selectedDate != null
        ? _selectedDate
        : DateTime.tryParse(_tglLahirController.text);
    final String jenisKelamin = _selectedGender.toString();
    final String puskesmas = _selectedPuskesmas.toString();

    if (nama.isEmpty || tanggalLahir == null || jenisKelamin.isEmpty) {
      showDialog(
        context: context, // Make sure you have access to the context
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upss!'),
            content: Text('Sepertinya ada data yang belum lengkapi.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ],
          );
        },
      );
      return;
    } else {
      final user = UserData(
        nama: nama,
        tanggalLahir: tanggalLahir,
        jenisKelamin: jenisKelamin,
        puskesmas: puskesmas,
      );

      int newId = await dbHelper.saveContact(user);
      String message = (newId == user.id) ? 'Data updated.' : 'Data inserted.';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValidatePage(),
        ),
      );
      print(message);
      printAllUserData();
      print('inserted user');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void printAllUserData() async {
    final users = await dbHelper.getAllContacts();
    // print('Total users: ${users.length}');
    users.forEach((user) {
      print('ID: ${user.id}');
      print('Nama: ${user.nama}');
      print('Tanggal Lahir: ${user.tanggalLahir}');
      print('Jenis Kelamin: ${user.jenisKelamin}');
      print('Puskesmas: ${user.puskesmas}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF6B81DE),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_sharp),
            //   padding: EdgeInsets.all(10),
            //   onPressed: () {},
            // ),
            backgroundColor: Color(0xFF6B81DE),
            expandedHeight: 150,
            floating: true,
            pinned: true,
            collapsedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Mengatur sejajar ke kiri
                children: [
                  Icon(Icons.arrow_back_sharp, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'Daftar',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsets.only(left: 30, bottom: 20, top: 33),
              centerTitle: false,
              expandedTitleScale: 1.3,
              collapseMode: CollapseMode.parallax,
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                          height: 700,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Data Lengkap",
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 26,
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
                                                color: Colors
                                                    .black), // Warna teks sebelum *
                                          ),
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                color: Colors
                                                    .red), // Warna teks asterisk (*)
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Tanggal Lahir ",
                                            style: TextStyle(
                                                color: Colors
                                                    .black), // Warna teks sebelum *
                                          ),
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                color: Colors
                                                    .red), // Warna teks asterisk (*)
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    InkWell(
                                      onTap: () {
                                        // _selectDate(context);
                                        _selectDate(context);
                                      },
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          fillColor: Color(0xFFF0F0F0),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _selectedDate == null
                                                  ? 'Pilih Tanggal Lahir'
                                                  : DateFormat('dd-MM-yyyy')
                                                      .format(_selectedDate!),
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
                                            text: "Jenis Kelamin ",
                                            style: TextStyle(
                                                color: Colors
                                                    .black), // Warna teks sebelum *
                                          ),
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                color: Colors
                                                    .red), // Warna teks asterisk (*)
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    DropdownButtonFormField(
                                      value: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value as String?;
                                        });
                                      },
                                      items: [
                                        DropdownMenuItem(
                                            value: "Laki-laki",
                                            child: Text("Laki-laki")),
                                        DropdownMenuItem(
                                            value: "Perempuan",
                                            child: Text("Perempuan")),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "Pilih Jenis Kelamin",
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400],
                                        ),
                                        fillColor: Color(0xFFF0F0F0),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Puskesmas",
                                            style: TextStyle(
                                                color: Colors
                                                    .black), // Warna teks sebelum *
                                          ),
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                color: Colors
                                                    .red), // Warna teks asterisk (*)
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    DropdownButtonFormField(
                                      value: _selectedPuskesmas,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedPuskesmas = value as String?;
                                        });
                                      },
                                      items: buildPuskesmasDropdownItems(),
                                      decoration: InputDecoration(
                                        hintText: "Pilih Puskesmas",
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400],
                                        ),
                                        fillColor: Color(0xFFF0F0F0),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    SizedBox(height: 5),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 52,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          registerUser();
                                        },
                                        child: Text('Simpan'),
                                      ),
                                    ),
                                  ]))))))
        ]));
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _jenisKelaminController.dispose();
    _tglLahirController.dispose();
    super.dispose();
  }
}
