import 'package:flutter/material.dart';
import 'package:recommender/models/constants.dart';
import 'package:recommender/widgets/alert_dialog_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EmptyAlertScreen extends StatefulWidget {
  const EmptyAlertScreen({Key key}) : super(key: key);

  @override
  _EmptyAlertScreenState createState() => _EmptyAlertScreenState();
}

class _EmptyAlertScreenState extends State<EmptyAlertScreen> {
  void callAlert() {
    Alert(
      onWillPopActive: true,
      context: context,
      title: 'COULDN\'T CLASSIFY',
      desc: 'The image taken has returned zero classifications.',
      style: kAlertStyle,
      closeFunction: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      buttons: [
        reusableAlertDialogButton(
          color: Color(0XFFEB1555),
          text: 'Cancel',
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      callAlert();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
    ));
  }
}
