import 'package:chat_chat/ModelForMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'apis.dart';

class MessageCard extends StatefulWidget{

  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return API.usr.uid == widget.message.form ? _green(): _blue();
  }

  Widget _blue(){
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .03,vertical: MediaQuery.of(context).size.height * .01),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: Text(widget.message.msg,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _green(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .03,vertical: MediaQuery.of(context).size.height * .01),
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade300,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
            ),
            child: Text(widget.message.msg,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

}