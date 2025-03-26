import 'package:flutter/material.dart';

class DataAnggotaPage extends StatelessWidget {
  const DataAnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Daftar Anggota",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2D572C),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color(0xFFE6F0E6),
        child: ListView(
          children: const [
            MemberCard(
              imagePath: "images/gita_profile.png",
              name: "Gita Poetri Dewi Siregar",
              nim: "123220087",
              location: "Yogyakarta",
            ),
            SizedBox(height: 16),
            MemberCard(
              imagePath: "images/shinta_profile.png",
              name: "Shinta Nursobah Chairani",
              nim: "123220074",
              location: "Tegal",
            ),
            SizedBox(height: 16),
            MemberCard(
              imagePath: "images/veyza_profile.png",
              name: "Veyza Pardita Ardhia Putri",
              nim: "123220102",
              location: "Bantul",
            ),
          ],
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String nim;
  final String location;

  const MemberCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.nim,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  nim,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
