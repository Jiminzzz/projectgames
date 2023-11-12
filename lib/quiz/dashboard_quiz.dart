import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:games/quiz/create_quiz.dart';
import 'package:games/quiz/alledit_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class dashboard_quiz extends StatefulWidget {
  const dashboard_quiz({super.key});

  @override
  State<dashboard_quiz> createState() => _dashboard_quizState();
}

class _dashboard_quizState extends State<dashboard_quiz> {
  //--------------------------------------------------------------------------------//
  String Email = "";
  String Name = "";
  String idclass = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Name = preferences.getString('Name');
      Email = preferences.getString('Email');
      idclass = preferences.getString('idclass');
    });
  }

//--------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    getEmail();
  }

//--------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("dashboard_admin")),
      backgroundColor: const Color(0xffffffff),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//--------------------------------------------------------------------------------//
              SizedBox(
                height: 100,
              ),
//-------------------------------text headder admin-------------------------------//
              Name == ''
                  ? Text('')
                  : Text(
                      (Name),
                      style: TextStyle(
                        fontFamily: 'Ambit',
                        fontSize: 42,
                        color: Color(0xff778bd9),
                        fontWeight: FontWeight.w700,
                        height: 0.47619047619047616,
                      ),
                    ),
//--------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
//----------------------------เชค id class ว่าตรงกันมั้ย-------------------------------//
              // idclass == ''
              //     ? Text('')
              //     : Text(
              //         (idclass),
              //         style: TextStyle(
              //           fontFamily: 'Ambit',
              //           fontSize: 20,
              //           color: Color(0xff414c79),
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
//----------------------------text Edit question and answer-----------------------//
              Text(
                'Edit question and answer  ',
                style: TextStyle(
                  fontFamily: 'Ambit',
                  fontSize: 20,
                  color: Color(0xff414c79),
                  fontWeight: FontWeight.w700,
                ),
              ),
//--------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
//---------------------------ปุ่มเชื่อมไปหน้าสรา้งคำถาม------------------------------//
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const create_quiz(),
                    ),
                  );
                },
//------------------------text ในปุ่มเชื่อมไปหน้าสร้างคำถาม ----------------------//
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 100, 138, 194),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(26),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                        child: const Text(
                          "Create question \nand answer",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(75, 0, 0, 0),
                        child: Image.asset(
                          'assets/img/plus.png',
                          width: 60,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//--------------------------------------------------------------------------------//
              SizedBox(
                height: 20,
              ),
//----------------------------ปุ่มเชื่อมไปหน้าแก้ไขคำถาม--------------------------------//
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const alledit_quiz(),
                    ),
                  );
                },
//-------------------------text เชื่อมไปหน้าแก่ไขคำถาม-------------------------------//
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 100, 138, 194),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(26),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                        child: Image.asset(
                          'assets/img/edit.png',
                          width: 60,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(95, 0, 0, 10),
                        child: const Text(
                          "Edit question \nand answer",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//--------------------------------------------------------------------------------//
            ],
          ),
        ),
      ),
    );
  }
}
