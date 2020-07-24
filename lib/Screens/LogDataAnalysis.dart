import 'package:flutter/material.dart';
import 'package:messadmin/Screens/AddFoodItem.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogDataAnalysis extends StatefulWidget {
  static String id='logdata_screen';

  @override
  _LogDataAnalysisState createState() => _LogDataAnalysisState();
}

class _LogDataAnalysisState extends State<LogDataAnalysis> {
  String workspace="";
  final List<Map<String, String>> listOfColumns = [];
  final List<Map<String, String>> listOfColumnsLunch = [];
  final List<Map<String, String>> listOfColumnsSnacks = [];
  final List<Map<String, String>> listOfColumnsDinner = [];
  Stream Customstream(){
      var ref=Firestore.instance.collection("CloudDataEvents").document("Mess 1").collection("DataAnalysis").document("24-07-2020").collection("Breakfast").getDocuments().then((value){
        listOfColumns.clear();
        for(int i=0;i<value.documents.length;i++){
          listOfColumns.add({
            "Type":value.documents[i].data['ItemName'],
            "Quantity":value.documents[i].data['Quantity'],
            "Cash":value.documents[i].data['Cash'],
            "GPay":value.documents[i].data['GPay'],
            "Khaata":value.documents[i].data['Khaata'],
            "TotalAmt":value.documents[i].data['TotalAmt'],
          });
        }

      });
      Firestore.instance.collection("CloudDataEvents").document("Mess 1").collection("DataAnalysis").document("24-07-2020").collection("Lunch").getDocuments().then((value){
        listOfColumnsLunch.clear();
        for(int i=0;i<value.documents.length;i++){
          listOfColumnsLunch.add({
            "Type":value.documents[i].data['ItemName'],
            "Quantity":value.documents[i].data['Quantity'],
            "Cash":value.documents[i].data['Cash'],
            "GPay":value.documents[i].data['GPay'],
            "Khaata":value.documents[i].data['Khaata'],
            "TotalAmt":value.documents[i].data['TotalAmt'],
          });
        }
      });
      Firestore.instance.collection("CloudDataEvents").document("Mess 1").collection("DataAnalysis").document("24-07-2020").collection("Snacks").getDocuments().then((value){
        listOfColumnsSnacks.clear();
        for(int i=0;i<value.documents.length;i++){
          listOfColumnsSnacks.add({
            "Type":value.documents[i].data['ItemName'],
            "Quantity":value.documents[i].data['Quantity'],
            "Cash":value.documents[i].data['Cash'],
            "GPay":value.documents[i].data['GPay'],
            "Khaata":value.documents[i].data['Khaata'],
            "TotalAmt":value.documents[i].data['TotalAmt'],
          });
        }
      });
      Firestore.instance.collection("CloudDataEvents").document("Mess 1").collection("DataAnalysis").document("24-07-2020").collection("Dinner").getDocuments().then((value){
        listOfColumnsDinner.clear();
        for(int i=0;i<value.documents.length;i++){
          listOfColumnsDinner.add({
            "Type":value.documents[i].data['ItemName'],
            "Quantity":value.documents[i].data['Quantity'],
            "Cash":value.documents[i].data['Cash'],
            "GPay":value.documents[i].data['GPay'],
            "Khaata":value.documents[i].data['Khaata'],
            "TotalAmt":value.documents[i].data['TotalAmt'],
          });
        }
      });
     return Firestore.instance.collection("CloudDataEvents").document("Mess 1").collection("DataAnalysis").document("27-07-2020").get().asStream();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvaluesfromshared();

  }
  Future<bool> getvaluesfromshared() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
      workspace=sharedPreferences.getString('workspace');
    });

    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent[100],
      body: StreamBuilder(
          stream: Customstream(),
          builder:(context,snapshot){
              if(!snapshot.hasData){
                  return Center(
                    child: Text("Loading"),
                  );
              }
              return SingleChildScrollView(
                child: SafeArea(
                  maintainBottomViewPadding: true,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.group_work,size: 35,),
                            Text(workspace,style: GoogleFonts.saira(color:Colors.red,fontSize: 30),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'BreakFast',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                            ],
                            rows:
                            listOfColumns.map((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["Type"],style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),)), //Extracting from Map element the value
                                DataCell(Text(element["Quantity"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )),
                                DataCell(Text(element["Cash"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)),
                                DataCell(Text(element["GPay"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)), //Extracting from Map element the value
                                DataCell(Text(element["Khaata"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),)),
                                DataCell(Text("Rs "+element["TotalAmt"],
                                  style: TextStyle(
                                    fontSize: 19,),)),
                              ],
                            )).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Lunch',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                            ],
                            rows:
                            listOfColumnsLunch.map((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["Type"],style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),)), //Extracting from Map element the value
                                DataCell(Text(element["Quantity"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )),
                                DataCell(Text(element["Cash"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)),
                                DataCell(Text(element["GPay"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)), //Extracting from Map element the value
                                DataCell(Text(element["Khaata"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),)),
                                DataCell(Text("Rs "+element["TotalAmt"],
                                  style: TextStyle(
                                    fontSize: 19,),)),
                              ],
                            )).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Snacks',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                            ],
                            rows:
                            listOfColumnsSnacks.map((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["Type"],style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),)), //Extracting from Map element the value
                                DataCell(Text(element["Quantity"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )),
                                DataCell(Text(element["Cash"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)),
                                DataCell(Text(element["GPay"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)), //Extracting from Map element the value
                                DataCell(Text(element["Khaata"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),)),
                                DataCell(Text("Rs "+element["TotalAmt"],
                                  style: TextStyle(
                                    fontSize: 19,),)),
                              ],
                            )).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Dinner',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                              DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                            ],
                            rows:
                            listOfColumnsDinner.map((element) => DataRow(

                              cells: <DataCell>[
                                DataCell(Text(element["Type"],style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),)), //Extracting from Map element the value
                                DataCell(Text(element["Quantity"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )),
                                DataCell(Text(element["Cash"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)),
                                DataCell(Text(element["GPay"],
                                  style: TextStyle(
                                    fontSize: 18,

                                  ),)), //Extracting from Map element the value
                                DataCell(Text(element["Khaata"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),)),
                                DataCell(Text("Rs "+element["TotalAmt"],
                                  style: TextStyle(
                                    fontSize: 19,),)),
                              ],
                            )).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
      ),

    );
  }
}
