import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recommender/widgets/reusable_tile.dart';
import 'package:recommender/widgets/rounded_button.dart';
import 'package:recommender/models/get_classification.dart';

class PreviewImageScreen extends StatelessWidget {
  const PreviewImageScreen({Key key, this.path}) : super(key: key);
  final String path;

  ReusableTile getClassificationsURL(int index) {
    ReusableTile classification = ReusableTile(
      classification: Classification.getClassificationAtIndex(index),
      path: path,
    );
    return classification;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.file(
              File(path),
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
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        elevation: 20.0,
                        backgroundColor: Colors.black45,
                        builder: (context) => LayoutBuilder(
                          builder: (context, BoxConstraints constraints) =>
                              Container(
                            height: constraints.maxHeight / 1.5,
                            child: ListView.builder(
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
