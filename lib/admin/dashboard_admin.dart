import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:games/admin/login_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:games/user/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:games/admin/listview_adapter_admin.dart';

class dashboard_admin extends StatefulWidget {
  const dashboard_admin({super.key});
  @override
  State<dashboard_admin> createState() => _dashboard_adminState();
}

class _dashboard_adminState extends State<dashboard_admin> {
  TextEditingController Id_Class = TextEditingController();
  TextEditingController Name_Class = TextEditingController();

//----------------------------------- เรียก Admin ปัจจุบัน--------------------------------//
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

//------------------------------------------------------------------------------------//
//-------------------ฟังก์ชันเรียก classroom ของ Admin นั้้นๆมาแสดง---------------------------//
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

//-------------------------------------------------------------------------------------//
//----------------------------ฟังชั้นก์สร้าง classroom--------------------------------------//
  Future createclass_admin() async {
    var url = 'http://172.20.10.2/games/createclass_admin.php';
    var response = await http.post(url, body: {
      "Email": Email.toString(),
      "Id_Class": Id_Class.text.toString(),
      "Name_Class": Name_Class.text.toString(),
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'Build failed, something has problem occurred.!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Create classroom Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  //------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    getEmail();
  }

  //------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("dashboard_admin")),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //----------------------------------------------------------------------------------//
              SizedBox(
                height: 100,
              ),
              //------------------------------เรียก Admin ปัจุบันมาแสดง------------------------------//
              Padding(
                padding: EdgeInsets.all(0),
                child: Name == ''
                    ? Text('')
                    : Text(
                        (Name),
                        style: TextStyle(
                          fontSize: 42,
                          color: Color(0xff778bd9),
                          fontWeight: FontWeight.w700,
                          height: 0.47619047619047616,
                        ),
                      ),
              ),
              //--------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
              //---------------------------hadder Create classroom------------------------------//
              Text(
                'Create classroom',
                style: TextStyle(
                  fontFamily: 'Ambit',
                  fontSize: 20,
                  color: Color(0xff414c79),
                  fontWeight: FontWeight.w700,
                ),
              ),
              //--------------------------------------------------------------------------------///
              SizedBox(
                height: 25,
              ),
              //--------------------------------------------------------------------------------///
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: const Color(0xff5a81ba),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                              "Create classroom",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(135, 0, 0, 0),
                            child: Image.asset(
                              'assets/img/plus.png',
                              width: 35,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //--------------------------------------------------------------------------------///
                    const SizedBox(
                      height: 15,
                    ),
                    //--------------------------------------------------------------------------------///
                    Padding(
                      padding: EdgeInsetsDirectional.all(10),
                      child: TextField(
                        controller: Name_Class,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: InputDecoration(
                          hintText: 'Nameclass',
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
                    //--------------------------------------------------------------------------------///
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
                    //--------------------------------------------------------------------------------///
                    const SizedBox(
                      height: 0,
                    ),
                    //--------------------------------------------------------------------------------///
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
                            onTap: createclass_admin,
                            child: const Text(
                              "Create classroom",
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
              //--------------------------------------------------------------------------------///
              Container(
                height: 700,
                child: ListView.builder(
                  itemCount: classroom.length,
                  itemBuilder: (context, index) {
                    String classname =
                        classroom[index]['Name_Class'].toString();
                    String id_class = classroom[index]['Id_Class'].toString();
                    return listview_adapter_admin(
                        child: classname, idclass: id_class);
                  },
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
