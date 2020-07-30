import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFf2f6ff),
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(
          width: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
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
                          style: TextStyle(
                              fontSize: 45.0, color: Color(0xFF38B6FF)),
                        ),
                      ),
                    ],
                  ),
                ),

//            color: Colors.red,

//          Opacity(
//            opacity: 0.7,
//            child: Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              color: Color(0xFF38B6FF)Accent,
//            ),
//          ),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: <Widget>[
                //       Center(child:

                //       GestureDetector(
                //         onTap: (){
                //           Navigator.pushNamed(context, 'LoginPage');
                //         },
                //         child: Text('Already registered?',style: TextStyle(color: Colors.white),),
                //       )

                //         ,),
                //       SizedBox(height: 15.0,),
                //       Center(child:
                //       GestureDetector(
                //         onTap: (){
                //           Navigator.pop(context);
                //           Navigator.pushNamed(context, 'NewHere');
                //         },
                //         child:
                //         Container(
                //           width: MediaQuery.of(context).size.width * 0.8,
                //           height: 50.0,
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(25.0),
                //               ),
                //           child:Center(child:
                //           Text('Im new here'),),
                //         ),),

                //       ),
                //       SizedBox(height: 15.0,),
                //     ],
                //   ),),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/oval.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height / 2.6,
        // color: Color(0xFF38B6FF),
        child: Padding(
          padding: EdgeInsets.only(top: 25.0),
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
        ),
      ),
    );
  }
}
