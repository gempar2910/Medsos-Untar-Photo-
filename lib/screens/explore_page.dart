import 'package:flutter/material.dart';
import '../screens/image_preview_page.dart'; // pastikan path benar

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // fungsi untuk refresh grid explore
  Future<void> _refreshImages() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {}); // biar regenerate gambar baru
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Explore",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshImages,
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 kolom
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: 50, // jumlah gambar
          itemBuilder: (context, index) {
            final imageUrl =
                "https://picsum.photos/id/${index + 30}/400/400"; // random explore

            return GestureDetector(
              onTap: () {
                // 👇 push ke ImagePreview
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImagePreview(imageUrl: imageUrl),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey[300]);
                  },
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}