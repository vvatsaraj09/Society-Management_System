import 'package:CMS1/homePage.dart';
import 'package:CMS1/options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nice_button/nice_button.dart';
import 'package:intl/intl.dart';

void main() => runApp(new Admin_Page());
class Admin_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Management System',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurpleAccent,
      ),
      home: MyIntroPage(title: 'Categories_2'),
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

final DatabaseReference database = FirebaseDatabase.instance.reference().child("Announcements List");
 TextEditingController _controller;
 TextEditingController _controller1;
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  String topic = "topic";
  String content = "content";
  static var now = new DateTime.now();
  String date = new DateFormat("dd-MM-yyyy").format(now);
  String time = new DateFormat("H:m:s").format(now);

  @override
  void initState(){
    super.initState();
    _controller = TextEditingController();
    _controller1 = TextEditingController();
  }
  
Future<void> sendData() async{
  setState(() {
      topic = _controller.text.toString();
      content = _controller1.text.toString();
    });
    database.push().set({
      'topic': topic,
      'content': content,
      'dateDay': date,
      'dateTime': time
    });
    _controller.clear();
    _controller1.clear();
  }


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
          title: new Text("Admin_Page"),
          ),
        body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100.0
                ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Title",
                  )
                ),
                SizedBox(height: 50),
                TextField(
                  controller: _controller1,
                  decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Content",
                  ),
                ),
                SizedBox(
                  height: 50.0
                ),
                NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Upload",
                gradientColors: [secondColor, firstColor],
                onPressed: () {
                  sendData();
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => homePage()));
                  },
                background: firstColor,
              ),
          ]),)
        )
     );
    }
  }