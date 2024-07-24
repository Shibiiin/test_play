import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/dashBoard_page.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
    with TickerProviderStateMixin {
  double fontSize = 2;
  double containerSize = 3;
  double textOpacity = 0.0;
  double containerOpacity = 0.0;

  // AnimationController? controller;
  Animation<double>? animation1;

  @override
  void initState() {
    super.initState();

    AnimationController controller = AnimationController(
      duration: const Duration(seconds: 2), // Set the desired duration
      vsync: this, // You need to specify a TickerProvider
    );

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          textOpacity = 1.0;
        });
      });

    controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        containerSize = 2;
        containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 4), () {
      setState(() {
        Navigator.pushReplacement(context, PageTransition(DashBoard()));
        // Navigator.pushReplacement(context, PageTransition(const UpgradingWidget()));
      });
    });
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0E1AB7),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: aquaGradients,
                  begin: Alignment.center,
                  end: Alignment.bottomRight),
            ),
            // height: MediaQuery.of(context).size.height *0.2,
          ),
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(seconds: 5),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / fontSize),
              AnimatedOpacity(
                duration: const Duration(seconds: 5),
                opacity: textOpacity,
                child: Text(
                  'Upgrader Check',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 5),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: containerOpacity,
              child: AnimatedContainer(
                  duration: const Duration(seconds: 5),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height * 0.4,
                  width: width * 0.65,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
// child: Image.asset('assets/images/file_name.png')
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/pendingLoan.png",
                        fit: BoxFit.fill,
                      ),
                      Text(
                        'ABC Check',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          //fontSize: animation1?.value,
                          fontSize: MediaQuery.of(context).size.width * 0.040,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 5),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

const List<Color> aquaGradients = [
  Color(0xFF0F1BD5),
  Color(0xFF23408A),
  Color(0xFF23408A),
];
