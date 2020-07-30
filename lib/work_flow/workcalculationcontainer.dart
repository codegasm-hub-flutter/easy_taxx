import 'dart:async';

import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';
import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:easy_taxx/work_flow/workmainquestions.dart';
import 'package:flutter/material.dart';

class WorkCalculationContainer extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  String briefqstn;
  double containerSize;
  String bigQuestion;
  String additionalData;
  String multipleData;
  List suggestion;

  WorkCalculationContainer(
      {this.identity,
      this.bigQuestion,
      this.briefqstn,
      this.completeQuestion,
      this.questionOption,
      this.containerSize,
      this.additionalData,
      this.multipleData,
      this.suggestion});
  @override
  _WorkCalculationContainerState createState() =>
      _WorkCalculationContainerState();
}

class _WorkCalculationContainerState extends State<WorkCalculationContainer> {
  TextEditingController calculations = TextEditingController();
  Questions qu = Questions();
  bool open = false;
  void timer() {
    Timer(Duration(seconds: 1), () {
      print("Yeah, this line is printed after 3 second");
      setState(() {
        open = true;
//        single=true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .004;
//    double maxHeight = MediaQuery
//        .of(context)
//        .size
//        .height * .3;

    //double maxHeight = 210.0;
    double maxHeight = widget.containerSize;
    // var maskTextInputFormatter = MaskTextInputFormatter(mask: "## / ## / ####");
//filter: { "#": RegExp(r'[0-9]')

    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
//                    constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
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
//                            onTap: () => setState(() => open = !open),
              child: Column(
                children: <Widget>[
                  Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Color(0xFFf2f6ff),
                    ),
                    onDismissed: (DismissDirection direction) {
                      setState(() {});
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
                                // margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
                                ),
                                height: 150.0,
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
                                              widget.completeQuestion,
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
                        //margin: EdgeInsets.only(right: 60.0),
//                                      decoration: new BoxDecoration(boxShadow: [
//                                        new BoxShadow(
//                                          color: Colors.grey,
//                                          blurRadius: 5.0,
//                                        ),
//                                      ]),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.70,
                                height: 50.0,
//                    color: Colors.wh,
                                child: TextFormField(
                                  controller: calculations,
                                  //inputFormatters: [maskTextInputFormatter],
                                  //keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontFamily: 'HelveticaBold',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText:
                                          widget.additionalData == "calculation"
                                              ? "€0"
                                              : "example",
                                      contentPadding:
                                          EdgeInsets.only(left: 15.0)),
                                  keyboardType:
                                      widget.additionalData == "calculation"
                                          ? TextInputType.number
                                          : TextInputType.emailAddress,
                                )),
                            Container(
                              //margin: EdgeInsets.only(left: 20.0),
                              // color: Colors.blue,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: GestureDetector(
                                onTap: () {
                                  AddData();
                                },
                                child: Text("Confirm",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            0XFF, 0X38, 0Xb6, 0XFF),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'HelveticaBold',
                                        fontSize: 16.0)),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            )));
  }

  void AddData() {
    if (widget.completeQuestion ==
            "How many more home offices would ${Questions.workYouIdentity} like enter?" &&
        widget.questionOption == "Number of home offices") {
      Questions.homeOfficeLength = 0;
      Questions.totalHomeOffice = int.parse(calculations.text);
      print("Total Home Office" + Questions.totalHomeOffice.toString());
      Questions.homeOfficeLength += 1;
      Questions.homeOfficeText =
          "HOME OFFICE " + Questions.homeOfficeLength.toString();
    } else if (widget.completeQuestion ==
            "How many items cost more than 488 EUR?" &&
        widget.questionOption == "Quantity") {
      Questions.workFurnitureLength = 0;
      Questions.totalWorkFurniture = int.parse(calculations.text);
      print("Total Furniture Length" + Questions.totalWorkFurniture.toString());
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the desk for?" &&
        widget.questionOption == "Usage desk") {
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the office chair for?" &&
        widget.questionOption == "Usage office chair") {
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the shelf for?" &&
        widget.questionOption == "Bookshelf usage") {
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the lamp for?" &&
        widget.questionOption == "Usage lamp") {
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How many years are ${Questions.workYouIdentity} going to use the filing cabinet for?" &&
        widget.questionOption == "Usage filing cabinet") {
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "For how many years will ${Questions.workYouIdentity} use the carpet?" &&
        widget.questionOption == "Other depreciation period") {
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "What kind of furniture/equipment did ${Questions.workYouIdentity} buy?" &&
        widget.questionOption == "Type") {
      Questions.otherFurniture = calculations.text;
    } else if (widget.completeQuestion ==
            "For how many years will ${Questions.workYouIdentity} use the ${Questions.otherFurniture}?" &&
        widget.questionOption == "Depreciation period") {
      Questions.workFurnitureLength += 1;
      Questions.workFurnitureText =
          "FURNITURE " + Questions.workFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How much did ${Questions.workYouIdentity} spend on these items in total?" &&
        widget.questionOption == "Total amount" &&
        Questions.totalWorkFurniture > 0) {
      Questions.homeOfficeLength += 1;
      Questions.homeOfficeText =
          "HOME OFFICE " + Questions.homeOfficeLength.toString();
    } else if (widget.completeQuestion ==
            "How many countries did ${Questions.workYouIdentity} travel to due to business trips?" &&
        widget.questionOption == "Number of countries") {
      Questions.workBusTripLength = 0;
      Questions.totalWorkBusTrip = int.parse(calculations.text);
      print("Total Business Trip" + Questions.totalWorkBusTrip.toString());
      Questions.workBusTripLength += 1;
      Questions.workBusTripText =
          "BUSINESS TRIP " + Questions.workBusTripLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.workYouIdentity} receive complimentary breakfast? " &&
        widget.questionOption == "Complimentary breakfast") {
      Questions.workBusTripLength += 1;
      Questions.workBusTripText =
          "BUSINESS TRIP " + Questions.workBusTripLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.workYouIdentity} get complimentary lunch? " &&
        widget.questionOption == "Free lunch") {
      Questions.workBusTripLength += 1;
      Questions.workBusTripText =
          "BUSINESS TRIP " + Questions.workBusTripLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.workYouIdentity} get complimentary dinner? " &&
        widget.questionOption == "Free dinner") {
      Questions.workBusTripLength += 1;
      Questions.workBusTripText =
          "BUSINESS TRIP " + Questions.workBusTripLength.toString();
    } else if (widget.completeQuestion ==
            "How many business trips did ${Questions.workYouIdentity} take in 2019?" &&
        widget.questionOption == "Number of business trips") {
      Questions.workBusCostLength = 0;
      Questions.totalWorkBusCost = int.parse(calculations.text);
      print("Total Business Trip Cost" + Questions.totalWorkBusCost.toString());
      Questions.workBusCostLength += 1;
      Questions.workBusCostText =
          "BUSINESS TRIP " + Questions.workBusCostLength.toString();
    } else if (widget.completeQuestion ==
            "How much of the travel expenses from ${Questions.workYourIdentity} business trip were ${Questions.workYouIdentity} reimbursed by ${Questions.workYourIdentity} employer?" &&
        widget.questionOption == "Reimbursement travel costs") {
      Questions.workBusCostLength += 1;
      Questions.workBusCostText =
          "BUSINESS TRIP " + Questions.workBusCostLength.toString();
    } else if (widget.completeQuestion ==
            "How much was reimbursed for accommodation by ${Questions.workYourIdentity} employer?" &&
        widget.questionOption == "Reimbursement accommodation") {
      Questions.workBusCostLength += 1;
      Questions.workBusCostText =
          "BUSINESS TRIP " + Questions.workBusCostLength.toString();
    } else if (widget.completeQuestion ==
            "How much was the total amount reimbursed for meals and expenses during ${Questions.workYourIdentity} business trip?" &&
        widget.questionOption == "Reimbursement amount") {
      Questions.workBusCostLength += 1;
      Questions.workBusCostText =
          "BUSINESS TRIP " + Questions.workBusCostLength.toString();
    } else if (widget.completeQuestion ==
            "How many pieces of furniture ${Questions.workYouIdentity} bought were over 488 EUR?" &&
        widget.questionOption == "Quantity") {
      Questions.officeFurnitureLength = 0;
      Questions.totalOfficeFurniture = int.parse(calculations.text);
      print("Total Office Furniture Length" +
          Questions.totalOfficeFurniture.toString());
      Questions.officeFurnitureLength += 1;
      Questions.officeFurnitureText =
          "FURNITURE " + Questions.officeFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the desk for? " &&
        widget.questionOption == "Usage desk") {
      Questions.officeFurnitureLength += 1;
      Questions.officeFurnitureText =
          "FURNITURE " + Questions.officeFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the office chair for? " &&
        widget.questionOption == "Usage office chair") {
      Questions.officeFurnitureLength += 1;
      Questions.officeFurnitureText =
          "FURNITURE " + Questions.officeFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the shelf for? " &&
        widget.questionOption == "Usage Bookshelf") {
      Questions.officeFurnitureLength += 1;
      Questions.officeFurnitureText =
          "FURNITURE " + Questions.officeFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How long are ${Questions.workYouIdentity} going to use the lamp for? " &&
        widget.questionOption == "Usage lamp") {
      Questions.officeFurnitureLength += 1;
      Questions.officeFurnitureText =
          "FURNITURE " + Questions.officeFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How many years are ${Questions.workYouIdentity} going to use the filing cabinet for? " &&
        widget.questionOption == "Amount") {
      Questions.officeFurnitureLength += 1;
      Questions.officeFurnitureText =
          "FURNITURE " + Questions.officeFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "What kind of furniture did you buy? " &&
        widget.questionOption == "Type") {
      Questions.otherOfficeFurniture = calculations.text;
    } else if (widget.completeQuestion ==
            "For how many years will ${Questions.workYouIdentity} use the ${Questions.otherOfficeFurniture}? " &&
        widget.questionOption == "Depreciation period") {
      Questions.officeFurnitureLength += 1;
      Questions.officeFurnitureText =
          "FURNITURE " + Questions.officeFurnitureLength.toString();
    } else if (widget.completeQuestion ==
            "How many items did ${Questions.workYouIdentity} buy?" &&
        widget.questionOption == "Quantity") {
      Questions.otherItemsLength = 0;
      Questions.totalOtherItems = int.parse(calculations.text);
      print("Total Other Items" + Questions.totalOtherItems.toString());
      Questions.otherItemsLength += 1;
      Questions.otherItemsText =
          "EQUIPMENT " + Questions.otherItemsLength.toString();
    } else if (widget.completeQuestion ==
            "What kind of item is item no. ${Questions.otherItemsLength}?" &&
        widget.questionOption == "Item no. ${Questions.otherItemsLength}") {
      Questions.otherItems = calculations.text;
    } else if (widget.completeQuestion ==
            "How much can ${Questions.workYouIdentity} depreciate for the item ${Questions.otherItems} in 2019?" &&
        widget.questionOption == "Depreciation amount") {
      Questions.otherItemsLength += 1;
      Questions.otherItemsText =
          "EQUIPMENT " + Questions.otherItemsLength.toString();
    } else if (widget.completeQuestion ==
            "How many places did ${Questions.workYouIdentity} travel to for job interviews?" &&
        widget.questionOption == "Journeys to interviews") {
      Questions.jobInterviewLength = 0;
      Questions.totalJobInterview = int.parse(calculations.text);
      print("Total Job Interview" + Questions.totalJobInterview.toString());
      Questions.jobInterviewLength += 1;
      Questions.jobInterviewText =
          "TRIP " + Questions.jobInterviewLength.toString();
    } else if (widget.completeQuestion ==
            "How much did ${Questions.workYouIdentity} receive?" &&
        widget.questionOption == "Amount") {
      Questions.jobInterviewLength += 1;
      Questions.jobInterviewText =
          "TRIP " + Questions.jobInterviewLength.toString();
    } else if (widget.completeQuestion ==
            "What kind of other costs did ${Questions.workYouIdentity} have (except daily allowances)?" &&
        widget.questionOption == "Kind other") {
      Questions.otherCostExpense = calculations.text;
    }

    qu.WorkAddAnswer(
        widget.identity,
        widget.bigQuestion,
        widget.completeQuestion,
        widget.questionOption,
        [calculations.text.toString()],
        55.0);

    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkMainQuestions(
          CheckCompleteQuestion: widget.completeQuestion,
          CheckQuestion: widget.questionOption,
          CheckAnswer: ["ok"]);
    }));
  }
}
