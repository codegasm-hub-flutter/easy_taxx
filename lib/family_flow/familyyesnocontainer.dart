import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/family_flow/familymainquestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';

class FamilyYesNoContainer extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  String briefqstn;
  double containerSize;
  String bigQuestion;
  String additionalData = "";
  String multipleData;

  FamilyYesNoContainer(
      {this.identity,
      this.bigQuestion,
      this.briefqstn,
      this.completeQuestion,
      this.questionOption,
      this.containerSize,
      this.additionalData,
      this.multipleData});

  @override
  _FamilyYesNoContainerScreenState createState() =>
      _FamilyYesNoContainerScreenState();
}

class _FamilyYesNoContainerScreenState extends State<FamilyYesNoContainer> {
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
    double maxHeight = widget.containerSize;
    // widget.Containersize;
    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 10.0, right: 10, left: 10, bottom: 0.0),
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
                      color: Color(0xFFf2f6ff),
                    ),
                    onDismissed: (DismissDirection direction) {
                      qu.FamilyAddAnswer(
                          widget.identity,
                          widget.bigQuestion,
                          widget.completeQuestion,
                          widget.questionOption,
                          ['skip'],
                          55.0);

                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FamilyMainQuestions(
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
                                height: 140.0,
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
                                          fontWeight: FontWeight.w600,
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
                        color: Colors.white,
                        //                      decoration: new BoxDecoration(boxShadow: [
//                        new BoxShadow(
//                          color: Colors.grey,
//                          blurRadius: 2.0,
//                        ),
//                      ]),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: SafeArea(
                          bottom: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  YesResponse();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 52.0,
                                  //color: Colors.white,
                                  decoration: BoxDecoration(
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
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'HelveticaBold',
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  NoResponse();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 52.0,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text('No',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                0XFF, 0X38, 0Xb6, 0XFF),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaBold',
                                            fontSize: 16.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            )));
  }

  void NoResponse() {
    if (widget.completeQuestion ==
            "Did you receive financial support from your employer for childcare at a kindergarten?" &&
        widget.questionOption == "Grants kindergarten") {
      Questions.kindergartenLength += 1;
      Questions.kindergartenText =
          "KINDERGARTEN " + Questions.kindergartenLength.toString();
    } else if (widget.completeQuestion ==
            "Did you receive financial support from your employer for childcare from a childminder?" &&
        widget.questionOption == "Grants child minder") {
      Questions.childMinderLength += 1;
      Questions.childMinderText =
          "CHILD MINDER " + Questions.childMinderLength.toString();
    } else if (widget.completeQuestion ==
            "Did you receive financial support from your employer for childcare from a nanny?" &&
        widget.questionOption == "Grants nanny care") {
      Questions.nannyLength += 1;
      Questions.nannyText = "NANNY " + Questions.nannyLength.toString();
    } else if (widget.completeQuestion ==
            "Did you receive financial support from your employer for childcare from a babysitter?" &&
        widget.questionOption == "Grants babysitter care") {
      Questions.babySitterLength += 1;
      Questions.babySitterText =
          "BABYSITTER " + Questions.babySitterLength.toString();
    } else if (widget.completeQuestion ==
            "Did you receive financial support from your employer for childcare from an au pair?" &&
        widget.questionOption == "Grants au pair care") {
      Questions.aupairLength += 1;
      Questions.aupairText = "AU PAIR " + Questions.aupairLength.toString();
    } else if (widget.completeQuestion ==
            "Did you receive financial support from your employer for childcare at a day center?" &&
        widget.questionOption == "Grants daycare center") {
      Questions.dayCareLength += 1;
      Questions.dayCareText =
          "DAYCARE CENTER " + Questions.dayCareLength.toString();
    }

    qu.FamilyAddAnswer(widget.identity, widget.bigQuestion,
        widget.completeQuestion, widget.questionOption, ['No'], 55.0);

    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FamilyMainQuestions(
          CheckCompleteQuestion: widget.completeQuestion,
          CheckQuestion: widget.questionOption,
          CheckAnswer: ["No"]);
    }));
  }

  void YesResponse() {
    qu.FamilyAddAnswer(widget.identity, widget.bigQuestion,
        widget.completeQuestion, widget.questionOption, ['Yes'], 55.0);

    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FamilyMainQuestions(
          CheckCompleteQuestion: widget.completeQuestion,
          CheckQuestion: widget.questionOption,
          CheckAnswer: ["Yes"]);
    }));
  }
}
