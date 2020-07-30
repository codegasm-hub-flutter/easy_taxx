import 'package:easy_taxx/screens/category_progress.dart';
import 'package:easy_taxx/show.dart';
import 'package:easy_taxx/training.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/income_flow/incomemainquestions.dart';
import 'package:easy_taxx/home_flow/homemainquestions.dart';
import 'package:easy_taxx/education_flow/educationmainquestions.dart';
import 'package:easy_taxx/family_flow/familymainquestions.dart';
import 'package:easy_taxx/health_flow/healthmainquestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finance_flow/financemainquestions.dart';

import 'package:easy_taxx/categoryfinishedscreens/totaltaxamount.dart';
import 'package:shared_preferences/shared_preferences.dart';
//void main() => runApp(MaterialApp(home:HomeScreen()));

class FinishCategory extends StatefulWidget {
  String currentCategory = "";
  String nextCategory = "";
  int cat_num;
  bool is_done;

  FinishCategory(
      this.currentCategory, this.nextCategory, this.cat_num, this.is_done);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FinishCategory> {
  bool open = false;
  bool v3 = false;
  bool checkkk = false;
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

  Future<String> _getStringFamily() async {
    final prefs = await SharedPreferences.getInstance();
    // read
    final String myString = prefs.getString('Family') ?? '';
    if (myString == 'no') {
      setState(() {
        checkkk = true;
      });
    }

    print(myString);
    print(checkkk);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStringFamily();
    timer();
    opennext();
  }

  void timer() {
    Timer(Duration(seconds: 1), () {
      print("Yeah, this line is printed after 3 second");
      setState(() {
        open = true;
      });
    });
  }

  void opennext() {
    Future.delayed(const Duration(milliseconds: 2000), () {
// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
        // if(){

        // }else{
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => categoryProgress(
        //           widget.currentCategory, widget.cat_num, widget.is_done),
        //     ));
        //     }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => categoryProgress(widget.currentCategory,
                  widget.cat_num, widget.is_done, checkkk),
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .004;
    //double maxHeight = MediaQuery.of(context).size.height * .3;
    double maxHeight = 210.0;
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: InkWell(
//                            onTap: () => setState(() => open = !open),
          child: Column(
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10.0),
              //     color: Color(0xFF38B6FF),
              //   ),
              //   height: 140.0,
              //   width: 450.0,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 20.0, top: 45.0),
              //     child: Text(
              //       "Congratulations! You have finished " +
              //           widget.currentCategory +
              //           ".Now You can move to " +
              //           widget.nextCategory,
              //       style: TextStyle(fontSize: 20.0, color: Colors.white),
              //     ),
              //   ),
              // ),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     child: RaisedButton(
              //         onPressed: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => categoryProgress(
              //                     widget.currentCategory, widget.cat_num),
              //               ));
              //         },
              //         child: Text("Continue next category"),
              //         color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)))
            ],
          ),
        ));
  }

  void Continue() {
    if (widget.currentCategory == "Living Situation Category") {
      Questions.categoryImageChange[1] = 1;

      Questions.categoryFinish[0] = 1;
      Questions.categoryName = "Home";
      Questions.categoryImage = "images/home.png";

      Questions.incomeAnswerShow = [];
      Questions.totalDomain = 0;
      Questions.domainLength = 0;
      Questions.totalValuable = 0;
      Questions.valuableLength = 0;
      Questions.residence = "";
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return IncomeMainQuestions(
            CheckCompleteQuestion:
                "Have you received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
            CheckQuestion: "",
            CheckAnswer: []);
      }));
    } else if (widget.currentCategory == "Income Category") {
      Questions.categoryImageChange[2] = 1;

      Questions.categoryFinish[1] = 1;
      Questions.categoryName = "Education";
      Questions.categoryImage = "images/education.png";

      Questions.homeAnswerShow = [];
      Questions.utilityBillLength = 0;
      Questions.totalUtilityBill = 0;
      Questions.WEGLength = 0;
      Questions.totalWEG = 0;
      Questions.modeOfTransport = "";
      Questions.Appliance = "";
      Questions.otherFixture = "";
      Questions.totalSecondHouseHold = 0;
      Questions.secondHouseHoldLength = 0;
      Questions.secondHouseHoldText = "";
      Questions.totalRelocation = 0;
      Questions.relocationLength = 0;
      Questions.relocationText = "";
      Questions.totalCraftsmen = 0;
      Questions.craftsmenLength = 0;
      Questions.craftsmenText = "";

      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeMainQuestions(
            CheckCompleteQuestion: "What is your current address?",
            CheckQuestion: "Current address",
            CheckAnswer: []);
      }));
    } else if (widget.currentCategory == "Home Category") {
      Questions.categoryImageChange[4] = 1;

      Questions.categoryName = "family";
      Questions.categoryImage = "images/family.png";

      Questions.categoryFinish[2] = 1;

      Questions.educationAnswerShow = [];
      Questions.educationOtherCosts = "";
      Questions.trainingLength = 1;
      Questions.totalTraining = 0;
      Questions.trainingText = "TRAINING ${Questions.trainingLength}";
      Questions.schoolRouteLength = 0;
      Questions.totalSchoolRoute = 0;
      Questions.schoolRouteText = "";
      Questions.libraryRouteLength = 0;
      Questions.totalLibraryRoute = 0;
      Questions.libraryRouteText = "";
      Questions.unpaidInternLength = 0;
      Questions.totalUnpaidIntern = 0;
      Questions.unpaidInternText = "";
      Questions.excursionLength = 0;
      Questions.totalExcursion = 0;
      Questions.excursionText = "";
      Questions.semesterLength = 0;
      Questions.totalSemester = 0;
      Questions.semesterText = "";
      Questions.educationTraItem = "";
      Questions.educationExpfurniture = "EXPENSIVE FURNITURE";
      Questions.educationOtherFurniture = "";
      Questions.equipmentLength = 0;
      Questions.totalEquipment = 0;
      Questions.equipmentText = "";
      Questions.equipmentName = "";
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EducationMainQuestions(
            CheckCompleteQuestion:
                "Did you complete any degrees or professional qualifications before 2019?",
            CheckQuestion: "Degree before 2019",
            CheckAnswer: []);
      }));
    } else if (widget.currentCategory == "Education Category") {
      Questions.categoryImageChange[5] = 1;

      Questions.categoryName = "Health";
      Questions.categoryImage = "images/health.png";

      Questions.categoryFinish[4] = 1;

      Questions.familyAnswerShow = [];
      Questions.childLength = 0;
      Questions.totalChild = 0;
      Questions.childText = "";
      Questions.childFirstName = "";
      Questions.childrenLive = "";
      Questions.childrenExpense = "";
      Questions.childAddressLength = 0;
      Questions.totalChildAddress = 0;
      Questions.childAddressText = "";
      Questions.kindergartenLength = 0;
      Questions.totalKindergarten = 0;
      Questions.kindergartenText = "";
      Questions.childMinderLength = 0;
      Questions.totalChildMinder = 0;
      Questions.childMinderText = "";
      Questions.nannyLength = 0;
      Questions.totalNanny = 0;
      Questions.nannyText = "";
      Questions.babySitterLength = 0;
      Questions.totalBabySitter = 0;
      Questions.babySitterText = "";
      Questions.aupairLength = 0;
      Questions.totalAupair = 0;
      Questions.aupairText = "";
      Questions.dayCareLength = 0;
      Questions.totalDayCare = 0;
      Questions.dayCareText = "";
      Questions.schoolLength = 0;
      Questions.totalSchool = 0;
      Questions.schoolText = "";

      if (widget.nextCategory == "Health Category") {
        widget.currentCategory = widget.nextCategory;
        print(widget.nextCategory + "in finish if " + widget.currentCategory);
        Questions.categoryImageChange[6] = 1;

        Questions.categoryName = "Finances";
        Questions.categoryImage = "images/fiancnce.png";
        Questions.categoryFinish[5] = 1;

        Questions.healthAnswerShow = [];
        Questions.healthYouIdentity = "you";
        Questions.healthYourIdentity = "your";
        Questions.healthChildrenLength = 0;
        Questions.totalHealthChildren = 0;
        Questions.healthChildrenText = "";
        Questions.peopleCareLength = 0;
        Questions.totalPeopleCare = 0;
        Questions.peopleCareText = "";

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HealthMainQuestions(
              CheckCompleteQuestion:
                  "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
              CheckQuestion: "Kind of health insurance",
              CheckAnswer: []);
        }));
      } else {
        print(widget.nextCategory + "in finish");
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FamilyMainQuestions(
              CheckCompleteQuestion: "How many children do you have?",
              CheckQuestion: "Number of children",
              CheckAnswer: []);
        }));
      }
    } else if (widget.currentCategory == "Family Category") {
      Questions.categoryImageChange[6] = 1;

      Questions.categoryName = "Finances";
      Questions.categoryImage = "images/fiancnce.png";
      Questions.categoryFinish[5] = 1;

      Questions.healthAnswerShow = [];
      Questions.healthYouIdentity = "you";
      Questions.healthYourIdentity = "your";
      Questions.healthChildrenLength = 0;
      Questions.totalHealthChildren = 0;
      Questions.healthChildrenText = "";
      Questions.peopleCareLength = 0;
      Questions.totalPeopleCare = 0;
      Questions.peopleCareText = "";

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HealthMainQuestions(
            CheckCompleteQuestion:
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
            CheckQuestion: "Kind of health insurance",
            CheckAnswer: []);
      }));
    } else if (widget.currentCategory == "Health Category") {
      Questions.categoryImageChange[7] = 1;

      Questions.categoryName = "Finances";
      Questions.categoryImage = "images/fiancnce.png";
      Questions.categoryFinish[6] = 1;

      Questions.financeAnswerShow = [];
      Questions.financeYouIdentity = "you";
      Questions.financeYourIdentity = "your";
      Questions.financeOrganizationLength = 0;
      Questions.totalFinanceOrganization = 0;
      Questions.financeOrganizationText = "";
      Questions.financeEuOrganizationLength = 0;
      Questions.totalFinanceEuOrganization = 0;
      Questions.financeEuOrganizationText = "";
      Questions.financeReligiousLength = 0;
      Questions.totalFinanceReligious = 0;
      Questions.financeReligiousText = "";
      Questions.financePartyLength = 0;
      Questions.totalFinanceParty = 0;
      Questions.financePartyText = "";
      Questions.financeVoterLength = 0;
      Questions.totalFinanceVoter = 0;
      Questions.financeVoterText = "";
      Questions.financeProjectLength = 0;
      Questions.totalFinanceProject = 0;
      Questions.financeProjectText = "";
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FinanceMainQuestions(
            CheckCompleteQuestion:
                "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
            CheckQuestion: "Pensions/Life insurances",
            CheckAnswer: []);
      }));
    } else if (widget.currentCategory == "Finances Category") {
      Questions.afterAllCategoryFinish = true;
      Questions.categoryName = "574.663,00€";

      Questions.categoryFinish[7] = 1;
      Navigator.pushReplacementNamed(context, 'allCategoryScreen');
    }
  }
}
