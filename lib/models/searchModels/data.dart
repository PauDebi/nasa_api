class Data {
  final String? dateCreated;
  final String description;
  final String mediaType;
  final String? photographer;
  final String title;

  Data({
    this.dateCreated,
    required this.description,
    required this.mediaType,
    required this.photographer,
    required this.title,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      dateCreated: json['date_created'],
      description: json['description'],
      mediaType: json['media_type'],
      photographer: json['photographer'],
      title: json['title'],
    );
  }
}