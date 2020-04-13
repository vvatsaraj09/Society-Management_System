import 'package:CMS1/Announcements.dart';
import 'package:CMS1/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nice_button/nice_button.dart';

void main() => runApp(new Announcement());
class Announcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Management System',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurpleAccent,
      ),
      home: MyIntroPage(title: 'Announcement'),
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

List<Announcements> ann = [];


@override
  void initState() {
    super.initState();
    final DatabaseReference database = FirebaseDatabase.instance.reference().child("Announcements List");
    database.once().then((DataSnapshot snap){
    
      var keys = snap.value.keys;

      var data = snap.value;

      ann.clear();
      for(var individualkey in keys)
      {
        Announcements ann1 = new Announcements(
          data[individualkey]['content'], 
          data[individualkey]['dateDay'],
          data[individualkey]['dateTime'],  
          data[individualkey]['topic'],
          );

          ann.add(ann1);
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
                  builder: (context) => homePage()));
              }
            )
          ],
          title: new Text("Announcement"),
          ),
        body: Container(
          child: ann.length == 0 ? new Text("No announcements so far."): new ListView.builder( 
          padding: const EdgeInsets.all(15),
            itemCount: ann.length,
            itemBuilder: (_, index){
              return postUI(ann[index].content, ann[index].dateDay, ann[index].dateTime, ann[index].topic);
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