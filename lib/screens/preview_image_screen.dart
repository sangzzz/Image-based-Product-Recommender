import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recommender/widgets/rounded_button.dart';

class PreviewImageScreen extends StatelessWidget {
  const PreviewImageScreen({Key key, this.path}) : super(key: key);
  final String path;
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
                    color: Colors.pink.shade800,
                    text: 'Retake',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButton(
                    color: Colors.teal,
                    text: 'Search',
                    onPressed: () {},
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
