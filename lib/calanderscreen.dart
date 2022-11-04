import 'package:attendance_app/user.dart';
import 'package:flutter/material.dart';
class CalanderScreen extends StatefulWidget {
  CalanderScreen({Key? key}) : super(key: key);

  @override
  State<CalanderScreen> createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  @override
  Widget build(BuildContext context) {
    String dj = User.username;
    return Scaffold(
      body: Center(
        child: Text(dj),
        // ignore: avoid_print
        //       
      ),
    
    );
      
  }
}