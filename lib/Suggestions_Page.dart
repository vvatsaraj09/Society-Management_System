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
import 'package:CMS1/Suggestions.dart';
import 'package:CMS1/suggestion1.dart';
import 'package:CMS1/resident_suggestion.dart';

class Suggestions_Page extends StatefulWidget {
  String content;
  Suggestions_Page(this.content);
  String user;
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(this.content);
  }
}

class _MyAppState extends State<Suggestions_Page> {
String user;
String content;
_MyAppState(this.content);

List<suggestion1> suggest = [];
@override
  void initState() {
    super.initState();
    setState(() {
      user = "Suggestions/"+content;
    });
    final DatabaseReference database = FirebaseDatabase.instance.reference().child(user);
    database.once().then((DataSnapshot snap){
    
      var keys = snap.value.keys;

      var data = snap.value;

      suggest.clear();
      for(var individualkey in keys)
      {
        suggestion1 ann1 = new suggestion1(
          data[individualkey]['content'], 
          data[individualkey]['dateDay'],
          data[individualkey]['dateTime'],  
          data[individualkey]['topic'],
          );

          suggest.add(ann1);
      }
      setState(() {
        print("Length is: $suggest.length");
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
                  builder: (context) => resident_suggestion()));
              }
            )
          ],
          title: new Text(content.replaceAll(' ', '.')),
          ),
        body: Container(
          child: suggest.length == 0 ? new Text("No suggestions by this user."): new ListView.builder( 
          padding: const EdgeInsets.all(15),
            itemCount: suggest.length,
            itemBuilder: (_, index){
              return postUI(suggest[index].content, suggest[index].dateDay, suggest[index].dateTime, suggest[index].topic);
            },
            ),
        )
        )
     );
    }


  Widget postUI(String content,String dateDay,String dateTime,String topic){
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
            new Text(
              topic,
              style: TextStyle(fontSize: 25),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  dateDay,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
                ),
                new Text(
                  dateTime,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
            ),
            ],
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