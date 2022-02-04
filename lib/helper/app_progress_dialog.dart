import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/material.dart';

class AppProgressDialog {

  late CustomProgressDialog arsProgressDialog;

  final BuildContext context;

  AppProgressDialog(this.context){
    /*Future.delayed(Duration.zero, () {
      _constructor();
    });*/
    _constructor();
  }

  _constructor(){
    arsProgressDialog = CustomProgressDialog (
        context,
        backgroundColor: Colors.transparent,
        blur: 3,
        dismissable: false,
    );
  }

  show() {
    arsProgressDialog.show();
  }

  hide() {
    arsProgressDialog.dismiss();
  }

}