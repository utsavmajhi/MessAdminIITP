import 'package:flutter/material.dart';
import 'package:messadmin/Screens/LoginScreen.dart';
import 'Screens/RegistrationScreen.dart';
import 'package:messadmin/Screens/HomeScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: HomeScreen.id,
      routes: {
          LoginScreen.id:(context) => LoginScreen(),
          RegistrationScreen.id:(context) => RegistrationScreen(),
          HomeScreen.id:(context) => HomeScreen(),

      },
    );
  }
}


