import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messadmin/Screens/EntryFinalScreen.dart';
import 'package:messadmin/PassArguments/AdditemScreen1.dart';
class AddFoodItem extends StatefulWidget {
  static String id='addfooditem_screen';
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  DateTime _dateTime=DateTime.now();  //date picker from calendar
  String _foodcat='None';
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked=await showDatePicker(context: context, initialDate: _dateTime, firstDate: DateTime(2016), lastDate: DateTime(2222));
    if(picked!=null && picked !=_dateTime)
    {

      setState(() {
        _dateTime=picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
            'Add Food Item'
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: SafeArea(
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
                        Text(
                          'Select Entry Date',
                          style: TextStyle(
                              fontSize: 22
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
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,EntryFinalScreen.id,arguments: AdditemScreen1(changetimeformat(_dateTime)));
                          },
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blueAccent,
                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//for formatting date
changetimeformat(@required DateTime datetimepicked)
{
  String formattedDate = DateFormat('dd-MM-yyyy').format(datetimepicked);

  return formattedDate;

}