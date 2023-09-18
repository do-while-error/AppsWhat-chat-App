import 'dart:convert';
import 'dart:developer';

import 'package:chat_chat/chatViewafterLogin.dart';
import 'package:chat_chat/myHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'ModelForChatUser.dart';
import 'apis.dart';

class LoginHomeScreen extends StatefulWidget{
  @override
  State<LoginHomeScreen> createState() => _LoginHomeScreenState();
}

class _LoginHomeScreenState extends State<LoginHomeScreen> {

  List<ChatUserModel> list =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/10),
            child: Text("AppsWhat",
            style: GoogleFonts.eczar(
              fontWeight: FontWeight.bold,

            ),
            ),
          ),
        ),
        backgroundColor: Color(0xff4E766B),
        leading: InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();

            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHome()));
    },

            child: Icon(Icons.logout
        )),
      ),
      body: StreamBuilder(
        stream: API.getAllUser(),
        builder: (context, snapshot) {

          //to show the progress bar indicator in case of slow connection
          switch(snapshot.connectionState){
            //if loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: const CircularProgressIndicator());

              //if loaded
            case ConnectionState.active:
            case ConnectionState.done:


              final data = snapshot.data?.docs;
              list = data?.map((e) => ChatUserModel.fromJson(e.data())).toList() ?? [];

            if(list.isNotEmpty){
              return  ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ChatView(user: list[index],);
                  // return Text("Name: ${list[index]}");
                },
              );
            } else {
             return  Center(child: Text("No Connection Found!!!",
             style: GoogleFonts.eczar(
               fontSize: 20,
             ),
             ));
            }

          }


        },
      ),
    );
  }
}