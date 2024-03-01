import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:games/admin/GoogleSignInApi.dart';
import 'package:games/admin/register_admin.dart';
import 'package:games/admin/tabbar_admin.dart';
import 'package:games/user/login_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:games/admin/dashboard_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_admin extends StatefulWidget {
  const login_admin({super.key});
  @override
  State<login_admin> createState() => _login_adminState();
}

class _login_adminState extends State<login_admin> {
  TextEditingController name = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
//---------------------------------ฟังก์ชั้น login--------------------------------------------//
  Future Login_admin() async {
    var url =
        'http://172.20.10.2/games/login_admin.php'; //(อย่าลืมเปลี่ยน ipasdress ใน ipconfig เสมอ)
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
      preferences.setString("Email", user.text); //ส่ง Email
      preferences.setString("usertype", "Admin"); //ส่ง type Admin

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const tabbar_admin(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid or you are not an admin',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

//-----------------------------------------------------------------------------------//
  // Future signingoogle() async {
  //   await GoogleSignInApi.login();
  // }
//-----------------------------------------------------------------------------------//
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
              //-----------------------------------------------------------------------------------//
              Text(
                'Log In Admin',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  color: const Color(0xff778bd9),
                  fontWeight: FontWeight.w700,
                  height: 0.5666666666666667,
                ),
              ),
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 50,
              ),
              //-----------------------------------------------------------------------------------//
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
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 25,
              ),
              //-----------------------------------------------------------------------------------//
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
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 25,
              ),
              //-----------------------------------------------------------------------------------//
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
                    onTap: Login_admin,
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
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 15,
              ),
              //-----------------------------------------------------------------------------------//
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
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 15,
              ),
              //-----------------------------------------------------------------------------------//
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
                child: GestureDetector(
                  onTap: () {
                    // signingoogle();
                  },
                  child: Center(
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
              ),
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 25,
              ),
              //-----------------------------------------------------------------------------------//
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const login_user(),
                      ),
                    );
                  },
                  child: Text(
                    'login user?',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: const Color(0x80414c79),
                      height: 1.2142857142857142,
                    ),
                  ),
                ),
              ),
              //-----------------------------------------------------------------------------------//
              const SizedBox(
                height: 50,
              ),
              //-----------------------------------------------------------------------------------//
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const register_admin(),
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
              //-----------------------------------------------------------------------------------//
            ],
          ),
        ),
      ),
    );
  }
}
