import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:nasa_api/models/models.dart';

class DailyNasaProvider extends ChangeNotifier{

  final String _baseUrl = 'api.nasa.gov';
  final String _apiKey = 'wRfUCOsACB3bE70vbaAE7JWeRr0PFhl8TcvxR9y8';

  List<DailyApiResonse> lastDailyFacts = [];
  List<DailyApiResonse> randomFacts = [];

  DailyNasaProvider(){
    getDailyFacts();
    getRandomFacts();
  }

  void getDailyFacts() async{
    DateTime now = DateTime.now();
    now = now.subtract(Duration(days: 50));
    String date = "${now.year}-${now.month}-${now.day}";
    String thumbs = "true";

    var url =
    Uri.https(_baseUrl, '/planetary/apod',
    {
        'api_key': _apiKey,
        'start_date': date,
        'thumbs': thumbs,
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final dailyApiResonse = Responses.fromJson(response.body);

    lastDailyFacts = dailyApiResonse.results;
    notifyListeners();
  }

  void getRandomFacts() async {
    String thumbs = "true";

    var url = Uri.https(_baseUrl, '/planetary/apod', {
      'api_key': _apiKey,
      'count': '50',
      'thumbs': thumbs,
    });

    final response = await http.get(url);
    final randomApiResonse = Responses.fromJson(response.body);

    randomFacts = randomApiResonse.results;
    notifyListeners();
  }

}
