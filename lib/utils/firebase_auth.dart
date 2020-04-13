import 'package:CMS1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
class AuthProvider{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email,String password) async {
    try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(),password: password);
    FirebaseUser user = result.user;
    if(user!=null)
    return true;
    else
    return false;
    }
    catch(e){
      print(e);
      return false;
    }

}
    Future<bool> logInWithGoogle() async {

    try{
    GoogleSignIn signin = GoogleSignIn();
    GoogleSignInAccount acc = await signin.signIn();
    if(acc == null)
    {
      return false;
    }
    else{
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: (await acc.authentication).idToken, accessToken: (await acc.authentication).idToken));
      FirebaseUser user = res.user;
      if(user == null){
        print("Login failed.");
        return false;
      }
      else{
        print("Login success");
        return true;
      }
    }
    }
    catch(e){
      return false;
    }
  }

Future<void> logOut() async {
  try{
    await _auth.signOut();
    print("Log out successful.");
  }
  catch(e)
  {
    print(e);
    print("Log out failed");
  }
}

Future<String> user() async {
  FirebaseUser user1 = await _auth.currentUser();
  String email1 = user1.email.toString();
  return email1;
}


}