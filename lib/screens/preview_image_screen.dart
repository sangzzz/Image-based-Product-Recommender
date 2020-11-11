import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recommender/screens/empty_alert.dart';
import 'package:recommender/widgets/reusable_tile.dart';
import 'package:recommender/widgets/rounded_button.dart';
import 'package:recommender/models/get_classification.dart';
import 'package:tflite/tflite.dart';

class PreviewImageScreen extends StatefulWidget {
  const PreviewImageScreen({Key key, this.path}) : super(key: key);
  final String path;

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  ReusableTile getClassificationsURL(int index) {
    ReusableTile classification = ReusableTile(
      classification: Classification.getClassificationAtIndex(index),
      path: widget.path,
    );
    return classification;
  }

  List<dynamic> classifications = [];
  Future updateClassifications(String imgPath) async {
    print(imgPath);
    // Run tensorflowlite image classification model on the image
    classifications = await Tflite.runModelOnImage(
      path: imgPath,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    Classification.updateClassifications(classifications);
    return;
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/tflite_model/mobilenet_v2_1.0_224.tflite",
        labels: "assets/tflite_model/labels.txt",
      );
      print(res);
    } on PlatformException {
      print('Failed to load model');
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((val) {
      setState(() {
        updateClassifications(widget.path);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.file(
              File(widget.path),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                    color: Color(0XFFEB1555),
                    text: 'Retake',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButton(
                    color: Colors.green,
                    text: 'Search',
                    onPressed: () async {
                      showModalBottomSheet<dynamic>(
                        context: context,
                        isScrollControlled: true,
                        elevation: 20.0,
                        backgroundColor: Colors.black45,
                        builder: (context) => LayoutBuilder(
                          builder: (context, BoxConstraints constraints) =>
                              Container(
                            constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight / 3),
                            child: Classification.getItemCount() == 0
                                ? EmptyAlertScreen()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: Classification.getItemCount(),
                                    itemBuilder: (context, index) =>
                                        AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: Duration(milliseconds: 800),
                                      child: FlipAnimation(
                                        child: SlideAnimation(
                                          child: getClassificationsURL(index),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
