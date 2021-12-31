import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';

import '../comHelper.dart';
import '../genTextFormField.dart';
class MembrePage extends StatefulWidget {
  const MembrePage({Key? key}) : super(key: key);

  @override
  _MembrePageState createState() => _MembrePageState();
}

class _MembrePageState extends State<MembrePage> {

 final _formddc = new GlobalKey<FormState>();
 final dbHelperrm = DatabaseHelper.instance;

  TextEditingController _conNameMembre = new TextEditingController();
  TextEditingController _conDescriptionMembre = new TextEditingController();
  TextEditingController _connumtel1 = new TextEditingController();
  TextEditingController _connumtel2 = new TextEditingController();

  _addcomposant() async {
    String me_name = _conNameMembre.text;
    String me_desc = _conDescriptionMembre.text;
    String me_numtel1 = _connumtel1.text;
    String me_numtel2 = _connumtel2.text;

    if (_formddc.currentState!.validate()) {

      _formddc.currentState!.save();

      Map<String, dynamic> rowwm = {
        DatabaseHelper.columnnm_name: me_name,
        DatabaseHelper.columnnm_description:me_desc ,
        DatabaseHelper.column_numtel1: me_numtel1,
        DatabaseHelper.column_numtel2:me_numtel2 ,


      };

      final id = await dbHelperrm.insertMembre(rowwm).then((value) {
        alertDialog(context, "successfully saved");
        print('inserted row name: ');


      }).catchError((error) {
        print(error);
       alertDialog(context, "error : data save fail");
      });
    }
  }//
  void _insertmem() async {
    String me_name = _conNameMembre.text;
    String me_desc = _conDescriptionMembre.text;
  String me_numtel1 = _connumtel1.text;
   String me_numtel2 = _connumtel2.text;

     //row to insert
   Map<String, dynamic> rowwwm = {
    DatabaseHelper.columnnm_name: me_name,
    DatabaseHelper.columnnm_description:me_desc ,
    DatabaseHelper.column_numtel1: me_numtel1,
    DatabaseHelper.column_numtel2:me_numtel2 ,
   };
  final id = await dbHelperrm.insertMembre(rowwwm);
  print('inserted row name: $id');
   alertDialog(context, "successfully saved");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('membre'),

      ),
      body: Form(

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(margin: const EdgeInsets.only(top: 15.0),

            child: Center(
              child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,


                  children: [
                    getTextFormField(
                        controller: _conNameMembre,
                        icon: Icons.person_outline,
                        inputType: TextInputType.name,
                        hintName: 'membre name'),
                    SizedBox(height: 10.0),
                    getTextFormField(
                        controller: _conDescriptionMembre,
                        icon: Icons.ac_unit,
                        inputType: TextInputType.emailAddress,
                        hintName: 'description'),
                    SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _connumtel1,
                      icon: Icons.accessibility,
                      hintName: 'quantity',
                      isObscureText: true,
                    ),
                    SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _connumtel2,
                      icon: Icons.account_balance,
                      hintName: 'family',
                      isObscureText: true,
                    ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: FlatButton(
                        child: Text(
                          'add composant',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _insertmem,

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
    );

  }

}