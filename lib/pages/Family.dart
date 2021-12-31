import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';

import '../comHelper.dart';
import '../genTextFormField.dart';
class FamilyPage extends StatefulWidget {
  const FamilyPage({Key? key}) : super(key: key);

  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {


  final dbHelperr = DatabaseHelper.instance;

  TextEditingController _conNameFamily = new TextEditingController();
  TextEditingController _conDescriptionFamily = new TextEditingController();


  void _insertfam() async {


    // row to insert
    Map<String, dynamic> rowww = {
      DatabaseHelper.columnn_ref: _conNameFamily.text,
      DatabaseHelper.columnn_name: _conDescriptionFamily.text,

    };
    try{
    final id = await dbHelperr.insertFamily(rowww);
    print('inserted row name: $DatabaseHelper.columnn_name');
    alertDialog(context, "successfully saved");
    final allRows = await dbHelperr.getAllfam();
    for(var i=0;i<allRows.length;i++){
      print(allRows[i]['name_famille']);
    }}
    catch(error){
      print(error);
      alertDialog(context, "error");
    }
    }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('family'),

    ),
    body: Form(

    child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(margin: const EdgeInsets.only(top: 15.0),

    child: Center(
    child: Column(

    mainAxisAlignment: MainAxisAlignment.center,


    children: [
      Image.asset("assets/images/family.png",
        height: 125,
        width:125 ,
      ),
    getTextFormField(
    controller: _conNameFamily,
    icon: Icons.person_outline,
    inputType: TextInputType.name,
    hintName: 'refernce famille'),
    SizedBox(height: 10.0),
    getTextFormField(
    controller: _conDescriptionFamily,
    icon: Icons.ac_unit,
    inputType: TextInputType.emailAddress,
    hintName: 'nom famille'),
    SizedBox(height: 10.0),
      Container(
        margin: EdgeInsets.all(30.0),
        width: double.infinity,
        child: FlatButton(
          child: Text(
            'add Family composant',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _insertfam,

        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    ]
    ),
    ),
    ),
    ),
    ),
    );}

}

