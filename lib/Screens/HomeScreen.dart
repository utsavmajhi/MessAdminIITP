import 'package:flutter/material.dart';
import 'package:messadmin/Screens/AddFoodItem.dart';
import 'package:messadmin/Screens/LogDataAnalysis.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

final _firestore=Firestore.instance;

class HomeScreen extends StatefulWidget {
  static String id='home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String workspace="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var auth=FirebaseAuth.instance.currentUser().then((value){
      _firestore.collection("UsersData").document(value.uid).get().then((value){
        setState(() {
          workspace=value.data['workspace'];
        });
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepPurple,
      body: SafeArea(
        child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                color: Colors.deepPurple,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 18),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset('images/iitpatna.png'),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Mess Admin Portal',
                          style: GoogleFonts.wellfleet(
                              fontSize: 28,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("WORKSPACE: $workspace",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),

                      ],
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:100.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.vertical(top: Radius.circular(30.0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 10,
                        primary: false,
                        children: <Widget>[
                          InkWell(
                            onTap: ()
                            {
                              //goto addfooditemscreens screen
                              Navigator.pushNamed(context, AddFoodItem.id);

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.deepOrangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(tag: 'AddEntry',
                                        child: SvgPicture.asset('images/bread.svg',height: 110,)),
                                    SizedBox(
                                      height: 10 ,
                                    ),
                                    Text(
                                      'Add Food item',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              //

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(tag: "LogData",
                                        child: SvgPicture.asset('images/register.svg',height: 100,)),
                                    SizedBox(
                                      height: 20 ,
                                    ),
                                    Text(
                                      'Edit Food item',
                                      style: TextStyle(

                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              //goto screen
                              Navigator.pushNamed(context, LogDataAnalysis.id);

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(tag: 'Cloud',
                                        child: SvgPicture.asset('images/log.svg',height: 100,)),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Log Data',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              //                      _showSnackBar("Coming Soon! Stay tuned",Colors.blue);

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset('images/excel.svg',height: 110,),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Export',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                        crossAxisCount: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
        ),
      ),

    );
  }
}
