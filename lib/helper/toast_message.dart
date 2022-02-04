import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {

  static showToast(String message, {Toast? length}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        backgroundColor: const Color(0xee444444),
        textColor: Colors.white
    );
  }
}