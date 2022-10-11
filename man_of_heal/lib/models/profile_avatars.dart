class ProfileAvatars {
  static const NAME = "name";
  static const URL = "url";

  String? name, url;

  ProfileAvatars({this.name, this.url});

  factory ProfileAvatars.fromMap(Map<String, dynamic> map) {
    return ProfileAvatars(name: map[NAME], url: map[URL]);
  }

  Map<String, dynamic> toJson() => {NAME: this.name, URL: this.url};
}
