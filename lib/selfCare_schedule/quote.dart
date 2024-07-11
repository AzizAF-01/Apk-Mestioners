import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mentioners/SQLite/db_helper.dart';

class Quote extends StatefulWidget {
  const Quote({super.key});

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  List<String> quotes = [
    "Saat kita menerima dan merawat luka-luka emosional kita, kita sedang memberi kesempatan bagi kehidupan yang lebih baik di masa depan.\n - Unknown",
    "Trauma bukanlah akhir dari kehidupan, tapi awal dari perjalanan pemulihan yang penuh kekuatan.\n - Unknown",
    "Merelakan dan melepaskan masa lalu adalah langkah pertama menuju kebahagiaan yang sesungguhnya.\n - Unknown",
    "Berani merasakan emosi yang dalam adalah tanda kekuatan, bukan kelemahan.\n - Unknown",
    "Pemulihan dari trauma bukanlah proses yang mudah, tapi hasilnya sangat berharga.\n - Unknown",
    "Setiap langkah kecil menuju pemulihan adalah terobosan besar dalam perjalanan kesehatan mental.\n - Unknown",
    "Kesehatan mental adalah hak setiap individu, termasuk mereka yang sedang berjuang melawan trauma.\n - Unknown",
    "Kelemahan bukanlah alasan untuk menyerah, tapi adalah panggilan untuk bangkit dan berjuang lebih keras.\n - Unknown",
    "Trauma bukanlah identitas, tapi hanya sebagian dari perjalanan hidup yang membutuhkan dukungan dan pengertian.\n - Unknown",
    "Mengungkap dan mengekspresikan trauma adalah bentuk keberanian yang tidak boleh diremehkan.\n - Unknown",
    "Menerima bantuan adalah langkah bijaksana, bukan tanda kelemahan.\n - Unknown",
    "Setiap orang memiliki kekuatan untuk pulih dari trauma, meski terkadang butuh waktu dan perjuangan yang besar.\n - Unknown",
    "Kesehatan mental adalah perjalanan, bukan tujuan.\n - Bruce M. Anderson",
    "Kesehatan mental adalah aset utama. Kamu tidak bisa melaksanakan pekerjaan sehari-hari tanpa kesehatan mental yang baik.\n - Arianna Huffington",
    "Penting untuk merawat diri sendiri dari dalam ke luar.\n - Unknown",
    "Yang dibutuhkan oleh kesehatan mental adalah lebih banyak sinar matahari, lebih banyak keterusterangan, dan lebih banyak percakapan tanpa rasa malu.\n - Glenn Close",
    "Kesehatan adalah hak dasar setiap warga negara dan bukan untuk diperjual belikan pemerintah terhadap rakyatnya.\n - Dr. Sp. S.",
    "Masalah kesehatan jiwa tidak menentukan siapa Anda. Melainkan sesuatu yang Anda alami. Anda berjalan di tengah hujan dan Anda merasakan hujan, tetapi Anda bukanlah hujan.\n - Matt Haig",
    "Aku percaya padamu. Anda bukan beban. Kamu tidak akan pernah menjadi beban.\n - Sophie Turner",
    "Anda, diri Anda sendiri, sama seperti siapa pun di seluruh alam semesta, layak mendapatkan cinta dan kasih sayang Anda.\n - Buddha",
    "Kesehatan adalah dasar dari semua nikmat Tuhan, yang tanpanya semua nikmat menjadi kurang utuh.\n - Mario Teguh",
    "Kesehatan mental membutuhkan banyak perhatian. Ini adalah hal yang paling tabu dan harus dihadapi dan ditangani.\n - Adam Ant",
    "Terserah Anda hari ini untuk mulai membuat pilihan-pilihan yang sehat. Bukan pilihan yang hanya sehat untuk tubuh Anda, tapi juga sehat untuk pikiran Anda.\n - Steve Maraboli",
    "Kesehatan adalah kekayaan terbesar yang memberikan nikmat kebahagiaan dan nikmat kebugaran di sepanjang hari.\n - Djajendra",
    "Orang terkuat adalah mereka yang memenangkan pertempuran yang kita tak ketahui tentangnya.\n - Anonim",
    "Kesehatan yang baik bukanlah sesuatu yang dapat kita beli. Namun, sesuatu yang dapat menjadi tabungan yang sangat berharga.\n - Anne Wilson Schaef",
    "Selalu ada harapan, bahkan ketika otak Anda mengatakan tidak ada harapan.\n - John Green",
    "Kebahagiaan dapat ditemukan bahkan di saat-saat tergelap sekalipun, jika kita ingat untuk menyalakan lampunya.\n - Albus Dumbledore",
    "Perawatan diri adalah suatu kebutuhan.\n - Unknown",
    "Kesehatan mental adalah kebahagiaan yang sejati.\n - Unknown",
    "Aku menemukan bahwa dengan depresi, salah satu hal terpenting yang bisa kamu sadari adalah bahwa kamu tidak sendirian. Kamu bukan yang pertama mengalaminya, dan kamu tidak akan menjadi yang terakhir.\n - Dwayne 'The Rock' Johnson"
  ];

  int currentQuoteIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuoteIndex();
  }

  void _loadQuoteIndex() {
    final today = DateTime.now();
    currentQuoteIndex = (today.day - 1) % quotes.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
            quotes[currentQuoteIndex],
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
      ),
    );
  }
}