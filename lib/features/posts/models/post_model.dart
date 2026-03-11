class PostModel {
  final int id;
  final String title;
  final String body;
  final int userId;
  final List<String> tags;
  final int views;
  final int likes;
  final int dislikes;

  const PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.views,
    required this.likes,
    required this.dislikes,
  });

  String get bodyPreview {
    if (body.length <= 120) return body;
    return '${body.substring(0, 120)}...';
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> reactions =
        json['reactions'] is Map ? json['reactions'] as Map<String, dynamic> : <String, dynamic>{};
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId'] ?? 0,
      tags: List<String>.from(json['tags'] ?? <String>[]),
      views: json['views'] ?? 0,
      likes: reactions['likes'] ?? 0,
      dislikes: reactions['dislikes'] ?? 0,
    );
  }
}
