import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/health_flow/healthmainquestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/health_flow/healthabroad.dart';
import 'package:easy_taxx/datamodels/designfile.dart';

class HealthTwoOptionContainer extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  String briefqstn;
  double containerSize;
  String bigQuestion;
  List answerOption = [];
  String additionalData;
  String multipleData;
  String suggestion;

  HealthTwoOptionContainer(
      {this.identity,
      this.briefqstn,
      this.bigQuestion,
      this.completeQuestion,
      this.questionOption,
      this.answerOption,
      this.containerSize,
      this.additionalData,
      this.multipleData,
      this.suggestion});
  @override
  _HealthTwoOptionContainerState createState() =>
      _HealthTwoOptionContainerState();
}

class _HealthTwoOptionContainerState extends State<HealthTwoOptionContainer> {
  bool open = false;
  bool v3 = false;
  Questions qu = Questions();
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
  //List<String> items = ["Employeed","Minijob(e.g 4.50 basis)","Studying","others","Employeed","Minijob(e.g 4.50 basis)","Studying","others",];

  //bool containerColor = false;

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .008;
    //double maxHeight = MediaQuery.of(context).size.height * .59;
    //double maxHeight = 280.0;
    double maxHeight = widget.containerSize;
    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
//                    constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(10),
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
                  Container(
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
                              ),
                              height: 140.0,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.width * 0.04,
                                top: 7.0,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
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
                                left: MediaQuery.of(context).size.width / 30.0,
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 120.0,
                    width: 450.0,

//                                        color: Colors.red,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ListView.builder(
                          itemCount: widget.answerOption.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return GestureDetector(
                                onTap: () {
                                  if (widget.answerOption[index] == "Abroad") {
                                    //qu.EducationAddAnswer(widget.identity,widget.bigQuestion,widget.completeQuestion,widget.questionOption, [widget.answerOption[index]], 55.0);

                                    Navigator.of(context).pop();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HealthAbroad(
                                          identity: widget.identity,
                                          bigQuestion: widget.bigQuestion,
                                          completeQuestion:
                                              widget.completeQuestion,
                                          questionOption: widget.questionOption,
                                          containerSize: widget.containerSize);
                                    }));
//                                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                return EducationMainQuestions(CheckCompleteQuestion : widget.completeQuestion,CheckQuestion : widget.questionOption,CheckAnswer : [widget.answerOption[index]]);
//                                }));

                                  } else {
                                    qu.HealthAddAnswer(
                                        widget.identity,
                                        widget.bigQuestion,
                                        widget.completeQuestion,
                                        widget.questionOption,
                                        [widget.answerOption[index]],
                                        55.0);

                                    Navigator.of(context).pop();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HealthMainQuestions(
                                          CheckCompleteQuestion:
                                              widget.completeQuestion,
                                          CheckQuestion: widget.questionOption,
                                          CheckAnswer: [
                                            widget.answerOption[index]
                                          ]);
                                    }));
                                  }
                                },
                                child: Column(children: <Widget>[
                                  ListTile(
                                    leading: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: Text(widget.answerOption[index],
                                          style: TextStyle(
                                              color: Color(0xFF003350)
                                                  .withOpacity(0.803),
                                              fontFamily: "HelveticaBold",
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                ]));
                          }),
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
