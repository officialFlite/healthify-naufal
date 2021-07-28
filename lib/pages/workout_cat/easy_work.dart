import 'package:flutter/material.dart';
import 'package:healthify_testing/widgets/workout_button.dart';
import 'package:healthify_testing/widgets/rest_button.dart';

class EasyWork extends StatefulWidget {
  @override
  _EasyWorkState createState() => _EasyWorkState();
}

class _EasyWorkState extends State<EasyWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthify'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 178, 34, 34),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                WorkoutButton(
                  boxImage: ("assets/images/workout-images/jumping-jacks.png"),
                  descButton: 'Jumping Jacks',
                  descText: '30 Seconds',
                  descFull:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nec porta libero. Aliquam purus dui, cursus et placerat in, rutrum in sapien. d tellus venenatis, vitae molestie turpis pulvinar. Fusce sit amet risus pharetra, maximus turpis eget, posuere orci. ',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                WorkoutButton(
                  boxImage: ("assets/images/workout-images/crossover.png"),
                  descButton: 'Crossover Crunch',
                  descText: '20x',
                  descFull:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nec porta libero. Aliquam purus dui, cursus et placerat in, rutrum in sapien. d tellus venenatis, vitae molestie turpis pulvinar. Fusce sit amet risus pharetra, maximus turpis eget, posuere orci.',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                RestButton(
                  boxImage: ("assets/images/workout-images/rest.jpg"),
                  descButton: 'Rest',
                  descText: '15 Minutes',
                  descFull:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nec porta libero. Aliquam purus dui, cursus et placerat in, rutrum in sapien. d tellus venenatis, vitae molestie turpis pulvinar. Fusce sit amet risus pharetra, maximus turpis eget, posuere orci.',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                WorkoutButton(
                  boxImage: ("assets/images/workout-images/squats.jpg"),
                  descButton: 'Squats',
                  descText: '30x',
                  descFull:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nec porta libero. Aliquam purus dui, cursus et placerat in, rutrum in sapien. d tellus venenatis, vitae molestie turpis pulvinar. Fusce sit amet risus pharetra, maximus turpis eget, posuere orci.',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                RestButton(
                  boxImage: ("assets/images/workout-images/rest.jpg"),
                  descButton: 'Rest',
                  descText: '15 Minutes',
                  descFull:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nec porta libero. Aliquam purus dui, cursus et placerat in, rutrum in sapien. d tellus venenatis, vitae molestie turpis pulvinar. Fusce sit amet risus pharetra, maximus turpis eget, posuere orci.',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
                WorkoutButton(
                  boxImage: ("assets/images/easy_jog.png"),
                  descButton: 'Jogging',
                  descText: '1 Km',
                  descFull:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nec porta libero. Aliquam purus dui, cursus et placerat in, rutrum in sapien. d tellus venenatis, vitae molestie turpis pulvinar. Fusce sit amet risus pharetra, maximus turpis eget, posuere orci.',
                  color: Color.fromARGB(255, 55, 60, 77),
                  textColor: Colors.black,
                  press: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
