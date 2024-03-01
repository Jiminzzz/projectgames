// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:games/admin/login_admin.dart';
import 'package:games/admin/proflie_adapter_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class edit_profile_admin extends StatefulWidget {
  const edit_profile_admin({super.key});
  @override
  State<edit_profile_admin> createState() => _edit_profile_adminState();
}

class _edit_profile_adminState extends State<edit_profile_admin> {
  TextEditingController code_name = TextEditingController();

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

//----------------------------------เรียก Admin ปัจจุบัน -----------------------------------------------//
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

//--------------------------------------------------------------------------------------------------//
//------------------------------------ฟังก์ชัน logout ออกจากระบบ--------------------------------------//
  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('Email');
    preferences.remove('usertype');

    Fluttertoast.showToast(
      backgroundColor: Colors.green,
      textColor: Colors.white,
      msg: 'Logout Successful',
      toastLength: Toast.LENGTH_SHORT,
    );
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => login_admin(),
        ));
  }

//--------------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    getallclassroom();
    getEmail();
  }

//--------------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
//--------------------------------------------------------------------------------------------------//
                  SizedBox(
                    height: 30,
                  ),
//--------------------------------------------------------------------------------------------------//
                  Row(
                    children: [
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
                      // GestureDetector(
                      //   onTap: () {
                      //     logout(context);
                      //   },
                      //   child: Container(
                      //     child: Padding(
                      //       padding: const EdgeInsets.fromLTRB(170, 0, 0, 0),
                      //       child: Image.asset(
                      //         'assets/img/logout.png',
                      //         width: 30,
                      //         fit: BoxFit.fitWidth,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
//-------------------------------------------------------------------------------------//
                  SizedBox(
                    height: 25,
                  ),
//-------------------------------------------------------------------------------------//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      'Edit profile admin ',
                      style: TextStyle(
                        fontFamily: 'Ambit',
                        fontSize: 20,
                        color: Color(0xff414c79),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

//--------------------------------------------------------------------------------------------------//
                  SizedBox(
                    height: 30,
                  ),
//--------------------------------------------------------------------------------------------------//
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xff5a81ba),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //--------------------------------------------------------------------------------///
                        const SizedBox(
                          height: 15,
                        ),
                        //--------------------------------------------------------------------------------///
                        Padding(
                          padding: EdgeInsetsDirectional.all(10),
                          child: TextField(
                            controller: code_name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
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
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                            ),
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
                            controller: code_name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              hintText: 'Teacher ID',
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
                                // onTap: createclass_admin,
                                child: const Text(
                                  "Create ",
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
                        ),
                      ],
                    ),
                  ),
//--------------------------------------------------------------------------------------------------//
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
