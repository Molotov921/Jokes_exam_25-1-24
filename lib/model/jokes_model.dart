class Joke {
  final List<String> categories;
  final String createdAt;
  final String iconUrl;
  final String id;
  final String updatedAt;
  final String url;
  final String value;
  bool isLiked;

  Joke({
    required this.categories,
    required this.createdAt,
    required this.iconUrl,
    required this.id,
    required this.updatedAt,
    required this.url,
    required this.value,
    this.isLiked = false,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      categories: List<String>.from(json['categories']),
      createdAt: json['created_at'],
      iconUrl: json['icon_url'],
      id: json['id'],
      updatedAt: json['updated_at'],
      url: json['url'],
      value: json['value'],
      isLiked: json['isLiked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories,
      'created_at': createdAt,
      'icon_url': iconUrl,
      'id': id,
      'updated_at': updatedAt,
      'url': url,
      'value': value,
      'isLiked': isLiked,
    };
  }
}
