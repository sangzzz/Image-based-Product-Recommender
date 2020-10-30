import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  RoundedButton({
    @required this.text,
    @required this.color,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
        ),
        child: FlatButton(
          onPressed: onPressed,
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Itim',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
