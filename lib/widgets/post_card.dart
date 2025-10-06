import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          title: Text(post.user),
          trailing: const Icon(Icons.more_vert),
        ),

        // Gambar
        if (post.imagePath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.file(
              File(post.imagePath!),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
          )
        else
          Container(
            height: 300,
            color: Colors.grey[300],
            child: const Center(child: Text("No Image")),
          ),

        // Actions
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  post.liked ? Icons.favorite : Icons.favorite_border,
                  color: post.liked ? Colors.red : Colors.black,
                  size: 28,
                ),
                onPressed: onLike,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 28),
                onPressed: onComment,
              ),
              const SizedBox(width: 16),
              const Icon(Icons.send, size: 28),
              const Spacer(),
              const Icon(Icons.bookmark_border, size: 28),
            ],
          ),
        ),

        // Likes & Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "${post.likes} likes",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (post.caption.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Text(post.caption),
          ),
        const SizedBox(height: 12),
      ],
    );
  }
}