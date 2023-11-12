// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:games/admin/listview_adapter_admin.dart';
import 'package:games/quiz/alledit_adapter_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class alledit_quiz extends StatefulWidget {
  const alledit_quiz({super.key});
  @override
  State<alledit_quiz> createState() => _alledit_quizState();
}

class _alledit_quizState extends State<alledit_quiz> {
//----------------------------------- เรียก Admin ปัจจุบัน--------------------------------//
  String Email = "";
  String Name = "";
  String idclass = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Email = preferences.getString('Email');
      Name = preferences.getString('Name');
      idclass = preferences.getString('idclass');
      getallEditquiz();
    });
  }

//---------------------------------------------------------------------------------------//
//--------------------ฟังก์ชันส่ง edit ของ Admin นั้้นๆมาแสดง-----------------------------------//
  List editquiz = [];
  Future getallEditquiz() async {
    final queryParams = {
      'Email': Email.toString(),
      'idclass': idclass.toString()
    };
    //เปลี่ยน
    var url = Uri.parse('http://172.20.10.2/games/edit_quiz.php');
    var response = await http.get(url.replace(queryParameters: queryParams));
    //เปลี่ยน
    if (response.statusCode == 200) {
      setState(() {
        editquiz = jsonDecode(response.body);
      });
      return editquiz;
    }
  }

//---------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    getEmail();
  }

//-------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 130, 0, 0),
              child: Name == ''
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
            ),
//-------------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//-------------------------------------------------------------------------------------//
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                'Edit question and answer ',
                style: TextStyle(
                  fontFamily: 'Ambit',
                  fontSize: 20,
                  color: Color(0xff414c79),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
//-------------------------------------------------------------------------------------//
            Container(
              height: 700,
              child: ListView.builder(
                itemCount: editquiz.length,
                itemBuilder: (context, index) {
                  String Questionstext =
                      editquiz[index]['Questions_text'].toString();
                  String Questionsid =
                      editquiz[index]['Id_Questions'].toString();
                  return alledit_adapter_quiz(
                      child: Questionstext, childs: Questionsid);
                },
              ),
            ),
//-------------------------------------------------------------------------------------//
          ],
        ),
      ),
    );
  }
}
