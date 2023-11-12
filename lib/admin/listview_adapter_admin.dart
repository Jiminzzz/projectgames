import 'package:flutter/material.dart';
import 'package:games/quiz/dashboard_quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class listview_adapter_admin extends StatelessWidget {
  final String child;
  final String idclass;
  const listview_adapter_admin({required this.child, required this.idclass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: GestureDetector(
//----------------------------ปุ่มไปหน้าสรา้งคำถาม คำตอบ------------------------------///
        onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          var getidclass = preferences.getString('idclass');
          if (getidclass == null) {
            preferences.setString("idclass", idclass); //ส่ง idclass
          } else {
            preferences.remove("idclass");
            preferences.setString("idclass", idclass); //ส่ง idclass
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const dashboard_quiz(),
            ),
          );
        },
//--------------------------------------------------------------------------------///
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
