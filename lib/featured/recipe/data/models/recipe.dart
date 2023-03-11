
class Recipe {
  String? id;
  String title;
  String category;
  String description;
  String youtubeLink;
  List<String>? images;
  List<String> likes;
  String datetime;

  Recipe({
     this.id,
    required this.title,
    required this.description,
    required this.youtubeLink,
     this.images,
    required this.likes,
    required this.datetime,
    required this.category,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json['id'],
    title: json['title'],
    category: json['category'],
    description: json['description'],
    youtubeLink: json['youtube_link'],
    images: List<String>.from(json['images']),
    likes: List<String>.from(json['likes']),
    datetime: json['datetime'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'description': description,
    'youtube_link': youtubeLink,
    'images': images,
    'likes': likes,
    'datetime': datetime,
  };
}
