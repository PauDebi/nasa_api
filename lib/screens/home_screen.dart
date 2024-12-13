import 'package:flutter/material.dart';
import 'package:nasa_api/providers/daily_nasa_provider.dart';
import 'package:nasa_api/widgets/card_swiper.dart';
import 'package:nasa_api/widgets/slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyNasaProvider = Provider.of<DailyNasaProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, 'search');
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade600,
                  Colors.purple.shade400,
                  Colors.pink.shade300,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            "Nasa's Daily Facts",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 8,
          shadowColor: Colors.black45,
          
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwiper(responses: dailyNasaProvider.lastDailyFacts),
            FactsSlider(responses: dailyNasaProvider.randomFacts),
            // Más elementos se pueden añadir aquí...
          ],
        ),
      ),
    );
  }
}
