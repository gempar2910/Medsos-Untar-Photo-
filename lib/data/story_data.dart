import 'dart:math';
import '../models/story.dart';

// daftar nama random
final List<String> _names = [
  "Alex", "Bella", "Charlie", "Diana", "Evan",
  "Fiona", "George", "Hana", "Ivan", "Julia"
];

// daftar gambar random (placeholder avatar gratis)
final List<String> _images = [
  "https://i.pravatar.cc/150?img=1",
  "https://i.pravatar.cc/150?img=2",
  "https://i.pravatar.cc/150?img=3",
  "https://i.pravatar.cc/150?img=4",
  "https://i.pravatar.cc/150?img=5",
  "https://i.pravatar.cc/150?img=6",
  "https://i.pravatar.cc/150?img=7",
  "https://i.pravatar.cc/150?img=8",
  "https://i.pravatar.cc/150?img=9",
  "https://i.pravatar.cc/150?img=10",
];

List<Story> generateStories(int count) {
  final random = Random();
  return List.generate(count, (index) {
    return Story(
      user: _names[random.nextInt(_names.length)],
      imageUrl: _images[random.nextInt(_images.length)],
    );
  });
}