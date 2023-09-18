import 'dart:convert';

import 'package:chat_chat/ModelForChatUser.dart';
import 'package:chat_chat/apis.dart';
import 'package:chat_chat/chatViewafterLogin.dart';
import 'package:chat_chat/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MessageCard.dart';
import 'ModelForMessage.dart';

class MyMainChatScreen extends StatefulWidget {
  final ChatUserModel user;

  const MyMainChatScreen({super.key, required this.user});

  @override
  State<MyMainChatScreen> createState() => _MyMainChatScreenState();
}

class _MyMainChatScreenState extends State<MyMainChatScreen> {
  List<Message> _list = [];

  // final textController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // MediaQuery mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4E766B),
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 21),
            child: Container(
              // height: MediaQuery.of(context).size.height/,
              // child: CircleAvatar(
              //   backgroundColor: Colors.white,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginHomeScreen(),
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                      )),
                  Icon(
                    Icons.account_circle_rounded,
                    size: 40.2,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 40,
                  ),
                  Text(widget.user.name,
                      style: GoogleFonts.eczar(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  Text("Last Seen: Not Available"),
                ],
              ),
              // ),
              // color: Colors.red,
            ),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: StreamBuilder(
              stream: API.getAllMessages(widget.user),
              builder: (context, snapshot) {
                //to show the progress bar indicator in case of slow connection
                switch (snapshot.connectionState) {
                  //if loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: const CircularProgressIndicator());

                  //if loaded
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;

                    _list =
                        data?.map((e) => Message.fromJson(e.data())).toList() ??
                            [];

                    // _list.clear();
                    // _list.add(Message(msg: "hii", read: "true", form: API.usr.uid, to: "xyz", type: Type.text, sent: "45"));
                    // _list.add(Message(msg: "hello", read: "1523", form: "9587", to: API.usr.uid, type: Type.text, sent: "456"));

                    if (_list.isNotEmpty) {
                      // _list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
                      return ListView.builder(

                        physics: BouncingScrollPhysics(),
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return MessageCard(
                            message: _list[index],
                          );
                        },
                      );
                    } else {
                      return Container(
                        color: Colors.teal.shade100,
                        child: Center(
                          child: Text(
                            "Say Hii!!!",
                            style: GoogleFonts.eastSeaDokdo(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.emoji_emotions,
                              color: Color(0xff4E766B),
                            )),
                        Expanded(
                            child: TextField(
                          // autocorrect: true,
                          controller: textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Type a Message",
                            hintStyle:
                                TextStyle(color: Colors.blueGrey.shade200),
                          ),
                        )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.image_sharp,
                              color: Color(0xff4E766B),
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Color(0xff4E766B),
                            )),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        API.sendMessage(widget.user, textController.text);
                        textController.text = "";
                      }
                    },
                    minWidth: 0,
                    child: Icon(
                      Icons.send,
                      size: 30,
                    ))
              ],
            ),
          ),
        ]));
  }
}
