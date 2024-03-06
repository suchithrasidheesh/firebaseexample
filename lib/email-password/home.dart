import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseexample/email-password/Firebase_Function.dart';
import 'package:firebaseexample/email-password/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class firebaseHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
        Center(child: Text('Welcome')),
          Center(child: ElevatedButton(onPressed: (){
            FirebaseHelper().logout().then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>FirebaseLogin())));
           }, child:Text('Logout')))
        ],
      ),
    );
  }

}