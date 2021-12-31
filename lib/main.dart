// ignore_for_file: prefer_const_constructors
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';
import 'package:projetflutterfinal/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projetflutterfinal/SignUp.dart';
import 'package:projetflutterfinal/comHelper.dart';
import 'database/DatabaseHelper.dart';
import 'genTextFormField.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final EmailController = TextEditingController();
  final PwdController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  final tab_admin = 'admin';







  login() async {
    String email = EmailController.text;
    String password = PwdController.text;

    if (email.isEmpty) {
      alertDialog(context, "please enter your mail ");
    } else if (password.isEmpty) {
      alertDialog(context, "please enter your password");
    } else {
      await dbHelper.getLoginUser(email, password).then((userData) {
        if (userData != null) {
          alertDialog(context, "login succesful !");
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => homePage()),
                    (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "error : user not found");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "error login fail");
      });
    }
  }

  Future setSP( user) async {
    final SharedPreferences sp = await _pref;
    sp.setString("id_admin", user.id_admin);
    sp.setString("nom_admin", user.nom_admin);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }


  @override
  void dispose() {
    EmailController.dispose();
    PwdController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/login.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:20,bottom: 0),


              child: getTextFormField(
                  controller: EmailController,
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  hintName: 'email'),

            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: getTextFormField(
                controller: PwdController,
                icon: Icons.lock,
                hintName: 'password',
                isObscureText: true,
              ),
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'forgot password ',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed:  login ,

                child: Text(
                  'login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignupForm()));             },
              child: Text(
                'new user ? create account',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}