import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  final List<Map<String, String>> helpItems = [
    {
      "title": "Bagaimana cara menggunakan fitur stopwatch",
      "content":
          "Jika button mulai di klik stopwatch akan mulai menghitung waktu kemudian jika menekan tombol putaran akan merekam tiap waktu.",
    },
    {
      "title": "Bagaimana cara menggunakan fitur konversi waktu",
      "content":
          "Fitur konversi waktu memungkinkan pengguna untuk mengubah satuan waktu dari jam ke menit, menit ke detik, dan sebagainya.",
    },
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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
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
                    child: Text(
                      helpItems[index]["content"]!,
                      style: TextStyle(fontSize: 20),
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
