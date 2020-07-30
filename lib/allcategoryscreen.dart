import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_taxx/screens/testAPI.dart';
import 'package:easy_taxx/screens/testDb.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/income_flow/incomemainquestions.dart';
import 'package:easy_taxx/home_flow/homemainquestions.dart';
import 'package:easy_taxx/education_flow/educationmainquestions.dart';
import 'package:easy_taxx/family_flow/familymainquestions.dart';
import 'package:easy_taxx/health_flow/healthmainquestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finance_flow/financemainquestions.dart';
import 'package:easy_taxx/work_flow/workmainquestions.dart';
import 'package:easy_taxx/categoryfinishedscreens/totaltaxamount.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:io';

class AllCategoryScreen extends StatefulWidget {
  @override
  _AllCategoryScreenState createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen>
    with SingleTickerProviderStateMixin {
  double screenheight, screenwidth;
  bool isCollasped = true;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.65).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<QuestionInDb>> _getQuestions() async {
    var queryRow = await DbHelper.insatance.queryAll();

    var jsonData = json.decode(queryRow.toString());

    List<QuestionInDb> allQuestion = [];

    for (var q in jsonData) {
      QuestionInDb questionInDb =
          QuestionInDb(q["_id"], q["question"], q["answer"], q["status"]);
      allQuestion.add(questionInDb);
    }

    return allQuestion;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;
    final Duration duration = const Duration(milliseconds: 300);

    return Stack(
      children: <Widget>[
        menu(context),
        AnimatedPositioned(
          duration: duration,
          top: isCollasped ? 0 : 0.05 * screenheight,
          bottom: 0,
          left: isCollasped ? 0 : -0.3 * screenwidth,
          right: isCollasped ? 0 : 0.6 * screenwidth,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              animationDuration: Duration(milliseconds: 300),
              borderRadius: BorderRadius.circular(20),
              elevation: 8,
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage("images/bg.png"), fit: BoxFit.cover)
                  color: Color(0xfff2f6ff),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: Container(
                          height: 110,
                          color: Color(0xFF38B6FF),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 45.0,
                              ),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child:
                                          // Icon(
                                          //   Icons.arrow_back_ios,
                                          //   color: Colors.white,
                                          //   size: 22.0,
                                          // )
                                          Image(
                                        image: AssetImage(
                                            "images/arrow_forward_ios.png"),
                                        height: 16,
                                        width: 9,
                                      ),
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isCollasped) {
                                                _controller.forward();
                                              } else {
                                                _controller.reverse();
                                              }

                                              isCollasped = !isCollasped;
                                              print("is " +
                                                  isCollasped.toString());
                                            });
                                          },
                                          // onTap: () {},
                                          // child: Icon(
                                          //   Icons.person_outline,
                                          //   color: Colors.white,
                                          //   size: 32,
                                          // ),
                                          child: Image(
                                            image: AssetImage(
                                                "images/allcategoryuser.png"),
                                            width: 18.0,
                                            height: 18.0,
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  trailing: Image(
                                    image: AssetImage("images/skip.png"),
                                    width: 21.0,
                                    height: 21.0,
                                  )),
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   height: 60.0,
                      //   color: Color(0xFF38B6FF),

                      //   child: ListTile(

                      //       title: Container(child:Text("You have not verified your email address yet.",style: TextStyle(color: Colors.white,fontSize: 13.0),)),
                      //       trailing: Text("Resend Email",style: TextStyle(fontSize: 15.0),)
                      //   ),

                      // ),

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ListTile(
                      //     title: Text(
                      //       "Tax 2019",
                      //       style: TextStyle(
                      //         fontSize: 22.0,
                      //         fontWeight: FontWeight.bold,
                      //        color: Color(0xFF003350).withOpacity(0.803),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Container(

                          // height: MediaQuery.of(context).size.height * 0.81,
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: AssetImage("images/textbg.png"),
                                  //     fit: BoxFit.cover)),
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Tax 2019",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'HelveticaBold',
                                        color: Color(0xFF003350)
                                            .withOpacity(0.803)
                                            .withOpacity(0.803),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                LivingSituation();
                              },
                              child: Container(
                                height: 88,
                                width: 320,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(12)
                                    // image: DecorationImage(
                                    //     image: AssetImage("images/livingall.png"),
                                    //     fit: BoxFit.cover)),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10,
                                      right: 25,
                                      left: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage("images/living.png"),
                                        height: 36,
                                        width: 36,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, right: 25),
                                        child: Text(
                                          "Living Situation",
                                          style: TextStyle(
                                              color: Color(0xFF003350)
                                                  .withOpacity(0.803)
                                                  .withOpacity(0.803),
                                              fontSize: 18,
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                      Image(
                                        image:
                                            AssetImage("images/movenext.png"),
                                        height: 16,
                                        width: 9,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //               Container(
                            //                 height: 110,
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.all(12.0),
                            //                   child: Container(
                            //                     decoration: BoxDecoration(
                            //           boxShadow: [
                            //   BoxShadow(
                            //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                            //     spreadRadius: 1,
                            //     blurRadius: 15,
                            //     offset: Offset(3, 0), // changes position of shadow
                            //   ),
                            // ],
                            //         ),
                            //                     child: Card(
                            //                       shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(12.0),
                            // ),
                            //                       child: GestureDetector(
                            //                           onTap: () {
                            //                             LivingSituation();
                            //                           },
                            //                           child: Container(
                            //                               padding: EdgeInsets.only(
                            //                                   top: 26.0,
                            //                                   bottom: 26.0,
                            //                                   left: 16.0,
                            //                                   right: 16.0),

                            //                               child: Row(
                            //                                 children: <Widget>[
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width *
                            //                                         0.70,
                            //                                     child: Row(
                            //                                       children: <Widget>[
                            //                                         Questions.categoryImageChange[0] == 1
                            //                                             ? Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/living.png"),
                            //                                               )
                            //                                             : Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/living.png")),
                            //                                         Padding(
                            //                                           padding: EdgeInsets.only(
                            //                                               left: 18.0, top: 8),
                            //                                           child: Text(
                            //                                             "Living Situation",
                            //                                             style: TextStyle(
                            //                                               fontSize: 19.0,
                            //                                               color: Color(0xFF212335),
                            //                                             ),
                            //                                           ),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width *
                            //                                         0.12,
                            //                                     child: Row(
                            //                                       mainAxisAlignment:
                            //                                           MainAxisAlignment.end,
                            //                                       children: <Widget>[
                            //                                         Padding(
                            //                                           padding:
                            //                                               EdgeInsets.only(right: 5.0),
                            //                                           child: Questions
                            //                                                       .categoryFinish[0] ==
                            //                                                   1
                            //                                               ? Image(
                            //                                                   image: AssetImage(
                            //                                                       "images/righttick.png"))
                            //                                               : Text(""),
                            //                                         ),
                            //                                         Icon(
                            //                                           Icons.arrow_forward_ios,
                            //                                           color: Colors.grey,
                            //                                           size: 16.0,
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   )
                            //                                 ],
                            //                               ))),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),

                            // Divider(
                            //   height: 10.0,
                            //   thickness: 1.0,
                            // ),

                            GestureDetector(
                              onTap: () {
                                Income();
                              },
                              child: Container(
                                height: 88,
                                width: 320,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(12)
                                    // image: DecorationImage(
                                    //     image: AssetImage("images/livingall.png"),
                                    //     fit: BoxFit.cover)),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10,
                                      right: 25,
                                      left: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage("images/income.png"),
                                        height: 36,
                                        width: 36,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, right: 89),
                                        child: Text(
                                          "Income",
                                          style: TextStyle(
                                              color: Color(0xFF003350)
                                                  .withOpacity(0.803)
                                                  .withOpacity(0.803),
                                              fontSize: 18,
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                      Image(
                                        image:
                                            AssetImage("images/movenext.png"),
                                        height: 16,
                                        width: 9,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            //               Container(
                            //                 height: 110,
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.all(12.0),
                            //                   child: Container(
                            //                      decoration: BoxDecoration(
                            //           boxShadow: [
                            //   BoxShadow(
                            //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                            //     spreadRadius: 1,
                            //     blurRadius: 15,
                            //     offset: Offset(3, 0), // changes position of shadow
                            //   ),
                            // ],
                            //         ),
                            //                     child: Card(
                            //                       shape: RoundedRectangleBorder(
                            //                         borderRadius: BorderRadius.circular(12.0),
                            //                       ),
                            //                       child: GestureDetector(
                            //                           onTap: () {
                            //                             Income();
                            //                           },
                            //                           child: Container(
                            //                               padding: EdgeInsets.only(
                            //                                   top: 22.0,
                            //                                   bottom: 22.0,
                            //                                   left: 16.0,
                            //                                   right: 16.0),

                            //                               child: Row(
                            //                                 children: <Widget>[
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width *
                            //                                         0.70,
                            //                                     child: Row(
                            //                                       children: <Widget>[
                            //                                         Questions.categoryImageChange[1] == 1
                            //                                             ? Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/income.png"))
                            //                                             : Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/income.png")),
                            //                                         Padding(
                            //                                           padding: EdgeInsets.only(
                            //                                               left: 18.0, top: 8),
                            //                                           child: Text(
                            //                                             "Income",
                            //                                             style: TextStyle(
                            //                                               fontSize: 20.0,
                            //                                               color: Color(0xFF212335),),
                            //                                           ),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width *
                            //                                         0.12,
                            //                                     child: Row(
                            //                                       mainAxisAlignment:
                            //                                           MainAxisAlignment.end,
                            //                                       children: <Widget>[
                            //                                         Padding(
                            //                                           padding:
                            //                                               EdgeInsets.only(right: 5.0),
                            //                                           child: Questions
                            //                                                       .categoryFinish[1] ==
                            //                                                   1
                            //                                               ? Image(
                            //                                                   image: AssetImage(
                            //                                                       "images/righttick.png"))
                            //                                               : Text(""),
                            //                                         ),
                            //                                         Icon(
                            //                                           Icons.arrow_forward_ios,
                            //                                           color: Colors.grey,
                            //                                           size: 16.0,
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   )
                            //                                 ],
                            //                               ))),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),

                            GestureDetector(
                              onTap: () {
                                Home();
                              },
                              child: Container(
                                height: 88,
                                width: 320,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(12)
                                    // image: DecorationImage(
                                    //     image: AssetImage("images/livingall.png"),
                                    //     fit: BoxFit.cover)),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10,
                                      right: 25,
                                      left: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage("images/home.png"),
                                        height: 36,
                                        width: 36,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, right: 95),
                                        child: Text(
                                          "Home",
                                          style: TextStyle(
                                              color: Color(0xFF003350)
                                                  .withOpacity(0.803)
                                                  .withOpacity(0.803),
                                              fontSize: 18,
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                      Image(
                                        image:
                                            AssetImage("images/movenext.png"),
                                        height: 16,
                                        width: 9,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //               Container(
                            //                 height: 110,
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.all(12.0),
                            //                   child: Container(
                            //                      decoration: BoxDecoration(
                            //           boxShadow: [
                            //   BoxShadow(
                            //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                            //     spreadRadius: 1,
                            //     blurRadius: 15,
                            //     offset: Offset(3, 0), // changes position of shadow
                            //   ),
                            // ],
                            //         ),
                            //                     child: Card(
                            //                       shape: RoundedRectangleBorder(
                            //                         borderRadius: BorderRadius.circular(12.0),
                            //                       ),
                            //                       child: GestureDetector(
                            //                           onTap: () {
                            //                             Home();
                            //                           },
                            //                           child: Container(
                            //                               padding: EdgeInsets.only(
                            //                                   top: 22.0,
                            //                                   bottom: 22.0,
                            //                                   left: 16.0,
                            //                                   right: 16.0),

                            //                               child: Row(
                            //                                 children: <Widget>[
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width *
                            //                                         0.70,
                            //                                     child: Row(
                            //                                       children: <Widget>[
                            //                                         Questions.categoryImageChange[2] == 1
                            //                                             ? Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/home.png"))
                            //                                             : Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/home.png")),
                            //                                         Padding(
                            //                                           padding:
                            //                                               EdgeInsets.only(left: 18.0,top: 8),
                            //                                           child: Text(
                            //                                             "Home",
                            //                                             style: TextStyle(
                            //                                               fontSize: 20.0,
                            //                                               color: Color(0xFF212335),),
                            //                                           ),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width *
                            //                                         0.12,
                            //                                     child: Row(
                            //                                       mainAxisAlignment:
                            //                                           MainAxisAlignment.end,
                            //                                       children: <Widget>[
                            //                                         Padding(
                            //                                           padding:
                            //                                               EdgeInsets.only(right: 5.0),
                            //                                           child: Questions
                            //                                                       .categoryFinish[2] ==
                            //                                                   1
                            //                                               ? Image(
                            //                                                   image: AssetImage(
                            //                                                       "images/righttick.png"))
                            //                                               : Text(""),
                            //                                         ),
                            //                                         Icon(
                            //                                           Icons.arrow_forward_ios,
                            //                                           color: Colors.grey,
                            //                                           size: 16.0,
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   )
                            //                                 ],
                            //                               ))),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),

                            Questions.workCategoryEnable == "Work"
                                ? GestureDetector(
                                    onTap: () {
                                      Work();
                                    },
                                    child: Container(
                                      height: 88,
                                      width: 320,
                                      decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(12)
                                          // image: DecorationImage(
                                          //     image: AssetImage("images/livingall.png"),
                                          //     fit: BoxFit.cover)),
                                          ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10,
                                            right: 25,
                                            left: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Image(
                                              image:
                                                  AssetImage("images/work.png"),
                                              height: 36,
                                              width: 36,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, right: 89),
                                              child: Text(
                                                "Work",
                                                style: TextStyle(
                                                    color: Color(0xFF003350)
                                                        .withOpacity(0.803)
                                                        .withOpacity(0.803),
                                                    fontSize: 18,
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ),
                                            Image(
                                              image: AssetImage(
                                                  "images/movenext.png"),
                                              height: 16,
                                              width: 9,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                // Container(
                                //     height: 110,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(12.0),
                                //       child: Card(
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(10.0),
                                //         ),
                                //         child: GestureDetector(
                                //             onTap: () {
                                //               Work();
                                //             },
                                //             child: Container(
                                //                 padding: EdgeInsets.only(
                                //                     top: 22.0,
                                //                     bottom: 22.0,
                                //                     left: 16.0,
                                //                     right: 16.0),
                                //                 color: Colors.white,
                                //                 child: Row(
                                //                   children: <Widget>[
                                //                     Container(
                                //                       width: MediaQuery.of(context)
                                //                               .size
                                //                               .width *
                                //                           0.75,
                                //                       child: Row(
                                //                         children: <Widget>[
                                //                           Questions.categoryImageChange[
                                //                                       3] ==
                                //                                   1
                                //                               ? Image(
                                //                                   image: AssetImage(
                                //                                       "images/work.png"))
                                //                               : Image(
                                //                                   image: AssetImage(
                                //                                       "images/work.png")),
                                //                           Padding(
                                //                             padding: EdgeInsets.only(
                                //                                 left: 12.0),
                                //                             child: Text(
                                //                               "Work",
                                //                               style: TextStyle(
                                //                                   fontSize: 15.0,
                                //                                   color: Color(0xFF212335),),
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       ),
                                //                     ),
                                //                     Container(
                                //                       width: MediaQuery.of(context)
                                //                               .size
                                //                               .width *
                                //                           0.15,
                                //                       child: Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment.end,
                                //                         children: <Widget>[
                                //                           Padding(
                                //                             padding: EdgeInsets.only(
                                //                                 right: 5.0),
                                //                             child: Questions.categoryFinish[
                                //                                         3] ==
                                //                                     1
                                //                                 ? Image(
                                //                                     image: AssetImage(
                                //                                         "images/righttick.png"))
                                //                                 : Text(""),
                                //                           ),
                                //                           Icon(
                                //                             Icons.arrow_forward_ios,
                                //                             color: Colors.grey,
                                //                             size: 16.0,
                                //                           ),
                                //                         ],
                                //                       ),
                                //                     )
                                //                   ],
                                //                 ))),
                                //       ),
                                //     ),
                                //   )
                                : Container(),

                            Questions.workCategoryEnable == "Work"
                                ? Divider(
                                    height: 10.0,
                                    thickness: 1.0,
                                  )
                                : Container(),

                            Questions.educationCategoryEnable == "Education"
                                ? Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Education();
                                        },
                                        child: Container(
                                          height: 88,
                                          width: 320,
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(12)
                                              // image: DecorationImage(
                                              //     image: AssetImage("images/livingall.png"),
                                              //     fit: BoxFit.cover)),
                                              ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                bottom: 10,
                                                right: 25,
                                                left: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Image(
                                                  image: AssetImage(
                                                      "images/education.png"),
                                                  height: 36,
                                                  width: 36,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0, right: 70),
                                                  child: Text(
                                                    "Education",
                                                    style: TextStyle(
                                                        color: Color(0xFF003350)
                                                            .withOpacity(0.803)
                                                            .withOpacity(0.803),
                                                        fontSize: 18,
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ),
                                                Image(
                                                  image: AssetImage(
                                                      "images/movenext.png"),
                                                  height: 16,
                                                  width: 9,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : Container(),

                            // Questions.educationCategoryEnable == "Education"
                            //     ?
                            //     Divider(
                            //         height: 10.0,
                            //         thickness: 1.0,
                            //       )
                            //     : Container(),

                            Questions.familyCategoryEnable == "Family"
                                ? Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Family();
                                        },
                                        child: Container(
                                          height: 88,
                                          width: 320,
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(12)
                                              // image: DecorationImage(
                                              //     image: AssetImage("images/livingall.png"),
                                              //     fit: BoxFit.cover)),
                                              ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                bottom: 10,
                                                right: 25,
                                                left: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Image(
                                                  image: AssetImage(
                                                      "images/family.png"),
                                                  height: 36,
                                                  width: 36,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0, right: 88),
                                                  child: Text(
                                                    "Family",
                                                    style: TextStyle(
                                                        color: Color(0xFF003350)
                                                            .withOpacity(0.803)
                                                            .withOpacity(0.803),
                                                        fontSize: 18,
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ),
                                                Image(
                                                  image: AssetImage(
                                                      "images/movenext.png"),
                                                  height: 16,
                                                  width: 9,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : Container(),

                            // Questions.familyCategoryEnable == "Family"
                            //     ?
                            //     Divider(
                            //         height: 10.0,
                            //         thickness: 1.0,
                            //       )
                            //     : Container(),

                            GestureDetector(
                              onTap: () {
                                Health();
                              },
                              child: Container(
                                height: 88,
                                width: 320,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(12)
                                    // image: DecorationImage(
                                    //     image: AssetImage("images/livingall.png"),
                                    //     fit: BoxFit.cover)),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10,
                                      right: 25,
                                      left: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage("images/health.png"),
                                        height: 36,
                                        width: 36,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, right: 89),
                                        child: Text(
                                          "Health",
                                          style: TextStyle(
                                              color: Color(0xFF003350)
                                                  .withOpacity(0.803)
                                                  .withOpacity(0.803),
                                              fontSize: 18,
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                      Image(
                                        image:
                                            AssetImage("images/movenext.png"),
                                        height: 16,
                                        width: 9,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //               Container(
                            //                 height: 110,
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.all(12.0),
                            //                   child: Container(
                            //                      decoration: BoxDecoration(
                            //           boxShadow: [
                            //   BoxShadow(
                            //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                            //     spreadRadius: 1,
                            //     blurRadius: 15,
                            //     offset: Offset(3, 0), // changes position of shadow
                            //   ),
                            // ],
                            //         ),
                            //                     child: Card(
                            //                            shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(12.0),
                            // ),
                            //                           child: GestureDetector(
                            //                           onTap: () {
                            //                             Health();
                            //                           },
                            //                           child: Container(
                            //                               padding: EdgeInsets.only(
                            //                                   top: 22.0, bottom: 22.0, left: 16.0, right: 16.0),

                            //                               child: Row(
                            //                                 children: <Widget>[
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width * 0.70,
                            //                                     child: Row(
                            //                                       children: <Widget>[
                            //                                         Questions.categoryImageChange[6] == 1
                            //                                             ? Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/health.png"))
                            //                                             : Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/health.png")),
                            //                                         Padding(
                            //                                           padding: EdgeInsets.only(left: 18.0,top: 8),
                            //                                           child: Text(
                            //                                             "Health",
                            //                                             style: TextStyle(
                            //                                               fontSize: 20.0,
                            //                                               color: Color(0xFF212335),),
                            //                                           ),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width * 0.12,
                            //                                     child: Row(
                            //                                       mainAxisAlignment: MainAxisAlignment.end,
                            //                                       children: <Widget>[
                            //                                         Padding(
                            //                                           padding: EdgeInsets.only(right: 5.0),
                            //                                           child: Questions.categoryFinish[6] == 1
                            //                                               ? Image(
                            //                                                   image: AssetImage(
                            //                                                       "images/righttick.png"))
                            //                                               : Text(""),
                            //                                         ),
                            //                                         Icon(
                            //                                           Icons.arrow_forward_ios,
                            //                                           color: Colors.grey,
                            //                                           size: 16.0,
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   )
                            //                                 ],
                            //                               ))),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),

                            // Divider(
                            //   height: 10.0,
                            //   thickness: 1.0,
                            // ),

                            SizedBox(
                              height: 20,
                            ),

                            GestureDetector(
                              onTap: () {
                                Finance();
                              },
                              child: Container(
                                height: 88,
                                width: 320,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(12)
                                    // image: DecorationImage(
                                    //     image: AssetImage("images/livingall.png"),
                                    //     fit: BoxFit.cover)),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10,
                                      right: 25,
                                      left: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Image(
                                        image:
                                            AssetImage("images/fiancnce.png"),
                                        height: 36,
                                        width: 36,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, right: 80),
                                        child: Text(
                                          "Finance",
                                          style: TextStyle(
                                              color: Color(0xFF003350)
                                                  .withOpacity(0.803)
                                                  .withOpacity(0.803),
                                              fontSize: 18,
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                      Image(
                                        image:
                                            AssetImage("images/movenext.png"),
                                        height: 16,
                                        width: 9,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //               Container(

                            //                 height: 110,
                            //                 child: Padding(

                            //                   padding: const EdgeInsets.all(12.0),
                            //                   child: Container(
                            //                      decoration: BoxDecoration(
                            //           boxShadow: [
                            //   BoxShadow(
                            //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                            //     spreadRadius: 1,
                            //     blurRadius: 15,
                            //     offset: Offset(3, 0), // changes position of shadow
                            //   ),
                            // ],
                            //         ),
                            //                     child: Card(
                            //                          shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(12.0)),
                            //                          child: GestureDetector(
                            //                           onTap: () {
                            //                             Finance();
                            //                           },
                            //                           child: Container(
                            //                               padding: EdgeInsets.only(
                            //                                   top: 22.0, bottom: 22.0, left: 16.0, right: 16.0),

                            //                               child: Row(
                            //                                 children: <Widget>[
                            //                                   Container(
                            //                                     width: MediaQuery.of(context).size.width * 0.70,
                            //                                     child: Row(
                            //                                       children: <Widget>[
                            //                                         Questions.categoryImageChange[7] == 1
                            //                                             ? Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/fiancnce.png"))
                            //                                             : Image(
                            //                                                 image: AssetImage(
                            //                                                     "images/fiancnce.png")),
                            //                                         Padding(
                            //                                           padding: EdgeInsets.only(left: 18.0,top:8),
                            //                                           child: Text(
                            //                                             "Finances",
                            //                                             style: TextStyle(
                            //                                               fontSize: 20.0,
                            //                                               color: Color(0xFF212335),),
                            //                                           ),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                 Container(
                            //                                     width: MediaQuery.of(context).size.width * 0.12,
                            //                                     child: Row(
                            //                                       mainAxisAlignment: MainAxisAlignment.end,
                            //                                       children: <Widget>[
                            //                                         Padding(
                            //                                           padding: EdgeInsets.only(right: 5.0),
                            //                                           child: Questions.categoryFinish[7] == 1
                            //                                               ? Image(
                            //                                                   image: AssetImage(
                            //                                                       "images/righttick.png"))
                            //                                               : Text(""),
                            //                                         ),
                            //                                         Icon(
                            //                                           Icons.arrow_forward_ios,
                            //                                           color: Colors.grey,
                            //                                           size: 16.0,
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   )
                            //                                 ],
                            //                               ))),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                          ]))),

//

                      // Container(

                      //       margin: EdgeInsets.only(top: 30,bottom: 30,right: 10,left: 10),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: <Widget>[
                      //           Row(
                      //             children: <Widget>[
                      // Questions.afterAllCategoryFinish == true
                      //     ? Text("")
                      //     : Image(image: AssetImage(Questions.categoryImage),width: 50,height: 50,),
                      // Padding(
                      //     padding: EdgeInsets.only(left: 10.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: <Widget>[
                      //         Questions.afterAllCategoryFinish == true
                      //             ? Text(
                      //                 "Loss carryforward",
                      //                 style: TextStyle(fontSize: 16.0,color: Color(0xFF212335),),
                      //               )
                      //             : Text(
                      //                 "Next",
                      //                 style: TextStyle(fontSize: 16.0,color: Color(0xFF212335),),
                      //               ),
                      //         Text(
                      //           Questions.categoryName,
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 18,
                      //             color: Color(0xFF212335),),
                      //         ),
                      //       ],
                      //     )),
                      //             ],
                      //           ),
                      //           GestureDetector(
                      // onTap: () {
                      //   Continue();
                      // },
                      // child: Container(
                      //     margin: EdgeInsets.only(right: 10.0),
                      //     width: MediaQuery.of(context).size.width * 0.25,
                      //     height: MediaQuery.of(context).size.height / 16,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFF38B6FF),
                      //       border: Border.all(
                      //         color: Colors
                      //             .lightBlueAccent, //                   <--- border color
                      //         width: 1.0,
                      //       ),
                      //       borderRadius: BorderRadius.circular(12.0),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         Questions.afterAllCategoryFinish == true
                      //             ? "see result"
                      //             : "Continue",
                      //         style: TextStyle(
                      //           fontSize: 14.0,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ))),
                      //         ],
                      //       )
                      //       )

                      //  Container(

                      //    color: Colors.white,
                      //    child:ListTile(

                      //      leading: Container(width:MediaQuery.of(context).size.width*0.3,child:Text("Add income to see your result",style: TextStyle(color: Colors.black,fontSize: 13.0,fontWeight: FontWeight.bold),)),

                      //      trailing:  GestureDetector(
                      //          onTap: (){
                      //            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Photo()));
                      //          },
                      //          child:Container(
                      //            //margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.3),
                      //              width: MediaQuery.of(context).size.width*0.25,
                      //              height: 35.0,
                      //              decoration: BoxDecoration(
                      //                color: Color(0xFF38B6FF)Accent,
                      //                border: Border.all(
                      //                  color: Color(0xFF38B6FF)Accent, //                   <--- border color
                      //                  width: 1.0,
                      //                ),
                      //                borderRadius: BorderRadius.circular(4.0),
                      //              ),
                      //              child:Center(
                      //                child:Text("Continue",style: TextStyle(fontSize: 14.0,color: Colors.white,),),
                      //              ))),

                      //    ),
                      //  )
                    ],
                  )),
                  bottomNavigationBar: Container(
                    height: 107,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 80,
                            color: Color(0xff1D436A).withOpacity(0.2),
                            offset: Offset(0, 12),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    //        decoration: BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage("images/bottombg.png"), fit: BoxFit.cover)),
                    child: Container(
                        margin: EdgeInsets.only(
                            top: 30, bottom: 30, right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Questions.afterAllCategoryFinish == true
                                    ? Text("")
                                    : Image(
                                        image:
                                            AssetImage(Questions.categoryImage),
                                        width: 36,
                                        height: 36,
                                      ),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Questions.afterAllCategoryFinish == true
                                            ? Text(
                                                "Loss carryforward",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF212335),
                                                ),
                                              )
                                            : Text(
                                                "Next",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF003350)
                                                      .withOpacity(0.803)
                                                      .withOpacity(0.83),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        AutoSizeText(
                                          Questions.categoryName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color(0xFF003350)
                                                .withOpacity(0.803)
                                                .withOpacity(0.83),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: GestureDetector(
                                  onTap: () async {
                                    // var builder = new xml.XmlBuilder();
                                    // builder.processing('xml',
                                    //     'version="1.0" encoding="iso-8859-9"');
                                    // builder.element(queryRow.toString());
                                    // var fXml = builder.build();
                                    // DbHelper.insatance.deleteWithStatus("OK");

                                    List<Map<String, dynamic>> queryRow =
                                        await DbHelper.insatance.queryAll();
                                    print(queryRow);
                                    // var a;
                                    // Future<http.Response> fetchAlbum() {
                                    //   a = http.get(
                                    //       'https://urbanwears.co.uk/xmltojson.php');
                                    //   return a;
                                    // }

                                    // _getQuestions();

                                    // Continue();

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return testDb();
                                    }));
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(right: 1.0),
                                      width: 88,
                                      height: 47,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 2),
                                            color: Color(0xff1D436A)
                                                .withOpacity(0.3),
                                            blurRadius: 4,
                                          ),
                                        ],
                                        color: Color(0xFF38B6FF),
                                        border: Border.all(
                                          color: Colors
                                              .lightBlueAccent, //                   <--- border color
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // boxShadow: [
                                        //   BoxShadow(color:Color(0xFF38B6FF),spreadRadius: 0.4,blurRadius: 30,offset: Offset(0, 0) )
                                        // ]
                                      ),
                                      child: Center(
                                        child: Text(
                                          Questions.afterAllCategoryFinish ==
                                                  true
                                              ? "see result"
                                              : "Continue",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //menu
  Widget menu(Context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity,100),
      //   child: Container(
      //     child: Center(
      //       child: Text(
      //         "Account",

      //       ),
      //     ),
      //   )
      //   ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/menubg.png"), fit: BoxFit.cover)),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 70),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 150, right: 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Container(
                      //   margin: EdgeInsets.only(right: 20,left: 40,bottom: 30),
                      //   child: SizedBox(
                      //     height: 120,
                      //     width: 120,
                      //   ),
                      //   // child: ClipRRect(
                      //   //   borderRadius: BorderRadius.circular(20),
                      //   //   child:
                      //   //   // Image.network(
                      //   //   //     "http://discountersmall.com/download.jpg",
                      //   //   //   height: 120,
                      //   //   //   width: 120,
                      //   //   // ),

                      //   // ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 40,

                              child: Text(
                                "Change Pin",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.black54,
                              //   borderRadius: BorderRadius.circular(20),
                              //   shape: BoxShape.rectangle,
                              // ),
                              // child: Center(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(4.0),
                              //     child: Text(
                              //         "Italian",
                              //         style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 22
                              //         ),
                              //     ),
                              //   ),
                              // ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                "Terms and conditions",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.black54,
                              //   borderRadius: BorderRadius.circular(20),
                              //   shape: BoxShape.rectangle,
                              // ),
                              // child: Center(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(4.0),
                              //     child: Text(
                              //       "Asian",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 22
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.black54,
                              //   borderRadius: BorderRadius.circular(20),
                              //   shape: BoxShape.rectangle,
                              // ),
                              // child: Center(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(4.0),
                              //     child: Text(
                              //       "Exotic",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 22
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                "Cancelation policy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.black54,
                              //   borderRadius: BorderRadius.circular(20),
                              //   shape: BoxShape.rectangle,
                              // ),
                              // child: Center(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(4.0),
                              //     child: Text(
                              //       "French",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 22
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                "FAQ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.black54,
                              //   borderRadius: BorderRadius.circular(20),
                              //   shape: BoxShape.rectangle,
                              // ),
                              // child: Center(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(4.0),
                              //     child: Text(
                              //       "Chinese",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 22
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 120,
                        child: Divider(
                          color: Color(0xFF38B6FF),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                "Imprint",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                "Send diagnostic data",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //menu ends

  void LivingSituation() {
    Questions.categoryName = "Income";
    Questions.categoryImage = "images/income.png";
    Questions.categoryImageChange[0] = 1;

    if (Questions.answerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return mainQuestions(CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return mainQuestions(
            CheckQuestion: Questions.answerShow[Questions.answerShow.length - 1]
                ['question'],
            CheckAnswer: [
              Questions.answerShow[Questions.answerShow.length - 1]['answer'][0]
            ]);
      }));
    }
  }

  void Income() {
    Questions.categoryName = "Home";
    Questions.categoryImage = "images/home.png";
    Questions.categoryImageChange[1] = 1;

    if (Questions.incomeAnswerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return IncomeMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return IncomeMainQuestions(
            CheckCompleteQuestion: Questions
                    .incomeAnswerShow[Questions.incomeAnswerShow.length - 1]
                ['completequestion'],
            CheckQuestion: Questions
                    .incomeAnswerShow[Questions.incomeAnswerShow.length - 1]
                ['question'],
            CheckAnswer: [
              Questions.incomeAnswerShow[Questions.incomeAnswerShow.length - 1]
                  ['answer'][0]
            ]);
      }));
    }
  }

  void Home() {
    Questions.categoryName = "Education";
    Questions.categoryImage = "images/family.png";
    Questions.categoryImageChange[2] = 1;

    if (Questions.homeAnswerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeMainQuestions(
            CheckCompleteQuestion:
                Questions.homeAnswerShow[Questions.homeAnswerShow.length - 1]
                    ['completequestion'],
            CheckQuestion:
                Questions.homeAnswerShow[Questions.homeAnswerShow.length - 1]
                    ['question'],
            CheckAnswer: [
              Questions.homeAnswerShow[Questions.homeAnswerShow.length - 1]
                  ['answer'][0]
            ]);
      }));
    }
  }

  void Work() {
    Questions.categoryImageChange[3] = 1;

    if (Questions.workAnswerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WorkMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WorkMainQuestions(
            CheckCompleteQuestion:
                Questions.workAnswerShow[Questions.workAnswerShow.length - 1]
                    ['completequestion'],
            CheckQuestion:
                Questions.workAnswerShow[Questions.workAnswerShow.length - 1]
                    ['question'],
            CheckAnswer: [
              Questions.workAnswerShow[Questions.workAnswerShow.length - 1]
                  ['answer'][0]
            ]);
      }));
    }
  }

  void Education() {
    Questions.categoryName = "Family";
    Questions.categoryImage = "images/family.png";
    Questions.categoryImageChange[4] = 1;

    if (Questions.educationAnswerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EducationMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EducationMainQuestions(
            CheckCompleteQuestion: Questions.educationAnswerShow[
                Questions.educationAnswerShow.length - 1]['completequestion'],
            CheckQuestion: Questions.educationAnswerShow[
                Questions.educationAnswerShow.length - 1]['question'],
            CheckAnswer: [
              Questions.educationAnswerShow[
                  Questions.educationAnswerShow.length - 1]['answer'][0]
            ]);
      }));
    }
  }

  void Family() {
    Questions.categoryName = "Health";
    Questions.categoryImage = "images/health.png";
    Questions.categoryImageChange[5] = 1;

    if (Questions.familyAnswerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FamilyMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FamilyMainQuestions(
            CheckCompleteQuestion: Questions
                    .familyAnswerShow[Questions.familyAnswerShow.length - 1]
                ['completequestion'],
            CheckQuestion: Questions
                    .familyAnswerShow[Questions.familyAnswerShow.length - 1]
                ['question'],
            CheckAnswer: [
              Questions.familyAnswerShow[Questions.familyAnswerShow.length - 1]
                  ['answer'][0]
            ]);
      }));
    }
  }

  void Health() {
    Questions.categoryName = "Finances";
    Questions.categoryImage = "images/fiancnce.png";
    Questions.categoryImageChange[6] = 1;

    if (Questions.healthAnswerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HealthMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HealthMainQuestions(
            CheckCompleteQuestion: Questions
                    .healthAnswerShow[Questions.healthAnswerShow.length - 1]
                ['completequestion'],
            CheckQuestion: Questions
                    .healthAnswerShow[Questions.healthAnswerShow.length - 1]
                ['question'],
            CheckAnswer: [
              Questions.healthAnswerShow[Questions.healthAnswerShow.length - 1]
                  ['answer'][0]
            ]);
      }));
    }
  }

  void Finance() {
    Questions.categoryName = "Finances";
    Questions.categoryImage = "images/fiancnce.png";
    Questions.categoryImageChange[7] = 1;

    if (Questions.financeAnswerShow.length == 0) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FinanceMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FinanceMainQuestions(
            CheckCompleteQuestion: Questions
                    .financeAnswerShow[Questions.financeAnswerShow.length - 1]
                ['completequestion'],
            CheckQuestion: Questions
                    .financeAnswerShow[Questions.financeAnswerShow.length - 1]
                ['question'],
            CheckAnswer: [
              Questions
                      .financeAnswerShow[Questions.financeAnswerShow.length - 1]
                  ['answer'][0]
            ]);
      }));
    }
  }

  void Continue() {
    if (Questions.categoryName == "Income") {
      Questions.categoryImageChange[1] = 1;

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return IncomeMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else if (Questions.categoryName == "Home") {
      Questions.categoryImageChange[2] = 1;

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else if (Questions.categoryName == "Education") {
      Questions.categoryImageChange[4] = 1;

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EducationMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else if (Questions.categoryName == "Family") {
      Questions.categoryImageChange[5] = 1;

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FamilyMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else if (Questions.categoryName == "Health") {
      Questions.categoryImageChange[6] = 1;

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HealthMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else if (Questions.categoryName == "Finances") {
      Questions.categoryImageChange[7] = 1;

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FinanceMainQuestions(
            CheckCompleteQuestion: "", CheckQuestion: "", CheckAnswer: []);
      }));
    } else if (Questions.categoryName == "574.663,00€") {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TotalTaxAmount()));
    }
  }
}

class QuestionInDb {
  final int _id;
  final String question;
  final String answer;
  final String status;

  QuestionInDb(this._id, this.question, this.answer, this.status);
}
