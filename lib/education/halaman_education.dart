import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentioners/education/ebook.dart';
import 'package:mentioners/education/video_education.dart';

class HomeEducation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      Container(
                        padding: EdgeInsets.all(5),
                        width: 125,
                        height: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(60, 135, 124, 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(
                          'assets/Menu3.png',
                          width: 0.8 * 150,
                          height: 0.8 * 150,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Text(
                        'Education',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  height: 64,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF3C877C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Temukan Kebutuhanmu!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFF3C877C).withOpacity(.7),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 17),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EBook()));
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Education_book.png',
                                  width: 0.8 * 150,
                                  height: 0.8 * 150,
                                ),
                                Text(
                                  'E-BOOK',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPlayerPage()));
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Education_video.png',
                                  width: 0.8 * 150,
                                  height: 0.8 * 150,
                                ),
                                Container(
                                  child: Text(
                                    'VIDEO ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
