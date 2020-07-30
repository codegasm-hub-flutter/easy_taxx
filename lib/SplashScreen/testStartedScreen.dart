import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class testStartedScreen extends StatefulWidget {
  @override
  _testStartedScreenState createState() => _testStartedScreenState();
}

class _testStartedScreenState extends State<testStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFf2f6ff),
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
          height: MediaQuery.of(context).size.height * 3.5 / 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 120.0),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image(
                      image: AssetImage("images/logoo.png"),
                      height: 145,
                      width: 145,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0, bottom: 25),
                  height: 50.0,
                  child: Text(
                    "easyTaxx",
                    style: TextStyle(fontSize: 45.0, color: Color(0xFF38B6FF)),
                  ),
                ),
              ],
            ),
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/oval.png"),
            fit: BoxFit.fill,
          ),
        ),
        height: MediaQuery.of(context).size.height * 1.5 / 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   height: 50,
            // ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'LoginPage');
              },
              child: Text(
                "Avoid",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 40.00,
            ),
            ButtonTheme(
              minWidth: 285,
              height: 48,
              child: RaisedButton(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'NewHere');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "       Im new here 👋       ",
                    style: TextStyle(
                        color: Color(0xFF3BBDFF),
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        letterSpacing: 1.2,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
          ],
        ),
        // color: Color(0xFF38B6FF),
      ),
    );
  }
}
