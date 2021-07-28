import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final WorkoutButton workoutbutton;

  const ImageDialog({Key key, this.workoutbutton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 450,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 400,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: ExactAssetImage(workoutbutton.boxImage),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Text(
              workoutbutton.descButton,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              workoutbutton.descText,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 19,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Text(
                  workoutbutton.descFull,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutButton extends StatelessWidget {
  final String descButton, descText, descFull;
  final Function press;
  final String boxImage;
  final Color color, textColor;

  const WorkoutButton({
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
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) => ImageDialog(
              workoutbutton: WorkoutButton(
                boxImage: boxImage,
                descButton: descButton,
                descText: descText,
                descFull: descFull,
              ),
            ),
          );
        },
        child: Container(
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
                child: Image.asset(
                  boxImage,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
