import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:CMS1/utils/firebase_auth.dart';
import 'package:CMS1/homePage.dart';
import 'package:nice_button/nice_button.dart';


void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Society Management System',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurpleAccent,
      ),
      home: MyIntroPage(title: 'Vihang Darshan'),
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

  final DatabaseReference database = FirebaseDatabase.instance.reference().child("Suggestions");
   TextEditingController _emailController;
   TextEditingController _passwordController;
    var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
    String email;
    String password;
    String user1;
  @override
  void initState(){
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }
  

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome',
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Vihang Darshan"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                height: 150.0
                ),
                TextField(
                  controller: _emailController,
                  decoration: new InputDecoration(
                  labelText: "Enter Email",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  ),
                  ),
                ),
                SizedBox(
                height: 30.0
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: new InputDecoration(
                  labelText: "Enter password",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  ),
                  ),
                ),
                SizedBox(
                height: 30.0
                ),
                NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Log In",
                icon: Icons.flip,
                gradientColors: [secondColor, firstColor],
                  onPressed: () async {
                    setState(() {
                      email = _emailController.text.toString().trim();
                      password = _passwordController.text.toString().trim();
                    });
                    bool res = await AuthProvider().signInWithEmail(email,password);
                    if(res == false){
                      print("Login failed");
                    }
                    else{
                      print("Login successful.");
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => homePage()));
                    }
                  },
                  background: firstColor),
                SizedBox(
                height: 30.0
                ),
                NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Google LogIn",
                icon: Icons.flip,
                gradientColors: [secondColor, firstColor],
                  onPressed: () async{
                    bool res = await AuthProvider().logInWithGoogle();
                    if(!res)
                    {
                      print("Error logging");
                    }
                    else{
                      print("Success.");
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => homePage()));
                    }
                  },
                  background: firstColor
                )
              ],
            ),
          )
          )
      );
      }

  }