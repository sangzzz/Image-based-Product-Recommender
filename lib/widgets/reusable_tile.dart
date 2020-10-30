import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        horizontal: 40.0,
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
                  builder: (context) =>
                      RecommendationScreen(link: link, path: path),
                ),
              );
            }
          },
          child: ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.amazon,
              color: Colors.grey.shade400,
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: TypewriterAnimatedTextKit(
                  totalRepeatCount: 1,
                  speed: Duration(milliseconds: 125),
                  text: [classification.toUpperCase()],
                  textStyle: kCardTextStyle.copyWith(
                    color: Colors.grey.shade400,
                    fontSize: 16.0,
                    fontFamily: 'Itim',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
