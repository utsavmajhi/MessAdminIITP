import 'package:flutter/material.dart';
import 'package:messadmin/Screens/AddFoodItem.dart';
import 'package:messadmin/Screens/EditItemsdateSelec.dart';
import 'package:messadmin/Screens/LogDataAnalysis.dart';
import 'package:messadmin/Screens/LogDateSelecSc1.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:messadmin/Screens/LoginScreen.dart';
final _auth = FirebaseAuth.instance;
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
    var uid="";
    var auth=FirebaseAuth.instance.currentUser().then((value){
      //uid=value.uid;
      _firestore.collection("UsersData").document(value.uid).get().then((value){

        setState(() {
          workspace=value.data['workspace'];
        });
      });
    });


  }
  Future<String> setsharedprefs(String username,String workspace,String uid) async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString('username', username);
    await sharedPreferences.setString('workspace', workspace);
    await sharedPreferences.setString('UID', uid);
    sharedPreferences.commit();
    return "true";

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
                                Navigator.pushNamed(context, EditItemdateSelec.id);
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
                                        child: SvgPicture.asset('images/register.svg',height: 100)),
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
                              Navigator.pushNamed(context, LogDateSelecSc1.id);

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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('images/dummypro.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:1.0,top: 5),
                    child: Text("Welcome!",style: TextStyle(color: Colors.white,fontSize: 25),),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage("images/header.jpeg"),
                  fit: BoxFit.cover,
                )
              ),
            ),
            ListTile(
              leading: Icon(Icons.track_changes),
              title: Text('Change Workspace'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () async{
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Warning",
                  desc: "You will be Logged Out",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Log Out!",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: ()async {
                        _signOut();//signout from firebase
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        await preferences.clear();
                        // Navigator.pushReplacementNamed(context, LoginScreen.id);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()
                            ),
                            ModalRoute.withName("/Login_screen")
                        );
                      },
                      color: Colors.red[600],
                    ),
                    DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.blueAccent,
                    )
                  ],
                ).show();
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );
  }
  _signOut() async {
    await _auth.signOut();
  }
}
