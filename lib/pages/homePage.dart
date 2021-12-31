import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';

import 'Modcomp.dart';
import 'drawer_widget.dart';
class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.lightGreen
    ),
    home: Page(),
  );

}
}




class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  final dbHelper = DatabaseHelper.instance;

  late List<Map<String, dynamic>>  ll;
  @override
  void initState(){
    super.initState();
    ll=[];
    _getComponents();
  }
  void _getComponents() async{

    final dbHelper = DatabaseHelper.instance;
    final allRows = await dbHelper.getAllComposant();
    ll=allRows;
    setState(() {
    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer : MyDrawer(),
      appBar: AppBar(title: Text("Accueil"),),
      body:ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: ll.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key:  UniqueKey(),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ' ${ll[index]["name_composant"]}  ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '  ${ll[index]["name_famille"]}  ',
                          style: TextStyle(
                              color: Colors.black12,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ${ll[index]["qte"]}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_)=>Modcomp(
                                    ss:ll[index]
                                  )));
                            },
                            color:Colors.red,
                            child: Icon(Icons.edit,color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            onDismissed: (direction) {
              dbHelper.deleteComponent(ll[index]["component_id"]);
            },
          );
        },
      ),
    );
  }

  EditComponent() {}
}






