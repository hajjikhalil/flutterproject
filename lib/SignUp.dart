import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';
import 'package:projetflutterfinal/main.dart';
import 'package:projetflutterfinal/comHelper.dart';
import 'package:projetflutterfinal/genTextFormField.dart';
import 'package:projetflutterfinal/pages/homePage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;



  TextEditingController _conUserId = new  TextEditingController();
  TextEditingController _conUserName = new TextEditingController();
  TextEditingController _conEmail = new TextEditingController();
  TextEditingController  _conPassword = new TextEditingController();
  TextEditingController  _conCPassword = new  TextEditingController();





  _signUp() async {
    String u_name = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cnf_passwd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != cnf_passwd) {
        alertDialog(context, 'please confirm your password!');
      } else {
        _formKey.currentState!.save();

        Map<String, dynamic> row = {
          DatabaseHelper.column_name: u_name,
          DatabaseHelper.column_email: email,
          DatabaseHelper.column_password: passwd
        };

        final id = await dbHelper.insert(row).then((value) {
          alertDialog(context, "successfully saved");

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyApp()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "error : data save fail");
        });
      }
    }
  }


  void _insert() async {
    String u_name = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;

    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.column_name : u_name,
      DatabaseHelper.column_password  : passwd,
      DatabaseHelper.column_email : email,
    };
    final id = await dbHelper.insert(row);
    print('inserted row name: $id');
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signup'),

      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(    margin: const EdgeInsets.only(top: 15.0),

            child: Center(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,


                children: [
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'user name'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'email'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'confirm password',
                    isObscureText: true,
                  ),

                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'signup',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _signUp,

                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('does you have account? '),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text('sign In'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginDemo()),
                                    (Route<dynamic> route) => false);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

