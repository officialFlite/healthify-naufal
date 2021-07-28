import 'package:flutter/material.dart';

class RestButton extends StatelessWidget {
  final String descButton, descText, descFull;
  final Function press;
  final String boxImage;
  final Color color, textColor;

  const RestButton({
    Key key,
    this.descButton,
    this.descText,
    this.descFull,
    this.press,
    this.color,
    this.textColor,
    this.boxImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    descButton,
                    style: TextStyle(
                      fontSize: 40,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    descText,
                    style: TextStyle(
                      fontSize: 25,
                      color: textColor,
                      fontWeight: FontWeight.w300,
                    ),
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
