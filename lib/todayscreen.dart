import 'package:attendance_app/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = Colors.blueGrey;

  int currentIndex = 1;
  String bold = "FuzzyBubbles-Bold";
  String regular = "FuzzyBubbles-Regular";
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Welcome,",
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "FuzzyBubbles-Regular",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Student "+ User.username,
                style: TextStyle(
                  fontFamily: "FuzzyBubbles-Bold",
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Today's Status",
                style: TextStyle(
                  fontFamily: "FuzzyBubbles-Bold",
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chenk In",
                          style: TextStyle(
                              fontFamily: regular,
                              fontSize: screenWidth / 20,
                              color: Colors.black54),
                        ),
                        Text(
                          "09:30",
                          style: TextStyle(
                            fontFamily: bold,
                            fontSize: screenWidth / 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chenk Out",
                          style: TextStyle(
                              fontFamily: regular,
                              fontSize: screenWidth / 20,
                              color: Colors.black54),
                        ),
                        Text(
                          "--/--",
                          style: TextStyle(
                            fontFamily: bold,
                            fontSize: screenWidth / 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: "${DateTime.now().day} ",
                    style: TextStyle(
                        color: primary,
                        fontSize: screenWidth / 18,
                        fontFamily: bold),
                    children: [
                      TextSpan(
                          text: DateFormat('MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                              color: Colors.black, fontSize: screenWidth / 18))
                    ]),
              ),
            ),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontFamily: regular,
                          fontSize: screenWidth / 20,
                          color: Colors.black54),
                    ),
                  );
                }),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Builder(
                builder: (context) {
                  final GlobalKey<SlideActionState> key = GlobalKey();
                  return SlideAction(
                    text: "Slide to Check Out",
                    textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidth / 20,
                      fontFamily: regular,
                    ),
                    outerColor: Colors.white,
                    innerColor: primary,
                    key: key,
                    onSubmit: () async {
                      print(DateFormat('hh:mm').format(DateTime.now()));

                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("Student")
                          .where('id', isEqualTo: User.username)
                          .get();

                      // print(snap.docs[0].id);
                    
                      // await FirebaseFirestore.instance
                      //     .collection("Student")
                      //     .doc(snap.docs[0].id)
                      //     .collection("Record")
                      //     .doc(
                      //       DateFormat('dd MMMM yyyy').format(
                      //         DateTime.now(),
                      //       ),
                      //     );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
