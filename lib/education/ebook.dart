import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentioners/education/webview.dart';

class EBook extends StatefulWidget {
  const EBook({super.key});

  @override
  State<EBook> createState() => _EBookState();
}

class _EBookState extends State<EBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF84BDBD)
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'BUKU INI DIBUAT\nKHUSUS UNTUK KAMU!!\nYUK KEPOIN ISINYA >>',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF3C877C)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: WebView(),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}