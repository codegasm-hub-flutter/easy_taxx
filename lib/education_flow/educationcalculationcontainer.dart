import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/education_flow/educationmainquestions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';

class EducationCalculationContainer extends StatefulWidget {
  String identity;
  String briefqstn;
  String completeQuestion;
  String questionOption;
  double containerSize;
  String bigQuestion;
  String additionalData;
  String multipleData;

  EducationCalculationContainer(
      {this.identity,
      this.briefqstn,
      this.bigQuestion,
      this.completeQuestion,
      this.questionOption,
      this.containerSize,
      this.additionalData,
      this.multipleData});
  @override
  _EducationCalculationContainerState createState() =>
      _EducationCalculationContainerState();
}

class _EducationCalculationContainerState
    extends State<EducationCalculationContainer> {
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

  final _formKey = GlobalKey<FormState>();
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
            "How many different trainings did ${Questions.educationYouIdentity} participate in during 2019?" &&
        widget.questionOption == "Number of training courses") {
      Questions.trainingLength = 1;
      Questions.totalTraining = int.parse(calculations.text);
      print("Total Training:" + Questions.totalTraining.toString());
    } else if (widget.completeQuestion == "How much money was reimbursed?" &&
        widget.questionOption == "Reimbursed") {
      Questions.trainingLength += 1;
      Questions.trainingText =
          "TRAINING " + Questions.trainingLength.toString();
    } else if (widget.completeQuestion ==
            "What kind of costs did ${Questions.educationYouIdentity} have?" &&
        widget.questionOption == "Kind of costs") {
      Questions.educationOtherCosts = calculations.text.toString();
    } else if (widget.completeQuestion ==
            "How many different routes to school/university did ${Questions.educationYouIdentity} use?" &&
        widget.questionOption == "Number of routes") {
      Questions.schoolRouteLength = 0;
      Questions.totalSchoolRoute = int.parse(calculations.text);
      print("Total School Route:" + Questions.totalSchoolRoute.toString());
      Questions.schoolRouteLength += 1;
      Questions.schoolRouteText =
          "ROUTE " + Questions.schoolRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How much have ${Questions.educationYouIdentity} spent on travels to training?" &&
        widget.questionOption == "Travel costs") {
      Questions.schoolRouteLength += 1;
      Questions.schoolRouteText =
          "ROUTE " + Questions.schoolRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How many different routes did ${Questions.educationYouIdentity} use to travel to libraries outside ${Questions.educationYourIdentity} campus?" &&
        widget.questionOption == "Number of routes") {
      Questions.libraryRouteLength = 0;
      Questions.totalLibraryRoute = int.parse(calculations.text);
      print("Total School Route:" + Questions.totalLibraryRoute.toString());
      Questions.libraryRouteLength += 1;
      Questions.libraryRouteText =
          "ROUTE " + Questions.libraryRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} use the route no. ${Questions.libraryRouteLength} to the library?" &&
        widget.questionOption == "Number of drives") {
      Questions.libraryRouteLength += 1;
      Questions.libraryRouteText =
          "ROUTE " + Questions.libraryRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How much did ${Questions.educationYouIdentity} spend in total?" &&
        widget.questionOption == "Actual costs") {
      Questions.libraryRouteLength += 1;
      Questions.libraryRouteText =
          "ROUTE " + Questions.libraryRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How many different routes did ${Questions.educationYouIdentity} use for travels to learning communities?" &&
        widget.questionOption == "Number of routes") {
      Questions.learningRouteLength = 0;
      Questions.totalLearningRoute = int.parse(calculations.text);
      print("Total Learning Route:" + Questions.totalLearningRoute.toString());
      Questions.learningRouteLength += 1;
      Questions.learningRouteText =
          "ROUTE " + Questions.learningRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} use the route no. ${Questions.learningRouteLength}?" &&
        widget.questionOption == "Number of drives") {
      Questions.learningRouteLength += 1;
      Questions.learningRouteText =
          "ROUTE " + Questions.learningRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How much did ${Questions.educationYouIdentity} spend in total for the route no. ${Questions.learningRouteLength}?" &&
        widget.questionOption == "Actual costs") {
      Questions.learningRouteLength += 1;
      Questions.learningRouteText =
          "ROUTE " + Questions.learningRouteLength.toString();
    } else if (widget.completeQuestion ==
            "How many unpaid internships did ${Questions.educationYouIdentity} participate in?" &&
        widget.questionOption == "Number of internships") {
      Questions.unpaidInternLength = 0;
      Questions.totalUnpaidIntern = int.parse(calculations.text);
      print(
          "Total Unpiad Internships:" + Questions.totalUnpaidIntern.toString());
      Questions.unpaidInternLength += 1;
      Questions.unpaidInternText =
          "UNPAID INTERNSHIP " + Questions.unpaidInternLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?" &&
        widget.questionOption == "Number of breakfast" &&
        Questions.unpaidInternText.contains("UNPAID INTERNSHIP")) {
      Questions.unpaidInternLength += 1;
      Questions.unpaidInternText =
          "UNPAID INTERNSHIP " + Questions.unpaidInternLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary lunch?" &&
        widget.questionOption == "Number of lunch" &&
        Questions.unpaidInternText.contains("UNPAID INTERNSHIP")) {
      Questions.unpaidInternLength += 1;
      Questions.unpaidInternText =
          "UNPAID INTERNSHIP " + Questions.unpaidInternLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary dinner?" &&
        widget.questionOption == "Number of dinner" &&
        Questions.unpaidInternText.contains("UNPAID INTERNSHIP")) {
      Questions.unpaidInternLength += 1;
      Questions.unpaidInternText =
          "UNPAID INTERNSHIP " + Questions.unpaidInternLength.toString();
    } else if (widget.completeQuestion ==
            "To how many excursions did ${Questions.educationYouIdentity} go?" &&
        widget.questionOption == "Number of excursions") {
      Questions.excursionLength = 0;
      Questions.totalExcursion = int.parse(calculations.text);
      print("Total Excursion:" + Questions.totalExcursion.toString());
      Questions.excursionLength += 1;
      Questions.excursionText =
          "EXCURSION " + Questions.excursionLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?" &&
        widget.questionOption == "Number of breakfast" &&
        Questions.excursionText.contains("EXCURSION")) {
      Questions.excursionLength += 1;
      Questions.excursionText =
          "EXCURSION " + Questions.excursionLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary lunch?" &&
        widget.questionOption == "Number of lunch" &&
        Questions.excursionText.contains("EXCURSION")) {
      Questions.excursionLength += 1;
      Questions.excursionText =
          "EXCURSION " + Questions.excursionLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary dinner?" &&
        widget.questionOption == "Number of dinner" &&
        Questions.excursionText.contains("EXCURSION")) {
      Questions.excursionLength += 1;
      Questions.excursionText =
          "EXCURSION " + Questions.excursionLength.toString();
    } else if (widget.completeQuestion ==
            "To how many semester abroad did ${Questions.educationYouIdentity} go?" &&
        widget.questionOption == "Number of semester abroad") {
      Questions.semesterLength = 0;
      Questions.totalSemester = int.parse(calculations.text);
      print("Total Semester:" + Questions.totalSemester.toString());
      Questions.semesterLength += 1;
      Questions.semesterText =
          "SEMESTER ABROAD " + Questions.semesterLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?" &&
        widget.questionOption == "Number of breakfast" &&
        Questions.semesterText.contains("SEMESTER ABROAD")) {
      Questions.semesterLength += 1;
      Questions.semesterText =
          "SEMESTER ABROAD " + Questions.semesterLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary lunch?" &&
        widget.questionOption == "Number of lunch" &&
        Questions.semesterText.contains("SEMESTER ABROAD")) {
      Questions.semesterLength += 1;
      Questions.semesterText =
          "SEMESTER ABROAD " + Questions.semesterLength.toString();
    } else if (widget.completeQuestion ==
            "How often did ${Questions.educationYouIdentity} receive complimentary dinner?" &&
        widget.questionOption == "Number of dinner" &&
        Questions.semesterText.contains("SEMESTER ABROAD")) {
      Questions.semesterLength += 1;
      Questions.semesterText =
          "SEMESTER ABROAD " + Questions.semesterLength.toString();
    } else if (widget.completeQuestion ==
            "What kind of items did ${Questions.educationYouIdentity} buy?" &&
        widget.questionOption == "Items") {
      Questions.educationTraItem = calculations.text;
    } else if (widget.completeQuestion ==
            "How many pieces of furnitures cost more than 488 EUR?" &&
        widget.questionOption == "Number") {
      Questions.expFurnitureLength = 0;
      Questions.totalExpFurniture = int.parse(calculations.text);
      print("Total Expensive Furniture:" +
          Questions.totalExpFurniture.toString());
      Questions.expFurnitureLength += 1;
    } else if (widget.completeQuestion ==
            "What kind of  furniture did ${Questions.educationYouIdentity} buy?" &&
        widget.questionOption == "Type") {
      Questions.educationOtherFurniture = calculations.text;
    } else if (widget.completeQuestion ==
            "How much other valuable items for training did ${Questions.educationYouIdentity} buy in previous years?" &&
        widget.questionOption == "Quantity") {
      Questions.equipmentLength = 0;
      Questions.totalEquipment = int.parse(calculations.text);
      print("Total Equipment:" + Questions.totalEquipment.toString());
      Questions.equipmentLength += 1;
      Questions.equipmentText =
          "EQUIPMENT " + Questions.equipmentLength.toString();
    } else if (widget.completeQuestion ==
            "What items did ${Questions.educationYouIdentity} purchase for ${Questions.educationYourIdentity} training?" &&
        widget.questionOption == "Items") {
      Questions.equipmentName = calculations.text;
    } else if (widget.completeQuestion ==
            "What can ${Questions.educationYouIdentity} depreciate for item ${Questions.equipmentName} in 2019?" &&
        widget.questionOption == "Amount") {
      Questions.equipmentLength += 1;
      Questions.equipmentText =
          "EQUIPMENT " + Questions.equipmentLength.toString();
    }

    qu.EducationAddAnswer(
        widget.identity,
        widget.bigQuestion,
        widget.completeQuestion,
        widget.questionOption,
        [calculations.text.toString()],
        55.0);

    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EducationMainQuestions(
          CheckCompleteQuestion: widget.completeQuestion,
          CheckQuestion: widget.questionOption,
          CheckAnswer: ["ok"]);
    }));
  }
}
