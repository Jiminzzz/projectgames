// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:games/admin/login_admin.dart';
import 'package:games/admin/proflie_adapter_admin.dart';
import 'package:games/user/login_user.dart';
import 'package:games/user/proflie_adapter_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile_user extends StatefulWidget {
  const profile_user({super.key});
  @override
  State<profile_user> createState() => _profile_userState();
}

class _profile_userState extends State<profile_user> {
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
          builder: (context) => login_user(),
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
                      GestureDetector(
                        onTap: () {
                          logout(context);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(220, 0, 0, 0),
                            child: Image.asset(
                              'assets/img/logout.png',
                              width: 30,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
//--------------------------------------------------------------------------------------------------//
                  SizedBox(
                    height: 22,
                  ),
//--------------------------------------------------------------------------------------------------//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      height: height * 0.3,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double innerHeight = constraints.maxHeight;
                          double innerWidth = constraints.maxWidth;
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    height: innerHeight * 0.72,
                                    width: innerWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xff5a81ba),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
//--------------------------------------------------------------------------------------------------//
                                        SizedBox(
                                          height: 50,
                                        ),
//--------------------------------------------------------------------------------------------------//
                                        // ignore: prefer_const_constructors
                                        Center(
                                          child: Text(
                                            'Username',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  247, 247, 247, 1),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
//--------------------------------------------------------------------------------------------------//
                                        SizedBox(
                                          height: 5,
                                        ),
//--------------------------------------------------------------------------------------------------//
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
//--------------------------------------------------------------------------------------------------//
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 10, 5),
                                                  child: Text(
                                                    'Student  ID',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
//--------------------------------------------------------------------------------------------------//
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 5),
                                                  child: Text(
                                                    'xxxxxxxxxxxxx',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
//--------------------------------------------------------------------------------------------------//
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 25,
                                                vertical: 8,
                                              ),
                                              child: Container(
                                                height: 50,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                              ),
                                            ),
//--------------------------------------------------------------------------------------------------//
                                            Column(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
//--------------------------------------------------------------------------------------------------//
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 10, 5),
                                                  child: Text(
                                                    'Sec',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
//--------------------------------------------------------------------------------------------------//
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 5),
                                                  child: Text(
                                                    'xx',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
//--------------------------------------------------------------------------------------------------//
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 110,
                                right: 20,
                                child: Icon(
                                  AntDesign.setting,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 30,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    child: Image.asset(
                                      'assets/img/profile.png',
                                      width: innerWidth * 0.35,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
//--------------------------------------------------------------------------------------------------//
                  Container(
                    height: 700,
                    child: ListView.builder(
                      itemCount: classroom.length,
                      itemBuilder: (context, index) {
                        String classname =
                            classroom[index]['Name_Class'].toString();
                        return proflie_adapter_user(child: classname);
                      },
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
