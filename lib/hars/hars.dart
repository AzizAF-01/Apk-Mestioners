import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'hars_hasil.dart';

class Hars extends StatefulWidget {
  const Hars({super.key});

  @override
  State<Hars> createState() => _HarsState();
}

class _HarsState extends State<Hars> {
  // Array untuk menyimpan nilai dari setiap pertanyaan
  final List<int> _scores = List<int>.filled(14, 0);

  // List pertanyaan
  final List<String> _questions = [
    '1.	Perasaan Ansietas : cemas, firasat buruk, takut akan pikiran sendiri, mudah tersinggung.',
    '2.	Ketegangan : Perasaan tegang, mudah lelah, tidak bisa istirahat tenang, mudah terkejut, mudah menangis, gemetar, perasaan gelisah, tidak mampu rileks.',
    '3.	Ketakutan: Terhadap kegelapan, terhadap orang asing, ketika ditinggal sendirian, terhadap binatang besar, terhadap keramaian lalu lintas, takut di kerumunan banyak orang.',
    '4.	Gangguan Tidur : Kesulitan tidur, terbangun di malam hari, gangguan tidur, tidur tidak nyenyak dan kelelahan saat bangun tidur, mimpi buruk atau menakutkan',
    '5.	Intelektual: Kesulitan berkonsentrasi, daya ingat buruk atau lemah.',
    '6.	Perasaan Depresi : Kehilangan minat, kurang bisa menikmati hobi, sedih, depresi, sering terbangun dini hari, perasaan berubah-ubah sepanjang hari.',
    '7.	Gejala Somatik (otot): sakit dan nyeri pada otot, pegal, kedutan otot, kaku, gigi bergemeretak, suara tidak stabil, otot terasa tegang.',
    '8.	Gejala Somatik (sensorik) : telinga berdenging, penglihatan kabur, muka memerah atau pucat, tubuh terasa dingin, perasaan lemas, perasaan seperti ditusuk-tusuk.',
    '9.	Gejala Kardiovaskular (jantung dan pembuluh darah) : nadi terasa cepat, jantung berdebar, nyeri dada, pembuluh darah berdenyut, perasaan lesu atau lemas seperti ingin pingsan, detak jantung berhenti sekejap.',
    '10.	Gejala Pernapasan: Dada terasa tertekan atau sesak, perasaan tercekik, sering menarik nafas, nafas pendek atau sesak.',
    '11.	Gejala Saluran Cerna : Susah menelan, perut terasa melilit, rasa terbakar di perut, perut terasa penuh atau kembung, mual, muntah, diare, penurunan berat badan, susah untuk buang air besar.',
    '12.	Gejala Urogenital : sering buang air kecil, tidak dapat menahan air kencing, berhenti haid, nyeri haid, ejakulasi dini (terlalu cepat mengeluarkan sperma).',
    '13.	Gejala Otonom: Mulut kering, muka tampak kemerahan, mudah berkeringat, pusing, sakit kepala, cenderung berkeringat, bulu di tangan atau kaki berdiri.',
    '14.	Perilaku saat Wawancara: Gelisah atau mondar-mandir, tangan gemetar, alis berkerut, wajah tegang, nafas pendek dan cepat, wajah pucat atau merah.'
  ];

  @override
  Widget build(BuildContext context) {
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(60, 135, 124, 1),
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/3part2.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Hamilton Anxiety\nRating Scale (HARS)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Skor Penilaian\n'
                                '0 = Tidak ada\n'
                                '1 = Ringan\n'
                                '2 = Sedang\n'
                                '3 = Parah\n'
                                '4 = Sangat Parah\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // Generate RadioGroup widget menggunakan loop
                          ..._questions.asMap().entries.map((entry) {
                            int index = entry.key;
                            String question = entry.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  buildRadioGroup(question, _scores[index], (value) {
                                    setState(() {
                                      _scores[index] = value!;
                                    });
                                  }),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(60, 135, 124, 1),
                                ),
                                onPressed: () {
                                  int totalScore = _scores.reduce((a, b) => a + b);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HasilHars(totalScore: totalScore),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Kirim',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildRadioGroup(String title, int groupValue, ValueChanged<int?>? onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, 
          textAlign: TextAlign.justify, 
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.w500,
            color: Colors.white
          )
        ),
        LayoutBuilder(
          builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(5, (index) {
              return Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.circle,
                      color: groupValue == index ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      onChanged?.call(index);
                    },
                  ),
                  Text(
                    '$index', 
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                    ),
                  ],
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
