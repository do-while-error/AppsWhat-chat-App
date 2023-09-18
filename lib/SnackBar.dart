import 'package:flutter/material.dart';

class ToastBar{
  static void tb(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}