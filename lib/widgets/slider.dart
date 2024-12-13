import 'package:flutter/material.dart';
import 'package:nasa_api/models/dailyApiResponse.dart';

class FactsSlider extends StatelessWidget {
  final List<DailyApiResonse> responses;

  const FactsSlider({Key? key, required this.responses}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    if (this.responses.isEmpty) {
      return Container(
        width: double.infinity,
        height: 260,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Random Facts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: responses.length,
                itemBuilder: (_, int index) => _MoviePoster(info: responses[index])),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final DailyApiResonse info;
  const _MoviePoster({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: info),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: _getValidImageUrl(info),
                width: 130,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            info.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
  
  ImageProvider<Object> _getValidImageUrl(DailyApiResonse info) {

    if (info.url != null && (info.url!.endsWith('.jpg') || info.url!.endsWith('.png'))) {
      return NetworkImage(info.url!);
    }
    if (info.thumbnailUrl != null && (info.thumbnailUrl!.endsWith('.jpg') || info.thumbnailUrl!.endsWith('.png'))) {
      return NetworkImage(info.thumbnailUrl!);
    }
    return const AssetImage('assets/noImage.png');
    
  }
}
