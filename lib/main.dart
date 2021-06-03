import 'package:touchngo/screens/attendance.dart';
import 'package:touchngo/screens/attendance/attendance_main.dart';
import 'package:touchngo/screens/attendance/reminder.dart';
import 'package:touchngo/screens/businessCard.dart';
import 'package:touchngo/screens/eAuthenticity.dart';
import 'package:touchngo/screens/home.dart';
import 'package:touchngo/screens/hotel/screens/food_main.dart';
import 'package:touchngo/screens/invitation/invitation_main.dart';
import 'package:touchngo/screens/sos.dart';
import 'package:touchngo/screens/taskAutomation.dart';
import 'package:touchngo/screens/tourist_main.dart';
import 'package:touchngo/screens/verify.dart';
import 'package:touchngo/screens/wrapper.dart';
import 'package:touchngo/screens/education.dart';
import 'package:touchngo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchngo/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(accentColor: Colors.blueAccent,
          primarySwatch: Colors.blue,
          fontFamily: 'Quicksand',
          //Quicksand, OpenSans
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20
              ),
            )
          )
        ),
        initialRoute: '/', // default is '/'
      routes: {
        // '/': (ctx) => Home(),
        BusinessCard.routeName: (ctx) => BusinessCard(),
        Authenticity.routeName: (ctx) => Authenticity(),
        TaskAutomation.routeName: (ctx) => TaskAutomation(),
        AttendanceMain.routeName: (ctx) => AttendanceMain(),
        Reminder.routeName: (ctx) => Reminder(),
        Sos.routeName: (ctx) => Sos(),
        FoodMain.routeName: (ctx) => FoodMain(),
        Education.routeName: (ctx) => Education(),
        TouristMain.routeName : (ctx) => TouristMain(),
        Verify.routeName : (ctx) => Verify(),
        InvitationMain.routeName : (ctx) => InvitationMain(),
      },
      ),
    );
  }
}