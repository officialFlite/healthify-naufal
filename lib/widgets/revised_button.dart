import 'package:flutter/material.dart';

class RevisedButton extends StatelessWidget {
  final String descButton, descText;
  final Function press;
  final Color color, textColor;
  final AssetImage boxImage;
  const RevisedButton({
    Key key,
    this.descButton,
    this.descText,
    this.press,
    this.color,
    this.textColor,
    this.boxImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: boxImage,
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(4, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(10, 13, 10, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black.withOpacity(.1),
              Colors.black.withOpacity(.8),
            ],
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: press,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(5, 85, 5, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  descButton,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  descText,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
