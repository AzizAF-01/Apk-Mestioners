import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mentioners/JsonModels/users.dart';
import 'package:mentioners/Views/login.dart';

import '../SQLite/db_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //Controllers
  final fullName = TextEditingController();
  final email = TextEditingController();
  final usrName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final db = DatabaseHelper();
  bool isVisible = false;
  bool isChecked = false;
  String? _passwordErrorText;
  String? _emailErrorText;
  String? _UsernameErrorText;
  String? _confirmpasswordErrorText;

  signUp() async {
    if (email.text.isNotEmpty &&
        usrName.text.isNotEmpty &&
        password.text.isNotEmpty) {
      var res = await db.createUser(Users(
          email: email.text, usrName: usrName.text, password: password.text));
      if (res > 0) {
        if (!mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {
      print(" Email, username, dan password harus diisi");
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_mentioners.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Register New Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: EdgeInsets.only(
                                right: 7, left: 11, bottom: 7, top: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromRGBO(13, 110, 114, 1).withOpacity(.5)),
                            child: TextFormField(
                              controller: email,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(120, 79, 68, 100),
                                contentPadding: EdgeInsets.only(
                                    top: 20, bottom: 10, left: 10),
                                icon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(7.5)),
                                hintText: "Email",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _emailErrorText = "Email is required";
                                  });
                                  // return "";
                                } else {
                                  setState(() {
                                    _emailErrorText = null;
                                  });
                                }
                                return null;
                              },
                            ),
                          ),
                          if (_emailErrorText != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                _emailErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: EdgeInsets.only(
                                right: 7, left: 11, bottom: 7, top: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromRGBO(13, 110, 114, 1).withOpacity(.5)),
                            child: TextFormField(
                              controller: usrName,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(120, 79, 68, 100),
                                contentPadding: EdgeInsets.only(
                                    top: 20, bottom: 10, left: 10),
                                icon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(7.5)),
                                hintText: "Username",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _UsernameErrorText = "Username is required";
                                  });
                                  // return "";
                                } else {
                                  setState(() {
                                    _UsernameErrorText = null;
                                  });
                                }
                                return null;
                              },
                            ),
                          ),
                          if (_UsernameErrorText != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                _UsernameErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: EdgeInsets.only(
                                right: 7, left: 11, bottom: 7, top: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromRGBO(13, 110, 114, 1).withOpacity(.5)),
                            child: TextFormField(
                              controller: password,
                              obscureText: !isVisible,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(120, 79, 68, 100),
                                contentPadding: EdgeInsets.only(
                                    top: 20, bottom: 10, left: 11),
                                icon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(7.5)),
                                hintText: "Password",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _passwordErrorText = "Password is required";
                                  });
                                  // return "";
                                } else {
                                  setState(() {
                                    _passwordErrorText = null;
                                  });
                                }
                                return null;
                              },
                            ),
                          ),
                          if (_passwordErrorText != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                _passwordErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: EdgeInsets.only(
                                right: 7, left: 11, bottom: 7, top: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromRGBO(13, 110, 114, 1).withOpacity(.5)),
                            child: TextFormField(
                              controller: confirmPassword,
                              obscureText: !isVisible,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(120, 79, 68, 100),
                                contentPadding: EdgeInsets.only(
                                    top: 20, bottom: 10, left: 11),
                                icon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(7.5)),
                                hintText: "Confirm Password",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    },
                                    icon: Icon(isChecked
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _confirmpasswordErrorText = "Confirm Password is required";
                                  });
                                  // return "";
                                } else {
                                  setState(() {
                                    _confirmpasswordErrorText = null;
                                  });
                                }
                                return null;
                              },
                            ),
                          ),
                          if (_confirmpasswordErrorText != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                _confirmpasswordErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                signUp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(13, 110, 114, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14))),
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account ?',
                          style: TextStyle(
                            color: Color.fromRGBO(7, 67, 69, 1),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Login',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
