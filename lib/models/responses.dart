import 'dart:convert';
import 'package:nasa_api/models/models.dart';

class Responses {
  List<DailyApiResonse> results;

  Responses({
    required this.results,
  });

  factory Responses.fromJson(String str) {
    List<dynamic> jsonData = json.decode(str);

    List<DailyApiResonse> parsedResults =
        jsonData.map((item) => DailyApiResonse.fromMap(item)).toList();

    return Responses(results: parsedResults);
  }

  String toJson() {
    List<Map<String, dynamic>> mappedResults =
        results.map((item) => item.toMap()).toList();
    return json.encode(mappedResults);
  }
}