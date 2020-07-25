import 'package:flutter/material.dart';
import 'package:messadmin/Screens/LoginScreen.dart';
import 'Screens/RegistrationScreen.dart';
import 'package:messadmin/Screens/HomeScreen.dart';
import 'Screens/AddFoodItem.dart';
import 'Screens/EntryFinalScreen.dart';
import 'Screens/LogDataAnalysis.dart';
import 'Screens/EditItemsdateSelec.dart';
import 'Screens/EditItemsFinalSc.dart';
import 'Screens/LogDateSelecSc1.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: LoginScreen.id,
      routes: {
          LoginScreen.id:(context) => LoginScreen(),
          RegistrationScreen.id:(context) => RegistrationScreen(),
          HomeScreen.id:(context) => HomeScreen(),
          EntryFinalScreen.id:(context) => EntryFinalScreen(),
          AddFoodItem.id:(context) => AddFoodItem(),
          LogDataAnalysis.id:(context) => LogDataAnalysis(),
          EditItemdateSelec.id:(context) => EditItemdateSelec(),
          EditItemsFinalSc.id:(context) => EditItemsFinalSc(),
          LogDateSelecSc1.id:(context) => LogDateSelecSc1(),



      },
    );
  }
}


