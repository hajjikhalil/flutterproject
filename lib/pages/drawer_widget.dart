import 'package:flutter/material.dart';
import 'package:projetflutterfinal/pages/homePage.dart';
import 'package:projetflutterfinal/pages/membre.dart';
import 'package:projetflutterfinal/pages/rechcomp.dart';

import 'Family.dart';
import 'composant.dart';



class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black12,
                        Colors.lightBlue,
                      ]
                  )
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/gstock.png"),
                  radius: 50,
                ),
              )
          ),
          ListTile(
            title: Text("home", style: TextStyle(fontSize:26),),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => homePage()));
            },
          ),
          Divider(height:5 ,color : Colors.black ,),
          ListTile(
            title: Text("add new family", style: TextStyle(fontSize:26),),
            leading: Icon(IconData(0xe04c, fontFamily: 'MaterialIcons')),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FamilyPage()));
            },
          ),
          Divider(height:5 ,color : Colors.black ,),
          ListTile(
            title: Text("add new composant", style: TextStyle(fontSize: 26),),
            leading: Icon(IconData(0xe04b, fontFamily: 'MaterialIcons')),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ComposantPage()));
            },
          ),
          Divider(height:5 ,color : Colors.black ,),
          ListTile(
            title: Text("search ", style: TextStyle(fontSize: 26),),
            leading: Icon(IconData(0xee4e, fontFamily: 'MaterialIcons')),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Recherche()));
            },

          ),
          Divider(height:5 ,color : Colors.black ,),


        ],
      ),
    );
  }

}
