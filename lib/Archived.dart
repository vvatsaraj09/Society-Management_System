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

void main() => runApp(new Archived());
 
class Archived extends StatelessWidget {
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
  

final DatabaseReference database = FirebaseDatabase.instance.reference().child("Images");
  File sampleImage;
 TextEditingController _emailController;
 String url;
 String topic;
 static var now = new DateTime.now();
  String date = new DateFormat("dd-MM-yyyy").format(now);
  String time = new DateFormat("H:m:s").format(now);
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
 
    setState(() {
      sampleImage = tempImage;
    });
  }
   var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
 @override
  void initState(){
    super.initState();
    _emailController = TextEditingController();
  }

   
Future<void> sendData() async{
  setState(() {
      topic = _emailController.text.toString();
    });
    database.push().set({
      'topic': topic,
      'url' : url,
      'dateDay': date,
      'dateTime': time
    });
    _emailController.toString();
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
                  builder: (context) => homePage()));
              }
            )
          ],
        title: new Text('Image Upload'),
        centerTitle: true,
      ),
      body: new Column(
      children: <Widget>[
        SizedBox(
          height: 30.0
          ),
        TextField(
          controller: _emailController,
          decoration: new InputDecoration(
          labelText: "Enter name",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          ),
          ),
          ),
          SizedBox(
          height: 50.0
          ),
        sampleImage == null ? Text('Select an image') : enableUpload(),
        SizedBox(
          height: 150.0
          ),
      FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add),
      ), ],),
    );
  }
Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0, width: 300.0),
          NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Upload",
                icon: Icons.access_alarms,
                gradientColors: [secondColor, firstColor],
            onPressed: () async {
              final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(_emailController.text.toString());
              final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);

              var imageUrl = await (await task.onComplete).ref.getDownloadURL();
              setState(() {
                url = imageUrl;
              });
              sendData();

            },
            background: firstColor,
          )
        ],
      ),
    );
  }
}