import 'package:flutter/material.dart';
import 'package:messadmin/PassArguments/AdditemScreen1.dart';
import 'package:messadmin/Screens/LogDataAnalysis.dart';
import 'package:messadmin/Screens/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings/strings.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'FoodItemModel.dart';
import 'package:messadmin/Screens/roundedbuttonsmall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:messadmin/PassArguments/LogDatesc1args.dart';

class LogDateSelecSc1 extends StatefulWidget {
  static String id='logdateselecc_screen';

  @override
  _LogDateSelecSc1State createState() => _LogDateSelecSc1State();
}

class _LogDateSelecSc1State extends State<LogDateSelecSc1> {
  String workspace="";
  DateTime _dateTime=DateTime.now();  //date picker from calendar
  bool showSpinner = false;
  Future<bool> getvaluesfromshared() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    workspace=sharedPreferences.getString('workspace');
    setState(() {

    });

    return true;
  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked=await showDatePicker(context: context, initialDate: _dateTime, firstDate: DateTime(2016), lastDate: DateTime(2222));
    if(picked!=null && picked !=_dateTime)
    {

      setState(() {
        _dateTime=picked;
      });
    }
  }
  //snackbar initialises
  _showSnackBar(@required String message, @required Color colors) {
    if (_scaffoldKey != null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: colors,
          content: new Text(message),
          duration: new Duration(seconds: 4),
        ),
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvaluesfromshared();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
            'Log Data'
        ),

      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 45,
                          child: SvgPicture.asset('images/log.svg',fit: BoxFit.cover,),
                        ),
                      ),
                      Text(
                        "LOG DATA",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select Date',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      FlatButton(
                        color: Colors.amberAccent,
                        onPressed: (){
                          _selectDate(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text (
                              _dateTime==null? "Please Select" : changetimeformat(_dateTime),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.arrow_drop_down),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              showSpinner=true;
                            });
                              print(workspace);
                              Navigator.pushNamed(context,LogDataAnalysis.id,arguments: LogDatesc1args(date:changetimeformat(_dateTime),workspace: workspace));
                              setState(() {
                                showSpinner=false;
                              });

                          },
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.purple,
                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  //for formatting date
  changetimeformat(@required DateTime datetimepicked)
  {
    String formattedDate = DateFormat('dd-MM-yyyy').format(datetimepicked);
    return formattedDate;

  }
}
