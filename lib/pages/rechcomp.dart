import 'package:flutter/material.dart';
import 'package:projetflutterfinal/database/DatabaseHelper.dart';
import 'package:projetflutterfinal/pages/homePage.dart';

class Recherche extends StatefulWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  final dbaHelper = DatabaseHelper.instance;
  late List<Map<String, dynamic>>  myComp=[];
  late String keyword;
  @override
  void initState(){
    super.initState();

    _getComponents();
  }

  void _getComponents() async{

    final dbaHelper = DatabaseHelper.instance;
    final allRows = await dbaHelper.recher(keyword);
    myComp=allRows!;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    print("****");
    print(myComp);
    return Scaffold(
      appBar: AppBar(
        title: Text("search component "),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_)=>homePage()));
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Key word'),
                  onChanged: (value){
                    keyword=value;
                    print(keyword);
                    setState(() {
                      _getComponents();
                    });
                  },
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: myComp.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Reference : ${myComp[index]["component_name"]} '),
                    subtitle: Text('Quantity : ${myComp[index]["qte"]}'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

