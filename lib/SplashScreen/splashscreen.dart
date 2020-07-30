import 'package:easy_taxx/SplashScreen/startedScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          //image: DecorationImage(image: AssetImage("images/mainimage.png"), ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.6, 0.6, 1.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
              Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
              Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
              Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Image(
                  image: AssetImage("images/mainimage.png"),
                )),
            Expanded(
              //child:Image(image: AssetImage("images/maintext.png"),) ,
              // child:Image(image: AssetImage("images/maintext.jpg"),width: 300.0,height:50.0)
              child: Container(
                margin: EdgeInsets.only(bottom: 25),
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  //child: Container(
                  // padding: const EdgeInsets.only(
                  //     top: 8.0, right: 10, left: 10, bottom: 8.0),
                  child: Text(
                    "Mit Viel ❤️ in Hamburg gemacht",
                    style: TextStyle(
                        color: Color(0xFF38B6FF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, 'testStartedScreens');
  }
}
