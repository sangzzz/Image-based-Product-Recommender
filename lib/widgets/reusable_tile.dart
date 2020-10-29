import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recommender/models/constants.dart';
import 'dart:convert';
import 'package:recommender/screens/recommendation_screem.dart';

class ReusableTile extends StatelessWidget {
  const ReusableTile({
    Key key,
    @required this.classification,
  }) : super(key: key);

  final String classification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 100.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
          color: Color(0XFF1F252E),
        ),
        child: GestureDetector(
          onTap: () async {
            var response = await http.get(
                '$url?cx=$cx&q=shop+${classification.toLowerCase()}&key=$apiKey');
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              String link = jsonResponse['items'][0]['link'].toString();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecommendationScreen(link: link),
                ),
              );
            }
          },
          child: ListTile(
            title: Center(
              child: Text(
                classification.toUpperCase(),
                style: kCardTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
