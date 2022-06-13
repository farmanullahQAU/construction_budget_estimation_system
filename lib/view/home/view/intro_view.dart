// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:construction_budget_estimation_system/view/signup/signup_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w800,),
      bodyTextStyle: TextStyle(fontSize: 25.0, ),

      // descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),

      imagePadding: EdgeInsets.all(20), //image padding
      // boxDecoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topRight,
      //     end: Alignment.bottomLeft,
      //     stops: [0.1, 0.5, 0.7, 0.9],
      //     colors: [
      //       Colors.cyanAccent,
      //       Colors.cyan,
      //       Colors.cyanAccent,
      //       Colors.cyan,
      //     ],
      //   ),
      // ),
    );

    return IntroductionScreen(
      // globalBackgroundColor: Colors.cyan,
      //main background of screen
      pages: [
        //set your page view here
        PageViewModel(
          title: "Welcome to Construction Budget Estimateion System",
          body:
              "Supported by Human Appeal ",
          image: introImage('assets/images/cbes_logo.png'),
          decoration: pageDecoration,
        ),

          
   
         PageViewModel(
          title: "Access for ",
          body:
              "Vendor, Builder and Landowner ",
          image: introImage('assets/images/cbes_logo.png'),
          decoration: pageDecoration,
        ),
             PageViewModel(
          title: "Welcome to Construction Budget Estimateion System",
          body:
              "Easy, Fast and Secure ",
          image: introImage('assets/images/cbes_logo.png'),
          decoration: pageDecoration,
        ),



        //add more screen here
      ],

      onDone: () => Get.off(()=>SignupView()), //go to home page on done
      onSkip: () => goHomepage(context), // You can override on skip
      showSkipButton: true,
      // skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: const TextStyle(),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: const Text(
        'Continue',
        
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0), //size of dots
        color: Colors.white, //color of dots
        activeSize: Size(22.0, 10.0),
        //activeColor: Colors.white, //color of active dot
        activeShape: RoundedRectangleBorder(
          //shave of active dot
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void goHomepage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return SignupView();
    }), (Route<dynamic> route) => false);
  }

  Widget introImage(String assetName) {
    return DottedBorder(
      borderType: BorderType.Circle,
      radius: Radius.circular(20),
      // color: Colors.blueAccent,
      dashPattern: [1, 2, 3, 6, 8],
      strokeWidth: 10,
      strokeCap: StrokeCap.butt,
      padding: EdgeInsets.all(1),
      child: CircleAvatar(
        backgroundImage: ExactAssetImage(
          'assets/images/cbes_logo.png',
        ),
        radius: 90,
      ),
    );
  }
}


