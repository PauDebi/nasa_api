import 'dart:convert';
import 'package:nasa_api/models/models.dart';

class Responses {
  List<DailyApiResonse> results;

  Responses({
    required this.results,
  });

  factory Responses.fromJson(String str) {
    // Decode the JSON string into a List of Maps.
    List<dynamic> jsonData = json.decode(str);

    // Map each JSON object to a DailyApiResonse instance and return the list.
    List<DailyApiResonse> parsedResults =
        jsonData.map((item) => DailyApiResonse.fromMap(item)).toList();

    // Return a new Responses instance with the parsed results.
    return Responses(results: parsedResults);
  }

  /// Method to encode the Responses object back to JSON.
  String toJson() {
    // Convert each DailyApiResonse instance in results to a Map, then encode.
    List<Map<String, dynamic>> mappedResults =
        results.map((item) => item.toMap()).toList();
    return json.encode(mappedResults);
  }
}