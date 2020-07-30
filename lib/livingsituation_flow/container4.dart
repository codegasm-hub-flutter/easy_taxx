import 'package:easy_taxx/livingsituation_flow/container3.dart';
import 'package:easy_taxx/livingsituation_flow/container3.dart';
import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:easy_taxx/show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_taxx/livingsituation_flow/unsupportedscreen.dart';
//void main() => runApp(MaterialApp(home:HomeScreen()));

class Container4 extends StatefulWidget {
  String Identity;
  String Question;
  String briefqstn;
  String QuestionOption;
  double Containersize;
  List AnswerOption = [];
  List AnswerImages = [];
  String BigQuestion;

  Container4(
      {this.Identity,
      this.BigQuestion,
      this.Question,
      this.briefqstn,
      this.QuestionOption,
      this.AnswerOption,
      this.AnswerImages,
      this.Containersize});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Container4> {
  bool open = false;
  bool v3 = false;
  Questions qu = Questions();
  final _formKey = GlobalKey<FormState>();
  String noOption = "";
  bool noOptionCheck = true;
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
    addBoolValue();
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

  List values = [];

  //bool containerColor = false;

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .008;
    //double maxHeight = MediaQuery.of(context).size.height * .59;
    double maxHeight = widget.Containersize;
    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
//                    constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 10.0, right: 10, left: 10, bottom: 0),
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
                        skip();
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
                                //margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                // margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Questions.LivingCheck == 1 ||
                                          Questions.LivingCheck == 2
                                      ? Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)
                                      : Colors.deepPurple[400],
                                ),
                                height: 160.0,
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
                                          wordSpacing: 3.0,
                                          height: 1.5),
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
                                          fontSize: questionFontSize,
                                          color: Colors.white,
                                          wordSpacing: 3.0,
                                          fontFamily: "HelveticaBold",
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 150.0,
                      width: 450.0,
                      color: Colors.white,

//                                        color: Colors.red,
                      child:
//                    ListView.builder
//                      (
//                        itemCount: widget.AnswerOption.length,
//                        itemBuilder: (BuildContext ctxt, int index) {
//                          return GestureDetector(
//
//                              child:
//                              Container(
//                                  color: Colors.white,
//
//                                  child:
//                                  Column(
//                                    children: <Widget>[
//                                      Divider(
//                                        height: 1.0,
//                                        thickness: 1.0,
//                                      ),
//                                      Row(
//                                        children: <Widget>[
//
//                                          Checkbox(
//
//                                            value: this.values[index],
//                                            onChanged: (bool value) {
//                                              print(value);
//
//                                              setState(() {
//                                                this.values[index] = value;
//                                                //containerColor = ! containerColor;
//
//                                              });
//                                            },
//
//                                          ),
//
////                                          Icon(Icons.timer),
//                                          Image(image:AssetImage(widget.AnswerImages[index]),width: 22.0,height: 35.0,),
//                                          SizedBox(width: 20.0,),
//                                          Text(widget.AnswerOption[index],style: TextStyle(color:Questions.LivingCheck == 1 || Questions.LivingCheck == 2 ? Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF) : Colors.deepPurple[300])),
//                                        ],
//                                      )
//                                    ],
//                                  )
//                              ));
//                        }
//                    ),

                          ListView.builder(
                              itemCount: widget.AnswerOption.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return widget.AnswerOption[index] == "No" ||
                                        widget.AnswerOption[index] == "None" ||
                                        widget.AnswerOption[index] ==
                                            "None of this applies" ||
                                        widget.AnswerOption[index] ==
                                            "None of them" ||
                                        widget.AnswerOption[index] ==
                                            "None of these" ||
                                        widget.AnswerOption[index] ==
                                            "None of this"
                                    ? Container()
                                    : Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            Divider(
                                              color: Color(0xFFF2F6FF),
                                              height: 3,
                                              thickness: 2,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  ChangeCheckbox(index);
                                                },
                                                child: Opacity(
                                                    opacity: 0.8,
                                                    child: Container(
                                                        color: values[index] ==
                                                                true
                                                            ? Colors.white
                                                            : Colors.white,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 12.0,
                                                                bottom: 12.0),
                                                        child: Row(
                                                          children: <Widget>[
//                                          Checkbox(
//
//                                            value: this.values[index],
//                                            onChanged: (bool value) {
//                                              print(value);
//
//                                              setState(() {
//                                                this.values[index] = value;
//                                                //containerColor = ! containerColor;
//
//                                              });
//                                            },
//
//                                          ),

                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          10.0),
                                                              child:
                                                                  values[index] ==
                                                                          true
                                                                      ? Image(
                                                                          image:
                                                                              AssetImage("images/checked.png"),
                                                                          width:
                                                                              20.0,
                                                                          height:
                                                                              20.0,
                                                                        )
                                                                      : Image(
                                                                          image:
                                                                              AssetImage("images/unchecked.png"),
                                                                          width:
                                                                              20.0,
                                                                          height:
                                                                              20.0,
                                                                        ),
                                                            ),
                                                            SizedBox(
                                                              width: 20.0,
                                                            ),

//                                          Icon(Icons.timer),
                                                            Image(
                                                              image: AssetImage(
                                                                  widget.AnswerImages[
                                                                      index]),
                                                              width: 22.0,
                                                              height: 35.0,
                                                            ),
                                                            SizedBox(
                                                              width: 20.0,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.65,
                                                              child:
                                                                  AutoSizeText(
                                                                widget.AnswerOption[
                                                                    index],
                                                                style: TextStyle(
                                                                    color: Color(
                                                                            0xFF003350)
                                                                        .withOpacity(
                                                                            0.803),
                                                                    fontFamily:
                                                                        "HelveticaBold",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                minFontSize: 14,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          ],
                                                        ))))
                                          ],
                                        ));
                              }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!(noOption == "No" ||
                              noOption == "None" ||
                              noOption == "None of this applies" ||
                              noOption == "None of them" ||
                              noOption == "None of these" ||
                              noOption == "None of this") &&
                          (noOptionCheck == true)) {
                        print("no option select");
                      } else {
                        Confirm();
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Colors.white,
//                    decoration: new BoxDecoration(
//                        color: Colors.white,
//                        boxShadow: [
//                          new BoxShadow(
//                            color: Colors.grey,
//                            blurRadius: 5.0,
//                          ),
//
//                        ]),

                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
//                    color: Colors.wh,
                        child: Center(
                            child: (noOption == "No" ||
                                        noOption == "None" ||
                                        noOption == "None of this applies" ||
                                        noOption == "None of them" ||
                                        noOption == "None of these" ||
                                        noOption == "None of this") &&
                                    noOptionCheck == true
                                ? Text(noOption,
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            0XFF, 0X38, 0Xb6, 0XFF),
                                        fontFamily: "HelveticaBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0))
                                : noOptionCheck == true
                                    ? Text('Confirm',
                                        style: TextStyle(
                                            color: Colors.grey[300],
                                            fontFamily: "HelveticaBold",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0))
                                    : Text('Confirm',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                0XFF, 0X38, 0Xb6, 0XFF),
                                            fontFamily: "HelveticaBold",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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

  void addBoolValue() {
    // last index ma agar no wagera ha to
    noOption = widget.AnswerOption[widget.AnswerOption.length - 1];

    for (int i = 0; i < widget.AnswerOption.length; i++) {
      values.add(false);
      print('hello');
    }
  }

  void skip() {
    List answer = [];
    answer.add("skip");

    qu.addAnswer(widget.Identity, widget.BigQuestion, widget.QuestionOption,
        answer, 55.0);

    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return mainQuestions(
          CheckQuestion: widget.QuestionOption, CheckAnswer: answer);
    }));
  }

  void Confirm() {
    List data = [];

    //no wagera ka liya
    if ((noOption == "No" ||
            noOption == "None" ||
            noOption == "None of this applies" ||
            noOption == "None of them" ||
            noOption == "None of these" ||
            noOption == "None of this") &&
        noOptionCheck == true) {
      data.add(noOption);
    } else {
      for (int i = 0; i < widget.AnswerOption.length; i++) {
        if (values[i] == true) {
          data.add(widget.AnswerOption[i]);
        }
      }
    }

    if (data[0] == "Survivor’s pension") {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UnSupportedScreen(
            textImage: "images/unsupportsurvivor.png",
            textTitle: "Survivors pension",
            textMessage:
                "We are so sorry for your loss. We would really like to help you with your taxes. Please be a bit patient.");
      }));
    }

    //Questions.animatedContainer = 210.0;
    else {
      qu.addAnswer(widget.Identity, widget.BigQuestion, widget.QuestionOption,
          data, 55.0);

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return mainQuestions(
            CheckQuestion: widget.QuestionOption, CheckAnswer: data);
      }));
    }
  }

  void ChangeCheckbox(int index) {
    print("work");
    if (values[index] == true) {
      setState(() {
        values[index] = false;
      });
    } else {
      setState(() {
        values[index] = true;
      });
    }

    for (int j = 0; j < widget.AnswerOption.length; j++) {
      if (values[j] == true) {
        noOptionCheck = false;
        break;
      } else {
        noOptionCheck = true;
      }
    }

    setState(() {
      noOptionCheck;
    });
  }
}
