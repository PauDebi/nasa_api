import 'package:flutter/material.dart';
import 'package:nasa_api/models/searchModels/item.dart';
import 'package:nasa_api/providers/daily_nasa_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DailyNasaProvider provider = Provider.of<DailyNasaProvider>(context, listen: false);
    bool isSearching = false;
    int textCount = -1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (value.isEmpty && textCount != 0) {
                  _buildSearchResults(provider, value);
                } else if (value.length >= 3 && value.length != textCount) {
                  _buildSearchResults(provider, value);
                }
                textCount = value.length;
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSearchResults(DailyNasaProvider provider, String search) {
    provider.updateSearchResults({'q': search});
    List<Item> searchResults = provider.searchResults;
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(searchResults[index].data?[0].title ?? 'No title'),
        );
      },
    );
  }
}