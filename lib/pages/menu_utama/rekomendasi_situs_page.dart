import 'package:flutter/material.dart';
import 'package:mobile_tugas3/pages/data/watch_data.dart';
import 'package:mobile_tugas3/pages/menu_utama/detail_watch_page.dart';
import 'package:intl/intl.dart';

class RekomendasiSitusPage extends StatefulWidget {
  const RekomendasiSitusPage({super.key});

  @override
  State<RekomendasiSitusPage> createState() => _RekomendasiSitusPageState();
}

class _RekomendasiSitusPageState extends State<RekomendasiSitusPage> {
  bool showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final filteredWatches = showFavoritesOnly
        ? wathes.where((watch) => watch.isFavorite).toList()
        : wathes;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Situs Rekomendasi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2D572C),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'favorite') {
                setState(() {
                  showFavoritesOnly = !showFavoritesOnly;
                });
              }
            },
            itemBuilder: (context) => [
              CheckedPopupMenuItem(
                value: 'favorite',
                checked: showFavoritesOnly,
                child: const Text("Tampilkan Favorit"),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: filteredWatches.isEmpty
              ? const Text("Tidak ada jam tangan yang ditampilkan.")
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 260,
                  ),
                  itemCount: filteredWatches.length,
                  itemBuilder: (context, index) =>
                      _watchList(context, filteredWatches[index]),
                ),
        ),
      ),
      backgroundColor: const Color(0xFFE7F1E9),
    );
  }

  Widget _watchList(BuildContext context, var watch) {
    final formattedPrice =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0)
            .format(watch.price);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailWatchPage(index: wathes.indexOf(watch)),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                "images/${watch.imageUrl}",
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      watch.brand,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      watch.model,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      formattedPrice,
                      style: const TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
