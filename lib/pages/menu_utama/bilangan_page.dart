import 'package:flutter/material.dart';

class BilanganPage extends StatefulWidget {
  const BilanganPage({super.key});

  @override
  State<BilanganPage> createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final TextEditingController _controller = TextEditingController();
  String? resultPrime;
  String? resultDecimal;
  String? resultSign;
  String? resultCacah;
  String? errorText; // ✅ Tambahan error message

  void clearFields() {
    _controller.clear();
    setState(() {
      resultPrime = null;
      resultDecimal = null;
      resultSign = null;
      resultCacah = null;
      errorText = null; // ✅ Reset error
    });
  }

  void calculateResult() {
    final input = _controller.text;
    final num? number = num.tryParse(input);

    if (input.isEmpty) {
      setState(() {
        errorText = 'Field tidak boleh kosong';
        resultPrime = null;
        resultDecimal = null;
        resultSign = null;
        resultCacah = null;
      });
      return;
    }

    if (number == null) {
      setState(() {
        errorText = 'Format tidak valid. Masukkan angka yang benar.';
        resultPrime = null;
        resultDecimal = null;
        resultSign = null;
        resultCacah = null;
      });
      return;
    }

    // ✅ Jika valid, hilangkan error dan proses hasil
    setState(() {
      errorText = null;
      resultPrime = (number is int && isPrime(number))
          ? 'Bilangan Prima'
          : 'Bukan Bilangan Prima';
      resultDecimal =
          number % 1 == 0 ? 'Bukan Bilangan Desimal' : 'Bilangan Desimal';
      resultSign = number > 0
          ? 'Bilangan Positif'
          : (number < 0 ? 'Bilangan Negatif' : 'Nol');
      resultCacah = (number is int && number >= 0)
          ? 'Bilangan Cacah'
          : 'Bukan Bilangan Cacah';
    });
  }

  bool isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Menu Bilangan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2D572C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              "images/menubilangan_image.png",
              height: 300,
              width: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Masukkan Bilangan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                errorText: errorText, // Tampilkan error di sini
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: calculateResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D572C),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text(
                    "Hasil",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: clearFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Hasil :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (resultPrime != null)
              Text(
                resultPrime!,
                style: const TextStyle(
                  color: Color(0xFF2D572C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (resultDecimal != null)
              Text(
                resultDecimal!,
                style: const TextStyle(
                  color: Color(0xFF2D572C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (resultSign != null)
              Text(
                resultSign!,
                style: const TextStyle(
                  color: Color(0xFF2D572C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (resultCacah != null)
              Text(
                resultCacah!,
                style: const TextStyle(
                  color: Color(0xFF2D572C),
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
