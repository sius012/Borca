class Like {
  final String id_liker;
  final String id_post;
  String? like_date = DateTime.now().toString();
  Like({required this.id_liker, required this.id_post, this.like_date});

  Map<String, dynamic> toJson() => {
        'id_liker': id_liker,
        'id_post': id_post,
        'like_date': like_date,
      };

  static Like fromJson(Map<String, dynamic> json) => Like(
      id_liker: json['id_liker'],
      id_post: json['id_post'],
      like_date: json['like_date']);
}
