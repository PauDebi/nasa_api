import 'package:flutter/material.dart';
import 'package:nasa_api/models/models.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DailyApiResonse? info = ModalRoute.of(context)?.settings.arguments as DailyApiResonse?;
    if (info == null) {
      return const Scaffold(
        body: Center(child: Text('Error: No data received.')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            info: info,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(
                  info: info,
                ),
                _Overview(
                  info: info,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final DailyApiResonse info;
  
  const _CustomAppBar({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(3), // Espaciado interno
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7), // Color translúcido
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            child: Text(
              info.title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black), // Asegúrate de que el texto sea legible
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: _getImageProvider(info),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final DailyApiResonse info;
  const _PosterAndTitile({required this.info});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        _getTitle(context, textTheme, info),  
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Publish Date: ${info.date.toLocal().toString().split(' ')[0]}",
                  style: textTheme.titleMedium,
                ),
                if (info.copyright != null)
                  Text(
                    "Copyright: ${info.copyright!}",
                    style: textTheme.titleMedium,
                  ),
                if (info.mediaType != MediaType.IMAGE && info.url != null)
                  SizedBox(
                    width: 180,
                    child: 
                      Text(
                        'VideoUrl: ${info.url}',
                        style: textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: _getImageProvider(info),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],)
        ),
        const SizedBox(
          width: double.infinity,
          height: 20,
        ),
      ],
    );
  }
}


class _Overview extends StatelessWidget {
  final DailyApiResonse info;
  const _Overview({required this.info});
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          info.explanation,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
  }
}

Widget _getTitle(BuildContext context, TextTheme textTheme, DailyApiResonse? info) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.black87, Colors.black54],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Center(
          child: Text(
            info!.title,
            style: textTheme.headlineLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.black87, Colors.black54],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(
          width: double.infinity,
          height: 20,
        ),
      ],
    ),
  );
}

ImageProvider _getImageProvider(DailyApiResonse info) {
  if (info.url != null && (info.url!.endsWith('.jpg') || info.url!.endsWith('.png'))) {
    return NetworkImage(info.url!);
  }
  if (info.thumbnailUrl != null && (info.thumbnailUrl!.endsWith('.jpg') || info.thumbnailUrl!.endsWith('.png'))) {
    return NetworkImage(info.thumbnailUrl!);
  }
  return const AssetImage('assets/noImage.png');
}