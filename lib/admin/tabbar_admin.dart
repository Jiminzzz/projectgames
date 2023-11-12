import 'package:flutter/material.dart';
import 'package:games/admin/dashboard_admin.dart';
import 'package:games/admin/profile_admin.dart';
import 'package:games/admin/scoreboard_admin.dart';
import 'package:games/admin/showscore_admin.dart';
import 'package:games/admin/testimg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tabbar_admin extends StatefulWidget {
  const tabbar_admin({super.key});
  @override
  State<tabbar_admin> createState() => _tabbar_adminState();
}

class _tabbar_adminState extends State<tabbar_admin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
//--------------------------------------สรา้ง ที่ใส่ tapview--------------------------------------------------//
            const Expanded(
                child: TabBarView(
              children: [
                dashboard_admin(),
                testimg(),
                // scoreboard_admin(),
                profile_admin(),
              ],
            )),
//--------------------------------------สร้าง tapview------------------------------------------------------//
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 20),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Color(0xff778bd9),
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Color.fromARGB(255, 155, 172, 241),
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Tab(
                        icon: Image(
                          image: AssetImage('assets/img/homepage.png'),
                          width: 22,
                          fit: BoxFit.fitWidth,
                        ),
                        text: 'Home',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Tab(
                        icon: Image(
                          image: AssetImage('assets/img/score.png'),
                          width: 22,
                          fit: BoxFit.fitWidth,
                        ),
                        text: 'Score',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Tab(
                        icon: Image(
                          image: AssetImage('assets/img/user.png'),
                          width: 19,
                          fit: BoxFit.fitWidth,
                        ),
                        text: 'Profile',
                      ),
                    ),
                  ],
                ),
              ),
            ),
//-----------------------------------------------------------------------------------------------------//
          ],
        ),
      ),
    );
  }
}
