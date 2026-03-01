class Channel {
  final String name;
  final String url;
  final String logoUrl;
  final String group;
  bool isFavorite;

  Channel({
    required this.name,
    required this.url,
    required this.logoUrl,
    required this.group,
    this.isFavorite = false,
  });

  Channel copyWith({bool? isFavorite}) {
    return Channel(
      name: name,
      url: url,
      logoUrl: logoUrl,
      group: group,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'logoUrl': logoUrl,
        'group': group,
        'isFavorite': isFavorite,
      };

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        name: json['name'],
        url: json['url'],
        logoUrl: json['logoUrl'],
        group: json['group'],
        isFavorite: json['isFavorite'] ?? false,
      );
}
