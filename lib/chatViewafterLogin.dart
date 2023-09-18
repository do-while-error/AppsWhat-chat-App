import 'package:chat_chat/ModelForChatUser.dart';
import 'package:chat_chat/MyMainChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ChatView extends StatefulWidget {

  final ChatUserModel user;

  const ChatView({super.key, required this.user});
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Card(
      color: Colors.lightGreen.shade300,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.01),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainChatScreen(user: widget.user,)));
        },
        child: ListTile(
          trailing: const Text("12:00 PM"),
          leading: const CircleAvatar(
            backgroundColor: Colors.black12,
            child: FaIcon(FontAwesomeIcons.user),
          ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about,
          maxLines: 1,
          ),

        ),
      ),
    );
  }
}