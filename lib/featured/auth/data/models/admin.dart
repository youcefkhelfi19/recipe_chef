class Admin {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String imageLink;
  final String tiktokLink;
  final String instagramLink;
  final String youtubeLink;
  final String facebookLink;

  Admin({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.imageLink,
    required this.tiktokLink,
    required this.instagramLink,
    required this.youtubeLink,
    required this.facebookLink,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageLink': imageLink,
      'tiktokLink': tiktokLink,
      'instagramLink': instagramLink,
      'youtubeLink': youtubeLink,
      'facebookLink': facebookLink,
    };
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      imageLink: json['imageLink'],
      tiktokLink: json['tiktokLink'],
      instagramLink: json['instagramLink'],
      youtubeLink: json['youtubeLink'],
      facebookLink: json['facebookLink'],
    );
  }
}
