import 'package:flutter/material.dart';
import '../data/story_data.dart';

class StoryBar extends StatelessWidget {
  const StoryBar({super.key}); // ✅ constructor const bisa, tapi isinya jangan pakai const

  @override
  Widget build(BuildContext context) {
    final stories = generateStories(10); // pakai data random

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.purple[100],
                  backgroundImage: story.imageUrl != null
                      ? NetworkImage(story.imageUrl!)
                      : null,
                ),
                const SizedBox(height: 6),
                Text(
                  story.user,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
