import 'package:nasa_api/models/searchModels/data.dart';
import 'package:nasa_api/models/searchModels/link.dart';

class Item {
  final String? href;
  final List<Data>? data;
  final List<Link>? links;

  Item({
    required this.href,
    required this.data,
    required this.links,
  });

factory Item.fromJson(Map<String, dynamic> json) {
  return Item(
    href: json['href'],
    data: json['data'] != null
        ? (json['data'] as List).map((e) => Data.fromJson(e)).toList()
        : [],
    links: json['links'] != null
        ? (json['links'] as List).map((e) => Link.fromJson(e)).toList()
        : [],
  );
}
}