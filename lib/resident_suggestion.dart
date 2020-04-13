import 'package:CMS1/homePage.dart';
import 'package:CMS1/utils/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nice_button/nice_button.dart';
import 'package:CMS1/main.dart';
import 'package:CMS1/Announcement.dart';
import 'package:CMS1/Announcements.dart';
import 'package:CMS1/Admin_Page.dart';
import 'package:CMS1/Suggestions_Page.dart';
import 'package:CMS1/Suggestions.dart';
import 'package:CMS1/options.dart';

void main() => runApp(new resident_suggestion());
class resident_suggestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Management System',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurpleAccent,
      ),
      home: MyIntroPage(title: 'Society Management System'),
    );
  }
}
class MyIntroPage extends StatefulWidget {
  MyIntroPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyIntroPage> {

List<String> ann = [];


@override
  void initState() {
    super.initState();
    final DatabaseReference database = FirebaseDatabase.instance.reference().child("Suggestions");
    database.once().then((DataSnapshot snap){
    
      var keys = snap.value.keys;

      var data = snap.value;

      ann.clear();
      for(var individualkey in keys)
      {
          ann.add(individualkey);
      }
      setState(() {
        print("Length is: $ann.length");
      });

    });
  }

    final border = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.0),
    );

    var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome_now',
      home: new Scaffold(
          appBar: new AppBar(
             actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.arrow_back), 
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => options()));
              }
            )
          ],
          title: new Text("Suggestions users"),
          ),
        body: Container(
          child: ann.length == 0 ? new Text("No Users so far."): new ListView.builder( 
          padding: const EdgeInsets.all(15),
            itemCount: ann.length,
            itemBuilder: (_, index){
              return postUI(ann.elementAt(index));
            },
            ),
        )
        )
     );
    }

  Widget postUI(String content){
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
            new Row(
              children: <Widget>[
                new Text(
                content,
                style: TextStyle(fontSize: 25),
                ),
                new SizedBox(
                  width: 10,
                ),
                new IconButton(
                  icon: new Icon(Icons.forward), 
                onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => Suggestions_Page(content)));
                } )
              ],
            ),
            new SizedBox(
              height: 20,
            ),
            ],
        ),
      )
    ),
  );
  }
  }