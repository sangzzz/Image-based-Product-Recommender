import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const TextStyle kCardTextStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

const AlertStyle kAlertStyle = AlertStyle(
  animationDuration: Duration(milliseconds: 500),
  animationType: AnimationType.grow,
  overlayColor: Colors.black45,
  descStyle: TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: 'Itim',
  ),
  titleStyle: TextStyle(
    fontSize: 22.0,
    fontFamily: 'Reem',
  ),
);

const String url =
    'https://customsearch.googleapis.com/customsearch/v1/siterestrict';
const String cx = '0f2785e03e27c89d9';
const String apiKey = 'AIzaSyDBA-d2hVucY-QXcf8UuYX0pVA9XskoWnE';
const TextStyle kFeedbackTextStyle = TextStyle(
  color: Colors.grey,
  fontStyle: FontStyle.italic,
  fontFamily: 'SourceSans',
  fontSize: 20.0,
);
