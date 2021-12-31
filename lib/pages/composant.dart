import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';

import '../comHelper.dart';
import '../genTextFormField.dart';
class ComposantPage extends StatefulWidget {
  const ComposantPage({Key? key}) : super(key: key);

  @override
  _ComposantPageState createState() => _ComposantPageState();
}

class _ComposantPageState extends State<ComposantPage> {


  final dbHelperrm = DatabaseHelper.instance;

  TextEditingController _conNameComposant = new TextEditingController();
  TextEditingController _conDescriptionComposant = new TextEditingController();
  TextEditingController _conQuantity = new TextEditingController();

  var SelectedValue;
  late List<String> myList;

  @override
  void initState() {
    super.initState();
    myList = [];
    _getfam();
  }

  _getfam() async {
    List<String> items=[];
    await dbHelperrm.getAllfam().then((value) {
      for (var i = 0; i < value.length; i++) {
        items.add(value[i]['name_famille']);
      }
    }
    );
    myList=items;
    setState(() {

    });
  }


  Future<void> _insertcom() async {
    String c_name = _conNameComposant.text;
    String c_desc = _conDescriptionComposant.text;
    String qte = _conQuantity.text;


    var value = await dbHelperrm.getIdfam(SelectedValue);
    insertt(int.parse(qte), value![0]['reff_family']);
    // row to insert


  }

  void insertt(int qte, String family) async {
    Map<String, dynamic> rowwwm = {
      DatabaseHelper.columnnn_id: _conNameComposant.text,
      DatabaseHelper.columnnn_name: _conDescriptionComposant.text,
      DatabaseHelper.columnn_quantite: qte,
      DatabaseHelper.columnn_famcomp: family,
    };
    try {
      final id = await dbHelperrm.insertComposant(rowwwm);
      alertDialog(context, "successfully saved");
      print('inserted row name: ');
    }
    catch (error) {
      print(error);
      alertDialog(context, "not saved");
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
                    Image.asset("assets/images/img.png",
                      height: 125,
                      width:125 ,
                    ),
                    getTextFormField(
                        controller: _conNameComposant,
                        icon: Icons.dialpad,
                        hintName: "name_composant"),
                    SizedBox(height: 10.0),
                    getTextFormField(
                        controller:_conDescriptionComposant,
                        icon: Icons.filter_none,
                        hintName: 'description composant'),
                    SizedBox(height: 10.0),
                    getTextFormField(
                        controller:_conQuantity,
                        icon: Icons.view_headline,
                        hintName: 'quantite'),
                    SizedBox(height: 10.0),
                    Container(
                        margin: EdgeInsets.all(30.0),
                        width: double.infinity,
                        child:DropdownButton<String>(
                          hint: Text('Select family'),
                          value: null,
                          onChanged:(newValue){
                            setState(() {
                              SelectedValue=newValue.toString();
                              print(SelectedValue);
                            });
                          },
                          items: myList.map<DropdownMenuItem<String>>((ValueItem){
                            return DropdownMenuItem<String>(
                                value: ValueItem,
                                child:Text(
                                  ValueItem,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                            );
                          }).toList(),
                        )
                    ),
    Container(
    margin: EdgeInsets.all(30.0),
    width: double.infinity,
    child: FlatButton(
    onPressed: () {
    _insertcom();
    },
    child: Text(
    "Add",
    style: TextStyle(color:Colors.white),
    ),
    ),
    decoration: BoxDecoration(
    color:Colors.blue,
    borderRadius: BorderRadius.circular(30.0)
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
