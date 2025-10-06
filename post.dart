class Post {
  String user;
  String caption;
  String? imagePath;
  String? imageUrl; 
  bool liked;
  int likes;
  List<String> comments;

  Post({
    required this.user,
    required this.caption,
    this.imagePath,
    this.imageUrl,
    this.liked = false,
    this.likes = 0,
    List<String>? comments,
  }) : comments = comments ?? [];
}
