class Post {
  final String title;
  final String body;

  Post({required this.title, required this.body});

  @override
  bool operator ==(Object other) {
    return other is Post && other.title == title && other.body == body;
  }

  @override
  int get hashCode => Object.hash(title, body);
}
