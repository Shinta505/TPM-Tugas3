import 'package:flutter/material.dart';
import 'package:mobile_tugas3/pages/data/watch_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DetailWatchPage extends StatefulWidget {
  final int index;
  const DetailWatchPage({super.key, required this.index});

  @override
  State<DetailWatchPage> createState() => _DetailWatchPageState();
}

class _DetailWatchPageState extends State<DetailWatchPage> {
  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(wathes[widget.index].price);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Detail Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2D572C),
        actions: [
          IconButton(
            icon: Icon(
              wathes[widget.index].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                wathes[widget.index].isFavorite =
                    !wathes[widget.index].isFavorite;
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.asset(
            "images/${wathes[widget.index].imageUrl}",
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          wathes[widget.index].brand,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 56, 108, 58),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formattedPrice,
                        style: const TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _builDetailItem("Model", wathes[widget.index].model),
                  _builDetailItem("Style", wathes[widget.index].style),
                  _builDetailItem("Gender", wathes[widget.index].gender),
                  _builDetailItem("Case Diameter",
                      "${wathes[widget.index].caseDiameter} mm"),
                  _builDetailItem(
                      "Case Material", wathes[widget.index].caseMaterial),
                  _builDetailItem(
                      "Strap Material", wathes[widget.index].strapMaterial),
                  _builDetailItem(
                      "Color", wathes[widget.index].color.toString()),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        await launchUrl(
                            Uri.parse(wathes[widget.index].websiteUrl));
                      },
                      child: const Text(
                        "Go to store page",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
