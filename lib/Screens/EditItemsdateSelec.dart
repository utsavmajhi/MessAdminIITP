import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messadmin/Screens/EditItemsFinalSc.dart';
import 'package:messadmin/Screens/EntryFinalScreen.dart';
import 'package:messadmin/PassArguments/EditItemSc1.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditItemdateSelec extends StatefulWidget {
  static String id='edititemdateselec_screen';

  @override
  _EditItemdateSelecState createState() => _EditItemdateSelecState();
}

class _EditItemdateSelecState extends State<EditItemdateSelec> {
  String workspace="";
  DateTime _dateTime=DateTime.now();  //date picker from calendar
  String _foodcat='None';
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
            'Edit Food Item'
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
                          child: SvgPicture.asset('images/register.svg',height: 60,fit: BoxFit.cover,),
                        ),
                      ),
                      Text(
                        "EDIT ITEMS IN MENU",
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
                      Text(
                        'Select Food Category',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      DropdownButton<String>(
                        value: _foodcat ,
                        icon: Icon(Icons.fastfood,
                          color: Colors.deepPurple,),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _foodcat = newValue;
                          });
                        },
                        items: <String>['None','Breakfast','Lunch','Snacks','Dinner']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              showSpinner=true;
                            });
                            if(_foodcat=="None"){
                              _showSnackBar("Please Select Food Category", Colors.red[600]);
                              setState(() {
                                showSpinner=false;
                              });
                            }else{
                              print(workspace);
                              Navigator.pushNamed(context,EditItemsFinalSc.id,arguments: EditItemSc1(date:changetimeformat(_dateTime),food_cat: _foodcat,workspace: workspace));
                              _foodcat="None";
                              setState(() {
                                showSpinner=false;
                              });
                            }
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
