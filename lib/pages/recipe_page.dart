import 'package:flutter/material.dart';
import 'package:healthify_testing/pages/workout_menu/breakfast_menu.dart';
import 'package:healthify_testing/pages/workout_menu/dinner_menu.dart';
import 'package:healthify_testing/pages/workout_menu/lunch_menu.dart';
import 'package:healthify_testing/pages/workout_menu/post_work_menu.dart';
import 'package:healthify_testing/pages/workout_menu/pre_work_menu.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthify'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 178, 34, 34),
      ),
      body: Container(
        color: Colors.grey[300],
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
        //     0.1,
        //     0.4,
        //   ], colors: [
        //     Colors.black.withOpacity(.5),
        //     Colors.black.withOpacity(.0)
        //   ]),
        // ),
        width: double.infinity,
        padding: EdgeInsets.all(13),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red[400],
                      Colors.orange[200],
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(3, 3),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eat.',
                      style: TextStyle(
                        fontSize: 55,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Boost your workout with these choices of  healthy food recipe.',
                      style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(3),
                child: Column(
                  children: [
                    PreWorkMenu(),
                    SizedBox(height: 20),
                    PostWorkMenu(),
                    SizedBox(height: 20),
                    BreakfastMenu(),
                    SizedBox(height: 20),
                    LunchMenu(),
                    SizedBox(height: 20),
                    DinnerMenu(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Text('Pre-Workout'),
      // Text('Post-Workout'),
      // Text('Breakfast'),
      // Text('Lunch'),
      // Text('Dinner'),
    );
  }
}
