import 'package:flutter/material.dart';
import 'package:healthify_testing/pages/workout_menu/selected_recipe_page.dart';

class RecipeButton extends StatelessWidget {
  final String descButton;
  final Function press;
  final Color color, textColor;
  final AssetImage boxImage;
  const RecipeButton({
    Key key,
    this.descButton,
    this.press,
    this.color,
    this.textColor,
    this.boxImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: boxImage,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black.withOpacity(.01),
              Colors.black.withOpacity(.6),
            ],
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.bottomLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedRecipePage(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              descButton,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
