import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class HistoryScreen extends StatefulWidget {
  final String directoryPath;

  HistoryScreen({required this.directoryPath});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Riwayat Kuis',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Manrope",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF6B81DE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<File>>(
          future: getPDFFiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('Belum Ada Riwayat Kuis'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (conbasotext, index) {
                  final fileName = snapshot.data![index].path
                      .split('/')
                      .last; // Dapatkan nama file saja
                  // // Ubah urutan indeks untuk membalik urutan daftar
                  // final reversedIndex = snapshot.data!.length - 1 - index;
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 7.0,
                      bottom: 7.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        navigateToPDFViewer(context, snapshot.data![index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                fileName,
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontFamily: "Manrope"),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                String selectedFileName = fileName;
                                await deletePDFFile(selectedFileName, snapshot);
                                setState(() {
                                  showDeleteSuccessDialog(selectedFileName);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> deletePDFFile(
      String fileName, AsyncSnapshot<List<File>> snapshot) async {
    try {
      List<File> pdfFiles = snapshot.data!;
      File? pdfFileToDelete;

      // Cari file dengan nama yang sesuai
      for (var file in pdfFiles) {
        if (file.path.endsWith(fileName)) {
          pdfFileToDelete = file;
          break;
        }
      }

      // Hapus file jika ditemukan
      if (pdfFileToDelete != null) {
        await pdfFileToDelete.delete();
        print('File deleted successfully: ${pdfFileToDelete.path}');
      } else {
        print('File not found: $fileName');
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

// Tambahkan metode untuk menampilkan dialog sukses
  void showDeleteSuccessDialog(String fileName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 100.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'File "$fileName"Berhasil dihapus',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        );
      },
    );
  }

  Future<List<File>> getPDFFiles() async {
    Directory directory = Directory(widget.directoryPath);

    if (!directory.existsSync()) {
      print('Direktori tidak ditemukan: ${widget.directoryPath}');
      return []; // Kembalikan daftar kosong jika direktori tidak ada
    }

    List<File> pdfFiles = [];
    var files = directory.listSync();
    // Sortir file berdasarkan waktu modifikasi (terbaru hingga terlama)
    files.sort((a, b) {
      var aTime = (a.statSync().modified as DateTime).millisecondsSinceEpoch;
      var bTime = (b.statSync().modified as DateTime).millisecondsSinceEpoch;
      return bTime.compareTo(aTime);
    });
    for (var file in files) {
      if (file is File && file.path.endsWith('.pdf')) {
        pdfFiles.add(file);
      }
    }

    print('Jumlah file PDF: ${pdfFiles.length}');

    return pdfFiles;
  }

  // Future<List<File>> getPDFFiles() async {
  //   Directory directory = Directory(widget.directoryPath);
  //   List<File> pdfFiles = [];
  //   var files = directory.listSync();
  //   // Urutkan berdasarkan tanggal modifikasi file (terbaru ke terlama)
  //   files.sort(
  //       (a, b) => (b.statSync().modified.compareTo(a.statSync().modified)));

  //   if (directory.existsSync()) {
  //     var files = directory.listSync();
  //     for (var file in files) {
  //       if (file is File && file.path.endsWith('.pdf')) {
  //         pdfFiles.add(file);
  //       }
  //     }
  //   }

  //   return pdfFiles;
  // }

  void navigateToPDFViewer(BuildContext context, File pdfFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewer(pdfPath: pdfFile.path),
      ),
    );
  }
}

class PDFViewer extends StatelessWidget {
  final String pdfPath;

  PDFViewer({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Kuis'),
      ),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageSnap: true,
        pageFling: true,
        onRender: (pages) {
          // Callback saat PDF telah di-render
        },
        onError: (error) {
          // Callback jika terjadi kesalahan
        },
        onPageChanged: (int? page, int? total) {
          // Callback saat halaman berubah
        },
      ),
    );
  }
}
