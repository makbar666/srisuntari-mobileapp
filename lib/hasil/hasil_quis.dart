import 'package:flutter/material.dart';

class HasilQuis extends StatelessWidget {
  const HasilQuis({super.key, required this.nilai});
  final int nilai;

  @override
  Widget build(BuildContext context) {
    String indikator = "Hijau";
    String catatan = "Anda Masih Sehat";
    Color progressBarColor = Colors.green; // Warna awal progress indikator
// Menggunakan operator ternary untuk mengubah warna progress bar berdasarkan nilai 'nilai'
    if (nilai >= 1 && nilai <= 10) {
      indikator = "Merah";
      catatan =
          "Segerah Bawah anda ke puskesmas Monokwari untuk melakukan pemeriksaan lanjut dan rujukan ke rumah sakit";
      progressBarColor = Colors.red;
    } else if (nilai >= 10 && nilai <= 17) {
      indikator = "Kuning";
      catatan = "anda hanya belum menikah makannya jomblo terus";
      progressBarColor = Colors.yellow;
    } else if (nilai >= 18) {
      indikator = "Hijau";
      catatan = "anda belum melakukan rutinitas hari ini contohnya colli";
      progressBarColor = Colors.green;
    }

    return Scaffold(
      backgroundColor: Color(0xFF6B81DE),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 32.0, top: 52.0, right: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Mengatur ikon dan teks sejajar ke kiri
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Kuis Telah Selesai",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      child: Image(image: AssetImage("images/family.png")),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hasil Quiz",
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Berikut Adalah Hasil Kuis Kamu",
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Nama Lengkap', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // Rata kiri teks
                                ),
                                Spacer(),
                                Text(
                                  'partis', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black, // Warna teks
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Umur Kamu', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // Rata kiri teks
                                ),
                                Spacer(),
                                Text(
                                  '1 tahun 1 bulan', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black, // Warna teks
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Status Indikator', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // Rata kiri teks
                                ),
                                Spacer(),
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: progressBarColor,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '$indikator', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black, // Warna teks
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Catatan', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left, // Rata kiri teks
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double
                                  .infinity, // Mengatur lebar menjadi penuh
                              decoration: BoxDecoration(
                                color: Colors.grey
                                    .shade200, // Warna latar belakang kontainer
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: Colors.grey.shade300, // Warna border
                                  width: 2.0, // Lebar border
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '$catatan', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  // Rata kiri teks
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  //Belum Ada
                                },
                                child: Text("Unduh Hasil",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 20, // Sesuaikan jarak dari bawah sesuai kebutuhan Anda
          //   left: 40,
          //   right: 40,
          //   child: Center(
          //     child: Container(
          //       width: MediaQuery.of(context).size.width,
          //       height: 52,
          //       child: ElevatedButton(
          //         onPressed: () {
          //           //Belum Ada
          //         },
          //         child: Text("Unduh Hasil",
          //             style: TextStyle(
          //               fontSize: 22,
          //               fontWeight: FontWeight.bold,
          //             )),
          //         style: ElevatedButton.styleFrom(
          //           primary: Color(0xFF6B81DE),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20.0),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
