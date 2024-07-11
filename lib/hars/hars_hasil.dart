import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HasilHars extends StatelessWidget {
  final int totalScore;

  HasilHars({required this.totalScore});

  @override
  Widget build(BuildContext context) {
    String interpretation;
    String advice;
    String imagePath;

    if (totalScore < 14) {
      interpretation = 'tidak ada kecemasan';
      advice = 'Anda tampaknya tidak memiliki kecemasan yang signifikan.';
      imagePath = 'assets/Hars1.png';
    } else if (totalScore < 21) {
      interpretation = 'kecemasan ringan';
      advice = 'Mungkin ada perlu melakukan terapi relaksasi, positive self talk, perhatikan asupan makanan, lakukan aktivitas fisik seperti berolahraga, dan anda juga bisa bercerita ke orang terdekat.';
      imagePath = 'assets/Hars2.png';
    } else if (totalScore < 28) {
      interpretation = 'kecemasan sedang';
      advice = 'Mungkin ada perlu melakukan terapi relaksasi, positive self talk, perhatikan asupan makanan, lakukan aktivitas fisik seperti berolahraga, dan anda juga bisa bercerita ke orang terdekat.';
      imagePath = 'assets/Hars3.png';
    } else if (totalScore < 42) {
      interpretation = 'kecemasan berat';
      advice = 'Sebaiknya Anda mencari bantuan profesional untuk mengelola kecemasan Anda. Terapi dan konseling dapat sangat membantu.';
      imagePath = 'assets/Hars4n5.png';
    } else {
      interpretation = 'kecemasan berat sekali';
      advice = 'Sangat disarankan untuk segera mencari bantuan dari profesional kesehatan mental untuk mengatasi kecemasan yang Anda rasakan.';
      imagePath = 'assets/Hars4n5.png';
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/bg_mentioners.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Center(
                      child: Text(
                        'Hamilton Anxiety\nRating Scale (HARS)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: Image.asset(imagePath, height: 100),
                    ),
                    SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(60, 135, 124, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Berdasarkan hasil tes melalui HARS, diperoleh skor anda adalah $totalScore yang menandakan $interpretation.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              Text(
                                advice,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
