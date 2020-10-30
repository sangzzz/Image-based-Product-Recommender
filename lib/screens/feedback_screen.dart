import 'package:flutter/material.dart';
import 'package:recommender/models/constants.dart';
import 'package:recommender/models/write_feedback.dart';
import 'package:recommender/screens/alert_screen.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen(
      {Key key, @required this.path, @required this.appRecommendation})
      : super(key: key);
  final String path;
  final String appRecommendation;
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    String newValue;
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.bottomCenter,
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight / 2,
                ),
                decoration: BoxDecoration(
                  color: Color(0XFF1D1E33),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Suggest An Alternate Classification',
                          style: kFeedbackTextStyle.copyWith(
                            color: Color(0XFFEB1555),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        cursorColor: Colors.grey,
                        style: kFeedbackTextStyle.copyWith(
                          fontSize: 25.0,
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                        ),
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        controller: controller,
                        onChanged: (newString) {
                          newValue = newString;
                        },
                        maxLengthEnforced: true,
                        enabled: true,
                        decoration: InputDecoration(
                          isDense: false,
                          prefixIcon: Icon(Icons.keyboard_arrow_right),
                          suffixIcon: Icon(Icons.keyboard_arrow_left),
                          labelStyle: kFeedbackTextStyle,
                          hintText: 'Enter Classification',
                          hintStyle: kFeedbackTextStyle.copyWith(
                            fontSize: 15.0,
                          ),
                        ),
                        autofocus: true,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      FlatButton(
                        onPressed: () async {
                          controller.clear();
                          await addToFile(
                            path: widget.path,
                            appRecommendation: widget.appRecommendation,
                            suggestedRecommendation: newValue,
                          );

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AlertScreen(),
                          ));
                        },
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Color(0XFFEB1555),
                            fontSize: 40.0,
                            fontFamily: 'Reem',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
