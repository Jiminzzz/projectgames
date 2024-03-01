import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class create_quiz extends StatefulWidget {
  const create_quiz({super.key});

  @override
  State<create_quiz> createState() => _create_quizState();
}

class _create_quizState extends State<create_quiz> {
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
  String Email = "";
  String idclass = "";
  String Name = "";
  //---------------------------------------------------------------------------------------------//
  File? image;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  //------------------------------------------ฟังก์ชันถ่ายรูปทีละรูป--------------------------------------------------------------------//
  Future pickcamera1(int img) async {
    try {
      var imageflie = await ImagePicker.pickImage(source: ImageSource.camera);
      //  var imageflie = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (img == 1) {
          image = new File(imageflie.path);
        } else if (img == 2) {
          image1 = new File(imageflie.path);
        } else if (img == 3) {
          image2 = new File(imageflie.path);
        } else if (img == 4) {
          image3 = new File(imageflie.path);
        } else if (img == 5) {
          image4 = new File(imageflie.path);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

//-----------------------------------Create Answer ฟังก์ชันสร้างคำตอบ ---------------------------------------------//
  Future CreateAns(int questid) async {
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
        msg: 'Build failed, something has problem occurred.!',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    // Navigator.pop(context);
  }

//------------------------------------------------------------------------------------------------------------------------------//
  Future<void> CreateAnstest(int questid) async {
    List<File> imageFiles = [image!, image1!, image2!, image3!, image4!];
    var url = 'http://172.20.10.2/games/create_answer2.php';
    var request = http.MultipartRequest("POST", Uri.parse(url));

    // Add text data
    request.fields['Questions_id'] = questid.toString();
    request.fields['Answer1'] = ans1.text.toString();
    request.fields['Answer2'] = ans2.text.toString();
    request.fields['Answer3'] = ans3.text.toString();
    request.fields['Answer4'] = ans4.text.toString();
    request.fields['Status1'] = status1.toString();
    request.fields['Status2'] = status2.toString();
    request.fields['Status3'] = status3.toString();
    request.fields['Status4'] = status4.toString();

    // Add image files
    for (var imageFile in imageFiles) {
      var stream = http.ByteStream(imageFile.openRead())..cast();
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('images[]', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      if (data == "Success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Add Answer Successfully!',
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Build failed, something has problem occurred!',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Failed to connect to server!',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  //---------------------------------Create Question ฟังก์ชันสร้างคำถาม เลเวล คะแนน-------------------------------------------------//
  Future CreateQuest() async {
    var url = 'http://172.20.10.2/games/create_question.php';
    var response = await http.post(url, body: {
      "Questions_text": quest.text.toString(),
      "Score": score.text.toString(),
      "Level": level.text.toString(),
      "Id_Class": idclass.toString()
    });
    var data = json.decode(response.body);
    print(data);
    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'Build failed, something has problem occurred.!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      int qid = int.parse(data.toString());
      //CreateAns(qid); //questions id
      CreateAnstest(qid);
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'add Question Successfully!',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  //--------------------------------------------------------------------------------//
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Email = preferences.getString('Email');
      idclass = preferences.getString('idclass');
      Name = preferences.getString('Name');
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
                        hintText: 'Question',
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
                    child: GestureDetector(
                      onTap: () {
                        pickcamera1(1);
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: image != null
                              ? Image.file(image!)
                              : Image.asset(
                                  'assets/img/image-gallery.png',
                                  width: 100,
                                  fit: BoxFit.fitWidth,
                                ),
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
                        hintText: 'Answer 1',
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
                    child: GestureDetector(
                      onTap: () {
                        pickcamera1(2);
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: image1 != null
                              ? Image.file(image1!)
                              : Image.asset(
                                  'assets/img/image-gallery.png',
                                  width: 100,
                                  fit: BoxFit.fitWidth,
                                ),
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
                        hintText: 'Answer 2',
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
                    child: GestureDetector(
                      onTap: () {
                        pickcamera1(3);
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: image2 != null
                              ? Image.file(image2!)
                              : Image.asset(
                                  'assets/img/image-gallery.png',
                                  width: 100,
                                  fit: BoxFit.fitWidth,
                                ),
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
                        hintText: 'Answer 3',
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
                    child: GestureDetector(
                      onTap: () {
                        pickcamera1(4);
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: image3 != null
                              ? Image.file(image3!)
                              : Image.asset(
                                  'assets/img/image-gallery.png',
                                  width: 100,
                                  fit: BoxFit.fitWidth,
                                ),
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
                        hintText: 'Answer 4',
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
                    child: GestureDetector(
                      onTap: () {
                        pickcamera1(5);
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: image4 != null
                              ? Image.file(image4!)
                              : Image.asset(
                                  'assets/img/image-gallery.png',
                                  width: 100,
                                  fit: BoxFit.fitWidth,
                                ),
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
                        hintText: 'Create level',
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
                        hintText: 'Create Score',
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
                onTap: CreateQuest,
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
