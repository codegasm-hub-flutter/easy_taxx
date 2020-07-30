import 'package:easy_taxx/livingsituation_flow/container2.dart';
import 'package:easy_taxx/livingsituation_flow/unsupportedscreen.dart';
import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';

class ContainerAlimony extends StatefulWidget {
  String Identity;
  String BigQuestion = "";
  String briefqstn;
  String Question;
  String QuestionOption;
  double Containersize;
  List AnswerOption = [];

  ContainerAlimony(
      {this.Identity,
      this.BigQuestion,
      this.briefqstn,
      this.Question,
      this.QuestionOption,
      this.AnswerOption,
      this.Containersize});

  @override
  _testing4State createState() => _testing4State();
}

class _testing4State extends State<ContainerAlimony> {
  Questions qu = Questions();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
    //print("okxjsdnsmd");
  }

  void timer() {
    Timer(Duration(seconds: 1), () {
      print("Yeah, this line is printed after 3 second");
      setState(() {
        open = true;
//        single=true;
      });
    });
  }

  bool open = false;
  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .008;
    double maxHeight = widget.Containersize;
    //double maxHeight = MediaQuery.of(context).size.height * .62;
    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
//                            alignment: Alignment.lerp(1, 1, 0),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        decoration: BoxDecoration(
          //color: Colors.grey[200],
          color: Color(0xFFf2f6ff),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: InkWell(
              onTap: () => setState(() => open = !open),
              child: Column(
                children: <Widget>[
                  Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Color(0xFFf2f6ff),
                    ),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        GetData("skip");
                      });
                    },
                    child: Container(
                      height: 170,
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
                                  color: Color(0xFF38B6FF),

                                  //                image: DecorationImage(
                                  // image: AssetImage("images/bgqsn.png"), fit: BoxFit.cover),
                                ),
                                height: 140.0,
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
                                        fontSize: 12.5,
                                        color: Colors.black,
                                      ),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 220.0,
                    width: 400.0,
                    // margin: EdgeInsets.only(bottom: 10),

//                                        color: Colors.red,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    GetData(widget.AnswerOption[index]);
                                  },
                                  child: Container(
                                    child: Column(children: <Widget>[
                                      ListTile(
                                        leading: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0, top: 5),
                                          child: Text(
                                            widget.AnswerOption[index],
                                            style: TextStyle(
                                                color: Color(0xFF003350)
                                                    .withOpacity(0.803)
                                                    .withOpacity(0.803),
                                                fontSize: 14,
                                                fontFamily: 'HelveticaBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Color(0xFFF2F6FF),
                                        height: 3,
                                        thickness: 2,
                                      ),
                                    ]),
                                  ));
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  GetData(String maritalData) {
    if (maritalData == "None") {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UnSupportedScreen(
            textImage: "images/unsupportletting.png",
            textTitle: "No",
            textMessage:
                "Kindly Choose another option, \"No\" is not supported! ");
      }));
    } else if (maritalData == "Married/ civil partnership") {
      qu.addAnswer(widget.Identity, "Relationship status",
          widget.QuestionOption, [maritalData], 55.0);
    } else if (maritalData == "Divorced") {
      qu.addAnswer(widget.Identity, "Relationship status",
          widget.QuestionOption, [maritalData], 55.0);
    } else if (maritalData == "Widowed") {
      qu.addAnswer(widget.Identity, "Relationship status",
          widget.QuestionOption, [maritalData], 55.0);
    } else if (maritalData == "It's Complicated") {
      qu.addAnswer(widget.Identity, "Relationship status",
          widget.QuestionOption, [maritalData], 55.0);
    } else if (maritalData == "skip") {
      qu.addAnswer(widget.Identity, "Relationship status",
          widget.QuestionOption, [maritalData], 55.0);
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return mainQuestions(
            CheckQuestion: widget.QuestionOption, CheckAnswer: [maritalData]);
      }));
    }
  }
}
