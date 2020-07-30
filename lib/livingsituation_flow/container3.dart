import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:easy_taxx/show.dart';
import 'package:easy_taxx/training.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';
import 'package:easy_taxx/livingsituation_flow/unsupportedscreen.dart';
import 'package:responsive_container/responsive_container.dart';
//void main() => runApp(MaterialApp(home:HomeScreen()));

class Container3 extends StatefulWidget {
  String Identity;
  String Question;
  String briefqstn;
  String QuestionOption;
  double Containersize;
  String BigQuestion;

  Container3(
      {this.Identity,
      this.BigQuestion,
      this.Question,
      this.briefqstn,
      this.QuestionOption,
      this.Containersize});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Container3> {
  bool open = false;
  bool v3 = false;
  Questions qu = Questions();
  final _formKey = GlobalKey<FormState>();
  Widget circleButton(IconData iconData) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: 30,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  void timer() {
    Timer(Duration(seconds: 1), () {
      print("Yeah, this line is printed after 3 second");
      setState(() {
        open = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .004;
    //double maxHeight = MediaQuery.of(context).size.height * .3;
    double maxHeight = widget.Containersize;
    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
        decoration: BoxDecoration(
          //color: Colors.grey[200],
          color: Color(0xFFf2f6ff),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: InkWell(
//                            onTap: () => setState(() => open = !open),
              child: Column(
                children: <Widget>[
                  Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Color(0xFFf2f6ff),
                    ),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        qu.addAnswer(widget.Identity, widget.BigQuestion,
                            widget.QuestionOption, ['skip'], 55.0);

                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return mainQuestions(
                              CheckQuestion: widget.QuestionOption,
                              CheckAnswer: ["skip"]);
                        }));
                      });
                    },
                    child: Container(
                      height: 140,
                      padding: EdgeInsets.only(top: 20),
                      // decoration: BoxDecoration(
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Color(0xFF38B6FF).withOpacity(1),
                      //       spreadRadius: 2,
                      //       blurRadius: 15,
                      //       offset: Offset(0,0), // changes position of shadow
                      //     ),
                      //   ],
                      // ),
                      child: Center(
                        child: Container(
                          //  decoration: BoxDecoration(
                          //             boxShadow: <BoxShadow>[
                          //               BoxShadow(
                          //                 color: Color(0xFF84868C).withOpacity(0.3),
                          //                 blurRadius: 4,
                          //                 offset: Offset(0, 1),
                          //               ),
                          //             ],
                          //           ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Questions.LivingCheck == 1 ||
                                          Questions.LivingCheck == 2
                                      ? Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)
                                      : Colors.deepPurple[400],
                                ),
                                height: 148.0,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Positioned(
                                  right:
                                      MediaQuery.of(context).size.width * 0.04,
                                  top: 10.0,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return questionInQuestion(
                                              widget.Question,
                                              widget.briefqstn);
                                        }));
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            "images/question_mark.png"),
                                        width: questionMarkWidth,
                                        height: questionMarkHeight,
                                      ))),
                              Positioned(
                                  left:
                                      MediaQuery.of(context).size.width / 30.0,
                                  top: 30.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 12.5, color: Colors.black),
                                    ),
                                  )),
                              Positioned(
                                top: 52.0,
                                left: MediaQuery.of(context).size.width / 30.0,
                                right: MediaQuery.of(context).size.width / 30.0,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      widget.Question,
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: Colors.white,
                                          wordSpacing: 3.0,
                                          fontFamily: "HelveticaBold",
                                          fontWeight: FontWeight.bold,
                                          height: 1.5),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  // Container(
                  //   //margin: EdgeInsets.only(top: 5.0),
                  //   height: 2.0,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: new BoxDecoration(boxShadow: [
                  //       new BoxShadow(
                  //         color: Colors.grey[300],
                  //         blurRadius: 0.8,

                  //       ),
                  //     ]),

                  // ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
//                                    decoration: new BoxDecoration(boxShadow: [
//                                      new BoxShadow(
//                                        color: Colors.grey,
//                                        //blurRadius: 0.1,
//
//                                      ),
//                                    ]),

                      width: MediaQuery.of(context).size.width * 0.93,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              //Questions.animatedContainer = 420.0;

                              if (widget.QuestionOption == "Joint assessment") {
                                qu.updateAnswer(
                                    "You & Partner", "", "", [], 60.0);
                                qu.addAnswer(
                                    widget.Identity,
                                    widget.BigQuestion,
                                    widget.QuestionOption,
                                    ['Yes'],
                                    55.0);
                                qu.addAnswer("You", "", "", [], 60.0);
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return mainQuestions(
                                      CheckQuestion: widget.QuestionOption,
                                      CheckAnswer: ["Yes"]);
                                }));
                              } else if (widget.QuestionOption ==
                                  "More than one property") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage: "images/unsupportletting.png",
                                      textTitle:
                                          "Letting, leasing, and sales of multiple properties",
                                      textMessage:
                                          "Being a landlord you probably know that tax declarations are very tricky in your situation.Please be patient while we figure out a simple solution for you.");
                                }));
                              } else if (widget.QuestionOption ==
                                  "> 10% of shares") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage: "images/adultrelative.png",
                                      textTitle: "Support of adult relatives",
                                      textMessage:
                                          "We admire that you support your relatives and we would really like to help you with your taxes.Please be a bit patient");
                                }));
                              } else if (widget.QuestionOption ==
                                  "> 25% of shares") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage:
                                          "images/unsupportsilentpartnership.png",
                                      textTitle:
                                          "Silent partnerships, Company shares, Shareholder in a company",
                                      textMessage:
                                          "Making tax declarations most profitable for you requires some more time.Please be patient while we figure out a simple solution for you!");
                                }));
                              } else if (widget.QuestionOption ==
                                  "> 1% of shares") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage:
                                          "images/unsupportsilentpartnership.png",
                                      textTitle:
                                          "Silent partnerships, Company shares, Shareholder in a company",
                                      textMessage:
                                          "Making tax declarations most profitable for you requires some more time.Please be patient while we figure out a simple solution for you!");
                                }));
                              } else if (widget.QuestionOption ==
                                  "Living abroad") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage: "images/unsupportabroad.png",
                                      textTitle:
                                          "Living abroad & income from abroad",
                                      textMessage:
                                          "Living in a different country opens perspectives! However, it makes things tricky with taxes. Please be patient while we figure out a simple solution for you.");
                                }));
                              } else if (widget.QuestionOption ==
                                  "Foreign Income") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage: "images/unsupportabroad.png",
                                      textTitle:
                                          "Living abroad & income from abroad",
                                      textMessage:
                                          "Living in a different country opens perspectives! However, it makes things tricky with taxes. Please be patient while we figure out a simple solution for you.");
                                }));
                              } else {
                                qu.addAnswer(
                                    widget.Identity,
                                    widget.BigQuestion,
                                    widget.QuestionOption,
                                    ['Yes'],
                                    55.0);

                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return mainQuestions(
                                      CheckQuestion: widget.QuestionOption,
                                      CheckAnswer: ["Yes"]);
                                }));
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.465,
                              height: 52.0,
                              //color: Colors.white,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                //borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                      color: Questions.LivingCheck == 1 ||
                                              Questions.LivingCheck == 2 ||
                                              Questions.livcolContainer == 1
                                          ? Color.fromARGB(
                                              0XFF, 0X38, 0Xb6, 0XFF)
                                          : Colors.deepPurple[300],
                                      wordSpacing: 3.0,
                                      fontFamily: "HelveticaBold",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.QuestionOption == "Child benefits") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage: "images/adultrelative.png",
                                      textTitle: "Support of adult relatives",
                                      textMessage:
                                          "We admire that you support your relatives and we would really like to help you with your taxes.Please be a bit patient");
                                }));
                              } else if (widget.QuestionOption ==
                                  "Certificate for old shares") {
                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UnSupportedScreen(
                                      textImage: "images/unsupportloan.png",
                                      textTitle: "Bank certificate",
                                      textMessage:
                                          "In order for the sale of old shares to be recorded in the tax return, a confirmation from the bank must be submitted. If this is not available, the tax case cannot be supported. The bank confirmation can be requested from the bank.");
                                }));
                              } else {
                                //Questions.animatedContainer = 420.0;
                                qu.addAnswer(
                                    widget.Identity,
                                    widget.BigQuestion,
                                    widget.QuestionOption,
                                    ['No'],
                                    55.0);

                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return mainQuestions(
                                      CheckQuestion: widget.QuestionOption,
                                      CheckAnswer: ["No"]);
                                }));
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.465,
                              height: 52.0,
                              color: Colors.white,
                              child: Center(
                                child: Text('No',
                                    style: TextStyle(
                                        color: Questions.LivingCheck == 1 ||
                                                Questions.LivingCheck == 2 ||
                                                Questions.livcolContainer == 1
                                            ? Color.fromARGB(
                                                0XFF, 0X38, 0Xb6, 0XFF)
                                            : Colors.deepPurple[300],
                                        fontFamily: "HelveticaBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  void showDefaultSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Hello from the default snackbar'),
        action: SnackBarAction(
          label: 'Click Me',
          onPressed: () {},
        ),
      ),
    );
  }
}
