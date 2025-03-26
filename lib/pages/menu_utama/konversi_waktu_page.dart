import 'package:flutter/material.dart';

class KonversiWaktuPage extends StatefulWidget {
  const KonversiWaktuPage({super.key});

  @override
  State<KonversiWaktuPage> createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final TextEditingController _waktuController = TextEditingController();
  String hasilTahun = "";
  String hasilJam = "";
  String hasilMenit = "";
  String hasilDetik = "";
  String selectedUnit = "Tahun";
  bool isValid = true;

  void _hitungKonversi() {
    String input = _waktuController.text.trim();

    // Validasi regex agar bisa menerima angka desimal dengan koma atau titik
    if (RegExp(r'^[0-9]+([.,][0-9]+)?$').hasMatch(input)) {
      double nilai =
          double.parse(input.replaceAll(',', '.')); // Ubah koma ke titik

      setState(() {
        isValid = true;
        switch (selectedUnit) {
          case "Tahun":
            hasilTahun = "$nilai";
            hasilJam = "${nilai * 365 * 24}";
            hasilMenit = "${nilai * 365 * 24 * 60}";
            hasilDetik = "${nilai * 365 * 24 * 60 * 60}";
            break;
          case "Jam":
            hasilTahun = "${nilai / (360 * 24)}";
            hasilJam = "$nilai";
            hasilMenit = "${nilai * 60}";
            hasilDetik = "${nilai * 60 * 60}";
            break;
          case "Menit":
            hasilTahun = "${nilai / (360 * 24 * 60)}";
            hasilJam = "${nilai / 60}";
            hasilMenit = "$nilai";
            hasilDetik = "${nilai * 60}";
            break;
          case "Detik":
            hasilTahun = "${nilai / (360 * 24 * 60 * 60)}";
            hasilJam = "${nilai / (60 * 60)}";
            hasilMenit = "${nilai / 60}";
            hasilDetik = "$nilai";
            break;
        }
      });
    } else {
      setState(() {
        isValid = false;
        hasilTahun = "";
        hasilJam = "";
        hasilMenit = "";
        hasilDetik = "";
      });
    }
  }

  void _clearFields() {
    setState(() {
      _waktuController.clear();
      hasilTahun = "";
      hasilJam = "";
      hasilMenit = "";
      hasilDetik = "";
      isValid = true;
    });
  }

  Widget _buildResultField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        "$label: $value",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth - 52) / 2;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Konversi Waktu",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2D572C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset(
              "images/konversiwaktu_image.png",
              height: 250,
            ),
            const SizedBox(height: 20),

            // Dropdown Pilihan Unit
            DropdownButton<String>(
              value: selectedUnit,
              items: ["Tahun", "Jam", "Menit", "Detik"].map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedUnit = newValue!;
                });
              },
            ),

            const SizedBox(height: 10),

            // Input Field dengan Error Handling
            TextField(
              controller: _waktuController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Masukkan nilai $selectedUnit",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: isValid ? Colors.transparent : Colors.red,
                    width: 2,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                filled: true,
                fillColor: Colors.white,
                errorText: isValid ? null : "Input tidak valid",
                errorStyle: const TextStyle(color: Colors.red),
              ),
              onChanged: (value) {
                setState(() {
                  isValid = RegExp(r'^[0-9]+([.,][0-9]+)?$').hasMatch(value);
                });
              },
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: buttonWidth,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: _hitungKonversi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D572C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text("Hasil",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: buttonWidth,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: _clearFields,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text("Clear",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              "HASIL KONVERSI",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildResultField("Tahun", hasilTahun),
            _buildResultField("Jam", hasilJam),
            _buildResultField("Menit", hasilMenit),
            _buildResultField("Detik", hasilDetik),
          ],
        ),
      ),
    );
  }
}
