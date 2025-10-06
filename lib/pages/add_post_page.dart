import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/post.dart';

class AddPostPage extends StatefulWidget {
  final Function(Post) onPostAdded;

  const AddPostPage({super.key, required this.onPostAdded});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _captionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _submitPost() {
    if (_captionController.text.isNotEmpty || _selectedImage != null) {
      final newPost = Post(
        user: "User",
        caption: _captionController.text,
        imagePath: _selectedImage?.path,
      );
      widget.onPostAdded(newPost);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(labelText: "Write a caption..."),
            ),
            const SizedBox(height: 16),
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 200,
                    fit: BoxFit.contain,
                  )
                : const Text("No Image Selected"),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo),
              label: const Text("Pick Image"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submitPost,
              child: const Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
