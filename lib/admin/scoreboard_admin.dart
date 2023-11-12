import 'package:flutter/material.dart';
import 'package:games/quiz/dashboard_quiz.dart';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:games/admin/scoreboard_adapter_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class scoreboard_admin extends StatefulWidget {
  const scoreboard_admin({super.key});
  @override
  State<scoreboard_admin> createState() => _scoreboard_adminState();
}

class _scoreboard_adminState extends State<scoreboard_admin> {
  //--------------------------------------------เรียก Admin -------------------------------------------------------//
  String Email = "";
  String Name = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Email = preferences.getString('Email');
      Name = preferences.getString('Name');
      getallclassroom();
    });
  }

//--------------------------------------------------------------------------------------------------------------//
//---------------------------------ฟังก์ชันเรียก classroom ของ Admin นั้้นๆมาแสดง--------------------------------------//
  List classroom = [];

  Future getallclassroom() async {
    final queryParams = {'Email': Email.toString()};
    //เปลี่ยน
    var url = Uri.parse('http://172.20.10.2/games/listview_admin.php');
    var response = await http.get(url.replace(queryParameters: queryParams));
    //เปลี่ยน
    if (response.statusCode == 200) {
      setState(() {
        classroom = jsonDecode(response.body);
      });
      return classroom;
    }
  }

//--------------------------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    getEmail();
  }

//--------------------------------------------------------------------------------------------------------------//
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
//--------------------------------------------------------------------------------------------------------------//
              SizedBox(
                height: 100,
              ),
//--------------------------------------------------------------------------------------------------------------//
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
//--------------------------------------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
//--------------------------------------------------------------------------------------------------------------//
              Text(
                'Scoreboard',
                style: TextStyle(
                  fontFamily: 'Ambit',
                  fontSize: 20,
                  color: Color(0xff414c79),
                  fontWeight: FontWeight.w700,
                ),
              ),
//--------------------------------------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
//--------------------------------------------------------------------------------------------------------------//
              Container(
                height: 700,
                child: ListView.builder(
                  itemCount: classroom.length,
                  itemBuilder: (context, index) {
                    String classname =
                        classroom[index]['Name_Class'].toString();
                    return scoreboard_adapter_admin(child: classname);
                  },
                ),
              ),
//--------------------------------------------------------------------------------------------------------------//
            ],
          ),
        ),
      ),
    );
  }
}
