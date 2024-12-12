import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:nasa_api/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<DailyApiResonse> responses;

  const CardSwiper({super.key, required this.responses});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (responses.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: responses.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.45,
        itemBuilder: (BuildContext context, int index) {
          final info = responses[index];
          final imageUrl = _getValidImageUrl(info);

          return Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details', arguments: info),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: imageUrl.startsWith('http')
                        ? NetworkImage(imageUrl)
                        : AssetImage(imageUrl) as ImageProvider,
                    fit: BoxFit.cover,
                    height: size.height * 0.45, // Ajuste de altura uniforme
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getValidImageUrl(DailyApiResonse info) {

    if (info.url != null && (info.url!.endsWith('.jpg') || info.url!.endsWith('.png'))) {
      return info.url!;
    }
    return info.thumbnailUrl ?? 'assets/noImage.png';
  }
}