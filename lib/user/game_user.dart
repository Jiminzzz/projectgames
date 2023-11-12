import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:games/user/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class game_user extends StatefulWidget {
  const game_user({super.key});
  @override
  State<game_user> createState() => _game_userState();
}

class _game_userState extends State<game_user> {
  TextEditingController Id_Class = TextEditingController();
//---------------------------------เรียก USer มาแสดง---------------------------------------//
  String Email = "";
  String Name = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Email = preferences.getString('Email');
      Name = preferences.getString('Name');
    });
  }

//----------------------------------------------------------------------------------------//
//---------------------------ฟังก์ชัน join classroom----------------------------------------//
  Future joinclass_user() async {
    var url = 'http://172.20.10.2/games/joinclass_user.php';
    var response = await http.post(url, body: {
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

//----------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    getEmail();
  }

//----------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("game_user")),
      backgroundColor: const Color(0xffffffff),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//----------------------------------------------------------------------------------------//
              SizedBox(
                height: 100,
              ),
//----------------------------------------------------------------------------------------//
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
//----------------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
//----------------------------------------------------------------------------------------//
              Text(
                'All game',
                style: TextStyle(
                  fontFamily: 'Ambit',
                  fontSize: 20,
                  color: Color(0xff414c79),
                  fontWeight: FontWeight.w700,
                ),
              ),
//----------------------------------------------------------------------------------------//
              const SizedBox(
                height: 20,
              ),
//----------------------------------------------------------------------------------------//
              GestureDetector(
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const listview_user(),
                //     ),
                //   );
                // },
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
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: const Text(
                          "Game",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(135, 0, 0, 0),
                        child: Image.asset(
                          'assets/img/console.png',
                          width: 75,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//----------------------------------------------------------------------------------------//
            ],
          ),
        ),
      ),
    );
  }
}
