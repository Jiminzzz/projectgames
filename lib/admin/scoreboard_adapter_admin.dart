import 'package:flutter/material.dart';

class scoreboard_adapter_admin extends StatelessWidget {
  final String child;
  const scoreboard_adapter_admin({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
    );
  }
}
