import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:games/user/register_user.dart';
import 'package:games/user/tabbar_user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:games/user/dashboard_user.dart';
import 'package:games/admin/login_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_user extends StatefulWidget {
  const login_user({super.key});
  @override
  State<login_user> createState() => _login_userState();
}

class _login_userState extends State<login_user> {
  TextEditingController name = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

//-------------------------------------ฟังก์ชัน Login_user -----------------------------------//
  Future Login_user() async {
    var url = 'http://172.20.10.2/games/login_user.php';
    var response = await http.post(url, body: {
      "Name": name.text,
      "Email": user.text,
      "Passwords": pass.text,
    });
    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("Name", name.text);
      preferences.setString("Email", user.text);
      preferences.setString("usertype", "User");
//----------------------------------------------------------------------------------------//
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const tabbar_user(),
        ),
      );
//----------------------------------------------------------------------------------------//
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

//----------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        child: SingleChildScrollView(
          // padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          padding: EdgeInsets.fromLTRB(30, 130, 30, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //----------------------------------------------------------------------------------------//
              // ignore: prefer_const_constructors
              Text(
                'Log In',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  color: const Color(0xff778bd9),
                  fontWeight: FontWeight.w700,
                  height: 0.5666666666666667,
                ),
              ),
              //----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 50,
              ),
              //----------------------------------------------------------------------------------------//
              TextField(
                controller: name,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Color(0x80414c79),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: const BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 25,
              ),
              //-----------------------------------------------------------------------------------//
              TextField(
                controller: user,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  hintText: 'Email / Username',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Color(0x80414c79),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: const BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
              //----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 25,
              ),
              //----------------------------------------------------------------------------------------//
              TextField(
                controller: pass,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Color(0x80414c79),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: const BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
              //----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 25,
              ),
              //----------------------------------------------------------------------------------------//
              Container(
                height: 40,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: const Color(0xff778bd9),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(26),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xcc778bd9),
                      offset: Offset(0, 6),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: Login_user,
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
              //----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 15,
              ),
              //----------------------------------------------------------------------------------------//
              const Text(
                'or',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Color(0xff778bd9),
                  fontWeight: FontWeight.w700,
                  height: 0.9444444444444444,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                softWrap: false,
              ),
              //----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 15,
              ),
              //----------------------------------------------------------------------------------------//
              Container(
                height: 40,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: const Color(0xffd97787),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(26),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xccd97792),
                      offset: Offset(0, 6),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Center(
                  // onTap: login,
                  child: const Text(
                    "google",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              //----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 25,
              ),
              //----------------------------------------------------------------------------------------//
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const login_admin(),
                      ),
                    );
                  },
                  child: Text(
                    'login admin?',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: const Color(0x80414c79),
                      height: 1.2142857142857142,
                    ),
                  ),
                ),
              ),
              //----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 50,
              ),
              //----------------------------------------------------------------------------------------//
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const register_user(),
                    ),
                  );
                },
                child: const Text(
                  'Register Here',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Color(0xff778bd9),
                    fontWeight: FontWeight.w700,
                    height: 0.9444444444444444,
                  ),
                ),
              )
              //----------------------------------------------------------------------------------------//
            ],
          ),
        ),
      ),
    );
  }
}
