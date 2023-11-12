import 'package:flutter/material.dart';
import 'package:games/quiz/edit_quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class alledit_adapter_quiz extends StatelessWidget {
  final String child;
  final String childs;
  const alledit_adapter_quiz({required this.child, required this.childs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
      child: GestureDetector(
        //----------------------------ปุ่มไปหน้าแก้ไขคำถามคำตอบ------------------------------///
        onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          var getidquestion = preferences.getString('idquestion');
          if (getidquestion == null) {
            preferences.setString("idquestion", childs); //ส่ง idquestion
          } else {
            preferences.remove("idquestion");
            preferences.setString("idquestion", childs); //ส่ง idquestion
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const edit_quiz(),
            ),
          );
        },

//-------------------------------------------------------------------------------------//
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xff5a81ba),
            borderRadius: BorderRadius.circular(26.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(50),
                child: Text(
                  child,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: Color.fromARGB(255, 246, 246, 246),
                    fontWeight: FontWeight.w700,
                    height: 0.5666666666666667,
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
