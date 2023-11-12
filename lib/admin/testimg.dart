import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:games/quiz/dashboard_quiz.dart';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:games/admin/scoreboard_adapter_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class testimg extends StatefulWidget {
  const testimg({super.key});
  @override
  State<testimg> createState() => _testimgState();
}

class _testimgState extends State<testimg> {
  File? image;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
//--------------------------------------------------------------------------------------------------------------//
  Future pickcamera1(int img) async {
    try {
      var imageflie = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (img == 1) {
          image = new File(imageflie.path);
        } else if (img == 2) {
          image1 = new File(imageflie.path);
        } else if (img == 3) {
          image2 = new File(imageflie.path);
        } else if (img == 4) {
          image3 = new File(imageflie.path);
        } else if (img == 4) {
          image4 = new File(imageflie.path);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

//--------------------------------------------------------------------------------------------------------------//
  Future pickcamera() async {
    try {
      var imageflie = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        image = new File(imageflie.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

//--------------------------------------------------------------------------------------------------------------//
  Future upload(File imageflie) async {
    var stream = http.ByteStream(imageflie.openRead())..cast();
    var length = await imageflie.length();
    var url = Uri.parse('http://172.20.10.2/games/testimg.php');
    var request = new http.MultipartRequest("POST", url);

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageflie.path));

    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'image Upload is Susscessfully!',
        toastLength: Toast.LENGTH_SHORT,
      );
      print('image Upload is Susscessfully!');
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'image Upload failed, something has problem occurred.!',
        toastLength: Toast.LENGTH_SHORT,
      );
      print('image Upload SFailed!');
    }
  }

  //--------------------------------------------เรียก Admin -------------------------------------------------------//
  String Email = "";
  String Name = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Email = preferences.getString('Email');
      Name = preferences.getString('Name');
    });
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
                'Testimg',
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
                        onTap: pickcamera,
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
//------------------------------------------------------------------------------//
                  ],
                ),
              ),
//------------------------------------------------------------------------------//
              SizedBox(
                height: 25,
              ),
//------------------------------------------------------------------------------//
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    upload(image!);
                  },
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
                        onTap: () {
                          upload(image!);
                        },
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
            ],
          ),
        ),
      ),
    );
  }
}
