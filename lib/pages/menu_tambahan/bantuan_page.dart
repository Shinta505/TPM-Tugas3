import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  final List<Map<String, dynamic>> helpItems = [
    {
      "title": "Bagaimana cara menggunakan Fitur Stopwatch?",
      "content": [
        "Klik tombol 'Mulai' untuk memulai stopwatch.",
        "Klik tombol 'Putaran' untuk mencatat history waktu saat tombol ditekan.",
        "Klik tombol 'Hentikan' untuk menghentikan stopwatch.",
        "Gunakan tombol 'Reset' untuk menghapus semua catatan waktu."
      ],
    },
    {
      "title": "Bagaimana cara menggunakan Fitur Jenis Bilangan?",
      "content": [
        "Masukkan angka yang ingin diperiksa.",
        "Aplikasi akan menentukan jenis bilangan baik itu bilangan prima, desimal, bulat positif/negatif, dan cacah."
      ],
    },
    {
      "title": "Bagaimana cara menggunakan Fitur Tracking LBS?",
      "content": [
        "Pastikan GPS di perangkat Anda aktif.",
        "Buka fitur tracking LBS di aplikasi.",
        "Aplikasi akan menampilkan lokasi Anda saat ini di peta."
      ],
    },
    {
      "title": "Bagaimana cara menggunakan Fitur Konversi Waktu?",
      "content": [
        "Masukkan angka pada input yang tersedia.",
        "Pilih satuan waktu yang diinginkan.",
        "Aplikasi akan otomatis menghitung hasil konversi."
      ],
    },
    {
      "title": "Bagaimana cara logout dari aplikasi?",
      "content": [
        "Buka Menu Utama.",
        "Tekan tombol Logout di bagian kanan bawah layar.",
        "Akun akan keluar dari sesi dan Anda harus login kembali untuk mengakses aplikasi."
      ],
    }
  ];

  BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu Bantuan",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF2C5E36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                title: Text(
                  helpItems[index]["title"]!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        helpItems[index]["content"].length,
                        (i) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("• ", style: TextStyle(fontSize: 20)),
                            Expanded(
                              child: Text(
                                helpItems[index]["content"][i],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
