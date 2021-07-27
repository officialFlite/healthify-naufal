import 'package:flutter/material.dart';
import 'package:healthify_testing/widgets/recipe_button.dart';

class PostWorkMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(3, 3),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Text(
              'Post-Workout',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 180,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                RecipeButton(
                  boxImage:
                      AssetImage("assets/images/foods/post-workout/14.png"),
                  descButton: 'Chicken Breast and Potatoes',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                SizedBox(width: 15),
                RecipeButton(
                  boxImage:
                      AssetImage("assets/images/foods/post-workout/15.png"),
                  descButton: 'Greek Yogurt and Banana',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                SizedBox(width: 15),
                RecipeButton(
                  boxImage:
                      AssetImage("assets/images/foods/post-workout/16.png"),
                  descButton: 'Oatmeal and Avocado',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
