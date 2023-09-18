import 'dart:io';

import 'package:chat_chat/SnackBar.dart';
import 'package:chat_chat/apis.dart';
import 'package:chat_chat/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
//OUR HOME WILL BE THE LOGIN
class MyHome extends StatefulWidget{
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  _handleGoogleBtnClick(){
    _signInWithGoogle().then((user) async {
      if(user != null) {

        if(await API.userExists()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginHomeScreen()));
        }
        else {
          API.createUser().then((value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginHomeScreen()));
          });
        }

      }
      });
    }

    Future<UserCredential?> _signInWithGoogle() async {
      // Trigger the authentication flow
      try{
        await InternetAddress.lookup("google.com"); //to check the internet connection, will throw error on no internet and will be catch by catch block
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } catch(e){
        print("\nNo Internet Connection: $e");
        ToastBar.tb(context, "Failed to Login!!!");
        return null;
      }
    }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
            children: [
              Container(height:size.height,child: Image.asset("assets/images/bghome.jpg")),
              Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   width: size.width / 0.5,
                  //   child: IconButton(
                  //       icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                  // ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 150),
                    width: size.width / 1.1,
                    child: Text(
                        "Welcome",
                        style: GoogleFonts.eczar(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                        "Sign In to Continue!!!",
                        style: GoogleFonts.eczar(
                          fontSize: 20,
                        )
                    ),
                  ),
                  SizedBox(
                    height: size.height / 90,
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Email", Icons.account_box, _email, false),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Password", Icons.lock, _password, true),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleGoogleBtnClick();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "LOGIN WITH ",
                            style: GoogleFonts.eczar(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            )
                        ),
                        FaIcon(FontAwesomeIcons.google)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                        "Don't have an account??  Create One!!!",
                        style: GoogleFonts.eczar(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        )
                    ),
                  ),
                  // Container(
                  //   width: size.width*0.6,
                  //   height: size.height*0.5,
                  //   color: Colors.red,
                  //   child: Image.asset("assets/images/bghome.jpg"),
                  // )
                ],
              ),


            ]
        ),
      ),
    );
  }
}

Widget field(
    Size size, String hintText, IconData icon, TextEditingController cont, bool passhint) {
  return Container(
    height: size.height / 14,
    width: size.width / 1.1,
    child: TextField(
      obscureText: passhint,
      controller: cont,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

}


Widget customButton(Size size) {
  return GestureDetector(
    onTap: () {},
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
  );
}