import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:games/user/listview_adapter_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:games/user/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:games/admin/listview_adapter_admin.dart';

class dashboard_user extends StatefulWidget {
  const dashboard_user({super.key});
  @override
  State<dashboard_user> createState() => _dashboard_userState();
}

class _dashboard_userState extends State<dashboard_user> {
  TextEditingController Id_Class = TextEditingController();
//--------------------------------------เรียก User มาแสดง---------------------------------------//
  String Name = "";
  String Email = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Email = preferences.getString('Email');
      Name = preferences.getString('Name');
      getallclassroom();
    });
  }

//---------------------------------------------------------------------------------------------//
//--------------------------------ฟังก์ชัน join classroom-----------------------------------------//
  Future joinclass_user() async {
    var url = 'http://172.20.10.2/games/joinclass_user.php';
    var response = await http.post(url, body: {
      "Email": Email.toString(),
      "Id_Class": Id_Class.text.toString(),
    });
    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'join classroom Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'join failed, something has problem occurred.!',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

//----------------------------------เรียก User ปัจจุบัน -----------------------------------------------//
  List classroom = [];
  Future getallclassroom() async {
    final queryParams = {'Email': Email.toString()};
    //เปลี่ยน
    var url = Uri.parse('http://172.20.10.2/games/listview_user.php');
    var response = await http.get(url.replace(queryParameters: queryParams));
    //เปลี่ยน
    if (response.statusCode == 200) {
      setState(() {
        classroom = jsonDecode(response.body);
      });
      return classroom;
    }
  }

//--------------------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    getEmail();
  }

//------------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("dashboard_user")),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//--------------------------------------------------------------------------------------//
                SizedBox(
                  height: 100,
                ),
//--------------------------------------------------------------------------------------//
                Text(
                  ('User'),
                  style: TextStyle(
                    fontFamily: 'Ambit',
                    fontSize: 42,
                    color: Color(0xff778bd9),
                    fontWeight: FontWeight.w700,
                    height: 0.47619047619047616,
                  ),
                ),
//--------------------------------------------------------------------------------------//
                SizedBox(
                  height: 25,
                ),
//--------------------------------------------------------------------------------------//
                Text(
                  'Join classroom',
                  style: TextStyle(
                    fontFamily: 'Ambit',
                    fontSize: 20,
                    color: Color(0xff414c79),
                    fontWeight: FontWeight.w700,
                  ),
                ),
//--------------------------------------------------------------------------------------//
                SizedBox(
                  height: 25,
                ),
//--------------------------------------------------------------------------------------//
                Container(
                  height: 215,
                  decoration: BoxDecoration(
                    color: const Color(0xff5a81ba),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
//--------------------------------------------------------------------------------------//
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
//--------------------------------------------------------------------------------------//
                      Container(
                        height: 50,
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 100, 138, 194),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(26),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 78, 121, 185),
                              offset: Offset(0, 6),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: const Text(
                                "join classroom",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(155, 0, 0, 0),
                              child: Image.asset(
                                'assets/img/plus.png',
                                width: 35,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                      ),
//--------------------------------------------------------------------------------------//
                      const SizedBox(
                        height: 15,
                      ),
//--------------------------------------------------------------------------------------//
                      Padding(
                        padding: EdgeInsetsDirectional.all(10),
                        child: TextField(
                          controller: Id_Class,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            hintText: 'codeclass',
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
//--------------------------------------------------------------------------------------//
                      const SizedBox(
                        height: 0,
                      ),
//--------------------------------------------------------------------------------------//
                      Padding(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Container(
                          height: 50,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            color: Color(0xff778bd9),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(26),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 78, 121, 185),
                                offset: Offset(0, 6),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: joinclass_user,
                              child: const Text(
                                "join classroom",
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
                    ],
                  ),
                ),
//--------------------------------------------------------------------------------------//
                Container(
                  height: 700,
                  child: ListView.builder(
                    itemCount: classroom.length,
                    itemBuilder: (context, index) {
                      String classname =
                          classroom[index]['Name_Class'].toString();
                      return listview_adapter_user(child: classname);
                    },
                  ),
                ),
//--------------------------------------------------------------------------------------//
              ],
            ),
          ),
        ),
      ),
    );
  }
}
