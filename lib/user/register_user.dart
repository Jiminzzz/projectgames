import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:games/user/login_user.dart';

class register_user extends StatefulWidget {
  const register_user({super.key});
  @override
  State<register_user> createState() => _register_userState();
}

class _register_userState extends State<register_user> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
//------------------------------ฟังก์ชัน Register_user-----------------------------------------//
  Future Register_user() async {
    var url = 'http://172.20.10.2/games/register.php';
    var response = await http.post(url, body: {
      "Name": name.text.toString(),
      "Email": user.text.toString(),
      "Passwords": pass.text.toString(),
      "User_Type": "User",
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'User already exit!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Registration Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    }
  }

//----------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//----------------------------------------------------------------------------------------//
            Text(
              'Register',
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
//--------------------------------------------------------------------------------------------------------------//
            const SizedBox(
              height: 25,
            ),
//----------------------------------------------------------------------------------------//
            TextField(
              controller: user,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                hintText: 'Email',
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
                  onTap: Register_user,
                  child: const Text(
                    "Register",
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
          ],
        ),
      ),
    );
  }
}
