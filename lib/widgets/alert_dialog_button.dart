import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

DialogButton reusableAlertDialogButton({
  @required String text,
  @required Color color,
  @required Function onPressed,
}) {
  return DialogButton(

    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        fontFamily: 'SourceSans',
      ),
    ),
    color: color,
    onPressed: onPressed,
  );
}
