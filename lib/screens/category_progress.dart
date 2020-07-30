import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

class categoryProgress extends StatefulWidget {
  String currentCategory;
  int catnum;
  bool isdon;
  bool isedu;

  categoryProgress(this.currentCategory, this.catnum, this.isdon, this.isedu);

  @override
  _categoryProgressState createState() =>
      _categoryProgressState(currentCategory, catnum, isdon, isedu);
}

class _categoryProgressState extends State<categoryProgress> {
  double percentage;
  int category_number;
  String category_title;
  bool isdonee;
  bool education;
  String imageName = "images/home.png";
  static int count = 1;
  static bool isHome = false,
      isLive = false,
      isWork = false,
      isFinance = false,
      isIncome = false,
      isHealth = false,
      isEd = false,
      isFam = false;
  String checkk = "";
  int checkkk = 0;
  String category_titlee = "";

  _categoryProgressState(
      this.category_title, this.category_number, this.isdonee, this.education);

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   _getStringFamily();
  // }

  @override
  Widget build(BuildContext context) {
    if (category_title == "Living Situation Category" &&
        isdonee == true &&
        isLive == false) {
      setState(() {
        category_titlee = "Living Situation Category";
        imageName = "images/income.png";
        isLive = true;
        count++;
      });
    } else if (category_title == "Home Category" &&
        isdonee == true &&
        isHome == false) {
      setState(() {
        category_titlee = "Home Category";
        imageName = "images/health.png";
        isHome = true;
        count++;
      });
    } else if (category_title == "Income Category" &&
        isdonee == true &&
        isIncome == false) {
      setState(() {
        category_titlee = "Income Category";
        imageName = "images/home.png";
        isIncome = true;
        count++;
      });
    } else if (category_title == "Health Category" &&
        isdonee == true &&
        isHealth == false) {
      setState(() {
        category_titlee = "Health Category";
        imageName = "images/fiancnce.png";
        isHealth = true;
        count++;
      });
    } else if (category_title == "Education Category" &&
        isdonee == true &&
        isEd == false) {
      setState(() {
        category_titlee = "Education Category";
        imageName = "images/family.png";
        isEd = true;
        count++;
      });
    } else if (category_title == "Family Category" &&
        isdonee == true &&
        isFam == false &&
        education == true) {
      setState(() {
        category_titlee = "Education Category";
        imageName = "images/health.png";
        isFam = true;
        count++;
      });
    } else if (category_title == "Family Category" &&
        isdonee == true &&
        isFam == false) {
      setState(() {
        category_titlee = "Family Category";
        imageName = "images/health.png";
        isFam = true;
        count++;
      });
    } else if (category_title == "Finances Category" &&
        isdonee == true &&
        isFinance == false) {
      setState(() {
        category_titlee = "Finances Category";
        imageName = "images/done.png";
        isFinance = true;
        count++;
      });
    } else {
      Questions.afterAllCategoryFinish = true;
      Questions.categoryName = "574.663,00€";

      Questions.categoryFinish[7] = 1;
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'allCategoryScreen');
    }

    switch (count) {
      case 1:
        percentage = 0.2;

        break;
      case 2:
        percentage = 0.2;
        break;
      case 3:
        percentage = 0.34;
        break;
      case 4:
        percentage = 0.44;
        break;
      case 5:
        percentage = 0.53;
        break;
      case 6:
        percentage = 0.66;
        break;
      case 7:
        percentage = 1;
        break;
      case 8:
        percentage = 1;
        break;
      default:
        percentage = 0.5;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFf2f6ff),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFf2f6ff),
          actions: <Widget>[Image(image: AssetImage("images/skipp.png"))],
          iconTheme: IconThemeData(
            color: Color(0xFF38B6FF), //change your color here
          ),
          // title: InkWell(

          //   onTap: (){
          //      Navigator.pop(context);
          //   },
          //   child: Icon(Icons.close,color: Color(0xFF38B6FF),),
          // ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          category_titlee + " done!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff003350).withOpacity(0.803),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        new CircularPercentIndicator(
                          radius: 250.0,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 30.0,
                          circularStrokeCap: CircularStrokeCap.round,
                          percent: percentage,
                          linearGradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF38B6FF),
                              Color(0xFF003350).withOpacity(0.803)
                            ],
                          ),
                          center: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Image.asset(
                                //   "images/medal.png",
                                //   height: 65,
                                //   width: 65,
                                // ),
                                Text(
                                  (count - 1).toString() + " / 6",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 54.0,
                                    color: Color(0xFF003350).withOpacity(0.803),
                                  ),
                                ),
                                Text(
                                  "Categories\nCompleted",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF003350).withOpacity(0.803),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height / 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage(imageName),
                    width: 50,
                    height: 50,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ButtonTheme(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Continue();
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.blue)),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Continue() {
    if (widget.currentCategory == "Living Situation Category") {
      category_number = 1;
      Questions.categoryImageChange[1] = 1;

      Questions.categoryFinish[0] = 1;
      Questions.categoryName = "Home";
      Questions.categoryImage = "images/uncolorhome.png";

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
      category_number = 2;
      Questions.categoryImageChange[2] = 1;

      Questions.categoryFinish[1] = 1;
      Questions.categoryName = "Education";
      Questions.categoryImage = "images/uncoloreducation.png";

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
      category_number = 3;
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
      category_number = 4;
      Questions.categoryImageChange[5] = 1;

      Questions.categoryName = "Health";
      Questions.categoryImage = "images/uncolorhealth.png";

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

      print(category_title + "in finish else");
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FamilyMainQuestions(
            CheckCompleteQuestion: "How many children do you have?",
            CheckQuestion: "Number of children",
            CheckAnswer: []);
      }));
    } else if (widget.currentCategory == "Family Category") {
      category_number = 5;
      Questions.categoryImageChange[6] = 1;

      Questions.categoryName = "Finances";
      Questions.categoryImage = "images/uncolorfinance.png";
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
    } else if (widget.currentCategory == "Health Category") {
      category_number = 6;
      Questions.categoryImageChange[7] = 1;

      Questions.categoryName = "Finances";
      Questions.categoryImage = "images/uncolorfinance.png";
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
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FinanceMainQuestions(
            CheckCompleteQuestion:
                "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
            CheckQuestion: "Pensions/Life insurances",
            CheckAnswer: []);
      }));
    } else if (widget.currentCategory == "Finances Category") {
      category_number = 7;
      Questions.afterAllCategoryFinish = true;
      Questions.categoryName = "574.663,00€";

      Questions.categoryFinish[7] = 1;
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'allCategoryScreen');
    }
  }
}
