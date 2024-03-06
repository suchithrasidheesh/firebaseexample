import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'Home.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey:'AIzaSyDziSU3xM6650rF0i7et8WEEHKEO6s9W-g',
          appId: '1:357315292350:android:dbf71f7749f0ad36af82ef',
          messagingSenderId:'',
          projectId: 'fir-eg-a1b89')
  );
  runApp(phneVerify());

}
class phneVerify extends StatefulWidget{
  @override
  State<phneVerify> createState() => _phneVerifyState();
}

class _phneVerifyState extends State<phneVerify> {
  final phne_Controller=TextEditingController();
  final otp_Controller=TextEditingController();

  String userNumber='';

  FirebaseAuth auth=FirebaseAuth.instance;

  var otpFieldVissibility=false;
  var receivedID='';

  void verifyUserPhoneNumber(){
    auth.verifyPhoneNumber(
        phoneNumber: userNumber,
        verificationCompleted:(PhoneAuthCredential credential)async{
          await auth.signInWithCredential(credential).then((value)async{
            if(value.user!=null){
              //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
              Get.offAll(Home());
            }
          });
        },
        verificationFailed:(FirebaseAuthException e){
          print(e.message);
        },
        codeSent:(String verificationId, int? resendToken){
          receivedID=verificationId;
          otpFieldVissibility=true;
          setState(() {

          });
        },
        codeAutoRetrievalTimeout:(String verificationId){},
    );
  }

  Future<void>verifyOTPCode()async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: receivedID,
        smsCode: otp_Controller.text,
    );
    await auth.signInWithCredential(credential).then((value)async{
      if(value.user!=null){
        //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
        Get.offAll(Home());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(

      appBar: AppBar(
        title: const Text(
          'Phone Authentication',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IntlPhoneField(
              controller: phne_Controller,
              initialCountryCode: 'NG',
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                userNumber = val.completeNumber;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Visibility(
              visible: otpFieldVissibility,
              child: TextField(
                controller: otp_Controller,
                decoration: const InputDecoration(
                  hintText: 'OTP Code',
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (otpFieldVissibility) {
                verifyOTPCode();
              } else {
                verifyUserPhoneNumber();
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Text(
              otpFieldVissibility ? 'Login' : 'Verify',
            ),
          )
        ],
      ),
    ),
  );
  }
}