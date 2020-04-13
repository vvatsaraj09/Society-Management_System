import 'package:CMS1/Archived.dart';
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
import 'package:CMS1/resident_suggestion.dart';
import 'package:CMS1/Suggestions.dart';


void main() => runApp(new options());
class options extends StatelessWidget {
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

    var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome',
      home: new Scaffold(
          appBar: new AppBar(
            actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.arrow_back), 
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => homePage()));
              }
            )
          ],
            title: new Text("Vihang Darshan"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                height: 150.0
                ),
                NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Post an Announcement",
                icon: Icons.flip,
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => Admin_Page()));
                },
                background: firstColor,
              ),
              SizedBox(
                height: 30.0
                ),
              NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Suggestions",
                icon: Icons.access_alarms,
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => resident_suggestion()));
                },
                background: firstColor,
              ),
              SizedBox(
                height: 30.0
                ),
              NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Archive Documents",
                icon: Icons.access_alarms,
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => Archived()));
                },
                background: firstColor,
              ),
              ],
            ),
          )
          )
      );
      }
}