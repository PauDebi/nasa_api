import 'package:nasa_api/models/searchModels/item.dart';

class Collection {
  final List<Item>? items;

  Collection({
    required this.items,
  });

factory Collection.fromJson(Map<String, dynamic> json) {
  return Collection(
    items: json['items'] != null
        ? (json['items'] as List).map((e) => Item.fromJson(e)).toList()
        : [],
  );
}
}