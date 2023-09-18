import 'package:chat_chat/ModelForChatUser.dart';
import 'package:chat_chat/ModelForMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class API {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get usr => FirebaseAuth.instance.currentUser!;

  // to check if user exist or not

  static Future<bool> userExists() async {
    return (await firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get()).exists;
  }

  //if user exist
  static Future<void> createUser() async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final user = ChatUserModel(image: usr.photoURL.toString(), name: usr.displayName.toString(), about:"Let's Chat!!", createdAt: time, id: usr.uid, lastActive: "Unknown", isOnline: false, email: usr.email.toString(), pushToken:"");

    return await firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(user.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>  getAllUser() {
    return firestore.collection("users").where("id", isNotEqualTo: usr.uid).snapshots();
  }

  static String getCID(String id) => usr.uid.hashCode <= id.hashCode ? "${usr.uid}_$id" : "${id}_${usr.uid}";

  static Stream<QuerySnapshot<Map<String, dynamic>>>  getAllMessages(ChatUserModel user) {
    return firestore.collection("chats/${getCID(user.id)}/messages/").snapshots();
  }

  static Future<void> sendMessage(ChatUserModel user, String msg) async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(msg: msg, read: "", form: usr.uid, to: user.id, type: Type.text, sent: time);

    final ref = firestore.collection("chats/${getCID(user.id)}/messages/");
    await ref.doc().set(message.toJson());
    }

}