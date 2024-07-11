import 'package:flutter/material.dart';
import 'package:mentioners/Views/login.dart';
import 'package:mentioners/Views/sign.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF84BDBD),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Memposisikan Column ke tengah secara vertical
                children: [
                  Text(
                    'WELCOME TO \nMENTIONERS',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    textAlign:
                        TextAlign.center, // Mengatur teks menjadi rata tengah
                  ),
                  Image.asset(
                    'assets/2part2.png',
                    width: 160,
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 200,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xFFE3B34C), // Warna teks putih
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600), // Ukuran teks
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  SizedBox(
                    width: 200,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF3C877C), // Warna teks putih
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600), // Ukuran teks
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: -70,
                left: -55,
                child: SizedBox(
                  // Wrap dalam SizedBox agar tetap dalam posisi relatif terhadap parent Stack
                  width: 200,
                  height: 280,
                  child: Image.asset(
                    'assets/5part2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -58,
                right: -115,
                child: SizedBox(
                  // Wrap dalam SizedBox agar tetap dalam posisi relatif terhadap parent Stack
                  width: 300,
                  height: 270,
                  child: Image.asset(
                    'assets/4part2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  // Wrap dalam SizedBox agar tetap dalam posisi relatif terhadap parent Stack
                  width: 250,
                  height: MediaQuery.of(context).size.height * 0.43,
                  child: Image.asset(
                    'assets/3part2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
