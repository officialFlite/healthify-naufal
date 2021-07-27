import 'package:flutter/material.dart';
import 'package:healthify_testing/widgets/recipe_button.dart';

class BreakfastMenu extends StatelessWidget {
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
              'Breakfast',
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
                  boxImage: AssetImage("assets/images/foods/breakfast/8.png"),
                  descButton: 'Banana Pancake',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                SizedBox(width: 15),
                RecipeButton(
                  boxImage: AssetImage("assets/images/foods/breakfast/9.png"),
                  descButton: 'Bread and Omelette',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                SizedBox(width: 15),
                RecipeButton(
                  boxImage: AssetImage("assets/images/foods/breakfast/10.png"),
                  descButton: 'Peanut Butter Avocado and Toast',
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
