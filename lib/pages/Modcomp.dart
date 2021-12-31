import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';

import '../comHelper.dart';
import 'homePage.dart';



class Modcomp extends StatefulWidget {
  Map<String, dynamic>  ss;
   Modcomp({Key? key,required this.ss}) : super(key: key);

  @override
  _ModcompState createState() => _ModcompState();
}

class _ModcompState extends State<Modcomp> {

  final composantRfr = TextEditingController();
  final qte = TextEditingController();


  final dbaHelper = DatabaseHelper.instance;

  var SelectedValue;


  @override
  void initState() {
    super.initState();
    composantRfr.text = widget.ss['name_composant'];
    qte.text = widget.ss["qte"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => homePage()));
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: composantRfr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Reference'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: qte,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Quantity'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    _modifier();
                  },
                  child: Text(
                    "update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0)
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  _modifier() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnnn_id: widget.ss['id_composant'],
      DatabaseHelper.columnnn_name: composantRfr.text,
      DatabaseHelper.columnn_quantite: int.parse(qte.text)
    };
    try {
      final bb = await dbaHelper.updateComposant(row);
      if (bb > 0) {
        alertDialog(context, "successfully updated");
      }
    }
    catch (error) {
      print(error);
      alertDialog(context, "error");
    }
  }
}