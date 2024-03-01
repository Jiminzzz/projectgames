import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:games/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:games/quiz/dashboard_quiz.dart';

class edit_quiz extends StatefulWidget {
  const edit_quiz({super.key});

  @override
  State<edit_quiz> createState() => _edit_quizState();
}

class _edit_quizState extends State<edit_quiz> {
  TextEditingController ans1 = TextEditingController();
  TextEditingController ans2 = TextEditingController();
  TextEditingController ans3 = TextEditingController();
  TextEditingController ans4 = TextEditingController();
  TextEditingController quest = TextEditingController();
  TextEditingController score = TextEditingController();
  TextEditingController level = TextEditingController();

  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;

  //--------------------------------------------------------------------------------------------//
  //----------------------------------- เรียก Admin ปัจจุบัน--------------------------------//
  String Email = "";
  String Name = "";
  String idclass = "";
  String idqust = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Email = preferences.getString('Email');
      Name = preferences.getString('Name');
      idclass = preferences.getString('idclass');
      idqust = preferences.getString('idquestion');

      getquestion();
      getanswer();
    });
  }

//-------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------//
  List getquest = [];
  Future getquestion() async {
    final queryParams = {'idquest': idqust.toString()};
    //เปลี่ยน
    var url = Uri.parse('http://172.20.10.2/games/edit_question.php');
    var response = await http.get(url.replace(queryParameters: queryParams));
    //เปลี่ยน
    if (response.statusCode == 200) {
      setState(() {
        getquest = jsonDecode(response.body);
      });
      return getquest;
    }
  }

//-------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------//
  List getans = [];
  Future getanswer() async {
    final queryParams = {'idquest': idqust.toString()};
    //เปลี่ยน
    var url = Uri.parse('http://172.20.10.2/games/edit_answer.php');
    var response = await http.get(url.replace(queryParameters: queryParams));
    //เปลี่ยน
    if (response.statusCode == 200) {
      setState(() {
        getans = jsonDecode(response.body);
        status1 = getans[0]['Answer_type'].toString() != null
            ? getans[0]['Answer_type'].toString().parseBool()
            : false;
        status2 = getans[1]['Answer_type'].toString() != null
            ? getans[1]['Answer_type'].toString().parseBool()
            : false;
        status3 = getans[2]['Answer_type'].toString() != null
            ? getans[2]['Answer_type'].toString().parseBool()
            : false;
        status4 = getans[2]['Answer_type'].toString() != null
            ? getans[2]['Answer_type'].toString().parseBool()
            : false;
      });
      return getans;
    }
  }
//-------------------------------------------------------------------------------------//

//-----------------------------------Create Answer ---------------------------------------------//
  Future EditAns(int questid) async {
    var url = 'http://172.20.10.2/games/create_answer.php';
    var response = await http.post(url, body: {
      "Questions_id": questid.toString(),
      "Answer1": ans1.text.toString(),
      "Answer2": ans2.text.toString(),
      "Answer3": ans3.text.toString(),
      "Answer4": ans4.text.toString(),
      "Status1": status1.toString(),
      "Status2": status2.toString(),
      "Status3": status3.toString(),
      "Status4": status4.toString(),
    });
    var data = json.decode(response.body);

    if (data == "Success") {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'add Answer Successfully!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'error',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    // Navigator.pop(context);
  }

  //---------------------------------Create Question-------------------------------------------------//
  Future EditQuest() async {
    print(getquest.toString());
    // var url = 'http://172.20.10.19/games/create_question.php';
    // var response = await http.post(url, body: {
    //   "Questions_text": quest.text.toString(),
    //   "Score": score.text.toString(),
    //   "Level": level.text.toString(),
    //   "Id_Class": idclass.toString()
    // });
    // var data = json.decode(response.body);
    // print(data);
    // if (data == "Error") {
    //   Fluttertoast.showToast(
    //     backgroundColor: Colors.orange,
    //     textColor: Colors.white,
    //     msg: 'User already exit!',
    //     toastLength: Toast.LENGTH_SHORT,
    //   );
    // } else {
    //   int qid = int.parse(data.toString());
    //   EditAns(qid);
    //   Fluttertoast.showToast(
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     msg: 'add Question Successfully!',
    //     toastLength: Toast.LENGTH_SHORT,
    //   );
    // }
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
//---------------------------text header Admin------------------------------------//
            Text(
              ('Admin'),
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
//---------------------------text Create question and answer----------------------//
            Text(
              'Create question and answer',
              style: TextStyle(
                fontFamily: 'Ambit',
                fontSize: 20,
                color: Color(0xff414c79),
                fontWeight: FontWeight.w700,
              ),
            ),
//-------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//---------------------------------สร้างคำถาม-------------------------------------//
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 5),
                    child: Text(
                      "Create Question",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(
                      controller: quest,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        hintText:
                            getquest[0]['Questions_text'].toString() != null
                                ? getquest[0]['Questions_text'].toString()
                                : "",
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//---------------------------กล่องไว้ import รูปของคำถาม------------------------------//
            Container(
              height: 290,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                    child: Text(
                      "Create Picture Question",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/img/image-gallery.png',
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//-----------------------------------สรา้งคำตอบข้อ 1-----------------------------------//
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 5),
                        child: Text(
                          "Create Answer 1",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 1-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(125, 10, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status1,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status1 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(
                      controller: ans1,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        hintText: getans[0]['Answer_text'].toString() != null
                            ? getans[0]['Answer_text'].toString()
                            : "",
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//---------------------------กล่องไว้ import รูปของคำตอบที่ 1------------------------------//
            Container(
              height: 290,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Text(
                          "Create Picture Answer 1",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 1-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(68, 15, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status1,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status1 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/img/image-gallery.png',
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//-----------------------------------สรา้งคำตอบข้อ2-----------------------------------//
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 5),
                        child: Text(
                          "Create Answer 2",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 2-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(125, 10, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status2,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status2 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(
                      controller: ans2,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        hintText: getans[1]['Answer_text'].toString() != null
                            ? getans[1]['Answer_text'].toString()
                            : "",
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//---------------------------กล่องไว้ import รูปของคำตอบที่ 2------------------------------//
            Container(
              height: 290,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Text(
                          "Create Picture Answer 2",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 2-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(68, 15, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status2,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status2 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/img/image-gallery.png',
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//-----------------------------------สรา้งคำตอบข้อ 3-----------------------------------//
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 5),
                        child: Text(
                          "Create Answer 3",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 3-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(125, 10, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status3,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status3 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(
                      controller: ans3,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        hintText: getans[2]['Answer_text'].toString() != null
                            ? getans[2]['Answer_text'].toString()
                            : "",
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//---------------------------กล่องไว้ import รูปของคำตอบที่ 3------------------------------//
            Container(
              height: 290,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Text(
                          "Create Picture Answer 3",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 3-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(68, 15, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status3,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status3 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/img/image-gallery.png',
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//-----------------------------------สรา้งคำตอบข้อ 4-----------------------------------//
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 5),
                        child: Text(
                          "Create Answer 4",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 4-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(125, 10, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status4,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status4 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(
                      controller: ans4,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        hintText: getans[3]['Answer_text'].toString() != null
                            ? getans[3]['Answer_text'].toString()
                            : "",
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//---------------------------กล่องไว้ import รูปของคำตอบที่ 4------------------------------//
            Container(
              height: 290,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Text(
                          "Create Picture Answer 4",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
//------------------------------ปุ่มเลือกคำตอบข้อ 4-----------------------------//
                      Padding(
                        padding: const EdgeInsets.fromLTRB(68, 15, 0, 0),
                        child: Container(
                          child: FlutterSwitch(
                            activeColor: Color.fromARGB(255, 116, 255, 148),
                            inactiveColor: const Color(0xffd97787),
                            width: 50.5,
                            height: 27.5,
                            valueFontSize: 12.5,
                            toggleSize: 22.5,
                            value: status4,
                            borderRadius: 15,
                            padding: 4,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status4 = val;
                              });
                            },
                          ),
                        ),
                      ),
//---------------------------------------------------------------------------------//
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/img/image-gallery.png',
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//---------------------------------------------------------------------------------//
            Text(
              'Create level',
              style: TextStyle(
                fontFamily: 'Ambit',
                fontSize: 20,
                color: Color(0xff414c79),
                fontWeight: FontWeight.w700,
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//-----------------------------------สรา้งเลเวลคำถามคำตอบ-----------------------------------//
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 5),
                    child: Text(
                      "Create level",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(
                      controller: level,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        hintText: getquest[0]['Level'].toString() != null
                            ? getquest[0]['Level'].toString()
                            : "",
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//------------------------------------------------------------------------------//

            Text(
              'Create Score',
              style: TextStyle(
                fontFamily: 'Ambit',
                fontSize: 20,
                color: Color(0xff414c79),
                fontWeight: FontWeight.w700,
              ),
            ),
//---------------------------------------------------------------------------------//
            SizedBox(
              height: 25,
            ),
//-----------------------------------สรา้งเลเวลคำถามคำตอบ-----------------------------------//
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 138, 194),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 5),
                    child: Text(
                      "Create Score",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: TextField(
                      controller: score,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        hintText: getquest[0]['Score'].toString() != null
                            ? getquest[0]['Score'].toString()
                            : "",
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//------------------------------------------------------------------------------//
            SizedBox(
              height: 50,
            ),
//------------------------------------------------------------------------------//
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: GestureDetector(
                onTap: EditQuest,
                child: Container(
                  height: 50,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    color: Color(0xff778bd9),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(26),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      // onTap: CreateQuest,
                      child: const Text(
                        "CONFIM",
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
              ),
            ),
//------------------------------------------------------------------------------//
            SizedBox(
              height: 50,
            ),
//---------------------------------------------------------------------------------//
          ],
        )),
      ),
    );
  }
}
