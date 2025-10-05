import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(post.user),
            trailing: const Icon(Icons.more_vert),
          ),
          if (post.imagePath != null)
            Image.file(
              File(post.imagePath!),
              fit: BoxFit.contain, // Biar portrait/landscape proporsional
            )
          else
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Text("No Image")),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.caption),
          ),
        ],
      ),
    );
  }
}
