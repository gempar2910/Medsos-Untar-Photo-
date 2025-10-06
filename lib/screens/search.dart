import 'package:flutter/material.dart';
import 'image_preview_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // trigger manual refresh
  Future<void> _refreshImages() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {}); // rebuild supaya gambar baru generate
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshImages,
        child: Column(
          children: [
            // 🔎 Search Bar
            Container(
              margin: const EdgeInsets.only(
                top: 50,
                left: 16,
                right: 16,
                bottom: 12,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.red, size: 26),
                  SizedBox(width: 8),
                  Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // 🔲 Grid Explore
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 kolom
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  // generate random url picsum
                  final imageUrl =
                      "https://picsum.photos/200/300?random=${DateTime.now().millisecondsSinceEpoch + index}";

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImagePreview(imageUrl: imageUrl),
                        ),
                      );
                    },
                    child: Hero(
                      tag: imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // fallback kalau gagal load gambar
                            return Container(
                              color: Colors
                                  .primaries[index % Colors.primaries.length],
                            );
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}