import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mentioners/JsonModels/users.dart';
import 'package:mentioners/Views/profile.dart';
import 'package:mentioners/Views/sign.dart';
import 'package:mentioners/menu/menu.dart';

import '../SQLite/db_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Our controllers
  //Controller is used to take the value from user and pass it to database
  final usrNameController = TextEditingController();
  final passwordController = TextEditingController();

  String? _passwordErrorText;
  String? _userNameErrorText;

  bool isChecked = false;
  bool isLoginTrue = false;

  bool isVisible = false;

  final db = DatabaseHelper();

  void _validateUsername(String value) {
  if (value.isEmpty) {
    setState(() {
      _userNameErrorText = "Username is required";
    });
  } else {
    DatabaseHelper().getUser(value).then((user) {
      if (user == null) {
        setState(() {
          _userNameErrorText = "Username not found";
        });
        print("Username '$value' not found in database");
      } else {
        setState(() {
          _userNameErrorText = null;
          print("Username '$value' found in database");
        });
      }
    }).catchError((error) {
      setState(() {
        _userNameErrorText = "Error occurred while checking username";
      });
      print("Error occurred while checking username: $error");
    });
  }
}

login() async {
  if (formKey.currentState!.validate()) {
    // Validasi form sebelum melakukan login
    _validateUsername(usrNameController.text); // Memanggil validasi untuk bidang username
    var res = await db.authenticate(Users(
        usrName: usrNameController.text, password: passwordController.text));
    if (res == true) {
      //If result is correct then go to profile or home
      if (!mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuPage()));
    } else {
      //Otherwise show the error message
      setState(() {
        isLoginTrue = true;
      });
    }
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
                padding: EdgeInsets.all(5),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 170,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/1part2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 12, bottom: 5),
                            padding: EdgeInsets.only(
                                right: 7, left: 11, bottom: 7, top: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(13, 110, 114, 1).withOpacity(.5),
                            ),
                            child: TextFormField(
                              controller: usrNameController,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Username",
                                icon: const Icon(Icons.person),
                                filled: true,
                                fillColor: Color.fromARGB(120, 79, 68, 100),
                                contentPadding: EdgeInsets.only(
                                    top: 20, bottom: 10, left: 10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                              ),
                              onChanged: _validateUsername,
                            ),
                          ),
                          if (_userNameErrorText != null && usrNameController.text.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                _userNameErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 5),
                            padding: EdgeInsets.only(
                                right: 7, left: 11, bottom: 7, top: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(13, 110, 114, 1).withOpacity(.5),
                            ),
                            child: TextFormField(
                              controller: passwordController,
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
                                } else {
                                  setState(() {
                                    _passwordErrorText = null;
                                  });
                                }
                                return null;
                              },
                            ),
                          ),
                          if (_passwordErrorText != null &&
                              passwordController.text.isEmpty) 
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                _passwordErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 50,
                        width: 185,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // Navigator.push(
                                //   context, MaterialPageRoute(
                                //     builder: (context) => MenuPage(),
                                //   )
                                // );
                                login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(13, 110, 114, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account ?',
                          style: TextStyle(
                            color: Color.fromRGBO(7, 67, 69, 1),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen()));
                                },
                            ),
                          ],
                        ),
                      ),
                      if (isLoginTrue && usrNameController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Incorrect username",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      // Different error message for incorrect username
                      if (isLoginTrue && passwordController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Incorrect Password",
                            style: TextStyle(color: Colors.red),
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
