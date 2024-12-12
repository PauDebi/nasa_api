import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:nasa_api/models/models.dart';

class DailyNasaProvider extends ChangeNotifier{

  final String _baseUrl = 'api.nasa.gov';
  final String _apiKey = 'wRfUCOsACB3bE70vbaAE7JWeRr0PFhl8TcvxR9y8';

  List<DailyApiResonse> lastDailyFacts = [];
  List<DailyApiResonse> randomFacts = [];

  DailyNasaProvider(){
    this.getDailyFacts();
    this.getRandomFacts();
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
    DateTime now = DateTime.now();
    DateTime randomDate = now.subtract(Duration(days: (now.difference(DateTime(2015, 1, 1)).inDays * (DateTime.now().millisecondsSinceEpoch % 100) ~/ 100)));
    DateTime limitDate = randomDate.subtract(Duration(days: 50));
    String lastDate = "${randomDate.year}-${randomDate.month}-${randomDate.day}";
    String firstDate = "${limitDate.year}-${limitDate.month}-${limitDate.day}";
    String thumbs = "true";

    var url = Uri.https(_baseUrl, '/planetary/apod', {
      'api_key': _apiKey,
      'start_date': firstDate,
      'end_date': lastDate,
      'thumbs': thumbs,
    });
    print(url);

    final response = await http.get(url);
    final randomApiResonse = Responses.fromJson(response.body);

    randomFacts = randomApiResonse.results;
    notifyListeners();
  }

}
