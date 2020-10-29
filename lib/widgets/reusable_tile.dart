import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recommender/models/constants.dart';
import 'dart:convert';
import 'package:recommender/screens/recommendation_screen.dart';

class ReusableTile extends StatelessWidget {
  const ReusableTile({
    Key key,
    @required this.classification,
    @required this.path,
  }) : super(key: key);

  final String classification;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 60.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          color: Color(0XFF1D1E33),
        ),
        child: ListTile(
          title: TextButton(
            onPressed: () async {
              var response = await http.get(
                  '$url?cx=$cx&q=shop+${classification.toLowerCase()}&key=$apiKey');
              if (response.statusCode == 200) {
                var jsonResponse = jsonDecode(response.body);
                String link = jsonResponse['items'][0]['link'].toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecommendationScreen(link: link, path: path),
                  ),
                );
              }
            },
            child: Center(
              child: Text(
                classification.toUpperCase(),
                style: kCardTextStyle.copyWith(
                  color: Color(0XFFEB1555),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
