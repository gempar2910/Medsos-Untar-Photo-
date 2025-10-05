import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/story_bar.dart';
import '../widgets/post_card.dart';
import 'search.dart';
import 'post.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 🔹 List Post untuk feed & profile
  // 🔹 List Post untuk feed & profile
  List<Post> posts = [
  Post(
    user: "gemparcr",
    caption: "Hello world!",
    likes: 12,
    comments: ["Keren banget!"],
    imageUrl: "https://picsum.photos/400/300?random=1", // ✅ tambahkan gambar random
  ),
  Post(
    user: "tarsoc_official",
    caption: "Event baru nih 🔥",
    likes: 30,
    comments: ["Nice!", "Love this ❤️"],
    imageUrl: "https://picsum.photos/400/300?random=2", // ✅ tambahkan gambar random
  ),
  Post(
    user: "alice99",
    caption: "Coffee time ☕",
    likes: 8,
    comments: ["Mau juga 😍"],
    imageUrl: "https://picsum.photos/400/300?random=3", // ✅ dummy post baru
  ),
  Post(
    user: "john_doe",
    caption: "Enjoying the sunset 🌅",
    likes: 15,
    comments: ["Indah banget!", "Mantap bro"],
    imageUrl: "https://picsum.photos/400/300?random=4", // ✅ dummy post baru
  ),
];


  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildFeed(),
      const SearchPage(),
      Container(),
      ProfilePage(posts: posts, username: "gemparcr"), // ✅ kirim posts ke profile
    ];
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // halaman tambah post
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostPage(onPostCreated: _addNewPost),
        ),
      );
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void _addNewPost(Post newPost) {
    setState(() {
      posts.insert(0, newPost);
      _pages[3] = ProfilePage(posts: posts, username: "gemparcr"); // refresh profile
      _selectedIndex = 0;
    });
  }

  void _toggleLike(int index) {
    setState(() {
      posts[index].liked = !posts[index].liked;
      posts[index].likes += posts[index].liked ? 1 : -1;
    });
  }

  void _showComments(int index) {
    // TODO: bikin modal untuk komentar
  }

  Widget _buildFeed() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset("assets/images/logo_untar.png", height: 32),
            const SizedBox(width: 8),
            const Text(
              "TarSoc",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black, size: 28),
          SizedBox(width: 16),
          Icon(Icons.send_outlined, color: Colors.black, size: 28),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const StoryBar(),
            const Divider(height: 1),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  post: posts[index],
                  onLike: () => _toggleLike(index),
                  onComment: () => _showComments(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
