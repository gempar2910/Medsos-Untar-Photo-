import 'package:flutter/material.dart';
import '../models/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final VoidCallback onLike;

  const PostWidget({super.key, required this.post, required this.onLike});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header (username dsb)
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(post.user[0].toUpperCase()),
          ),
          title: Text(post.user, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),

        // Gambar (kalau ada)
        if (post.imageUrl != null)
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              post.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),

        // Tombol Like & Komentar
        Row(
          children: [
            IconButton(
              icon: Icon(
                post.liked ? Icons.favorite : Icons.favorite_border,
                color: post.liked ? Colors.red : Colors.black,
              ),
              onPressed: widget.onLike,
            ),
            IconButton(
              icon: const Icon(Icons.comment_outlined),
              onPressed: () {
                // nanti bisa buat buka komentar
              },
            ),
          ],
        ),

        // Jumlah likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text("${post.likes} likes",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text("${post.user} ${post.caption}"),
        ),
      ],
    );
  }
}
