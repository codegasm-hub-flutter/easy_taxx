import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/home_flow/homemainquestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';

class HomeYesNoContainer extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  String briefqstn;
  double containerSize;
  String bigQuestion;
  String additionalData = "";
  String multipleData;

  HomeYesNoContainer(
      {this.identity,
      this.briefqstn,
      this.bigQuestion,
      this.completeQuestion,
      this.questionOption,
      this.containerSize,
      this.additionalData,
      this.multipleData});

  @override
  _HomeYesNoContainerScreenState createState() =>
      _HomeYesNoContainerScreenState();
}

class _HomeYesNoContainerScreenState extends State<HomeYesNoContainer> {
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
    // double maxHeight = 370.0;
    //double maxHeight = 280.0;
    double maxHeight = widget.completeQuestion ==
            "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?"
        ? 300.0
        : widget.containerSize;
    // widget.Containersize;
    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 10.0, bottom: 0.0, right: 10, left: 10),
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
              child: Column(
                children: <Widget>[
                  Dismissible(
                    key: _formKey,
                    background: Container(
                      color: Color(0xfff2f6ff),
                    ),
                    onDismissed: (DismissDirection direction) {
                      qu.HomeAddAnswer(
                          widget.identity,
                          widget.bigQuestion,
                          widget.completeQuestion,
                          widget.questionOption,
                          ['skip'],
                          55.0);

                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeMainQuestions(
                            CheckCompleteQuestion: widget.completeQuestion,
                            CheckQuestion: widget.questionOption,
                            CheckAnswer: ["skip"]);
                      }));
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
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color(0xFF84868C).withOpacity(0.3),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                // margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
                                ),
                                height: widget.completeQuestion ==
                                        "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?"
                                    ? 218.0
                                    : 138.0,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Positioned(
                                  right:
                                      MediaQuery.of(context).size.width * 0.04,
                                  top: 7.0,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return questionInQuestion(
                                              widget.completeQuestion,widget.briefqstn);
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
                                      widget.multipleData,
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
                                      widget.completeQuestion,
                                      style: TextStyle(
                                          fontSize: questionFontSize,
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
                  //     new BoxShadow(
                  //       color: Colors.grey[300],
                  //       blurRadius: 0.8,
                  //     ),
                  //   ]),
                  // ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                        //                      decoration: new BoxDecoration(boxShadow: [
//                        new BoxShadow(
//                          color: Colors.grey,
//                          blurRadius: 2.0,
//                        ),
//                      ]),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                if (widget.completeQuestion ==
                                        "Does your partner live somewhere else?" &&
                                    widget.questionOption ==
                                        "Partner somewhere else") {
                                  qu.HomeAddAnswer(
                                      "Partner", "", "", "", [], 60.0);
                                } else if (widget.completeQuestion ==
                                        "Did one or both of you move in 2019?" &&
                                    widget.questionOption == "Moving") {
                                  qu.HomeAddAnswer(
                                      "You & Partner", "", "", "", [], 60.0);
                                }
                                //Questions.animatedContainer = 420.0;
                                qu.HomeAddAnswer(
                                    widget.identity,
                                    widget.bigQuestion,
                                    widget.completeQuestion,
                                    widget.questionOption,
                                    ['Yes'],
                                    55.0);

                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeMainQuestions(
                                      CheckCompleteQuestion:
                                          widget.completeQuestion,
                                      CheckQuestion: widget.questionOption,
                                      CheckAnswer: ["Yes"]);
                                }));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
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
                                        color: Color.fromARGB(
                                            0XFF, 0X38, 0Xb6, 0XFF),
                                        fontFamily: "HelveticaBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.completeQuestion ==
                                        "Does your partner live somewhere else?" &&
                                    widget.questionOption ==
                                        "Partner somewhere else") {
                                  qu.HomeAddAnswer(
                                      "Partner", "", "", "", [], 60.0);
                                } else if (widget.completeQuestion ==
                                        "Did one or both of you move in 2019?" &&
                                    widget.questionOption == "Moving") {
                                  qu.HomeAddAnswer(
                                      "You & Partner", "", "", "", [], 60.0);
                                }

                                //Questions.animatedContainer = 420.0;
                                qu.HomeAddAnswer(
                                    widget.identity,
                                    widget.bigQuestion,
                                    widget.completeQuestion,
                                    widget.questionOption,
                                    ['No'],
                                    55.0);

                                Navigator.of(context).pop();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeMainQuestions(
                                      CheckCompleteQuestion:
                                          widget.completeQuestion,
                                      CheckQuestion: widget.questionOption,
                                      CheckAnswer: ["No"]);
                                }));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 52.0,
                                color: Colors.white,
                                child: Center(
                                  child: Text('No',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              0XFF, 0X38, 0Xb6, 0XFF),
                                          fontFamily: "HelveticaBold",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0)),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
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
