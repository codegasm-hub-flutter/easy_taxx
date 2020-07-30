import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/categoryfinishedscreens/Carryforward.dart';
import 'package:easy_taxx/categoryfinishedscreens/PersonalData.dart';

class TotalTaxAmount extends StatefulWidget {
  TotalTaxAmount({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TotalTaxAmount createState() => _TotalTaxAmount();
}

class _TotalTaxAmount extends State<TotalTaxAmount> {
//  var screenWidth = MediaQuery.of(context).size.width;
//  var screenHeight = MediaQuery.of(context).size.height;
//  double height;
//  double width;
  //double sp_width;
  final Color lightbluecolor = Color(0xFF38B6FF);

  @override
  Widget build(BuildContext context) {
//    width = MediaQuery.of(context).size.width;
//    height = MediaQuery.of(context).size.height;
    //sp_width = width * 0.85;
    //print(height);
    return Scaffold(
      backgroundColor: Color(0xFFf2f6ff),
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color(0xFF38B6FF),

      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       IconButton(
      //         onPressed: () {
      //           //Navigator.push(context, MaterialPageRoute(builder: (context)=>mainTax()));
      //           Navigator.pushReplacementNamed(context, 'allCategoryScreen');
      //           },
      //         icon: new Image.asset('images/close.png',color: Colors.white,),
      //       ),
      //       // Your widgets here
      //     ],
      //   ),

      // ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: lightbluecolor,
                    height: MediaQuery.of(context).size.height / 2.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                            ),
                            // SizedBox(height: 20),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: new Image.asset(
                            'images/party.png',
                            width: 80,
                            height: 80,
                            // fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Geschafft',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 42.0,
                              letterSpacing: 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 95,
                  left: 10.0,
                  right: 10.0,
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 94,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1D436A).withOpacity(0.2),

                              blurRadius: 80,
                              offset:
                                  Offset(0, 12), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0, bottom: 6),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Rückerstattung",
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Color(0xFF2FBE48),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaBold'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "1.007€",
                                  style: TextStyle(
                                      fontSize: 36,
                                      color:
                                          Color(0xFF003350).withOpacity(0.803)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Container(

          //   //width: width,
          //   height: MediaQuery.of(context).size.height / 4,
          //   child: new Column(
          //     children: [
          //       new Container(
          //         margin: EdgeInsets.all(15.0),
          //         child: new Row(
          //           children: <Widget>[
          //             Text(
          //               "LOSS CARRYFORWARD",
          //               textDirection: TextDirection.ltr,
          //               style: TextStyle(
          //                 decoration: TextDecoration.none,
          //                 fontSize: 12.0,
          //                 fontWeight: FontWeight.w700,
          //                 color: Colors.black,
          //               ),
          //             ),
          //             Spacer(),
          //             Text(
          //               "574.663,00" + "€",
          //               textDirection: TextDirection.rtl,
          //               style: TextStyle(
          //                 decoration: TextDecoration.none,
          //                 fontSize: 28.0,
          //                 fontWeight: FontWeight.w700,
          //                 color: Colors.black,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       // Container(
          //       //   margin: EdgeInsets.only(left:15.0,right:15.0,top:15.0),
          //       //   child: Row(

          //       //     children: <Widget>[
          //       //       Flexible(
          //       //         child: Text(
          //       //           "If your cost exceeds your income, then you,ve made aloss for this tax year."
          //       //               " you can carry this loss over into next year with..."
          //       //           ,
          //       //           textDirection: TextDirection.ltr,
          //       //           overflow: TextOverflow.ellipsis,
          //       //           maxLines: 2,
          //       //           style: TextStyle(
          //       //             decoration: TextDecoration.none,
          //       //             fontSize: 16.0,
          //       //             fontFamily: 'Raleway',
          //       //             fontWeight: FontWeight.w700,
          //       //             color: Colors.black,

          //       //           ),

          //       //         ),
          //       //       ),

          //       //     ],
          //       //   ),

          //       // ),
          //       // Container(
          //       //   margin: EdgeInsets.only(left:15.0, top: 5.0),
          //       //   alignment: Alignment.topLeft,
          //       //   child: GestureDetector(
          //       //     onTap: () {

          //       //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Carryforward()));
          //       //     },

          //       //     child:Text(
          //       //       "Info",
          //       //       textDirection: TextDirection.ltr,
          //       //       textAlign: TextAlign.left,
          //       //       style: TextStyle(
          //       //         decoration: TextDecoration.none,
          //       //         fontSize: 15.0,
          //       //         fontFamily: 'Roboto',
          //       //         fontWeight: FontWeight.w500,
          //       //         color: lightbluecolor,

          //       //       ),

          //       //     ),
          //       //   ),
          //       // ),

          //       new Expanded(
          //         child: new Container(
          //           alignment: Alignment.bottomCenter,
          //           margin:
          //               EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             verticalDirection: VerticalDirection.down,
          //             children: <Widget>[
          //               MaterialButton(
          //                 shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(12.0)),
          //                 minWidth: MediaQuery.of(context).size.width * 0.85,
          //                 height: 50,
          //                 onPressed: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => Personaldata()));
          //                 },
          //                 child: Text(
          //                   "Prepare for submission",
          //                   style: TextStyle(
          //                     decoration: TextDecoration.none,
          //                     fontSize: 15.0,
          //                     fontFamily: 'Raleway',
          //                     fontWeight: FontWeight.w700,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //                 color: lightbluecolor,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      )),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(260, 50),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 3.8,
          color: Color(0xFF38B6FF),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Text(
                  "How we calculate your result",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  height: 44,
                  child: RaisedButton(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, top: 8, bottom: 8),
                      child: Text(
                        "Prepare for submission 🎉",
                        style: TextStyle(
                            color: Color(0xFF3BBDFF),
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
