import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/income_flow/incomemainquestions.dart';
import 'package:easy_taxx/home_flow/homemainquestions.dart';
import 'package:easy_taxx/work_flow/workmainquestions.dart';
import 'package:easy_taxx/education_flow/educationmainquestions.dart';
import 'package:easy_taxx/family_flow/familymainquestions.dart';
import 'package:easy_taxx/health_flow/healthmainquestions.dart';
import 'package:easy_taxx/finance_flow/financemainquestions.dart';

class newHere extends StatefulWidget {
  @override
  _newHereState createState() => _newHereState();
}

class _newHereState extends State<newHere> {
  String _valGender;
  bool _selectedGerman = false;
  bool _selectedfrance = false;
  bool _selecteditaly = false;
  int index = 0;
  String _selectedItem = "English";
  List _listGender = ["English", "German"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Questions.animatedContainer = 420.0;
    Questions.incomeAnimatedContainer = 370.0;
    Questions.homeAnimatedContainer = 210.0;
    Questions.workAnimatedContainer = 220.0;
    Questions.educationAnimatedContainer = 220.0;
    Questions.familyAnimatedContainer = 220.0;
    Questions.healthAnimatedContainer = 370.0;
    Questions.financeAnimatedContainer = 430.0;
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }

  void openOptionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
            child: Column(
              children: <Widget>[
                // ListTile(
                //   // leading: Icon(Icons.ac_unit),
                //   title: Text(

                //     'English',
                //     style: TextStyle(
                //        color: Colors.lightBlue,
                //      ),),
                //   onTap: () => _selectItem('English'),
                // ),

                ListTile(
                  // leading: Icon(Icons.accessibility_new),
                  trailing: _selectedGerman
                      ? Icon(
                          Icons.check,
                          color: Colors.lightBlue,
                          size: 18,
                        )
                      : Icon(Icons.check, color: Colors.white),
                  title: Text(
                    'German',
                    style: TextStyle(
                      color: Color(0xFF38B6FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    _selectItem('German');
                    setState(() {
                      _selectedGerman = true;
                      _selectedfrance = false;
                    });
                  },
                ),
                Divider(),
                ListTile(
                  // leading: Icon(Icons.assessment),
                  trailing: _selectedfrance
                      ? Icon(
                          Icons.check,
                          color: Colors.lightBlue,
                          size: 18,
                        )
                      : Icon(Icons.check, color: Colors.white),
                  title: Text(
                    'English',
                    style: TextStyle(
                      color: Color(0xFF38B6FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    _selectItem('English');
                    setState(() {
                      _selectedGerman = false;
                      _selectedfrance = true;
                    });
                  },
                ),
                // Divider(),

                //  ListTile(
                //   trailing: _selecteditaly?Icon(Icons.check,color:Colors.lightBlue,size: 18,):Icon(Icons.check,color:Colors.white),
                //   // leading: Icon(Icons.assessment),
                //   title: Text(
                //     'Italy',
                //      style: TextStyle(
                //        color: Colors.lightBlue,fontWeight: FontWeight.bold,
                //      ),
                //   ),
                //   onTap:(){
                //     _selectItem('Italy');
                //      setState(() {
                //       _selectedGerman=false;
                //       _selectedfrance=false;
                //       _selecteditaly=true;
                //     });
                //   },
                // ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Color(0xfff2f6ff),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  child: Container(
                    color: Color(0xFF38B6FF),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40.0,
                        ),
                        ListTile(
                            // leading: Icon(
                            //   Icons.arrow_back_ios,
                            //   color: Colors.white,
                            //   size: 15.0,
                            // ),
                            trailing: Container(
                                alignment: Alignment.centerRight,
//                    color: Colors.redAccent,
                                padding: EdgeInsets.only(left: 10.0),
                                width: 200.0,
                                height: 30.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    //Text('Change tax country',style: TextStyle(fontSize: 13.0,color: Colors.lightBlue),),

                                    DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: Container(
                                        child: Container(
                                          child: InkWell(
                                            onTap: () {
                                              openOptionSheet();
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  _selectedItem,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.expand_more,
                                                  color: Colors.white,
                                                  size: 26,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

//                               child: DropdownButton(
//                                 dropdownColor: Colors.blue,

//                                 style: TextStyle(color: Colors.black,fontSize: 15.0),
//                                 hint: Text(
//                                   "English       ",
//                                   style: TextStyle(
//                                     decoration: TextDecoration.none,
//                                     fontSize: 15.0,
//                                     fontFamily: 'Roboto',
//                                     //fontWeight: FontWeight.w700,
//                                    color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)
//                                   ),
//                                 ),
//                                 value : _valGender,
//                                 items: _listGender.map((value) {
//                                   return DropdownMenuItem(
//                                     child: Text(value),
//                                     value: value,
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _valGender = value;  // To tell _valGender that the contents will be changed according to the value we selected
//                                   });
//                                 },
// //                    style: Theme.of(context).textTheme.headline6,
//                                 iconEnabledColor: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)
//                               ),
                                      ),
                                    )),
//                        SizedBox(width: 5.0,),
//                        Icon(Icons.keyboard_arrow_down,size: 20.0,color: Colors.lightBlue,),
                                  ],
                                ))),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 20, top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Choose a tax year',
                                  style: TextStyle(
                                      wordSpacing: 2,
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: 'Helvetica-Bold',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                              child: AutoSizeText(
                            'Haven\'t filled a tax return for any of the past years? You can do it upto 4 years back',
                            style: TextStyle(
                              wordSpacing: 1.4,
                              height: 1.3,
                              fontSize: 22.5,
                              color: Colors.white,
                            ),
                            maxLines: 3,
                          )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 72,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1D436A).withOpacity(0.2),

                                blurRadius: 80,
                                offset:
                                    Offset(0, 12), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 4, bottom: 4),
                              child: ListTile(
                                leading: Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: AutoSizeText(
                                    '2019',
                                    style: TextStyle(
                                      fontFamily: "HelveticaBold",
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color(0xFF003350).withOpacity(0.803),
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    //Work Flow Start

//                        Questions.workAnswerShow = [];
//                        Questions.workYouIdentity = "you";
//                        Questions.workYourIdentity = "your";
//                        Questions.homeOfficeLength = 0;
//                        Questions.totalHomeOffice = 0;
//                        Questions.homeOfficeText = "";
//                        Questions.workFurnitureLength = 0;
//                        Questions.totalWorkFurniture = 0;
//                        Questions.workFurnitureText = "";
//                        Questions.otherFurniture = "";
//                        Questions.homeOfficeFurniture = false;
//                        Questions.workBusTripLength = 0;
//                        Questions.totalWorkBusTrip = 0;
//                        Questions.workBusTripText = "";
//                        Questions.workBusCostLength = 0;
//                        Questions.totalWorkBusCost = 0;
//                        Questions.workBusCostText = "";
//                        Questions.officeFurnitureLength = 0;
//                        Questions.totalOfficeFurniture = 0;
//                        Questions.officeFurnitureText = "";
//                        Questions.otherOfficeFurniture = "";
//                        Questions.otherItemsLength = 0;
//                        Questions.totalOtherItems = 0;
//                        Questions.otherItemsText = "";
//                        Questions.otherItems ="";
//                        Questions.applicationExpense;
//                        Questions.jobInterviewLength = 0;
//                        Questions.totalJobInterview = 0;
//                        Questions.jobInterviewText = "";
//                        Questions.otherCostExpense = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return WorkMainQuestions(CheckCompleteQuestion:"What was ${Questions.workYourIdentity} job title?",CheckQuestion:"Profession",CheckAnswer:[]);
//                        }));

                                    //Work Flow End

                                    //Finance Flow Start

//                        Questions.financeAnswerShow = [];
//                        Questions.financeYouIdentity = "you";
//                        Questions.financeYourIdentity = "your";
//                        Questions.financeOrganizationLength = 0;
//                        Questions.totalFinanceOrganization = 0;
//                        Questions.financeOrganizationText = "";
//                        Questions.financeEuOrganizationLength = 0;
//                        Questions.totalFinanceEuOrganization = 0;
//                        Questions.financeEuOrganizationText = "";
//                        Questions.financeReligiousLength = 0;
//                        Questions.totalFinanceReligious = 0;
//                        Questions.financeReligiousText = "";
//                        Questions.financePartyLength = 0;
//                        Questions.totalFinanceParty = 0;
//                        Questions.financePartyText = "";
//                        Questions.financeVoterLength = 0;
//                        Questions.totalFinanceVoter = 0;
//                        Questions.financeVoterText = "";
//                        Questions.financeProjectLength = 0;
//                        Questions.totalFinanceProject = 0;
//                        Questions.financeProjectText = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FinanceMainQuestions(CheckCompleteQuestion:"Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",CheckQuestion:"Pensions/Life insurances",CheckAnswer:[]);
//                        }));
                                    //Finance flow End

                                    //Health Flow Start//
//                        Questions.healthAnswerShow = [];
//                        Questions.healthYouIdentity = "you";
//                        Questions.healthYourIdentity = "your";
//                        Questions.healthChildrenLength = 0;
//                        Questions.totalHealthChildren = 0;
//                        Questions.healthChildrenText = "";
//                        Questions.peopleCareLength = 0;
//                        Questions.totalPeopleCare = 0;
//                        Questions.peopleCareText = "";
//                          Questions.doctorTripLength = 0;
//                          Questions.totalDoctorTrip = 0;
//                          Questions.doctorTripText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return HealthMainQuestions(CheckCompleteQuestion:"What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",CheckQuestion:"Kind of health insurance",CheckAnswer:[]);
//                        }));

                                    //HealthFlow End

                                    //Family Flow Start//

//                        Questions.familyAnswerShow = [];
//                        Questions.familyYouIdentity = "you";
//                        Questions.familyYourIdentity = "your";
//                        Questions.childLength = 0;
//                        Questions.totalChild = 0;
//                        Questions.childText = "";
//                        Questions.childFirstName = "";
//                        Questions.childrenLive = "";
//                        Questions.childrenExpense = "";
//                        Questions.childAddressLength = 0;
//                        Questions.totalChildAddress = 0;
//                        Questions.childAddressText = "";
//                        Questions.kindergartenLength = 0;
//                        Questions.totalKindergarten = 0;
//                        Questions.kindergartenText = "";
//                        Questions.childMinderLength = 0;
//                        Questions.totalChildMinder = 0;
//                        Questions.childMinderText = "";
//                        Questions.nannyLength = 0;
//                        Questions.totalNanny = 0;
//                        Questions.nannyText = "";
//                        Questions.babySitterLength = 0;
//                        Questions.totalBabySitter = 0;
//                        Questions.babySitterText = "";
//                        Questions.aupairLength = 0;
//                        Questions.totalAupair = 0;
//                        Questions.aupairText = "";
//                        Questions.dayCareLength = 0;
//                        Questions.totalDayCare = 0;
//                        Questions.dayCareText = "";
//                        Questions.schoolLength = 0;
//                        Questions.totalSchool = 0;
//                        Questions.schoolText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FamilyMainQuestions(CheckCompleteQuestion:"How many children do you have?",CheckQuestion:"Number of children",CheckAnswer:[]);
//                        }));

                                    //Family Flow End//

                                    //Living Situation Flow Start //

                                    if (Questions.yearfirstTime == 0) {
                                      Questions.yearfirstTime = 1;
                                      Questions.answerShow = [];
                                      Questions.LivingCheck = 0;
                                      Questions.livcolContainer = 0;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return mainQuestions(
                                            CheckQuestion:
                                                "What is your official marital status in Germany?",
                                            CheckAnswer: []);
                                      }));
                                    } else {
                                      Navigator.pushNamed(
                                          context, 'allCategoryScreen');
                                    }
                                    //Living Situation Flow End //
                                  },
                                  child: Container(
                                      height: 33,
                                      width: 98,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF31D8AC),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Begin',
                                          style: TextStyle(
                                              letterSpacing: 1.2,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 72,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1D436A).withOpacity(0.2),

                                blurRadius: 80,
                                offset:
                                    Offset(0, 12), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 4, bottom: 4),
                              child: ListTile(
                                leading: Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: AutoSizeText(
                                    '2018',
                                    style: TextStyle(
                                      fontFamily: "HelveticaBold",
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color(0xFF003350).withOpacity(0.803),
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    //Work Flow Start

//                        Questions.workAnswerShow = [];
//                        Questions.workYouIdentity = "you";
//                        Questions.workYourIdentity = "your";
//                        Questions.homeOfficeLength = 0;
//                        Questions.totalHomeOffice = 0;
//                        Questions.homeOfficeText = "";
//                        Questions.workFurnitureLength = 0;
//                        Questions.totalWorkFurniture = 0;
//                        Questions.workFurnitureText = "";
//                        Questions.otherFurniture = "";
//                        Questions.homeOfficeFurniture = false;
//                        Questions.workBusTripLength = 0;
//                        Questions.totalWorkBusTrip = 0;
//                        Questions.workBusTripText = "";
//                        Questions.workBusCostLength = 0;
//                        Questions.totalWorkBusCost = 0;
//                        Questions.workBusCostText = "";
//                        Questions.officeFurnitureLength = 0;
//                        Questions.totalOfficeFurniture = 0;
//                        Questions.officeFurnitureText = "";
//                        Questions.otherOfficeFurniture = "";
//                        Questions.otherItemsLength = 0;
//                        Questions.totalOtherItems = 0;
//                        Questions.otherItemsText = "";
//                        Questions.otherItems ="";
//                        Questions.applicationExpense;
//                        Questions.jobInterviewLength = 0;
//                        Questions.totalJobInterview = 0;
//                        Questions.jobInterviewText = "";
//                        Questions.otherCostExpense = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return WorkMainQuestions(CheckCompleteQuestion:"What was ${Questions.workYourIdentity} job title?",CheckQuestion:"Profession",CheckAnswer:[]);
//                        }));

                                    //Work Flow End

                                    //Finance Flow Start

//                        Questions.financeAnswerShow = [];
//                        Questions.financeYouIdentity = "you";
//                        Questions.financeYourIdentity = "your";
//                        Questions.financeOrganizationLength = 0;
//                        Questions.totalFinanceOrganization = 0;
//                        Questions.financeOrganizationText = "";
//                        Questions.financeEuOrganizationLength = 0;
//                        Questions.totalFinanceEuOrganization = 0;
//                        Questions.financeEuOrganizationText = "";
//                        Questions.financeReligiousLength = 0;
//                        Questions.totalFinanceReligious = 0;
//                        Questions.financeReligiousText = "";
//                        Questions.financePartyLength = 0;
//                        Questions.totalFinanceParty = 0;
//                        Questions.financePartyText = "";
//                        Questions.financeVoterLength = 0;
//                        Questions.totalFinanceVoter = 0;
//                        Questions.financeVoterText = "";
//                        Questions.financeProjectLength = 0;
//                        Questions.totalFinanceProject = 0;
//                        Questions.financeProjectText = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FinanceMainQuestions(CheckCompleteQuestion:"Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",CheckQuestion:"Pensions/Life insurances",CheckAnswer:[]);
//                        }));
                                    //Finance flow End

                                    //Health Flow Start//
//                        Questions.healthAnswerShow = [];
//                        Questions.healthYouIdentity = "you";
//                        Questions.healthYourIdentity = "your";
//                        Questions.healthChildrenLength = 0;
//                        Questions.totalHealthChildren = 0;
//                        Questions.healthChildrenText = "";
//                        Questions.peopleCareLength = 0;
//                        Questions.totalPeopleCare = 0;
//                        Questions.peopleCareText = "";
//                          Questions.doctorTripLength = 0;
//                          Questions.totalDoctorTrip = 0;
//                          Questions.doctorTripText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return HealthMainQuestions(CheckCompleteQuestion:"What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",CheckQuestion:"Kind of health insurance",CheckAnswer:[]);
//                        }));

                                    //HealthFlow End

                                    //Family Flow Start//

//                        Questions.familyAnswerShow = [];
//                        Questions.familyYouIdentity = "you";
//                        Questions.familyYourIdentity = "your";
//                        Questions.childLength = 0;
//                        Questions.totalChild = 0;
//                        Questions.childText = "";
//                        Questions.childFirstName = "";
//                        Questions.childrenLive = "";
//                        Questions.childrenExpense = "";
//                        Questions.childAddressLength = 0;
//                        Questions.totalChildAddress = 0;
//                        Questions.childAddressText = "";
//                        Questions.kindergartenLength = 0;
//                        Questions.totalKindergarten = 0;
//                        Questions.kindergartenText = "";
//                        Questions.childMinderLength = 0;
//                        Questions.totalChildMinder = 0;
//                        Questions.childMinderText = "";
//                        Questions.nannyLength = 0;
//                        Questions.totalNanny = 0;
//                        Questions.nannyText = "";
//                        Questions.babySitterLength = 0;
//                        Questions.totalBabySitter = 0;
//                        Questions.babySitterText = "";
//                        Questions.aupairLength = 0;
//                        Questions.totalAupair = 0;
//                        Questions.aupairText = "";
//                        Questions.dayCareLength = 0;
//                        Questions.totalDayCare = 0;
//                        Questions.dayCareText = "";
//                        Questions.schoolLength = 0;
//                        Questions.totalSchool = 0;
//                        Questions.schoolText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FamilyMainQuestions(CheckCompleteQuestion:"How many children do you have?",CheckQuestion:"Number of children",CheckAnswer:[]);
//                        }));

                                    //Family Flow End//

                                    //Living Situation Flow Start //

                                    if (Questions.yearfirstTime == 0) {
                                      Questions.yearfirstTime = 1;
                                      Questions.answerShow = [];
                                      Questions.LivingCheck = 0;
                                      Questions.livcolContainer = 0;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return mainQuestions(
                                            CheckQuestion:
                                                "What is your official marital status in Germany?",
                                            CheckAnswer: []);
                                      }));
                                    } else {
                                      Navigator.pushNamed(
                                          context, 'allCategoryScreen');
                                    }
                                    //Living Situation Flow End //
                                  },
                                  child: Container(
                                      height: 33,
                                      width: 98,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF31D8AC),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Begin',
                                          style: TextStyle(
                                              letterSpacing: 1.2,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //       Container(
                    //         height: 90,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(4.0),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //           boxShadow: [
                    //   BoxShadow(
                    //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                    //     spreadRadius: 5,
                    //     blurRadius: 25,
                    //     offset: Offset(3, 0), // changes position of shadow
                    //   ),
                    // ],
                    //         ),
                    //             child: Card(
                    //               elevation: 0,
                    //               shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.all(8.0),
                    //                             child: ListTile(

                    //                 leading: Padding(
                    //                   padding: const EdgeInsets.only(top:6.0),
                    //                   child: AutoSizeText(
                    //                     '2018',
                    //                     style: TextStyle(
                    //                        fontFamily: "Helvetica",
                    //                       fontSize: 24.0,
                    //                       fontWeight: FontWeight.w700,
                    //                      color: Color(0xFF003350).withOpacity(0.803),),
                    //                   ),
                    //                 ),
                    //                 trailing: GestureDetector(
                    //                   onTap: () {
                    //                     // Questions.incomeAnswerShow = [];
                    //                     // Questions.incomeYouIdentity = "you";
                    //                     // Questions.incomeYourIdentity = "your";
                    //                     // Questions.totalDomain = 0;
                    //                     // Questions.domainLength = 0;
                    //                     // Questions.totalValuable = 0;
                    //                     // Questions.valuableLength = 0;
                    //                     // Questions.residence = "";
                    //                     // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //                     //   return IncomeMainQuestions(
                    //                     //         CheckCompleteQuestion:
                    //                     //             "Have you received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
                    //                     //         CheckQuestion: "",
                    //                     //         CheckAnswer: []);

                    //                      Questions.yearfirstTime = 1;
                    //                       Questions.answerShow = [];
                    //                       Questions.LivingCheck = 0;
                    //                       Questions.livcolContainer = 0;
                    //                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //                           return mainQuestions(
                    //                               CheckQuestion:
                    //                                   "What is your official marital status in Germany?",
                    //                               CheckAnswer: []);
                    //                     }));
                    //                   },
                    //                   child: Container(
                    //                       decoration: BoxDecoration(
                    //                              color: Color(0xFF31D8AC),
                    //                             borderRadius: BorderRadius.circular(10.0),
                    //                             border: Border.all(width: 1.0,color: Color(0xFF31D8AC))),
                    //                       child: Padding(
                    //                           padding: EdgeInsets.only(
                    //                               left: 26.0, right: 26.0, top: 8.0, bottom: 8.0),
                    //                           child: Text(
                    //                             'Begin',
                    //                             style: TextStyle(letterSpacing: 1.2,color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold ),
                    //                           ),
                    //                       )),
                    //                 ),
                    //               ),
                    //                           ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Divider(
                    //   thickness: 1.0,
                    // ),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 72,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1D436A).withOpacity(0.2),

                                blurRadius: 80,
                                offset:
                                    Offset(0, 12), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 4, bottom: 4),
                              child: ListTile(
                                leading: Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: AutoSizeText(
                                    '2017',
                                    style: TextStyle(
                                      fontFamily: "HelveticaBold",
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color(0xFF003350).withOpacity(0.803),
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    //Work Flow Start

//                        Questions.workAnswerShow = [];
//                        Questions.workYouIdentity = "you";
//                        Questions.workYourIdentity = "your";
//                        Questions.homeOfficeLength = 0;
//                        Questions.totalHomeOffice = 0;
//                        Questions.homeOfficeText = "";
//                        Questions.workFurnitureLength = 0;
//                        Questions.totalWorkFurniture = 0;
//                        Questions.workFurnitureText = "";
//                        Questions.otherFurniture = "";
//                        Questions.homeOfficeFurniture = false;
//                        Questions.workBusTripLength = 0;
//                        Questions.totalWorkBusTrip = 0;
//                        Questions.workBusTripText = "";
//                        Questions.workBusCostLength = 0;
//                        Questions.totalWorkBusCost = 0;
//                        Questions.workBusCostText = "";
//                        Questions.officeFurnitureLength = 0;
//                        Questions.totalOfficeFurniture = 0;
//                        Questions.officeFurnitureText = "";
//                        Questions.otherOfficeFurniture = "";
//                        Questions.otherItemsLength = 0;
//                        Questions.totalOtherItems = 0;
//                        Questions.otherItemsText = "";
//                        Questions.otherItems ="";
//                        Questions.applicationExpense;
//                        Questions.jobInterviewLength = 0;
//                        Questions.totalJobInterview = 0;
//                        Questions.jobInterviewText = "";
//                        Questions.otherCostExpense = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return WorkMainQuestions(CheckCompleteQuestion:"What was ${Questions.workYourIdentity} job title?",CheckQuestion:"Profession",CheckAnswer:[]);
//                        }));

                                    //Work Flow End

                                    //Finance Flow Start

//                        Questions.financeAnswerShow = [];
//                        Questions.financeYouIdentity = "you";
//                        Questions.financeYourIdentity = "your";
//                        Questions.financeOrganizationLength = 0;
//                        Questions.totalFinanceOrganization = 0;
//                        Questions.financeOrganizationText = "";
//                        Questions.financeEuOrganizationLength = 0;
//                        Questions.totalFinanceEuOrganization = 0;
//                        Questions.financeEuOrganizationText = "";
//                        Questions.financeReligiousLength = 0;
//                        Questions.totalFinanceReligious = 0;
//                        Questions.financeReligiousText = "";
//                        Questions.financePartyLength = 0;
//                        Questions.totalFinanceParty = 0;
//                        Questions.financePartyText = "";
//                        Questions.financeVoterLength = 0;
//                        Questions.totalFinanceVoter = 0;
//                        Questions.financeVoterText = "";
//                        Questions.financeProjectLength = 0;
//                        Questions.totalFinanceProject = 0;
//                        Questions.financeProjectText = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FinanceMainQuestions(CheckCompleteQuestion:"Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",CheckQuestion:"Pensions/Life insurances",CheckAnswer:[]);
//                        }));
                                    //Finance flow End

                                    //Health Flow Start//
//                        Questions.healthAnswerShow = [];
//                        Questions.healthYouIdentity = "you";
//                        Questions.healthYourIdentity = "your";
//                        Questions.healthChildrenLength = 0;
//                        Questions.totalHealthChildren = 0;
//                        Questions.healthChildrenText = "";
//                        Questions.peopleCareLength = 0;
//                        Questions.totalPeopleCare = 0;
//                        Questions.peopleCareText = "";
//                          Questions.doctorTripLength = 0;
//                          Questions.totalDoctorTrip = 0;
//                          Questions.doctorTripText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return HealthMainQuestions(CheckCompleteQuestion:"What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",CheckQuestion:"Kind of health insurance",CheckAnswer:[]);
//                        }));

                                    //HealthFlow End

                                    //Family Flow Start//

//                        Questions.familyAnswerShow = [];
//                        Questions.familyYouIdentity = "you";
//                        Questions.familyYourIdentity = "your";
//                        Questions.childLength = 0;
//                        Questions.totalChild = 0;
//                        Questions.childText = "";
//                        Questions.childFirstName = "";
//                        Questions.childrenLive = "";
//                        Questions.childrenExpense = "";
//                        Questions.childAddressLength = 0;
//                        Questions.totalChildAddress = 0;
//                        Questions.childAddressText = "";
//                        Questions.kindergartenLength = 0;
//                        Questions.totalKindergarten = 0;
//                        Questions.kindergartenText = "";
//                        Questions.childMinderLength = 0;
//                        Questions.totalChildMinder = 0;
//                        Questions.childMinderText = "";
//                        Questions.nannyLength = 0;
//                        Questions.totalNanny = 0;
//                        Questions.nannyText = "";
//                        Questions.babySitterLength = 0;
//                        Questions.totalBabySitter = 0;
//                        Questions.babySitterText = "";
//                        Questions.aupairLength = 0;
//                        Questions.totalAupair = 0;
//                        Questions.aupairText = "";
//                        Questions.dayCareLength = 0;
//                        Questions.totalDayCare = 0;
//                        Questions.dayCareText = "";
//                        Questions.schoolLength = 0;
//                        Questions.totalSchool = 0;
//                        Questions.schoolText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FamilyMainQuestions(CheckCompleteQuestion:"How many children do you have?",CheckQuestion:"Number of children",CheckAnswer:[]);
//                        }));

                                    //Family Flow End//

                                    //Living Situation Flow Start //

                                    if (Questions.yearfirstTime == 0) {
                                      Questions.yearfirstTime = 1;
                                      Questions.answerShow = [];
                                      Questions.LivingCheck = 0;
                                      Questions.livcolContainer = 0;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return mainQuestions(
                                            CheckQuestion:
                                                "What is your official marital status in Germany?",
                                            CheckAnswer: []);
                                      }));
                                    } else {
                                      Navigator.pushNamed(
                                          context, 'allCategoryScreen');
                                    }
                                    //Living Situation Flow End //
                                  },
                                  child: Container(
                                      height: 33,
                                      width: 98,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF31D8AC),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Begin',
                                          style: TextStyle(
                                              letterSpacing: 1.2,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //       Container(
                    //          height: 90,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(4.0),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //           boxShadow: [
                    //   BoxShadow(
                    //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                    //     spreadRadius: 5,
                    //     blurRadius: 25,
                    //     offset: Offset(3, 0), // changes position of shadow
                    //   ),
                    // ],
                    //         ),
                    //             child: Card(
                    //               elevation: 0,
                    //                 shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.all(8.0),
                    //                             child: ListTile(
                    //                   leading: Padding(
                    //                     padding: const EdgeInsets.only(top:6.0),
                    //                     child: AutoSizeText(
                    //                       '2017',
                    //                       style: TextStyle(
                    //                          fontFamily: "Helvetica",
                    //                       fontSize: 24.0,
                    //                       fontWeight: FontWeight.w700,
                    //                      color: Color(0xFF003350).withOpacity(0.803),),
                    //                     ),
                    //                   ),
                    //                   trailing: GestureDetector(
                    //                     onTap: () {
                    //                       // Questions.homeAnswerShow = [];
                    //                       // Questions.homeYouIdentity = "you";
                    //                       // Questions.homeYourIdentity = "your";
                    //                       // Questions.utilityBillLength = 0;
                    //                       // Questions.totalUtilityBill = 0;
                    //                       // Questions.WEGLength = 0;
                    //                       // Questions.totalWEG = 0;
                    //                       // Questions.modeOfTransport = "";
                    //                       // Questions.Appliance = "";
                    //                       // Questions.otherFixture = "";
                    //                       // Questions.totalSecondHouseHold = 0;
                    //                       // Questions.secondHouseHoldLength = 0;
                    //                       // Questions.secondHouseHoldText = "";
                    //                       // Questions.totalRelocation = 0;
                    //                       // Questions.relocationLength = 0;
                    //                       // Questions.relocationText = "";
                    //                       // Questions.totalCraftsmen = 0;
                    //                       // Questions.craftsmenLength = 0;
                    //                       // Questions.craftsmenText = "";
                    //                       // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //                       //   return HomeMainQuestions(
                    //                       //         CheckCompleteQuestion: "What is your current address?",
                    //                       //         CheckQuestion: "Current address",
                    //                       //         CheckAnswer: []);

                    //                        Questions.yearfirstTime = 1;
                    //                       Questions.answerShow = [];
                    //                       Questions.LivingCheck = 0;
                    //                       Questions.livcolContainer = 0;
                    //                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //                           return mainQuestions(
                    //                               CheckQuestion:
                    //                                   "What is your official marital status in Germany?",
                    //                               CheckAnswer: []);

                    //                       }));
                    //                     },
                    //                     child: Container(
                    //                         decoration: BoxDecoration(
                    //                               color: Color(0xFF31D8AC),
                    //                                     borderRadius: BorderRadius.circular(10.0),
                    //                                     border: Border.all(width: 1.0,color: Color(0xFF31D8AC))),
                    //                               child: Padding(
                    //                                   padding: EdgeInsets.only(
                    //                                       left: 26.0, right: 26.0, top: 8.0, bottom: 8.0),
                    //                                   child: Text(
                    //                                     'Begin',
                    //                                     style: TextStyle(letterSpacing: 1.2,color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold ),
                    //                                   ),
                    //                         )),
                    //                   )),
                    //                           ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    SizedBox(
                      height: 10.0,
                    ),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 72,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1D436A).withOpacity(0.2),

                                blurRadius: 80,
                                offset:
                                    Offset(0, 12), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 4, bottom: 4),
                              child: ListTile(
                                leading: Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: AutoSizeText(
                                    '2016',
                                    style: TextStyle(
                                      fontFamily: "HelveticaBold",
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color(0xFF003350).withOpacity(0.803),
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    //Work Flow Start

//                        Questions.workAnswerShow = [];
//                        Questions.workYouIdentity = "you";
//                        Questions.workYourIdentity = "your";
//                        Questions.homeOfficeLength = 0;
//                        Questions.totalHomeOffice = 0;
//                        Questions.homeOfficeText = "";
//                        Questions.workFurnitureLength = 0;
//                        Questions.totalWorkFurniture = 0;
//                        Questions.workFurnitureText = "";
//                        Questions.otherFurniture = "";
//                        Questions.homeOfficeFurniture = false;
//                        Questions.workBusTripLength = 0;
//                        Questions.totalWorkBusTrip = 0;
//                        Questions.workBusTripText = "";
//                        Questions.workBusCostLength = 0;
//                        Questions.totalWorkBusCost = 0;
//                        Questions.workBusCostText = "";
//                        Questions.officeFurnitureLength = 0;
//                        Questions.totalOfficeFurniture = 0;
//                        Questions.officeFurnitureText = "";
//                        Questions.otherOfficeFurniture = "";
//                        Questions.otherItemsLength = 0;
//                        Questions.totalOtherItems = 0;
//                        Questions.otherItemsText = "";
//                        Questions.otherItems ="";
//                        Questions.applicationExpense;
//                        Questions.jobInterviewLength = 0;
//                        Questions.totalJobInterview = 0;
//                        Questions.jobInterviewText = "";
//                        Questions.otherCostExpense = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return WorkMainQuestions(CheckCompleteQuestion:"What was ${Questions.workYourIdentity} job title?",CheckQuestion:"Profession",CheckAnswer:[]);
//                        }));

                                    //Work Flow End

                                    //Finance Flow Start

//                        Questions.financeAnswerShow = [];
//                        Questions.financeYouIdentity = "you";
//                        Questions.financeYourIdentity = "your";
//                        Questions.financeOrganizationLength = 0;
//                        Questions.totalFinanceOrganization = 0;
//                        Questions.financeOrganizationText = "";
//                        Questions.financeEuOrganizationLength = 0;
//                        Questions.totalFinanceEuOrganization = 0;
//                        Questions.financeEuOrganizationText = "";
//                        Questions.financeReligiousLength = 0;
//                        Questions.totalFinanceReligious = 0;
//                        Questions.financeReligiousText = "";
//                        Questions.financePartyLength = 0;
//                        Questions.totalFinanceParty = 0;
//                        Questions.financePartyText = "";
//                        Questions.financeVoterLength = 0;
//                        Questions.totalFinanceVoter = 0;
//                        Questions.financeVoterText = "";
//                        Questions.financeProjectLength = 0;
//                        Questions.totalFinanceProject = 0;
//                        Questions.financeProjectText = "";
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FinanceMainQuestions(CheckCompleteQuestion:"Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",CheckQuestion:"Pensions/Life insurances",CheckAnswer:[]);
//                        }));
                                    //Finance flow End

                                    //Health Flow Start//
//                        Questions.healthAnswerShow = [];
//                        Questions.healthYouIdentity = "you";
//                        Questions.healthYourIdentity = "your";
//                        Questions.healthChildrenLength = 0;
//                        Questions.totalHealthChildren = 0;
//                        Questions.healthChildrenText = "";
//                        Questions.peopleCareLength = 0;
//                        Questions.totalPeopleCare = 0;
//                        Questions.peopleCareText = "";
//                          Questions.doctorTripLength = 0;
//                          Questions.totalDoctorTrip = 0;
//                          Questions.doctorTripText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return HealthMainQuestions(CheckCompleteQuestion:"What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",CheckQuestion:"Kind of health insurance",CheckAnswer:[]);
//                        }));

                                    //HealthFlow End

                                    //Family Flow Start//

//                        Questions.familyAnswerShow = [];
//                        Questions.familyYouIdentity = "you";
//                        Questions.familyYourIdentity = "your";
//                        Questions.childLength = 0;
//                        Questions.totalChild = 0;
//                        Questions.childText = "";
//                        Questions.childFirstName = "";
//                        Questions.childrenLive = "";
//                        Questions.childrenExpense = "";
//                        Questions.childAddressLength = 0;
//                        Questions.totalChildAddress = 0;
//                        Questions.childAddressText = "";
//                        Questions.kindergartenLength = 0;
//                        Questions.totalKindergarten = 0;
//                        Questions.kindergartenText = "";
//                        Questions.childMinderLength = 0;
//                        Questions.totalChildMinder = 0;
//                        Questions.childMinderText = "";
//                        Questions.nannyLength = 0;
//                        Questions.totalNanny = 0;
//                        Questions.nannyText = "";
//                        Questions.babySitterLength = 0;
//                        Questions.totalBabySitter = 0;
//                        Questions.babySitterText = "";
//                        Questions.aupairLength = 0;
//                        Questions.totalAupair = 0;
//                        Questions.aupairText = "";
//                        Questions.dayCareLength = 0;
//                        Questions.totalDayCare = 0;
//                        Questions.dayCareText = "";
//                        Questions.schoolLength = 0;
//                        Questions.totalSchool = 0;
//                        Questions.schoolText = "";
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                          return FamilyMainQuestions(CheckCompleteQuestion:"How many children do you have?",CheckQuestion:"Number of children",CheckAnswer:[]);
//                        }));

                                    //Family Flow End//

                                    //Living Situation Flow Start //

                                    if (Questions.yearfirstTime == 0) {
                                      Questions.yearfirstTime = 1;
                                      Questions.answerShow = [];
                                      Questions.LivingCheck = 0;
                                      Questions.livcolContainer = 0;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return mainQuestions(
                                            CheckQuestion:
                                                "What is your official marital status in Germany?",
                                            CheckAnswer: []);
                                      }));
                                    } else {
                                      Navigator.pushNamed(
                                          context, 'allCategoryScreen');
                                    }
                                    //Living Situation Flow End //
                                  },
                                  child: Container(
                                      height: 33,
                                      width: 98,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF31D8AC),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Begin',
                                          style: TextStyle(
                                              letterSpacing: 1.2,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Divider(
                    //   thickness: 1.0,
                    // ),
                    //       Container(

                    //         child: Padding(
                    //           padding: const EdgeInsets.all(4.0),

                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //           boxShadow: [
                    //   BoxShadow(
                    //    color: Color(0xFF003350).withOpacity(0.803).withOpacity(0.2),
                    //     spreadRadius: 5,
                    //     blurRadius: 25,
                    //     offset: Offset(3, 0), // changes position of shadow
                    //   ),
                    // ],
                    //         ),
                    //             child: Card(
                    //               elevation: 0,
                    //                shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.all(8.0),
                    //                             child: ListTile(
                    //                   leading: Padding(
                    //                     padding: const EdgeInsets.only(top:6.0),
                    //                     child: AutoSizeText(
                    //                       '2016',
                    //                       style: TextStyle(
                    //                          fontFamily: "Helvetica",
                    //                       fontSize: 24.0,
                    //                       fontWeight: FontWeight.w700,
                    //                      color: Color(0xFF003350).withOpacity(0.803),),
                    //                     ),
                    //                   ),
                    //                   trailing: GestureDetector(
                    //                     onTap: () {
                    //                       // Questions.educationAnswerShow = [];
                    //                       // Questions.educationYouIdentity = "you";
                    //                       // Questions.educationYourIdentity = "your";
                    //                       // Questions.educationOtherCosts = "";
                    //                       // Questions.trainingLength = 1;
                    //                       // Questions.totalTraining = 0;
                    //                       // Questions.trainingText =
                    //                       //       "TRAINING ${Questions.trainingLength}";
                    //                       // Questions.schoolRouteLength = 0;
                    //                       // Questions.totalSchoolRoute = 0;
                    //                       // Questions.schoolRouteText = "";
                    //                       // Questions.libraryRouteLength = 0;
                    //                       // Questions.totalLibraryRoute = 0;
                    //                       // Questions.libraryRouteText = "";
                    //                       // Questions.unpaidInternLength = 0;
                    //                       // Questions.totalUnpaidIntern = 0;
                    //                       // Questions.unpaidInternText = "";
                    //                       // Questions.excursionLength = 0;
                    //                       // Questions.totalExcursion = 0;
                    //                       // Questions.excursionText = "";
                    //                       // Questions.semesterLength = 0;
                    //                       // Questions.totalSemester = 0;
                    //                       // Questions.semesterText = "";
                    //                       // Questions.educationTraItem = "";
                    //                       // Questions.educationExpfurniture = "EXPENSIVE FURNITURE";
                    //                       // Questions.educationOtherFurniture = "";
                    //                       // Questions.equipmentLength = 0;
                    //                       // Questions.totalEquipment = 0;
                    //                       // Questions.equipmentText = "";
                    //                       // Questions.equipmentName = "";
                    //                       // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //                       //   return EducationMainQuestions(
                    //                       //         CheckCompleteQuestion:
                    //                       //             "Did you complete any degrees or professional qualifications before 2019?",
                    //                       //         CheckQuestion: "Degree before 2019",
                    //                       //         CheckAnswer: []);

                    //                        Questions.yearfirstTime = 1;
                    //                       Questions.answerShow = [];
                    //                       Questions.LivingCheck = 0;
                    //                       Questions.livcolContainer = 0;
                    //                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //                           return mainQuestions(
                    //                               CheckQuestion:
                    //                                   "What is your official marital status in Germany?",
                    //                               CheckAnswer: []);
                    //                        }));

                    //                     },
                    //                     child: Container(
                    //                         decoration: BoxDecoration(
                    //                              color: Color(0xFF31D8AC),
                    //                                             borderRadius: BorderRadius.circular(10.0),
                    //                                             border: Border.all(width: 1.0,color: Color(0xFF31D8AC))),
                    //                                       child: Padding(
                    //                                           padding: EdgeInsets.only(
                    //                                               left: 26.0, right: 26.0, top: 8.0, bottom: 8.0),
                    //                                           child: Text(
                    //                                             'Begin',
                    //                                             style: TextStyle(letterSpacing: 1.2,color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold ),
                    //                                           ),
                    //                         )),
                    //                   )),
                    //                           ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //           ],
                    //         ),
                    //       ),

                    SizedBox(
                      height: 80.0,
                    ),
//           Divider(
//             thickness: 1.0,
//           ),
//           ListTile(
//               leading: Container(
//                   width: 250.0,
// //                color: Colors.red,
//                   child: Row(
//                     children: <Widget>[
//                       AutoSizeText(
//                         '2015',
//                         style: TextStyle(fontSize: 20.0, color: Colors.grey),
//                       ),
//                       SizedBox(
//                         width: 10.0,
//                       ),
//                       AutoSizeText(
//                         'Deadline Expired',
//                         style: TextStyle(fontSize: 20.0, color: Colors.grey),
//                       ),
//                     ],
//                   )
//                   )
//                   ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
