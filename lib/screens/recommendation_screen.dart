import 'package:flutter/material.dart';
import 'package:recommender/models/constants.dart';
import 'package:recommender/screens/feedback_screen.dart';
import 'package:recommender/widgets/alert_dialog_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RecommendationScreen extends StatefulWidget {
  final String link;
  final String path;

  const RecommendationScreen(
      {Key key, @required this.link, @required this.path})
      : super(key: key);
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen>
    with WidgetsBindingObserver {
  int resume;
  void launchURL() async {
    if (await canLaunch(widget.link)) {
      await launch(widget.link);
    } else {
      throw 'Could not open ${widget.link}';
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Alert(
          onWillPopActive: true,
          closeFunction: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          context: context,
          title: "FEEDBACK",
          style: kAlertStyle,
          desc:
              "Your valuable feedback will help us improve this service. Was the recommendation to your satisfaction?",
          buttons: [
            reusableAlertDialogButton(
              context: context,
              text: 'YES',
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            reusableAlertDialogButton(
              context: context,
              text: 'NO',
              color: Color(0XFFEB1555),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FeedbackScreen(
                      path: widget.path,
                      appRecommendation: widget.link,
                    ),
                  ),
                );
              },
            ),
          ],
        ).show();

        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    launchURL();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: TypewriterAnimatedTextKit(
              text: ['Loading'],
              repeatForever: true,
              speed: Duration(milliseconds: 400),
              textStyle: kCardTextStyle.copyWith(
                fontSize: 30.0,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
