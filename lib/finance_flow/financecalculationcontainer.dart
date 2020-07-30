import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finance_flow/financemainquestions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';

class FinanceCalculationContainer extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  String briefqstn;
  double containerSize;
  String bigQuestion;
  String additionalData;
  String multipleData;
  List suggestion;

  FinanceCalculationContainer(
      {this.identity,
      this.briefqstn,
      this.bigQuestion,
      this.completeQuestion,
      this.questionOption,
      this.containerSize,
      this.additionalData,
      this.multipleData,
      this.suggestion});
  @override
  _FinanceCalculationContainerState createState() =>
      _FinanceCalculationContainerState();
}

class _FinanceCalculationContainerState
    extends State<FinanceCalculationContainer> {
  TextEditingController calculations = TextEditingController();
  Questions qu = Questions();
  final _formKey = GlobalKey<FormState>();
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
                              // margin: EdgeInsets.only(left: 10.0,right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
                              ),
                              height: 150.0,
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
                        width: MediaQuery.of(context).size.width,
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
                                          fontFamily: "HelveticaBold",
                                          fontWeight: FontWeight.bold),
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
                                        fontFamily: "HelveticaBold",
                                        fontWeight: FontWeight.bold,
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
            "How many tax exempt organizations in Germany did ${Questions.financeYouIdentity} donate to?" &&
        widget.questionOption == "Number of organizations") {
      Questions.financeOrganizationLength = 0;
      Questions.totalFinanceOrganization = int.parse(calculations.text);
      print(
          "Total Organization" + Questions.totalFinanceOrganization.toString());
      Questions.financeOrganizationLength += 1;
      Questions.financeOrganizationText =
          "ORGANIZATION " + Questions.financeOrganizationLength.toString();
    } else if (widget.completeQuestion ==
            "How much money did ${Questions.financeYouIdentity} donate to this non-profit organization?" &&
        widget.questionOption == "Donation amount" &&
        Questions.totalFinanceOrganization > 0) {
      Questions.financeOrganizationLength += 1;
      Questions.financeOrganizationText =
          "ORGANIZATION " + Questions.financeOrganizationLength.toString();
    } else if (widget.completeQuestion ==
            "How many organizations did ${Questions.financeYouIdentity} donate to?" &&
        widget.questionOption == "Number of organizations") {
      Questions.financeEuOrganizationLength = 0;
      Questions.totalFinanceEuOrganization = int.parse(calculations.text);
      print("Total EU Organization" +
          Questions.totalFinanceEuOrganization.toString());
      Questions.financeEuOrganizationLength += 1;
      Questions.financeEuOrganizationText =
          "ORGANIZATION " + Questions.financeEuOrganizationLength.toString();
    } else if (widget.completeQuestion ==
            "How much money did ${Questions.financeYouIdentity} donate to this organization?" &&
        widget.questionOption == "Donated amount" &&
        Questions.totalFinanceEuOrganization > 0) {
      Questions.financeEuOrganizationLength += 1;
      Questions.financeEuOrganizationText =
          "ORGANIZATION " + Questions.financeEuOrganizationLength.toString();
    } else if (widget.completeQuestion ==
            "How many religious organizations did ${Questions.financeYouIdentity} donate to?" &&
        widget.questionOption == "Number of organizations") {
      Questions.financeReligiousLength = 0;
      Questions.totalFinanceReligious = int.parse(calculations.text);
      print("Total RELIGIOUS COMMUNITY" +
          Questions.totalFinanceReligious.toString());
      Questions.financeReligiousLength += 1;
      Questions.financeReligiousText =
          "RELIGIOUS COMMUNITY " + Questions.financeReligiousLength.toString();
    } else if (widget.completeQuestion ==
            "How much money did ${Questions.financeYouIdentity} donate?" &&
        widget.questionOption == "Donated amount" &&
        Questions.totalFinanceReligious > 0) {
      Questions.financeReligiousLength += 1;
      Questions.financeReligiousText =
          "RELIGIOUS COMMUNITY " + Questions.financeReligiousLength.toString();
    } else if (widget.completeQuestion ==
            "How many parties did ${Questions.financeYouIdentity} donate to?" &&
        widget.questionOption == "Number of party donations") {
      Questions.financePartyLength = 0;
      Questions.totalFinanceParty = int.parse(calculations.text);
      print("Total Party" + Questions.totalFinanceParty.toString());
      Questions.financePartyLength += 1;
      Questions.financePartyText =
          "PARTY " + Questions.financePartyLength.toString();
    } else if (widget.completeQuestion ==
            "How much did ${Questions.financeYouIdentity} donate to this party?" &&
        widget.questionOption == "Donated amount" &&
        Questions.totalFinanceParty > 0) {
      Questions.financePartyLength += 1;
      Questions.financePartyText =
          "PARTY " + Questions.financePartyLength.toString();
    } else if (widget.completeQuestion ==
            "How many voters' associations did ${Questions.financeYouIdentity} donate to?" &&
        widget.questionOption == "Number of voter groups") {
      Questions.financeVoterLength = 0;
      Questions.totalFinanceVoter = int.parse(calculations.text);
      print("Total Voter" + Questions.totalFinanceVoter.toString());
      Questions.financeVoterLength += 1;
      Questions.financeVoterText =
          "VOTERS' ASSOCIATION " + Questions.financeVoterLength.toString();
    } else if (widget.completeQuestion ==
            "How much did ${Questions.financeYouIdentity} donate to the voters' association?" &&
        widget.questionOption == "Donated amount" &&
        Questions.totalFinanceVoter > 0) {
      Questions.financeVoterLength += 1;
      Questions.financeVoterText =
          "VOTERS' ASSOCIATION " + Questions.financeVoterLength.toString();
    } else if (widget.completeQuestion ==
            "How many other projects did ${Questions.financeYouIdentity} donate to?" &&
        widget.questionOption == "Number of projects") {
      Questions.financeProjectLength = 0;
      Questions.totalFinanceProject = int.parse(calculations.text);
      print("Total Project" + Questions.totalFinanceProject.toString());
      Questions.financeProjectLength += 1;
      Questions.financeProjectText =
          "ORGANIZATION " + Questions.financeProjectLength.toString();
    } else if (widget.completeQuestion ==
            "How much money did ${Questions.financeYouIdentity} donate to this organization? " &&
        widget.questionOption == "Donated amount" &&
        Questions.totalFinanceProject > 0) {
      Questions.financeProjectLength += 1;
      Questions.financeProjectText =
          "ORGANIZATION " + Questions.financeProjectLength.toString();
    }

    qu.FinanceAddAnswer(
        widget.identity,
        widget.bigQuestion,
        widget.completeQuestion,
        widget.questionOption,
        [calculations.text.toString()],
        55.0);

    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FinanceMainQuestions(
          CheckCompleteQuestion: widget.completeQuestion,
          CheckQuestion: widget.questionOption,
          CheckAnswer: ["ok"]);
    }));
  }
}
