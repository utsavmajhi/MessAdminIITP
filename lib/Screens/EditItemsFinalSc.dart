import 'package:flutter/material.dart';
import 'package:messadmin/PassArguments/AdditemScreen1.dart';
import 'package:messadmin/Screens/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'FoodItemModel.dart';
import 'package:messadmin/Screens/roundedbuttonsmall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:messadmin/PassArguments/EditItemSc1.dart';
final _firestore=Firestore.instance;

class EditItemsFinalSc extends StatefulWidget {
  static String id='edititemfinalsc_screen';

  @override
  _EditItemsFinalScState createState() => _EditItemsFinalScState();
}

class _EditItemsFinalScState extends State<EditItemsFinalSc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getvaluesfromshared();
  }
  @override
  Widget build(BuildContext context) {
    var edititemname = TextEditingController();
    var edititemprice = TextEditingController();
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
//    List<> fooditems=[];
    EditItemSc1 editItemSC1args=ModalRoute.of(context).settings.arguments;
//    Stream CustomStream(){
//      var ref=Firestore.instance.collection("DailyFoodMenu").document(editItemSC1args.workspace).collection("Menu").document(editItemSC1args.date).collection(editItemSC1args.food_cat).getDocuments().then((value){
//
//      });
//      return Firestore.instance.collection("DailyFoodMenu").document(editItemSC1args.workspace).collection("Menu").document(editItemSC1args.date).collection(editItemSC1args.food_cat).snapshots();
//    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Edit Food Items"),
      ),
      key: _scaffoldKey,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("DailyFoodMenu").document(editItemSC1args.workspace).collection("Menu").document(editItemSC1args.date).collection(editItemSC1args.food_cat).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child:Text("Loading Data...",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
            );
          }
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.purple,
                            radius: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child:editItemSC1args.food_cat=="Breakfast"?SvgPicture.asset('images/breakfast.svg',fit: BoxFit.contain,):editItemSC1args.food_cat=="Lunch"?SvgPicture.asset('images/lunch2.svg',fit: BoxFit.contain,):editItemSC1args.food_cat=="Snacks"?SvgPicture.asset('images/snacks2.svg',fit: BoxFit.contain,):SvgPicture.asset('images/dinner.svg',fit: BoxFit.contain,),
                            )),
                      ),
                      Text(editItemSC1args.food_cat,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Date:${editItemSC1args.date}",
                        style: TextStyle(
                            fontSize: 15
                        ),)
                    ],
                  ),

                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context,position){
                      return GestureDetector(
                        onTap: (){
                          print(position);
                          //open modal screen
                          edititemname=TextEditingController(text: snapshot.data.documents[position]['itemname']);
                          edititemprice=TextEditingController(text: snapshot.data.documents[position]['itemprice'].toString());
                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding:  EdgeInsets.only(
                                              bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  controller: edititemname,
                                                  textAlign: TextAlign.start,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(
                                                        left: 15, bottom: 11, top: 11, right: 15),
                                                    labelText: 'Enter Item Name',
                                                    prefixIcon: Icon(Icons.fastfood),
                                                    labelStyle: TextStyle(
                                                      color: Color(0xFFB2BCC8),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                                TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: edititemprice,
                                                  textAlign: TextAlign.start,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(
                                                        left: 15, bottom: 11, top: 11, right: 15),
                                                    labelText: 'Enter Item Price',
                                                    prefixIcon: Icon(Icons.monetization_on),
                                                    labelStyle: TextStyle(
                                                      color: Color(0xFFB2BCC8),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:18.0,right: 18,top: 0,bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              RoundedButtonSmall(
                                                title: "Confirm Edits",
                                                colour: Colors.deepPurple,
                                                onPressed: (){
                                                  try{
                                                    _firestore.collection("DailyFoodMenu").document(editItemSC1args.workspace).collection("Menu").document(editItemSC1args.date).collection(editItemSC1args.food_cat).document(snapshot.data.documents[position]['itemid']).updateData({
                                                      'date':snapshot.data.documents[position]['date'],
                                                      'itemname':edititemname.text.toLowerCase(),
                                                      'itemprice':double.parse(edititemprice.text)
                                                    }).then((value){
                                                      print("Successfully edited");
                                                      _showSnackBar("Successfully Updated Item No:${position+1}", Colors.green[600]);
                                                    });

                                                  }
                                                  catch(e){
                                                    _showSnackBar(e.message,Colors.red[600]);

                                                  }
                                                  edititemprice.clear();
                                                  edititemname.clear();
                                                  Navigator.pop(context);


                                                },
                                              ),
                                              RoundedButtonSmall(
                                                title: "Delete Item",
                                                colour: Colors.red[600],
                                                onPressed: (){
                                                  //backend starts to delete doc of item
                                                  try{
                                                    _firestore.collection("DailyFoodMenu").document(editItemSC1args.workspace).collection("Menu").document(editItemSC1args.date).collection(editItemSC1args.food_cat).document(snapshot.data.documents[position]['itemid']).delete().then((value){
                                                      _showSnackBar("Successfully Deleted the Item from ${editItemSC1args.food_cat}", Colors.green[600]);
                                                    });
                                                  }catch(e){
                                                    _showSnackBar(e.message, Colors.red[600]);
                                                  }
                                                  edititemprice.clear();
                                                  edititemname.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title:Text("Item No: ${position+1}"),
                            subtitle: Text(snapshot.data.documents[position]['itemname']),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Price",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),
                                Text("Rs ${snapshot.data.documents[position]['itemprice']}",
                                  style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 15
                                  ),),
                              ],
                            ),


                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
