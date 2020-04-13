import 'package:CMS1/Resident.dart';
import 'package:CMS1/homePage.dart';
import 'package:CMS1/utils/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nice_button/nice_button.dart';
import 'package:CMS1/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';

void main() => runApp(new Archives());
 
class Archives extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  
List<String> ann = [];
List<String> ann1 = [];
List<String> ann2 = [];
List<String> ann3 = [];

   var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
 @override
  void initState(){
    super.initState();
    final DatabaseReference database = FirebaseDatabase.instance.reference().child("Images");
    database.once().then((DataSnapshot snap){
    
      var keys = snap.value.keys;

      var data = snap.value;

      ann.clear();
      ann1.clear();
      ann2.clear();
      ann3.clear();
      for(var individualkey in keys)
      {
          ann.add(data[individualkey]['url']);
          ann1.add(data[individualkey]['topic']);
          ann2.add(data[individualkey]['dateDay']);
          ann3.add(data[individualkey]['dateTime']);
      }
      setState(() {
        print("Length is: $ann.length");
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.arrow_back), 
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => Resident()));
              }
            )
          ],
        title: new Text('Archived Document'),
        centerTitle: true,
      ),
      body: Container(
          child: ann.length == 0 ? new Text("No documents so far."): new ListView.builder( 
          padding: const EdgeInsets.all(15),
            itemCount: ann.length,
            itemBuilder: (_, index){
              SizedBox(
                height: 20,
              );
              return postUI(ann.elementAt(index),ann1.elementAt(index),ann2.elementAt(index),ann3.elementAt(index));
            },
            ),
        )
    );
  }


  Widget postUI(String url,String content,String d1,String d2){
  return new Card(
    color: firstColor,
    child: new Container(
      decoration: BoxDecoration(
      borderRadius: new BorderRadius.only(
      topLeft:  const  Radius.circular(40.0),
      topRight: const  Radius.circular(40.0)),
      gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [firstColor, secondColor])),
      child: Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
              height: 20,
            ),
            Image.network(url),
            SizedBox(
              height: 10,
            ),
            new Text(
              content,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            new Text(
              d1,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            new Text(
              d2,
              style: TextStyle(fontSize: 15),
            ),
            
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )
    ),
  );
  }


}