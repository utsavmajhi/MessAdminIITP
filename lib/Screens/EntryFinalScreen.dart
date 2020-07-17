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
class EntryFinalScreen extends StatefulWidget {
  static String id='entryfinal_screen';
  @override
  _EntryFinalScreenState createState() => _EntryFinalScreenState();
}

class _EntryFinalScreenState extends State<EntryFinalScreen> {
  List<FoodItemModel> foodlist=[];
  final additemname = TextEditingController();
  final additemprice = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      AdditemScreen1 addentrysc1Data=ModalRoute.of(context).settings.arguments;
      setState(() {

      });

    });
  }
  @override
  Widget build(BuildContext context) {
    AdditemScreen1 addentrysc1Data=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Add Food Entries"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          //open modal screen
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
                                  controller: additemname,
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
                                  controller: additemprice,
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
                          child: RoundedButton(
                            title: "Add Item",
                            colour: Colors.deepPurple,
                            onPressed: (){
                              setState(() {
                                foodlist.add(FoodItemModel(additemname.text,double.parse(additemprice.text)));
                                additemprice.clear();
                                additemname.clear();
                                Navigator.pop(context);
                              });
                            },
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          child:addentrysc1Data.food_cat=="Breakfast"?SvgPicture.asset('images/breakfast.svg',fit: BoxFit.contain,):addentrysc1Data.food_cat=="Lunch"?SvgPicture.asset('images/lunch2.svg',fit: BoxFit.contain,):addentrysc1Data.food_cat=="Snacks"?SvgPicture.asset('images/snacks2.svg',fit: BoxFit.contain,):SvgPicture.asset('images/dinner.svg',fit: BoxFit.contain,),
                        )),
                  ),
                  Text(addentrysc1Data.food_cat,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Date:${addentrysc1Data.date}",
                  style: TextStyle(
                    fontSize: 15
                  ),)
                ],
              ),

            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: foodlist.length,
                itemBuilder: (BuildContext context, int position){
                  return Card(
                    child: ListTile(
                      title:Text("Item No: ${position+1}"),
                      subtitle: Text(foodlist[position].foodname),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Price",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          ),),
                          Text("Rs ${foodlist[position].foodprice}",
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 15
                          ),),
                        ],
                      ),


                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(title: "Submit",colour: Colors.deepPurple,
            onPressed: (){
              //confirm with a message

            },),
          )
        ],
      ),
    );
  }

 ListView getFooditemList() {
    return ListView.builder(
        itemCount: foodlist.length,
        itemBuilder: (BuildContext context, int position){
          return Card(
            child: ListTile(
            title:Text("Item No:"),
            ),
          );
        });
 }
}
