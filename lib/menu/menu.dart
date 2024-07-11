import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ikchatbot/ikchatbot.dart';
import 'package:mentioners/education/halaman_education.dart';
import 'package:mentioners/selfCare_schedule/selfCare_schedule.dart';
import 'package:mentioners/chatBot/keywords_respons.dart';
import 'package:mentioners/chatbot/chatbot.dart';
import 'package:mentioners/chatbot/ike_chatbot_config.dart' as local;
import 'package:mentioners/education/video_education.dart';
import 'package:mentioners/hars/hars.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        bool exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Konfirmasi'),
            content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Tidak', style: TextStyle(color: const Color.fromRGBO(60, 135, 124, 1))),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Ya', style: TextStyle(color: const Color.fromRGBO(60, 135, 124, 1))),
              ),
            ],
          ),
        );
        if (exit) {
          // Exit the app if the user confirms
          Future.delayed(Duration.zero, () {
            SystemNavigator.pop();
          });
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg_mentioners.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 4.0),
                      child: Container(
                        height: 100,
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/3part2.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 20.0),
                      child: Container(
                        height: 100,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              'MENTIONERS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(60, 135, 124, 1),
                      ),
                      width: 100,
                      height: 150,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/Menu1.png'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Container(
                          color: const Color.fromRGBO(60, 135, 124, 1),
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'MENTIONERS',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: const Color.fromRGBO(60, 135, 124, 1),
                          height: 100,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '"Baru setelah kita tersesat, kita mulai \n memahami diri kita sendiri." \n -Henry David Thoreau \n "Dan tetap saja, aku bangkit" \n -Maya Angelou',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Row 3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelfCareSchedule()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(60, 135, 124, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(4.0),
                            width: 150,
                            height: 150,
                            child: Center(
                              child: Image.asset(
                                'assets/Menu2.png',
                                width: 0.8 * 150,
                                height: 0.8 * 150,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'SelfCare-Schedule',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeEducation()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(60, 135, 124, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(4.0),
                            width: 150,
                            height: 150,
                            child: Center(
                              child: Image.asset(
                                'assets/Menu3.png',
                                width: 0.8 * 150,
                                height: 0.8 * 150,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Education',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Row 4
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatBot(
                                  config: local.IkChatBotConfig(
                                    keywords: keywords,
                                    responses: responses,
                                    backgroundColor: Colors.white,
                                    backgroundImageAsset:
                                        'assets/bg_mentioners.png',
                                    backgroundImageUrl:
                                        'https://i.pinimg.com/736x/d2/bf/d3/d2bfd3ea45910c01255ae022181148c4.jpg',
                                    initialGreeting:
                                        '''Hallo, \nSelamat datang di Mentioners \nBagaimana kabar mu hari ini ? \nPilih jawaban: \n> baik/buruk''',
                                    defaultResponse:
                                        "Maaf, Aku tidak paham apa yang kamu maksud",
                                    inactivityMessage: 'Kamu tidak aktif dalam beberapa waktu, \nsepertinya kamu sedang ada kegiatan... \nSilahkan datang lagi kembali, \naku akan menunggumu😊',
                                    closingMessage:
                                        "Percakapan ini telah berakhir.",
                                    inputHint: 'Kirim Pesan',
                                    botChatColor: const Color(0xFF3C877C),
                                    userChatColor:
                                        Color.fromARGB(255, 239, 239, 239),
                                    waitingTime: 1,
                                    closingTime: 1,
                                    delayResponse: 1,
                                    botIcon: const Icon(Icons.android,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    userIcon: const Icon(Icons.person,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(60, 135, 124, 1),
                                borderRadius: BorderRadius.circular(10.0)),
                            width: 150,
                            height: 150,
                            child: Center(
                              child: Image.asset(
                                'assets/Menu4.png',
                                width: 0.8 * 150,
                                height: 0.8 * 150,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'ChatBot',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Hars()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(60, 135, 124, 1),
                                borderRadius: BorderRadius.circular(10.0)),
                            width: 150,
                            height: 150,
                            child: Center(
                              child: Image.asset(
                                'assets/Menu5.png',
                                width: 0.8 * 150,
                                height: 0.8 * 150,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'HARS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
