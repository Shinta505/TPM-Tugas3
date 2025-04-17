import 'package:flutter/material.dart';
import 'package:mobile_tugas3/pages/menu_tambahan/anggota_page.dart';
import 'package:mobile_tugas3/pages/menu_tambahan/bantuan_page.dart';
import 'package:mobile_tugas3/pages/menu_utama/bilangan_page.dart';
import 'package:mobile_tugas3/pages/menu_utama/konversi_waktu_page.dart';
import 'package:mobile_tugas3/pages/menu_utama/rekomendasi_situs_page.dart';
import 'package:mobile_tugas3/pages/menu_utama/stopwatch_page.dart';
import 'package:mobile_tugas3/pages/menu_utama/trackinglbs_page.dart';
import 'package:mobile_tugas3/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C5E36),
        title: const Text(
          "Menu Utama",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [], // Removed the logout button from the AppBar
      ),
      backgroundColor: const Color(0xFFE7F1E9),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DataAnggotaPage()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BantuanPage()));
          } else if (index == 2) {
            _showLogoutDialog(context);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Anggota"),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: "Bantuan"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildMenuItem(context, "Aplikasi Stopwatch", "images/logomenu1.png",
                StopwatchPage()),
            buildMenuItem(context, "Aplikasi Bilangan", "images/logomenu2.png",
                BilanganPage()),
            buildMenuItem(context, "Tracking LBS", "images/logomenu3.png",
                TrackinglbsPage()),
            buildMenuItem(context, "Konversi Waktu", "images/logomenu4.png",
                KonversiWaktuPage()),
            buildMenuItem(context, "Rekomendasi Situs", "images/logomenu5.png",
                RekomendasiSitusPage()),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      BuildContext context, String title, String iconPath, Widget page) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C9A55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(200, 35),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => page));
                  },
                  child: const Text(
                    "Buka",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              iconPath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah yakin ingin logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove("isLoggedIn"); // Hapus sesi login

                // Navigasi ke halaman login dan hapus semua halaman sebelumnya
                Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }
}
