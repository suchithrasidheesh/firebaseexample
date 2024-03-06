import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseexample/email-password/Registration.dart';
import 'package:firebaseexample/email-password/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Firebase_Function.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey:'AIzaSyDziSU3xM6650rF0i7et8WEEHKEO6s9W-g',
        appId: '1:357315292350:android:dbf71f7749f0ad36af82ef',
        messagingSenderId:'',
        projectId: 'fir-eg-a1b89'));
  User? user=FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user == null ? FirebaseLogin() : firebaseHome(),
  ));
}
class FirebaseLogin extends StatelessWidget{
  var email_controller= TextEditingController();
  var pass_controller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(child: Text('Login Form',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),)),
          SizedBox(height: 40,),
          TextField(
            controller: email_controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: 'Email id'
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: pass_controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Password'
            ),
          ),
          SizedBox(height: 20,),

          ElevatedButton(onPressed: (){
            String email=email_controller.text.trim();
            String pass=pass_controller.text.trim();


            FirebaseHelper()
                .loginUser(email:email,pwd:pass)
                .then((result){
                  if(result==null){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>firebaseHome()));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text((result)),
                      backgroundColor: Colors.blue, ));
                  }
                });
            }, child:Text('Login')),
          SizedBox(height: 10,),

          TextButton(onPressed:(){
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>firebaseRegistration()));
            }, child:Text('Not registered User Register here')),
        ],
      ),
    );
  }

}