import 'package:easy_taxx/livingsituation_flow/container1.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finishcategory.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_taxx/health_flow/healthmultithreecontainer.dart';
import 'package:easy_taxx/health_flow/healthyesnocontainer.dart';
import 'package:easy_taxx/health_flow/healthcalculationcontainer.dart';
import 'package:easy_taxx/health_flow/healthmultipleoptionscontainer.dart';
import 'package:easy_taxx/health_flow/healthmultitwocontainer.dart';
import 'package:easy_taxx/health_flow/healthaddresscontainer.dart';
import 'package:easy_taxx/health_flow/healthtwooptioncontainer.dart';
import 'package:easy_taxx/health_flow/healthdatecontainer.dart';
import 'package:easy_taxx/health_flow/healthdifferentoptioncontainer.dart';

class HealthMainQuestions extends StatefulWidget {
  String CheckCompleteQuestion;
  String CheckQuestion;
  List CheckAnswer;

  HealthMainQuestions(
      {Key key,
      this.CheckCompleteQuestion,
      this.CheckQuestion,
      this.CheckAnswer})
      : super(key: key);

  @override
  _HealthMainQuestionsState createState() => _HealthMainQuestionsState();
}

class _HealthMainQuestionsState extends State<HealthMainQuestions> {
  Questions qu = Questions();
  var dynamicContainer = List<Widget>();
  var dynamicContainerbig = List<Widget>();
  bool detail = true;
  String detailOption;
  double screenHeight = 0.0;
  double screenHeightbig = 0.0;
  List screenHeightbiglist = [];
  String detailsHeight;
  int countLongContainer = 0;
  int i, j = 0, l = 0, co;
  int k = 0;
  int heightcount = 0;
  List heightList = [];
  List screenheightList = [];
  int hlength = 0;
  bool a = false;
  final dbHelper = DbHelper.insatance;

  void _insert(String question, String answer, String status) async {
    // row to insert
    Map<String, dynamic> row = {
      DbHelper.columnQuestion: question,
      DbHelper.columnAnswer: answer,
      DbHelper.columnStatus: status
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

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
    //timer();
    Screenheight();
    DynamicContainer();
  }

  void Screenheight() {
    print("question length:" + Questions.healthAnswerShow.length.toString());

    for (k = l; k < Questions.healthAnswerShow.length; k++) {
      print("how manysdsdsd");
      screenHeightbig = 0.0;
      if (Questions.healthAnswerShow[k]['identity'] == "You" ||
          Questions.healthAnswerShow[k]['identity'] == "You & Partner" ||
          Questions.healthAnswerShow[k]['identity'] == "Partner") {
        screenHeight = screenHeight + 70.0;
      } else if (Questions.healthAnswerShow[k]['details'] == "") {
        screenHeight = screenHeight + 60.0;
        detail = true;
      } else {
        detailsHeight = Questions.healthAnswerShow[k]['details'];

        for (l = k; l < Questions.healthAnswerShow.length; l++) {
          if (Questions.healthAnswerShow[l]['details'] == detailsHeight) {
            print("height");
            heightcount++;
          } else {
            //k = l-1;
            break;
          }
        }

        k = l - 1;

        print("height screen is:" + heightcount.toString());
        heightList.add(heightcount);
        print("height list:" + heightList.toString());
        heightcount = 0;
        screenheightList = [];
        for (int he = 0; he < heightList.length; he++) {
          screenheightList.add((heightList[he] * 60.0) + 60.0 + 2);
        }

        print(screenheightList.toString());
//        for(int h=0;h<screenheightList.length;h++)
//          {
//            screenHeightbig = screenheightList[h] + 5.0;
//          }

        //calculate screen height according to new big container
        screenHeight =
            screenHeight + screenheightList[screenheightList.length - 1] + 5.0;
      }
      print("k:" + k.toString() + "l:" + l.toString());
    }
    //screenHeightbig = screenHeightbig +2;
    screenHeight = screenHeight + Questions.healthAnimatedContainer;
    // screenHeight = screenHeight;
    print("Screen Height:" + screenHeight.toString());
//    print("Screen Height big:"+screenHeightbig.toString());

    detail = true;
  }

  void DynamicContainer() {
    hlength = 0;
    // print("question length:"+Questions.answerShow.length.toString());
    for (i = j; i < Questions.healthAnswerShow.length; i++) {
      print("value oif i is:" + i.toString());

      print("dat is:" + i.toString());
      //You and your and your partner identity
      if (Questions.healthAnswerShow[i]['identity'] == "You" ||
          Questions.healthAnswerShow[i]['identity'] == "You & Partner" ||
          Questions.healthAnswerShow[i]['identity'] == "Partner") {
        dynamicContainer.add(Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: Questions.healthAnswerShow[i]['containerheight'],
          width: 450.0,
          child: Text(Questions.healthAnswerShow[i]['identity'],
              style: TextStyle(fontSize: 40.0)),
        ));
      } else if (Questions.healthAnswerShow[i]['details'] == "") {
        dynamicContainer.add(SingleSmallContainer(currentIndex: i)
//            Container(
//              margin: EdgeInsets.only(
//                  top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
//              height: Questions.healthAnswerShow[i]['containerheight'],
//              width: 450.0,
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(7.0),
//                  border: Border.all(width: 1.0, color: Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8))
//              ),
//              child: Padding(
//                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      //Text(Questions.answerShow[i]['question']),
//                      Container(
//                          width: 155.0,
//                          //color: Colors.purple,
//                          child:AutoSizeText(Questions.healthAnswerShow[i]['question'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                      ),
//                      Row(children: <Widget>[
//                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                        Container(
//                            width: 140.0,
//                            // color:Colors.blue,
//                            child:AutoSizeText(Questions.healthAnswerShow[i]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
//
//                        ),
//                        SizedBox(width: 5.0,),
//                        Icon(Icons.arrow_forward_ios, size: 12.0,
//                            color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF))
//                      ],)
//                    ],
//                  )),
//            )
            );
      }

      //data that contains long container
      else {
        detailOption = Questions.healthAnswerShow[i]['details'];
        print(detailOption);
        countLongContainer = 0;
//print("ahsjasjasksss");

        //set length of data in details that how much data comes
        for (co = i; co < Questions.healthAnswerShow.length; co++) {
          if (Questions.healthAnswerShow[co]['details'] == detailOption) {
            countLongContainer++;
            //print("data after container");

          } else {
            break;
          }
        }

        countLongContainer = countLongContainer + i;
        //print("count long container:"+countLongContainer.toString()+" "+i.toString());

        for (j = i; j < countLongContainer; j++) {
//print("4<5");
          if (Questions.healthAnswerShow[j]['details'] == detailOption &&
              detail == true) {
            dynamicContainerbig.add(
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Container(
                    height: 55.0,
                    width: 450.0,
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Text(Questions.answerShow[i]['question']),
                            Text(
                              Questions.healthAnswerShow[i]['details'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'HelveticaBold',
                                  fontSize: 15.0,
                                  color: Color(0xFF003350).withOpacity(0.803)),
                            ),
                            Row(
                              children: <Widget>[
                                //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
                                Text(""),
                                SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            )
                          ],
                        ))),
              ),
            );

            dynamicContainerbig.add(
              Divider(
                color: Color(0xFFF2F6FF),
                height: 3,
                thickness: 2,
              ),
            );
            //so that details data not come again and again
            detail = false;
          }
          // after details data
          if (Questions.healthAnswerShow[j]['details'] == detailOption &&
              detail == false) {
            dynamicContainerbig.add(MultipleBigContainer(currentIndex: j)
//              Container(
//                  color: Colors.white,
//                  height: 55.0,
//                  width: 450.0,
//                  child: Padding(
//                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          //Text(Questions.answerShow[i]['question']),
//                          Container(
//                              width: 155.0,
//                              //color: Colors.purple,
//                              child:AutoSizeText(Questions.healthAnswerShow[j]['question'],style: TextStyle(color: Colors.grey),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                          ),
//                          Row(children: <Widget>[
//                            //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                            Container(
//                                width: 140.0,
//                                // color:Colors.blue,
//                                child:AutoSizeText(Questions.healthAnswerShow[j]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
//
//                            ),
//                            SizedBox(width: 5.0,),
//                            Icon(Icons.arrow_forward_ios, size: 12.0,
//                              color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),)
//                          ],)
//                        ],
//                      ))
//              ),

                );

//For last line

            dynamicContainerbig.add(Container(
              margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
              height: j == countLongContainer - 1 ? 0.0 : 1.0,
              color: Colors.grey[200],
            ));
          }
        }
//per container 5
        dynamicContainer.add(Container(
            height: screenheightList[hlength],
            margin:
                EdgeInsets.only(bottom: 2.5, top: 2.5, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // border: Border.all(width: 1.0, color: Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8))
            ),
            child: Column(
              children: dynamicContainerbig,
            )));

        i = j - 1;
        detail = true;
        dynamicContainerbig = [];
        hlength++;

        //print("value oif j is:"+j.toString());

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .008;
    double maxHeight = MediaQuery.of(context).size.height * .82;
    return Scaffold(
        backgroundColor: Color(0xFFf2f6ff),
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                height: 110,
                color: Color(0xFF38B6FF),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 45.0,
                    ),
                    ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                // Icon(
                                //   Icons.arrow_back_ios,
                                //   color: Colors.white,
                                //   size: 22.0,
                                // )
                                Image(
                              image: AssetImage("images/arrow_forward_ios.png"),
                              height: 16,
                              width: 9,
                            ),
                          ),
                        ),
                        title: Center(
                          child: Text(
                            "Health",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // title: Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: <Widget>[
                        //     GestureDetector(
                        //       // onTap: () {},
                        //       // child: Icon(
                        //       //   Icons.person_outline,
                        //       //   color: Colors.white,
                        //       //   size: 32,
                        //       // ),
                        //       child: Image(image: AssetImage("images/allcategoryuser.png"),width: 18.0,height: 18.0,)
                        //     ),
                        //     SizedBox(width: 5,),

                        //   ],
                        // ),

                        trailing: Image(
                          image: AssetImage("images/skip.png"),
                          width: 21.0,
                          height: 21.0,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),

        // AppBar(

        //   leading: GestureDetector(
        //       onTap: () {
        //         Navigator.pushReplacementNamed(context, 'allCategoryScreen');
        //         //  Navigator.pop(context);
        //       },
        //       child:Icon(Icons.arrow_back_ios,color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),size: 20.0)
        // ),
        // title: Text('Health',style: TextStyle(color: Colors.black,fontSize: 14.0),),
        // centerTitle: true,
        // actions: <Widget>[
        //   Padding(
        //       padding: EdgeInsets.only(right: 18.0),
        //       child:GestureDetector(
        //           onTap: (){
        //             print("skip");
        //           },
        //           child:Image(image:AssetImage("images/skip.png"),width: 23.0,height: 23.0,)
        //       )
        //   )
        // ]
        // ),
        body: SingleChildScrollView(
            reverse: true,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
              // height: 667.0,
              //height:Questions.answerShow.length <3 ? MediaQuery.of(context).size.height*0.87 : (Questions.answerShow.length*60.0)+420.0,
              //height:Questions.answerShow.length <3 ? 624.0 : (Questions.answerShow.length*60.0)+420.0,
              //height: MediaQuery.of(context).size.height*0.87,

              height: MediaQuery.of(context).size.height * 0.87 >= screenHeight
                  ? MediaQuery.of(context).size.height * 0.87
                  : screenHeight,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
//
                          Column(
                            children: dynamicContainer,
                          ),
                          HealthChangeContainer(),
                        ],
                      ),
                    ),
                  ),

//                Positioned(
//                  bottom: 0,
//                  child:changeContainer(),
//                ),
                ],
              ),
            )));
  }

  Widget HealthChangeContainer() {
    if (Questions.healthAnswerShow.length == 0) {
      if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
        qu.HealthAddAnswer("You", "", "", "", [], 60.0);
      }
      //Question No 1
      //For Statutory 220.0
      //For Private 220.0
      //For Family 430.0
      //For None 430.0
      return healthmultithreeContainer(
          """

<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>

""",
          "",
          "Health",
          "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
          "Kind of health insurance",
          ["Statutory", "Private", "Family", "None of them"],
          [
            "images/disabilityoption.png",
            "images/alimonypaidoption.png",
            "images/survivorspension.png",
            "images/check.png"
          ],
          220.0,
          "None of them",
          "",
          "");
    } else {
      //Answer No 1
      if (widget.CheckCompleteQuestion ==
              "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?" &&
          widget.CheckQuestion == "Kind of health insurance") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Statutory") {
            DbHelper.insatance..deleteWithquestion('Kind of health insurance');
            _insert('Kind of health insurance', 'Statutory', 'OK');
            //Question No 2
            //For No 430.0
            //For Yes 220.0
            return healthyesnoContainer("""
<p><strong>Refunds for health / nursing care insurance</strong></p>
<p>Indicate here whether you received refunds or contribution repayments from your statutory health or nursing care insurance in 2019.</p>
<p><strong>IMPORTANT</strong></p>
<p>If you have received refunds, this will have been communicated to you by post.</p>
<p><strong>Tip:</strong> Bonus payments from your health insurance fund are not premium refunds.</p>
<p>Note Your contributions to the statutory health insurance will be requested in your annual payslip.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Health",
                "Did ${Questions.healthYouIdentity} receive any reimbursement from your health or nursing care insurance?",
                "Statutory health insurance",
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Private") {
            DbHelper.insatance..deleteWithquestion('Kind of health insurance');
            _insert('Kind of health insurance', 'Private', 'OK');
            //Question no 4
            return healthcalculationContainer("""

<p><strong>Contributions to health insurance</strong></p>
<p>Please enter the amount of the annual premium in 2019 for private health insurance. Note that <strong>only the premium for basic coverage </strong>is relevant here.</p>
<p>The amount is stated on the certificate the insurance provided to you at the end of the year.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for ${Questions.healthYourIdentity} basic coverage of ${Questions.healthYourIdentity} private health insurance?",
                "Basic health insurance",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Family") {
            DbHelper.insatance..deleteWithquestion('Kind of health insurance');
            _insert('Kind of health insurance', 'Family', 'OK');
            //Question No 15
            // For Supplementary health insurance 320.0
            // For rest 220.0
            return healthmultipleoptionsContainer(
                """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
                "",
                "Health",
                "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
                "Other health insurance",
                [
                  "Supplementary health insurance",
                  "Supplementary nursing care insurance",
                  "For my adult child",
                  "For my Partner",
                  "Foreign health insurance",
                  "Travel insurance",
                  "Voluntary statutory health insurance",
                  "Health insurance for students",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "None of them") {
            DbHelper.insatance..deleteWithquestion('Kind of health insurance');
            _insert('Kind of health insurance', 'None of them', 'OK');
            //Question No 15
            return healthmultipleoptionsContainer(
                """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
                "",
                "Health",
                "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
                "Other health insurance",
                [
                  "Supplementary health insurance",
                  "Supplementary nursing care insurance",
                  "For my adult child",
                  "For my Partner",
                  "Foreign health insurance",
                  "Travel insurance",
                  "Voluntary statutory health insurance",
                  "Health insurance for students",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance..deleteWithquestion('Kind of health insurance');
            _insert('Kind of health insurance', 'skip', 'skip');
            //Question No 15
            return healthmultipleoptionsContainer(
                """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
                "",
                "Health",
                "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
                "Other health insurance",
                [
                  "Supplementary health insurance",
                  "Supplementary nursing care insurance",
                  "For my adult child",
                  "For my Partner",
                  "Foreign health insurance",
                  "Travel insurance",
                  "Voluntary statutory health insurance",
                  "Health insurance for students",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                "");
          }
        }
      }

      // ====== Statutory Starts ====== //

      //Answer No 2
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any reimbursement from your health or nursing care insurance?" &&
          widget.CheckQuestion == "Statutory health insurance") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Statutory health insurance');
          _insert('Statutory health insurance', 'No', 'OK');
          //Question No 15
          return healthmultipleoptionsContainer(
              """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
              "Other health insurance",
              [
                "Supplementary health insurance",
                "Supplementary nursing care insurance",
                "For my adult child",
                "For my Partner",
                "Foreign health insurance",
                "Travel insurance",
                "Voluntary statutory health insurance",
                "Health insurance for students",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Statutory health insurance');
          _insert('Statutory health insurance', 'skip', 'skip');
          //Question No 15
          return healthmultipleoptionsContainer(
              """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
              "Other health insurance",
              [
                "Supplementary health insurance",
                "Supplementary nursing care insurance",
                "For my adult child",
                "For my Partner",
                "Foreign health insurance",
                "Travel insurance",
                "Voluntary statutory health insurance",
                "Health insurance for students",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Statutory health insurance');
          _insert('Statutory health insurance', 'Yes', 'OK');
          //Question No 3
          return healthcalculationContainer("""
<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive?",
              "Amount of reimbursement",
              430.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 3
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount of reimbursement") {
        //Question No 15
        return healthmultipleoptionsContainer(
            """ left """,
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
            "Other health insurance",
            [
              "Supplementary health insurance",
              "Supplementary nursing care insurance",
              "For my adult child",
              "For my Partner",
              "Foreign health insurance",
              "Travel insurance",
              "Voluntary statutory health insurance",
              "Health insurance for students",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            "");
      }

      // ====== Statutory Ends ====== //

      // ====== Private Starts ====== //

      //Answer No 4
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for ${Questions.healthYourIdentity} basic coverage of ${Questions.healthYourIdentity} private health insurance?" &&
          widget.CheckQuestion == "Basic health insurance") {
        //Question No 5
        return healthcalculationContainer("""
<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>

""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} spend on private nursing care insurance?",
            "Nursing care insurance",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 5
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on private nursing care insurance?" &&
          widget.CheckQuestion == "Nursing care insurance") {
        //Question no 6
        return healthyesnoContainer("""
<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>

""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} receive any refunds for payments to ${Questions.healthYourIdentity} private health insurance?",
            "Private insurance refunds",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 6
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any refunds for payments to ${Questions.healthYourIdentity} private health insurance?" &&
          widget.CheckQuestion == "Private insurance refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Private insurance refunds');
          _insert('Private insurance refunds', 'No', 'OK');
          //Question No 8
          return healthcalculationContainer("""

<p><strong>Health insurance contributions, beyond basic coverage</strong></p>
<p>Please enter the <strong>2019 total amount</strong> of portion of health care contributions beyond basic coverage, as stated on your certificate provided by the insurance company.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for health insurance, beyond basic coverage?",
              "Beyond basic coverage",
              220.0,
              "calculation",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Private insurance refunds');
          _insert('Private insurance refunds', 'skip', 'skip');
          //Question No 8
          return healthcalculationContainer("""

<p><strong>Health insurance contributions, beyond basic coverage</strong></p>
<p>Please enter the <strong>2019 total amount</strong> of portion of health care contributions beyond basic coverage, as stated on your certificate provided by the insurance company.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for health insurance, beyond basic coverage?",
              "Beyond basic coverage",
              220.0,
              "calculation",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Private insurance refunds');
          _insert('Private insurance refunds', 'Yes', 'OK');
          //Question No 7
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did  ${Questions.healthYouIdentity} receive?",
              "Amount of reimbursement",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer no 7
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did  ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount of reimbursement") {
        //Question No 8
        return healthcalculationContainer("""

<p><strong>Health insurance contributions, beyond basic coverage</strong></p>
<p>Please enter the <strong>2019 total amount</strong> of portion of health care contributions beyond basic coverage, as stated on your certificate provided by the insurance company.</p>
<p>&nbsp;</p>

""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for health insurance, beyond basic coverage?",
            "Beyond basic coverage",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer no 8
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for health insurance, beyond basic coverage?" &&
          widget.CheckQuestion == "Beyond basic coverage") {
        //Question no 9
        return healthyesnoContainer("""
<p><strong>Reimbursements from health insurance</strong></p>
<p>Your insurance should provide a certificate at the end of the year listing both the amounts paid and the amounts reimbursed. If you have received reimbursements for your insurance contributions in excess of the basic coverage, they should be stated here. If you are unsure, you can contact the health insurance directly.</p>
<p>&nbsp;</p>


""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} receive any reimbursements for your contributions that exceed your basic coverage?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 9
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any reimbursements for your contributions that exceed your basic coverage?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Reimbursements');
          _insert('Reimbursements', 'No', 'OK');
          //Question No 11
          //For No 430.0
          //For Yes 220.0
          return healthyesnoContainer("""
<p><strong>Additional contribution to nursing care insurance</strong></p>
<p>Please indicate here whether an additional contribution to nursing care insurance is stated on the health insurance certificate.</p>
<p>This information is stated on the health insurance contribution invoice. This must contain information for the year 2019.</p>
<p>&nbsp;</p>


""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have additional contributions to nursing care insurace, according to the statement?",
              "Additional nursing care",
              430.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Reimbursements');
          _insert('Reimbursements', 'skip', 'skip');
          //Question No 11
          //For No 430.0
          //For Yes 220.0
          return healthyesnoContainer("""
<p><strong>Additional contribution to nursing care insurance</strong></p>
<p>Please indicate here whether an additional contribution to nursing care insurance is stated on the health insurance certificate.</p>
<p>This information is stated on the health insurance contribution invoice. This must contain information for the year 2019.</p>
<p>&nbsp;</p>


""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have additional contributions to nursing care insurace, according to the statement?",
              "Additional nursing care",
              430.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Reimbursements');
          _insert('Reimbursements', 'Yes', 'OK');
          //Question No 10
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive?",
              "Amount reimbursed",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 10
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount reimbursed") {
        //Question No 11
        return healthyesnoContainer("""
<p><strong>Additional contribution to nursing care insurance</strong></p>
<p>Please indicate here whether an additional contribution to nursing care insurance is stated on the health insurance certificate.</p>
<p>This information is stated on the health insurance contribution invoice. This must contain information for the year 2019.</p>
<p>&nbsp;</p>


""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have additional contributions to nursing care insurace, according to the statement?",
            "Additional nursing care",
            430.0,
            "",
            "",
            "");
      }

      //Answer No 11
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} have additional contributions to nursing care insurace, according to the statement?" &&
          widget.CheckQuestion == "Additional nursing care") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Additional nursing care');
          _insert('Additional nursing care', 'No', 'OK');
          //Question No 15
          return healthmultipleoptionsContainer(
              """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
              "Other health insurance",
              [
                "Supplementary health insurance",
                "Supplementary nursing care insurance",
                "For my adult child",
                "For my Partner",
                "Foreign health insurance",
                "Travel insurance",
                "Voluntary statutory health insurance",
                "Health insurance for students",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Additional nursing care');
          _insert('Additional nursing care', 'skip', 'skip');
          //Question No 15
          return healthmultipleoptionsContainer(
              """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
              "Other health insurance",
              [
                "Supplementary health insurance",
                "Supplementary nursing care insurance",
                "For my adult child",
                "For my Partner",
                "Foreign health insurance",
                "Travel insurance",
                "Voluntary statutory health insurance",
                "Health insurance for students",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Additional nursing care');
          _insert('Additional nursing care', 'Yes', 'OK');
          //Question No 12
          return healthcalculationContainer("""
<p><strong>Contributions to supplementary nursing care insurance</strong></p>
<p>Please enter the <strong>amount of your contributions</strong> to supplementary nursing care insurance.</p>
<p>Please note only contributions from 2019 are relevant.</p>
<p>If you have several policies, please enter the total of all contributions paid in 2019.</p>
<p>&nbsp;</p>


""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for supplementary nursing care insurance?",
              "Contribution",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 12
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for supplementary nursing care insurance?" &&
          widget.CheckQuestion == "Contribution") {
        //Question No 13
        //For No 430.0
        //For Yes 220.0
        return healthyesnoContainer("""
<p><strong>Reimbursements from nursing care insurance</strong></p>
<p>In the case you receive reimbursements relating your additional nursing care insurance payments, the insurance should send you a certificate listing all amounts paid and to which contribution it belongs to. If you are unsure, you can also ask your insurance for these details.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} receive any reimbursements related to your additional nursing care insurance contributions?",
            "Reimbursements",
            430.0,
            "",
            "",
            "");
      }

      //Answer no 13
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any reimbursements related to your additional nursing care insurance contributions?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Reimbursements');
          _insert('Reimbursements', 'No', 'OK');
          //Question No 15
          return healthmultipleoptionsContainer(
              """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
              "Other health insurance",
              [
                "Supplementary health insurance",
                "Supplementary nursing care insurance",
                "For my adult child",
                "For my Partner",
                "Foreign health insurance",
                "Travel insurance",
                "Voluntary statutory health insurance",
                "Health insurance for students",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Reimbursements');
          _insert('Reimbursements', 'skip', 'skip');
          //Question No 15
          return healthmultipleoptionsContainer(
              """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
              "Other health insurance",
              [
                "Supplementary health insurance",
                "Supplementary nursing care insurance",
                "For my adult child",
                "For my Partner",
                "Foreign health insurance",
                "Travel insurance",
                "Voluntary statutory health insurance",
                "Health insurance for students",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Reimbursements');
          _insert('Reimbursements', 'Yes', 'OK');
          //Question No 14
          return healthcalculationContainer("""
<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} receive in reimbursements?",
              "Amount reimbursed",
              430.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 14
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} receive in reimbursements?" &&
          widget.CheckQuestion == "Amount reimbursed") {
        //Question No 15
        return healthmultipleoptionsContainer(
            """
<p><strong>Contributions to other health insurances</strong></p>
<p>You can select multiple options.</p>
<p><strong>SUPPLEMENTARY HEALTH INSURANCE</strong></p>
<p>Here we mean additional health insurance plans. This includes, for example:</p>
<ul>
<li>additional dental insurance</li>
<li>additional insurance for treatments</li>
<li>health insurance for overseas</li>
</ul>
<p><strong>SUPPLEMENTARY NURSING CARE INSURANCE</strong></p>
<p>Here we mean additional nursing care insurance, such as:</p>
<ul>
<li>nursing care cash insurance</li>
<li>nursing cost insurance</li>
<li>nursing care pension</li>
</ul>
<p><strong>FOR MY ADULT CHILD</strong></p>
<p>Here we are talking about the following types of insurance of your adult child (a child for which you are not entitled to the child allowance):</p>
<ul>
<li>basic health insurance</li>
<li>basic nursing care insurance</li>
<li>additional health insurance</li>
</ul>
<p><strong>FOR MY PARTNER</strong></p>
<p>Here, we ask you for your contributions to the following types of insurance of your spouse:</p>
<ul>
<li>basic health insurance</li>
<li>based nursing care insurance</li>
<li>additional health &amp; nursing care insurance</li>
</ul>
<p><strong>FOREIGN HEALTH INSURANCE</strong></p>
<p>Foreign health insurance is a health insurance policy you entered into abroad. Insurance companies registered in the EU and the European Economic Area correspond to established the requirements for a minimum level of protection. An advantage of such an insurance is that the insured person can expect lifelong insurance protection.</p>
<p><strong>TRAVEL MEDICAL INSURANCE</strong></p>
<p>Travel medical insurance plans offer protection for any private trip. You're covered while traveling in the case of illness and injury.</p>
<p><strong>VOLUNTARY STATUTORY HEALTH INSURANCE</strong></p>
<p>This only applies if you are not insured via your employment (this applies for example to pensioners or people who optionally pay themselves). Please do not include payments stated within your payslip here as the app considers them automatically.</p>
<p><strong>HEALTH INSURANCE FOR STUDENTS</strong></p>
<p>Mostly students are insured via the family. In case this is not possible they have to pay on their own. You can choose this option in case this applies to you.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?",
            "Other health insurance",
            [
              "Supplementary health insurance",
              "Supplementary nursing care insurance",
              "For my adult child",
              "For my Partner",
              "Foreign health insurance",
              "Travel insurance",
              "Voluntary statutory health insurance",
              "Health insurance for students",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            "");
      }

// ====== Private Ends ====== //

      //Answer No 15

      // ====== Other health insurance Starts ====== //

      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} have costs for any other health insurance policies?" &&
          widget.CheckQuestion == "Other health insurance") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Supplementary health insurance") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'Supplementary health insurance',
                'OK');
            //Question No 16
            return healthmultitwoContainer(
                """
<p><strong>Additional health insurance</strong></p>
<p>Did you have supplementary health insurance?</p>
<p>Then choose here, whether these are <strong>statutory</strong> or <strong>private</strong>. This depends on your basic health insurance. In case you are statutory health insured due to your employment any additional health insurances are also statutory insurances. The same applies for private health insurances.</p>
<p>Supplementary insurances are for example:</p>
<ul>
<li>Dental supplement insurance</li>
<li>Additional insurance for cures</li>
<li>Health insurance for abroad</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>


""",
                "",
                "Health",
                "What type of contract is ${Questions.healthYourIdentity} supplementary health insurance policy?",
                "Health insurance",
                [
                  "Additional insurance (statutory)",
                  "Additional insurance (private)"
                ],
                ["images/disabilityoption.png", "images/alimonypaidoption.png"],
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] ==
              "Supplementary nursing care insurance") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance',
                'Supplementary nursing care insurance', 'OK');
            //Question No 24
            return healthcalculationContainer("""
<p>Contributions to private nursing care insurance</p>
<p>Please enter the <strong>amount</strong> of your contributions to private nursing care insurance in 2019. Add the amounts up and enter the total here.</p>
<p>You can find the amounts in your <strong>insurance documents</strong>.</p>
<p>&nbsp;</p>

""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for private supplementary nursing insurance?",
                "Supplementary nursing care insurance",
                430.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "For my adult child") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'For my adult child', 'OK');
            //Question No 27
            return healthcalculationContainer("""
<p><strong>Contributions to child's health insurance</strong></p>
<p>Enter here the number of adult children for which you paid health insurance contributions in 2019. For example, this might be the case if your child is studying or completing professional training.</p>
<p>&nbsp;</p>

""",
                "",
                "Health",
                "For how many adult children did ${Questions.healthYouIdentity} pay health insurance contributions?",
                "Number of children",
                220.0,
                "loop",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "For my Partner") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'For my Partner', 'OK');
            //Question No 38
            return healthcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "Please enter ${Questions.healthYourIdentity} spouse's first and last name.",
                "Spouse's name",
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Foreign health insurance") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'Foreign health insurance', 'OK');
            //Question No 47
            return healthcalculationContainer("""

<p><strong>Amount of contributions to foreign health insurance</strong></p>
<p>Enter the <strong>total amount of contributions made to foreign health insurance in 2019</strong>.</p>
<p>You can find the amount on your certificate of insurance which you received upon completion of the policy.</p>
<p>Do not enter any amount that you find on your annual pay slip ('Lohnsteuerbescheinigung') on line 25 "employee contributions to statutory health insurance".</p>
<p>Foreign health insurance is an insurance policy that entered into effect in another country. It is not the same as travel insurance.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for foreign health insurance?",
                "Foreign health insurance",
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Travel insurance") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'Travel insurance', 'OK');
            //Question No 55
            return healthcalculationContainer("""

<p><strong>Travel medical insurance</strong></p>
<p>Please enter the total amount you paid for travel medical insurance in 2019.</p>
<p>You can find the amount on your certificate of insurance which you received upon completion of the policy.</p>
<p><strong>MULTIPLE POLICIES</strong></p>
<p>If you had several insurance policies, enter the amount of the annual premium for all contracts. Contributions you paid for your child's insurance contracts can also be added to this amount.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""", "", "Health", "What was the annual amount spent on travel insurance?",
                "Travel insurance", 220.0, "", "", "");
          } else if (widget.CheckAnswer[m] ==
              "Voluntary statutory health insurance") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance',
                'Voluntary statutory health insurance', 'OK');
            //Question No 56
            return healthcalculationContainer("""

<p><strong>Contribution to basic health insurance</strong></p>
<p>Enter here your annual contribution in 2019 to your basic health insurance. The total amount will be stated in your insurance documents.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for basic health insurance (excluding amounts from the payslip)?",
                "Basic student health insurance",
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Health insurance for students") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'Health insurance for students',
                'OK');
            //Question No 62
            return healthcalculationContainer("""

<p><strong>Contribution to basic health insurance</strong></p>
<p>Enter here your annual contribution in 2019 to your basic health insurance. The total amount will be stated in your insurance documents.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for basic health insurance (Basis-Krankenversicherung)?",
                "Basic health insurance",
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'No', 'OK');
            //Question No 20
            return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
                "Work-related illness",
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance..deleteWithquestion('Other health insurance');
            _insert('Other health insurance', 'skip', 'OK');
            //Question No 20
            return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
                "Work-related illness",
                220.0,
                "",
                "",
                "");
          }
        }
      }

      // ====== Supplementary health insurance Starts ====== //

      //Answer No 16
      else if (widget.CheckCompleteQuestion ==
              "What type of contract is ${Questions.healthYourIdentity} supplementary health insurance policy?" &&
          widget.CheckQuestion == "Health insurance") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Additional insurance (statutory)") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'What type of contract is supplementary health insurance policy?');
            _insert(
                'What type of contract is supplementary health insurance policy?',
                'Additional insurance (statutory)',
                'OK');
            //Question No 17
            return healthcalculationContainer("""
<p><strong>Contributions to supplementary health insurance</strong></p>
<p>Please enter the <strong>amount of your contributions</strong> to supplementary health insurance policies in 2019.</p>
<p>Add the amounts up and enter the total here.</p>
<p>This could be additional dental coverage, for example.</p>
<p>You can find the amounts in your <strong>insurance documents</strong>.</p>
<p>&nbsp;</p>


""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for supplementary health insurance policies?",
                "Contribution",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] ==
              "Additional insurance (private)") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'What type of contract is supplementary health insurance policy?');
            _insert(
                'What type of contract is supplementary health insurance policy?',
                'Additional insurance (private)',
                'OK');
            //Question No 21

            return healthcalculationContainer("""
<p><strong>Contributions to supplementary insurance</strong></p>
<p>Please enter the <strong>amount of your contributions</strong> to supplementary insurance. Please note only contributions from are relevant. Add the amounts up and enter the total here.</p>
<p>You can find the amounts in your insurance documents. If you have several policies, please enter the total of all contributions paid in 2019.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for private supplementary health insurance?",
                "Private supplementary insurance",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'What type of contract is supplementary health insurance policy?');
            _insert(
                'What type of contract is supplementary health insurance policy?',
                'skip',
                'skip');
            //Question No 21

            return healthcalculationContainer("""
<p><strong>Contributions to supplementary insurance</strong></p>
<p>Please enter the <strong>amount of your contributions</strong> to supplementary insurance. Please note only contributions from are relevant. Add the amounts up and enter the total here.</p>
<p>You can find the amounts in your insurance documents. If you have several policies, please enter the total of all contributions paid in 2019.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "How much did ${Questions.healthYouIdentity} pay for private supplementary health insurance?",
                "Private supplementary insurance",
                220.0,
                "calculation",
                "",
                "");
          }
        }
      }

      // ====== Additional insurance (statutory) Starts ====== //

      //Answer No 17
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for supplementary health insurance policies?" &&
          widget.CheckQuestion == "Contribution") {
        //Question No 18
        return healthyesnoContainer("""
<p><strong>Contributions to supplementary insurance</strong></p>
<p>Please enter the <strong>amount of your contributions</strong> to supplementary insurance. Please note only contributions from are relevant. Add the amounts up and enter the total here.</p>
<p>You can find the amounts in your insurance documents. If you have several policies, please enter the total of all contributions paid in 2019.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Have ${Questions.healthYouIdentity} received any reimbursements from these supplementary health insurance policies?",
            "Refunds",
            220.0,
            "",
            "",
            "");
      }

//Answer No 18
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.healthYouIdentity} received any reimbursements from these supplementary health insurance policies?" &&
          widget.CheckQuestion == "Refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'received any reimbursements from these supplementary health insurance policies?');
          _insert(
              'received any reimbursements from these supplementary health insurance policies?',
              'No',
              'OK');
          //Question No 20
          //For No 430.0
          //For Yes 220.0
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'received any reimbursements from these supplementary health insurance policies?');
          _insert(
              'received any reimbursements from these supplementary health insurance policies?',
              'skip',
              'skip');
          //Question No 20
          //For No 430.0
          //For Yes 220.0
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'received any reimbursements from these supplementary health insurance policies?');
          _insert(
              'received any reimbursements from these supplementary health insurance policies?',
              'Yes',
              'OK');
          //Question No 19
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive?",
              "Refund",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 19
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Refund") {
        //Question No 20
        return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
            "Work-related illness",
            220.0,
            "",
            "",
            "");
      }

      // ====== Additional insurance (statutory) Ends ====== //

      // ====== Additional insurance (private) Starts ====== //

      //Answer No 21
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for private supplementary health insurance?" &&
          widget.CheckQuestion == "Private supplementary insurance") {
        //Question No 22
        return healthyesnoContainer("""
<p><strong>Refunds from supplementary health insurance</strong></p>
<p>Please state whether you received refunds from your supplementary health insurance in 2019.</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} receive any reimbursement for these supplementary insurance policies?",
            "Refunds",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 22
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any reimbursement for these supplementary insurance policies?" &&
          widget.CheckQuestion == "Refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'received any reimbursements from these supplementary insurance policies?');
          _insert(
              'received any reimbursements from these supplementary insurance policies?',
              'No',
              'OK');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'received any reimbursements from these supplementary insurance policies?');
          _insert(
              'received any reimbursements from these supplementary insurance policies?',
              'skip',
              'skip');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'received any reimbursements from these supplementary insurance policies?');
          _insert(
              'received any reimbursements from these supplementary insurance policies?',
              'Yes',
              'OK');
          //Question No 23
          return healthcalculationContainer("""
<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019. You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
""", "", "Health", "How much money was reimbursed?", "Refund amount", 220.0,
              "calculation", "", "");
        }
      }

      //Answer No 23
      else if (widget.CheckCompleteQuestion ==
              "How much money was reimbursed?" &&
          widget.CheckQuestion == "Refund amount") {
        //Question No 20
        return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
            "Work-related illness",
            220.0,
            "",
            "",
            "");
      }

      // ====== Additional insurance (private) Ends ====== //

      // ====== Supplementary health insurance Ends ====== //

      // ====== Supplementary nursing care insurance Starts ====== //

      //Answer No 24
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for private supplementary nursing insurance?" &&
          widget.CheckQuestion == "Supplementary nursing care insurance") {
        //Question No 25
        return healthyesnoContainer("""
<p><strong>Refunds from supplementary nursing care insurance</strong></p>
<p>Please state whether you received <strong>refunds</strong> from your supplementary nursing care insurance in 2019.</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} receive any reimbursements for these supplementary insurance policies?",
            "Refunds",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 25
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any reimbursements for these supplementary insurance policies?" &&
          widget.CheckQuestion == "Refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'receive any reimbursements for these supplementary insurance policies?');
          _insert(
              'receive any reimbursements for these supplementary insurance policies?',
              'No',
              'OK');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'receive any reimbursements for these supplementary insurance policies?');
          _insert(
              'receive any reimbursements for these supplementary insurance policies?',
              'skip',
              'skip');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'receive any reimbursements for these supplementary insurance policies?');
          _insert(
              'receive any reimbursements for these supplementary insurance policies?',
              'Yes',
              'OK');
          //Question No 26
          return healthcalculationContainer("""
<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019. You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""", "", "Health", "How much money was  reimbursed?", "Refund amount", 220.0,
              "calculation", "", "");
        }
      }

      //Answer No 26
      else if (widget.CheckCompleteQuestion ==
              "How much money was  reimbursed?" &&
          widget.CheckQuestion == "Refund amount") {
        //Question No 20
        return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
            "Work-related illness",
            220.0,
            "",
            "",
            "");
      }

      // ====== Supplementary nursing care insurance Ends ====== //

      //For my adult child Starts

      //Answer no 27
      else if (widget.CheckCompleteQuestion ==
              "For how many adult children did ${Questions.healthYouIdentity} pay health insurance contributions?" &&
          widget.CheckQuestion == "Number of children") {
        DbHelper.insatance.deleteWithquestion('Number of children');
        _insert('Number of children', Questions.healthChildrenText, 'OK');
        //Question No 28
        return healthcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "What is ${Questions.healthYourIdentity} child's full name?",
            "Your child's name",
            220.0,
            "",
            Questions.healthChildrenText,
            "");
      }

      //Answer no 28
      else if (widget.CheckCompleteQuestion ==
              "What is ${Questions.healthYourIdentity} child's full name?" &&
          widget.CheckQuestion == "Your child's name") {
        DbHelper.insatance.deleteWithquestion(
            'What is ${Questions.healthYourIdentity} child\'s full name?');
        _insert('What is ${Questions.healthYourIdentity} child\'s full name?',
            Questions.healthChildrenText, 'OK');
        //Question No 29
        return healthcalculationContainer("""
<p><strong>Tax identification number of your child</strong></p>
<p>Please enter the tax identification number of your child.</p>
<p>The federal tax office automatically send out this number <strong>after the birth</strong> of your child.</p>
<p>If you cannot find this information, you can ask <strong>your designated tax office</strong> for the number.</p>
<p>&nbsp;</p>
""", "", "Health", "Enter ${Questions.healthYourIdentity} child's Tax-ID.",
            "Tax-ID child", 220.0, "tax", Questions.healthChildrenText, "");
      }

      //Answer no 29
      else if (widget.CheckCompleteQuestion ==
              "Enter ${Questions.healthYourIdentity} child's Tax-ID." &&
          widget.CheckQuestion == "Tax-ID child") {
        DbHelper.insatance.deleteWithquestion('child\'s Tax-ID');
        _insert('child\'s Tax-ID', Questions.healthChildrenText, 'OK');
        //Question No 30
        return healthcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for the basic health insurance of ${Questions.healthYourIdentity} child?",
            "Basic health insurance adult child",
            220.0,
            "calculation",
            Questions.healthChildrenText,
            "");
      }

      //Answer no 30
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for the basic health insurance of ${Questions.healthYourIdentity} child?" &&
          widget.CheckQuestion == "Basic health insurance adult child") {
        DbHelper.insatance
            .deleteWithquestion('Basic health insurance adult child');
        _insert('Basic health insurance adult child',
            Questions.healthChildrenText, 'OK');
        //Question No 31
        return healthcalculationContainer("""
<p><strong>Basic nursing care insurance of your child</strong></p>
<p>Please enter the amount of your contributions to the basic nursing care insurance of your child. Please note only contributions from 2019 are relevant.</p>
<p><em>Please enter the total here.</em></p>
<p>If your child is still completing professional training or studying, then you can write off these contributions.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for the basic nursing care insurance of ${Questions.healthYourIdentity} child?",
            "Basic health insurance adult child",
            220.0,
            "calculation",
            Questions.healthChildrenText,
            "");
      }

      //Answer no 31
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for the basic nursing care insurance of ${Questions.healthYourIdentity} child?" &&
          widget.CheckQuestion == "Basic health insurance adult child") {
        //Question No 32
        return healthyesnoContainer("""
<p><strong>Refunds from insurance of adult child</strong></p>
<p>Please state whether you received refunds from your the health insurance of your adult child. Please note only refunds from 2019 are relevant.</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did you get refunds from ${Questions.healthYourIdentity} adult child's health insurance?",
            "Health insurance refunds - child",
            220.0,
            "",
            Questions.healthChildrenText,
            "");
      }

      //Answer No 32
      else if (widget.CheckCompleteQuestion ==
              "Did you get refunds from ${Questions.healthYourIdentity} adult child's health insurance?" &&
          widget.CheckQuestion == "Health insurance refunds - child") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you get refunds from adult child\'s health insurance?');
          _insert('Did you get refunds from adult child\'s health insurance?',
              'No', 'OK');
          //Question No 34
          return healthcalculationContainer("""
<p>Please enter the amount of your contributions to your adult child's private health and nursing care insurance. Please note only contributions from 2019 are relevant.</p>
<p><em>Enter the total here.</em></p>
<p>If your child is still completing professional training or studying, then you can write off these contributions.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for additional health and nursing care insurance for ${Questions.healthYourIdentity} adult child?",
              "Supplementary insurance",
              220.0,
              "calculation",
              Questions.healthChildrenText,
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you get refunds from adult child\'s health insurance?');
          _insert('Did you get refunds from adult child\'s health insurance?',
              'skip', 'OK');
          //Question No 34
          return healthcalculationContainer("""
<p>Please enter the amount of your contributions to your adult child's private health and nursing care insurance. Please note only contributions from 2019 are relevant.</p>
<p><em>Enter the total here.</em></p>
<p>If your child is still completing professional training or studying, then you can write off these contributions.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for additional health and nursing care insurance for ${Questions.healthYourIdentity} adult child?",
              "Supplementary insurance",
              220.0,
              "calculation",
              Questions.healthChildrenText,
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you get refunds from adult child\'s health insurance?');
          _insert('Did you get refunds from adult child\'s health insurance?',
              'Yes', 'OK');
          //Question No 33
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive?",
              "Health insurance refunds - child",
              220.0,
              "calculation",
              Questions.healthChildrenText,
              "");
        }
      }

      //Answer No 33
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Health insurance refunds - child") {
        DbHelper.insatance
            .deleteWithquestion('How much reimbursement did receive?');
        _insert('How much reimbursement did receive?',
            Questions.healthChildrenText, 'OK');
        //Question No 34
        return healthcalculationContainer("""
<p>Please enter the amount of your contributions to your adult child's private health and nursing care insurance. Please note only contributions from 2019 are relevant.</p>
<p><em>Enter the total here.</em></p>
<p>If your child is still completing professional training or studying, then you can write off these contributions.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for additional health and nursing care insurance for ${Questions.healthYourIdentity} adult child?",
            "Supplementary insurance",
            220.0,
            "calculation",
            Questions.healthChildrenText,
            "");
      }

      //Answer No 34
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for additional health and nursing care insurance for ${Questions.healthYourIdentity} adult child?" &&
          widget.CheckQuestion == "Supplementary insurance") {
        DbHelper.insatance.deleteWithquestion(
            'How much did pay for additional health and nursing care insurance for adult child?');
        _insert(
            'How much did pay for additional health and nursing care insurance for adult child?',
            Questions.healthChildrenText,
            'OK');
        //Question No 35
        return healthyesnoContainer("""
<p><strong>Refunds from supplementary health insurance of adult child</strong></p>
<p>Please state whether you received refunds from the supplementary health insurance of your adult child. Please note only refunds from 2019 are relevant.</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>You can find this amount in your health insurance documents.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did you receive any reimbursements from ${Questions.healthYourIdentity} adult child's supplementary health insurance?",
            "Health insurance refunds - child",
            220.0,
            "",
            Questions.healthChildrenText,
            "");
      }

      //Answer No 35
      else if (widget.CheckCompleteQuestion ==
              "Did you receive any reimbursements from ${Questions.healthYourIdentity} adult child's supplementary health insurance?" &&
          widget.CheckQuestion == "Health insurance refunds - child") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any reimbursements from adult child\'s supplementary health insurance?');
          _insert(
              'Did you receive any reimbursements from adult child\'s supplementary health insurance?',
              'No',
              'OK');

          if (Questions.healthChildrenLength <= Questions.totalHealthChildren) {
            //Question No 28
            return healthcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "What is ${Questions.healthYourIdentity} child's full name?",
                "Your child's name",
                220.0,
                "",
                Questions.healthChildrenText,
                "");
          } else {
            //Question No 37
            return healthyesnoContainer("""
<p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
<p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
<p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
<ul>
<li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
<li>Contribution shares of the statutory pension insurance institutions</li>
<li>Aid entitlements of civil servants</li>
<li>Contributions from the Artists' Social Fund</li>
</ul>
<p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
                "Claim for subsidies",
                220.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any reimbursements from adult child\'s supplementary health insurance?');
          _insert(
              'Did you receive any reimbursements from adult child\'s supplementary health insurance?',
              'skip',
              'OK');
          if (Questions.healthChildrenLength <= Questions.totalHealthChildren) {
            //Question No 28
            return healthcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "What is ${Questions.healthYourIdentity} child's full name?",
                "Your child's name",
                220.0,
                "",
                Questions.healthChildrenText,
                "");
          } else {
            //Question No 37
            return healthyesnoContainer("""
<p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
<p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
<p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
<ul>
<li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
<li>Contribution shares of the statutory pension insurance institutions</li>
<li>Aid entitlements of civil servants</li>
<li>Contributions from the Artists' Social Fund</li>
</ul>
<p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
                "Claim for subsidies",
                220.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any reimbursements from adult child\'s supplementary health insurance?');
          _insert(
              'Did you receive any reimbursements from adult child\'s supplementary health insurance?',
              'Yes',
              'OK');
          //Question No 36
          return healthcalculationContainer("""
<p><strong>Amount of refunds for your adult child</strong></p>
<p>Please enter the total amount of refunds you received in 2019 for your adult child.</p>
<p>You can find this amount in your health insurance documents.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much were ${Questions.healthYouIdentity} reimbursed?",
              "Health insurance refunds - child",
              220.0,
              "calculation",
              Questions.healthChildrenText,
              "");
        }
      }

      //Answer No 36
      else if (widget.CheckCompleteQuestion ==
              "How much were ${Questions.healthYouIdentity} reimbursed?" &&
          widget.CheckQuestion == "Health insurance refunds - child") {
        DbHelper.insatance.deleteWithquestion('How much were reimbursed?');
        _insert(
            'How much were reimbursed?', Questions.healthChildrenText, 'OK');

        if (Questions.healthChildrenLength <= Questions.totalHealthChildren) {
          //Question No 28
          return healthcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Health",
              "What is ${Questions.healthYourIdentity} child's full name?",
              "Your child's name",
              220.0,
              "",
              Questions.healthChildrenText,
              "");
        } else {
          //Question No 37
          return healthyesnoContainer("""
<p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
<p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
<p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
<ul>
<li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
<li>Contribution shares of the statutory pension insurance institutions</li>
<li>Aid entitlements of civil servants</li>
<li>Contributions from the Artists' Social Fund</li>
</ul>
<p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
              "Claim for subsidies",
              220.0,
              "",
              "",
              "");
        }
      }
      //For my adult child Ends

      //For My Partner Starts

      //Answer No 38
      else if (widget.CheckCompleteQuestion ==
              "Please enter ${Questions.healthYourIdentity} spouse's first and last name." &&
          widget.CheckQuestion == "Spouse's name") {
        DbHelper.insatance
            .deleteWithquestion('Please enter spouse\'s first and last name.');
        _insert('Please enter spouse\'s first and last name.',
            Questions.healthChildrenText, 'OK');
        //Question No 39
        return healthcalculationContainer("""
<p><strong>Tax identification number of your spouse</strong></p>
<p>Please enter the tax identification number of your spouse.</p>
<p>If you don't know this number you need to ask your partner for this information.</p>
<p>You can also ask your <strong>designated tax office</strong> for the number.</p>
<p>&nbsp;</p>
""", "", "Health", "What is ${Questions.healthYourIdentity} spouse's tax ID?",
            "Tax ID (partner)", 220.0, "tax", "", "");
      }

      //Answer No 39
      else if (widget.CheckCompleteQuestion ==
              "What is ${Questions.healthYourIdentity} spouse's tax ID?" &&
          widget.CheckQuestion == "Tax ID (partner)") {
        //Question No 40
        return healthcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for the basic health insurance of ${Questions.healthYourIdentity} spouse?",
            "Basic health insurance spouse",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 40
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for the basic health insurance of ${Questions.healthYourIdentity} spouse?" &&
          widget.CheckQuestion == "Basic health insurance spouse") {
        //Question No 41
        return healthcalculationContainer("""
<p><strong>Basic nursing care insurance of your child</strong></p>
<p>Please enter the amount of your contributions to the basic nursing care insurance of your child. Please note only contributions from 2019 are relevant.</p>
<p><em>Please enter the total here.</em></p>
<p>If your child is still completing professional training or studying, then you can write off these contributions.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for the basic nursing care insurance of ${Questions.healthYourIdentity} spouse?",
            "Basic nursing care insurance - spouse",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 41
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for the basic nursing care insurance of ${Questions.healthYourIdentity} spouse?" &&
          widget.CheckQuestion == "Basic nursing care insurance - spouse") {
        //Question No 42
        return healthyesnoContainer("""
<p><strong>Refunds from insurance of partner</strong></p>
<p>Please state whether you received refunds from your partner's health insurance. Please note only refunds from 2019 are relevant.</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>This reduces the tax deductible amount of contributions made to health and nursing care insurance.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} get refunds from ${Questions.healthYourIdentity} spouse's health insurance?",
            "Health insurance refunds - spouse",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 42
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} get refunds from ${Questions.healthYourIdentity} spouse's health insurance?" &&
          widget.CheckQuestion == "Health insurance refunds - spouse") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did get refunds from spouse\'s health insurance?');
          _insert(
              'Did get refunds from spouse\'s health insurance?', 'No', 'OK');
          //Question No 44
          return healthcalculationContainer("""
<p><strong>Contributions to supplementary health &amp; nursing care insurance of your partner</strong></p>
<p>Please enter the amount of your contributions to supplementary health &amp; nursing care insurance of your partner. Please note only contributions from 2019 are relevant.</p>
<p><em>Enter the total here.</em></p>
<p>These contributions are tax deductible.</p>
""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for supplementary private health and nursing care insurance for ${Questions.healthYourIdentity} spouse?",
              "Additional insurance spouse",
              220.0,
              "calculation",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did get refunds from spouse\'s health insurance?');
          _insert(
              'Did get refunds from spouse\'s health insurance?', 'skip', 'OK');
          //Question No 44
          return healthcalculationContainer("""
<p><strong>Contributions to supplementary health &amp; nursing care insurance of your partner</strong></p>
<p>Please enter the amount of your contributions to supplementary health &amp; nursing care insurance of your partner. Please note only contributions from 2019 are relevant.</p>
<p><em>Enter the total here.</em></p>
<p>These contributions are tax deductible.</p>
""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for supplementary private health and nursing care insurance for ${Questions.healthYourIdentity} spouse?",
              "Additional insurance spouse",
              220.0,
              "calculation",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did get refunds from spouse\'s health insurance?');
          _insert(
              'Did get refunds from spouse\'s health insurance?', 'Yes', 'OK');
          //Question No 43
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive?",
              "Health insurance refunds - spouse",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 43
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Health insurance refunds - spouse") {
        //Question No 44
        return healthcalculationContainer("""
<p><strong>Contributions to supplementary health &amp; nursing care insurance of your partner</strong></p>
<p>Please enter the amount of your contributions to supplementary health &amp; nursing care insurance of your partner. Please note only contributions from 2019 are relevant.</p>
<p><em>Enter the total here.</em></p>
<p>These contributions are tax deductible.</p>
""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for supplementary private health and nursing care insurance for ${Questions.healthYourIdentity} spouse?",
            "Additional insurance spouse",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 44
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for supplementary private health and nursing care insurance for ${Questions.healthYourIdentity} spouse?" &&
          widget.CheckQuestion == "Additional insurance spouse") {
        //Question No 45
        return healthyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} receive refunds from ${Questions.healthYourIdentity} spouse's supplementary health insurance?",
            "Health insurance refunds - spouse",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 45
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive refunds from ${Questions.healthYourIdentity} spouse's supplementary health insurance?" &&
          widget.CheckQuestion == "Health insurance refunds - spouse") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive refunds from spouse\'s supplementary health insurance?');
          _insert(
              'Did receive refunds from spouse\'s supplementary health insurance?',
              'No',
              'OK');
          //Question No 37
          return healthyesnoContainer("""
<p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
<p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
<p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
<ul>
<li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
<li>Contribution shares of the statutory pension insurance institutions</li>
<li>Aid entitlements of civil servants</li>
<li>Contributions from the Artists' Social Fund</li>
</ul>
<p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
              "Claim for subsidies",
              220.0,
              "",
              "",
              "");
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive refunds from spouse\'s supplementary health insurance?');
          _insert(
              'Did receive refunds from spouse\'s supplementary health insurance?',
              'skip',
              'skip');
          //Question No 37
          return healthyesnoContainer("""
<p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
<p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
<p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
<ul>
<li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
<li>Contribution shares of the statutory pension insurance institutions</li>
<li>Aid entitlements of civil servants</li>
<li>Contributions from the Artists' Social Fund</li>
</ul>
<p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
              "Claim for subsidies",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive refunds from spouse\'s supplementary health insurance?');
          _insert(
              'Did receive refunds from spouse\'s supplementary health insurance?',
              'Yes',
              'OK');
          //Question No 46
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive?",
              "Refund amount - spouse",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 46
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Refund amount - spouse") {
        //Question No 37
//         return healthyesnoContainer("""
// <p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
// <p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
// <p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
// <ul>
// <li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
// <li>Contribution shares of the statutory pension insurance institutions</li>
// <li>Aid entitlements of civil servants</li>
// <li>Contributions from the Artists' Social Fund</li>
// </ul>
// <p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//             "",
//             "Health",
//             "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity}  or ${Questions.healthYourIdentity} medical expenses?",
//             "Claim for subsidies",
//             220.0,
//             "",
//             "",
//             "");

        return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for foreign health insurance?",
            "Foreign health insurance",
            220.0,
            "calculation",
            "",
            "");
      }

      // For My Partner Ends

      // ====== Foreign health insurance Starts ====== //

      //Answer No 47
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Refund amount - spouse") {
        //Question No 48
        return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for foreign health insurance?",
            "Foreign health insurance",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 48
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for foreign health insurance?" &&
          widget.CheckQuestion == "Foreign health insurance") {
        //Question No 49
        return healthcalculationContainer("""
<p><strong>Refunds from insurance premium with sick pay</strong></p>
<p>Please enter the share of refunds received from your health insurance which do include entitlement to sick pay.</p>
<p><em>You can find this amount on the refund statement from your insurance.</em></p>
<p>Please enter the total amount for 2019.</p>
""",
            "",
            "Health",
            "What share of ${Questions.healthYourIdentity} contribution to foreign health insurance does not entitle ${Questions.healthYouIdentity} to sick pay?",
            "No sick pay",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 49
      else if (widget.CheckCompleteQuestion ==
              "What share of ${Questions.healthYourIdentity} contribution to foreign health insurance does not entitle ${Questions.healthYouIdentity} to sick pay?" &&
          widget.CheckQuestion == "No sick pay") {
        //Question No 50
        return healthcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} spend on foreign basic nursing care insurance?",
            "Foreign nursing care insurance",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 50
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on foreign basic nursing care insurance?" &&
          widget.CheckQuestion == "Foreign nursing care insurance") {
        //Question No 51
        return healthyesnoContainer("""
<p><strong>Refunds from insurance premium with sick pay</strong></p>
<p>Please enter the share of refunds received from your health insurance which do include entitlement to sick pay.</p>
<p><em>You can find this amount on the refund statement from your insurance.</em></p>
<p>Please enter the total amount for 2019.</p>
""",
            "",
            "Health",
            "Were ${Questions.healthYouIdentity} reimbursed for contributions from ${Questions.healthYourIdentity} foreign health insurance payments?",
            "Refunds",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 51
      else if (widget.CheckCompleteQuestion ==
              "Were ${Questions.healthYouIdentity} reimbursed for contributions from ${Questions.healthYourIdentity} foreign health insurance payments?" &&
          widget.CheckQuestion == "Refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Were reimbursed for contributions from foreign health insurance payments?');
          _insert(
              'Were reimbursed for contributions from foreign health insurance payments?',
              'No',
              'OK');
          //Question No 54
          return healthcalculationContainer("""
<p><strong>Supplementary foreign insurance</strong></p>
<p>Please enter the total amount of contributions made in 2019 for all of your additional premiums and insurance plans of your foreign insurance.</p>
<p>This includes services that go beyond through the primary health care/basic coverage, such as the following:</p>
<ul>
<li>private room (hospital)</li>
<li>dental insurance</li>
<li>alternative practitioners</li>
<li>hospital cash insurance</li>
<li>sickness benefit insurance</li>
</ul>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for foreign supplementary insurance?",
              "Foreign supplementary insurance",
              220.0,
              "calculation",
              "",
              "");
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Were reimbursed for contributions from foreign health insurance payments?');
          _insert(
              'Were reimbursed for contributions from foreign health insurance payments?',
              'skip',
              'OK');
          //Question No 54
          return healthcalculationContainer("""
<p><strong>Supplementary foreign insurance</strong></p>
<p>Please enter the total amount of contributions made in 2019 for all of your additional premiums and insurance plans of your foreign insurance.</p>
<p>This includes services that go beyond through the primary health care/basic coverage, such as the following:</p>
<ul>
<li>private room (hospital)</li>
<li>dental insurance</li>
<li>alternative practitioners</li>
<li>hospital cash insurance</li>
<li>sickness benefit insurance</li>
</ul>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} pay for foreign supplementary insurance?",
              "Foreign supplementary insurance",
              220.0,
              "calculation",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Were reimbursed for contributions from foreign health insurance payments?');
          _insert(
              'Were reimbursed for contributions from foreign health insurance payments?',
              'Yes',
              'OK');
          //Question No 52
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive from ${Questions.healthYourIdentity} foreign heath insurance?",
              "Refund amount",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 52
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive from ${Questions.healthYourIdentity} foreign heath insurance?" &&
          widget.CheckQuestion == "Refund amount") {
        //Question No 53
        return healthcalculationContainer("""
<p><strong>Refunds from insurance premium without sick pay</strong></p>
<p>Please enter the share of refunds received from your foreign health insurance which do not include entitlement to sick pay.</p>
<p><em>You can find this amount on the refund statement from your insurance.</em></p>
<p>Please enter the <strong>total amount </strong>for 2019.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "What share of the reimbursed amount does not entitle ${Questions.healthYouIdentity} to sick pay?",
            "Refund of child sick pay",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 53
      else if (widget.CheckCompleteQuestion ==
              "What share of the reimbursed amount does not entitle ${Questions.healthYouIdentity} to sick pay?" &&
          widget.CheckQuestion == "Refund of child sick pay") {
        //Question No 54
        return healthcalculationContainer("""
<p><strong>Supplementary foreign insurance</strong></p>
<p>Please enter the total amount of contributions made in 2019 for all of your additional premiums and insurance plans of your foreign insurance.</p>
<p>This includes services that go beyond through the primary health care/basic coverage, such as the following:</p>
<ul>
<li>private room (hospital)</li>
<li>dental insurance</li>
<li>alternative practitioners</li>
<li>hospital cash insurance</li>
<li>sickness benefit insurance</li>
</ul>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for foreign supplementary insurance?",
            "Foreign supplementary insurance",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 54
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for foreign supplementary insurance?" &&
          widget.CheckQuestion == "Foreign supplementary insurance") {
        //Question No 37
//         return healthyesnoContainer("""
// <p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
// <p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
// <p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
// <ul>
// <li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
// <li>Contribution shares of the statutory pension insurance institutions</li>
// <li>Aid entitlements of civil servants</li>
// <li>Contributions from the Artists' Social Fund</li>
// </ul>
// <p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//             "",
//             "Health",
//             "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
//             "Claim for subsidies",
//             220.0,
//             "",
//             "",
//             "");

        return healthcalculationContainer("""

<p><strong>Travel medical insurance</strong></p>
<p>Please enter the total amount you paid for travel medical insurance in 2019.</p>
<p>You can find the amount on your certificate of insurance which you received upon completion of the policy.</p>
<p><strong>MULTIPLE POLICIES</strong></p>
<p>If you had several insurance policies, enter the amount of the annual premium for all contracts. Contributions you paid for your child's insurance contracts can also be added to this amount.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""", "", "Health", "What was the annual amount spent on travel insurance?",
            "Travel insurance", 220.0, "", "", "");
      }

      // ====== Foreign health insurance Ends ====== //

      // ====== Travel insurance Starts ====== //

//Answer No 55
      else if (widget.CheckCompleteQuestion ==
              "What was the annual amount spent on travel insurance?" &&
          widget.CheckQuestion == "Travel insurance") {
        //Question No 20
        return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
            "Work-related illness",
            220.0,
            "",
            "",
            "");
      }

      // ====== Travel insurance Ends ====== //

      // ====== Voluntary statutory health insurance Starts ====== //

//Answer No 56
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for basic health insurance (excluding amounts from the payslip)?" &&
          widget.CheckQuestion == "Basic student health insurance") {
        //Question No 57
        return healthcalculationContainer("""
<p><strong>Sick pay premium for students</strong></p>
<p>Please enter how much of your premium is available to you as sick pay.</p>
<p>You can find the amount in your insurance documents.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much of ${Questions.healthYourIdentity} premium is available to ${Questions.healthYouIdentity} as sick pay?",
            "Sick pay",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 57
      else if (widget.CheckCompleteQuestion ==
              "How much of ${Questions.healthYourIdentity} premium is available to ${Questions.healthYouIdentity} as sick pay?" &&
          widget.CheckQuestion == "Sick pay") {
        //Question No 58
        return healthcalculationContainer("""
<p><strong>Sick pay premium for students</strong></p>
<p>Please enter how much of your premium is available to you as sick pay.</p>
<p>You can find the amount in your insurance documents.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for basic nursing care insurance?",
            "Basic nursing care insurance",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 58
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for basic nursing care insurance?" &&
          widget.CheckQuestion == "Basic nursing care insurance") {
        //Question No 59
        return healthyesnoContainer("""
<p><strong>Refunds</strong></p>
<p>Please state whether you received refunds from your health &amp; nursing care insurance. Please note only refunds from 2019 are relevant.</p>
<p>This reduces the tax deductible amount of contributions made to health and nursing care insurance.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Were ${Questions.healthYouIdentity} reimbursed for contributions from ${Questions.healthYouIdentity} health insurance payments?",
            "Health insurance refunds",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 59
      else if (widget.CheckCompleteQuestion ==
              "Were ${Questions.healthYouIdentity} reimbursed for contributions from ${Questions.healthYouIdentity} health insurance payments?" &&
          widget.CheckQuestion == "Health insurance refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Were reimbursed for contributions from health insurance payments?');
          _insert(
              'Were reimbursed for contributions from health insurance payments?',
              'No',
              'OK');
          //Question No 37
//           return healthyesnoContainer("""
// <p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
// <p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
// <p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
// <ul>
// <li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
// <li>Contribution shares of the statutory pension insurance institutions</li>
// <li>Aid entitlements of civil servants</li>
// <li>Contributions from the Artists' Social Fund</li>
// </ul>
// <p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//               "",
//               "Health",
//               "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
//               "Claim for subsidies",
//               220.0,
//               "",
//               "",
//               "");

          return healthcalculationContainer("""
<p><strong>Refunds from insurance premium with sick pay</strong></p>
<p>Please enter the share of refunds received from your health insurance which do include entitlement to sick pay.</p>
<p><em>You can find this amount on the refund statement from your insurance.</em></p>
<p>Please enter the total amount for 2019.</p>
""",
              "",
              "Health",
              "What share of ${Questions.healthYourIdentity} contribution to ${Questions.healthYourIdentity} health insurance entitles ${Questions.healthYouIdentity} to sick pay?",
              "Sick pay",
              220.0,
              "calculation",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Were reimbursed for contributions from health insurance payments?');
          _insert(
              'Were reimbursed for contributions from health insurance payments?',
              'skip',
              'skip');
          //Question No 37
//           return healthyesnoContainer("""
// <p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
// <p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
// <p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
// <ul>
// <li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
// <li>Contribution shares of the statutory pension insurance institutions</li>
// <li>Aid entitlements of civil servants</li>
// <li>Contributions from the Artists' Social Fund</li>
// </ul>
// <p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//               "",
//               "Health",
//               "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
//               "Claim for subsidies",
//               220.0,
//               "",
//               "",
//               "");

          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive from health insurance?",
              "Refund amount health insurance",
              220.0,
              "calculation",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Were reimbursed for contributions from health insurance payments?');
          _insert(
              'Were reimbursed for contributions from health insurance payments?',
              'Yes',
              'OK');
          //Question No 60
          return healthcalculationContainer("""

<p><strong>Amount of refunds</strong></p>
<p>Please enter the amount of refunds you received in 2019. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents from your health insurance.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Health",
              "How much reimbursement did ${Questions.healthYouIdentity} receive from health insurance?",
              "Refund amount health insurance",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 60
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.healthYouIdentity} receive from health insurance?" &&
          widget.CheckQuestion == "Refund amount health insurance") {
        //Question No 61
        return healthcalculationContainer("""
<p><strong>Refunds from insurance premium with sick pay</strong></p>
<p>Please enter the share of refunds received from your health insurance which do include entitlement to sick pay.</p>
<p><em>You can find this amount on the refund statement from your insurance.</em></p>
<p>Please enter the total amount for 2019.</p>
""",
            "",
            "Health",
            "What share of ${Questions.healthYourIdentity} contribution to ${Questions.healthYourIdentity} health insurance entitles ${Questions.healthYouIdentity} to sick pay?",
            "Sick pay",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 61
      else if (widget.CheckCompleteQuestion ==
              "What share of ${Questions.healthYourIdentity} contribution to ${Questions.healthYourIdentity} health insurance entitles ${Questions.healthYouIdentity} to sick pay?" &&
          widget.CheckQuestion == "Sick pay") {
        //Question No 37
        return healthyesnoContainer("""
<p><strong>Subsidies for health insurance contributions or medical expenses</strong></p>
<p>You can choose NO here if you paid all your medical expenses and health insurance contributions on your own and did not receive any subsidies or assistance from anyone else.</p>
<p>If you are entitled to subsidies or grants from a third party, for example your employer or the statutory pension insurance institution, you have to choose YES. These subsidies include, for example:</p>
<ul>
<li>Employer contributions to health insurance for employees subject to social insurance contributions or also for employees with voluntary statutory or private health insurance</li>
<li>Contribution shares of the statutory pension insurance institutions</li>
<li>Aid entitlements of civil servants</li>
<li>Contributions from the Artists' Social Fund</li>
</ul>
<p>A claim must also be stated if it only existed for a part of the year. If the person with whom you are insured (for example, your partner) is entitled to tax-free benefits, this also applies to you.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?",
            "Claim for subsidies",
            220.0,
            "",
            "",
            "");
      }

      // ====== Voluntary statutory health insurance Ends ====== //

      // ====== Health insurance for students Starts ====== //

      //Answer No 62
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for basic health insurance (Basis-Krankenversicherung)?" &&
          widget.CheckQuestion == "Basic health insurance") {
        //Question No 63
        return healthcalculationContainer("""
<p><strong>Entitlement to sick pay</strong></p>
<p>Enter here the amount of your contributions which entitles you to sickness benefits (in the event of illness, the health insurance will pay you sickness benefit to compensate for loss of earnings). The respective amount will be stated within your insurance documents.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much of ${Questions.healthYourIdentity} health insurance premium is available to ${Questions.healthYouIdentity} as sick pay?",
            "Thereof claim to sick pay",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 63
      else if (widget.CheckCompleteQuestion ==
              "How much of ${Questions.healthYourIdentity} health insurance premium is available to ${Questions.healthYouIdentity} as sick pay?" &&
          widget.CheckQuestion == "Thereof claim to sick pay") {
        //Question No 64
        return healthcalculationContainer("""
<p><strong>Contribution to basic nursing care insurance</strong></p>
<p>Enter here your annual contribution in 2019 to your basic nursing care insurance. The total amount will be stated within your insurance documents.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "How much did ${Questions.healthYouIdentity} pay for basic nursing care insurance (Basis-Pflegeversicherung)?",
            "Basic nursing care insurance",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 64
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for basic nursing care insurance (Basis-Pflegeversicherung)?" &&
          widget.CheckQuestion == "Basic nursing care insurance") {
        //Question No 65
        return healthyesnoContainer("""
<p><strong>Refund from your insurance</strong></p>
<p>Please state whether you received any refund from your health &amp; nursing care insurance in 2019. Choose "Yes" or "No" accordingly.</p>
<p>The refund reduces the deductible amount of health and nursing care insurance contributions.</p>
<p>You can find this information in your health insurance documents.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} receive any reimbursement from ${Questions.healthYourIdentity} health insurance?",
            "Health insurance refunds",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 65
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any reimbursement from ${Questions.healthYourIdentity} health insurance?" &&
          widget.CheckQuestion == "Health insurance refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursement from health insurance?');
          _insert('Did receive any reimbursement from health insurance?', 'No',
              'OK');
//Question No 68
          return healthyesnoContainer("""
<p><strong>BAf&ouml;G insurance subsidies</strong></p>
<p>Please state whether you received BAf&ouml;G (education grants under Federal Training Assistance Act) in 2019.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Have ${Questions.healthYouIdentity} received subsidies to ${Questions.healthYourIdentity} health insurance from the BAföG office?",
              "Health insurance subsidies from the BAföG office",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursement from health insurance?');
          _insert('Did receive any reimbursement from health insurance?',
              'skip', 'skip');
//Question No 68
          return healthyesnoContainer("""
<p><strong>BAf&ouml;G insurance subsidies</strong></p>
<p>Please state whether you received BAf&ouml;G (education grants under Federal Training Assistance Act) in 2019.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Have ${Questions.healthYouIdentity} received subsidies to ${Questions.healthYourIdentity} health insurance from the BAföG office?",
              "Health insurance subsidies from the BAföG office",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursement from health insurance?');
          _insert('Did receive any reimbursement from health insurance?', 'Yes',
              'OK');
          //Question No 66
          return healthcalculationContainer("""
<p><strong>Amount of refunds from health &amp; nursing care insurance</strong></p>
<p>Please state how much you received refunds from your statutory health &amp; nursing care insurance in. Please note only refunds from 2019 are relevant.</p>
<p><strong>IMPORTANT</strong></p>
<p>We are talking about the annual amount of refunds your received from your health and nursing care insurance.</p>
<p><strong>Tip:</strong></p>
<p>Bonus payments from your health insurance are not refunds. So you do not need to include these here.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much reimbursement  did ${Questions.healthYouIdentity} receive?",
              "Amount reimbursed",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 66
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement  did ${Questions.healthYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount reimbursed") {
        //Question No 67
        return healthcalculationContainer("""
<p><strong>Refunds from insurance premium with sick pay</strong></p>
<p>Please enter the share of refunds received from your health insurance which do include entitlement to sick pay.</p>
<p><em>You can find this amount on the refund statement from your insurance.</em></p>
<p>Please enter the total amount for 2019.</p>
""",
            "",
            "Health",
            "What share of ${Questions.healthYourIdentity} contribution to ${Questions.healthYourIdentity} health insurance entitles ${Questions.healthYouIdentity} to sick pay?",
            "Thereof claim to sick pay",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer No 67
      else if (widget.CheckCompleteQuestion ==
              "What share of ${Questions.healthYourIdentity} contribution to ${Questions.healthYourIdentity} health insurance entitles ${Questions.healthYouIdentity} to sick pay?" &&
          widget.CheckQuestion == "Thereof claim to sick pay") {
        //Question No 68
        return healthyesnoContainer("""
<p><strong>BAf&ouml;G insurance subsidies</strong></p>
<p>Please state whether you received BAf&ouml;G (education grants under Federal Training Assistance Act) in 2019.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Have ${Questions.healthYouIdentity} received subsidies to ${Questions.healthYourIdentity} health insurance from the BAföG office?",
            "Health insurance subsidies from the BAföG office",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 68
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.healthYouIdentity} received subsidies to ${Questions.healthYourIdentity} health insurance from the BAföG office?" &&
          widget.CheckQuestion ==
              "Health insurance subsidies from the BAföG office") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursement from health insurance?');
          _insert('Did receive any reimbursement from health insurance?', 'No',
              'OK');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursement from health insurance?');
          _insert('Did receive any reimbursement from health insurance?',
              'skip', 'skip');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursement from health insurance?');
          _insert('Did receive any reimbursement from health insurance?', 'Yes',
              'OK');
          //Question No 69
          return healthcalculationContainer("""
<p><strong>BAf&ouml;G insurance subsidies</strong></p>
<p>Please state whether you received BAf&ouml;G (education grants under Federal Training Assistance Act) in 2019.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much did ${Questions.healthYouIdentity} receive in BAföG subsidies?",
              "Amount BAföG subsidies",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 69
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} receive in BAföG subsidies?" &&
          widget.CheckQuestion == "Amount BAföG subsidies") {
        //Question No 20
        return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
            "",
            "Health",
            "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
            "Work-related illness",
            220.0,
            "",
            "",
            "");
      }

      // ====== Health insurance for students Ends ====== //

      //For  adult child and Partner and foreign health insurance and Voluntary statutory health insurance Starts
      //Answer No 37
      else if (widget.CheckCompleteQuestion ==
              "Are ${Questions.healthYouIdentity} entitled to subsidies for ${Questions.healthYourIdentity} health insurance contributions or ${Questions.healthYourIdentity} medical expenses?" &&
          widget.CheckQuestion == "Claim for subsidies") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Are entitled to subsidies for health insurance contributions or medical expenses?');
          _insert(
              'Are entitled to subsidies for health insurance contributions or medical expenses?',
              'No',
              'OK');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Are entitled to subsidies for health insurance contributions or medical expenses?');
          _insert(
              'Are entitled to subsidies for health insurance contributions or medical expenses?',
              'skip',
              'skip');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Are entitled to subsidies for health insurance contributions or medical expenses?');
          _insert(
              'Are entitled to subsidies for health insurance contributions or medical expenses?',
              'Yes',
              'OK');
          //Question No 20
          return healthyesnoContainer("""

<p><strong>Job-related sickness costs</strong></p>
<p>Please state whether you had job-related sickness costs in 2019 and whether or not you were reimbursed for these by your health insurance.</p>
<p>Select "Yes" or "No" accordingly.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment costs</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses could be back problems in craftsmen or office workers, for example.</p>
<p><strong>Important:</strong></p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?",
              "Work-related illness",
              220.0,
              "",
              "",
              "");
        }
      }

//For  adult child and Partner and foreign health insurance and Voluntary statutory health insurance Ends

// ====== Other health insurance Ends ====== //

      //Answer No 20
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} have expenses for work-related health issues?" &&
          widget.CheckQuestion == "Work-related illness") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did have expenses for work-related health issues?');
          _insert(
              'Did have expenses for work-related health issues?', 'No', 'OK');

          if (Questions.haveDisabilityHealth == "Have a disability") {
            //This questions comes only when in "living situation" (having a disability) is selected
            //Question No 132
            //For No 430.0
            //For Yes 220.0
            return healthyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "Do ${Questions.healthYouIdentity} have a disability certificate or confirmation from the social services office?",
                "Disability certificate available",
                220.0,
                "",
                "",
                "");
          }

          //For partner
          else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.healthPartner == true) {
            healthPartner();
            return healthmultithreeContainer(
                """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
                "Kind of health insurance",
                ["Statutory", "Private", "Family", "None of them"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "None of them",
                "",
                "");
          } else {
            if (Questions.childrenYesHealth == "Childrenyes") {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 131(Partner)
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did you both have for your family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 131
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            } else {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            }
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did have expenses for work-related health issues?');
          _insert('Did have expenses for work-related health issues?', 'skip',
              'skip');
          return healthmultipleoptionsContainer(
              """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
              "",
              "Your healthcare costs",
              "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
              "Medical expenses",
              [
                "Prescribed medication",
                "Treatment by a doctor",
                "Trips to the doctor or to treatments",
                "Operations",
                "Glasses",
                "Contact lenses",
                "Hearing aid",
                "Dental treatment",
                "Wheelchair / walking aid",
                "Hospital stay",
                "Nursing care",
                "Health course",
                "Other costs",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "None",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did have expenses for work-related health issues?');
          _insert(
              'Did have expenses for work-related health issues?', 'Yes', 'OK');
          //Question No 70
          //For No 430.0
          //For Yes 220.0
          return healthyesnoContainer("""
<p><strong>Certified by doctor</strong></p>
<p>In order for the professional costs of illness to be taken into account by the tax office, they should have been determined and prescribed by a doctor. If there is no such certificate but one is still of the opinion that it concerns occupationally caused costs, one can refer to the occupationally illnesses regulation or keep other proofs.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "Did a doctor certify the professional cause of ${Questions.healthYourIdentity} job related health costs?",
              "Certified by doctor",
              430.0,
              "",
              "",
              "");
        }
      }

      //Answer No 70
      else if (widget.CheckCompleteQuestion ==
              "Did a doctor certify the professional cause of ${Questions.healthYourIdentity} job related health costs?" &&
          widget.CheckQuestion == "Certified by doctor") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did a doctor certify the professional cause of job related health costs?');
          _insert(
              'Did a doctor certify the professional cause of job related health costs?',
              'No',
              'OK');

          if (Questions.haveDisabilityHealth == "Have a disability") {
            //This questions comes only when in "living situation" (having a disability) is selected
            //Question No 132
            //For No 430.0
            //For Yes 220.0
            return healthyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "Do ${Questions.healthYouIdentity} have a disability certificate or confirmation from the social services office?",
                "Disability certificate available",
                220.0,
                "",
                "",
                "");
          }

          //For partner
          else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.healthPartner == true) {
            healthPartner();
            return healthmultithreeContainer(
                """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
                "Kind of health insurance",
                ["Statutory", "Private", "Family", "None of them"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "None of them",
                "",
                "");
          } else {
            if (Questions.childrenYesHealth == "Childrenyes") {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 131(Partner)
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did you both have for your family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 131
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            } else {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            }
          }
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did a doctor certify the professional cause of job related health costs?');
          _insert(
              'Did a doctor certify the professional cause of job related health costs?',
              'No',
              'OK');

          if (Questions.haveDisabilityHealth == "Have a disability") {
            //This questions comes only when in "living situation" (having a disability) is selected
            //Question No 132
            //For No 430.0
            //For Yes 220.0
            return healthyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "Do ${Questions.healthYouIdentity} have a disability certificate or confirmation from the social services office?",
                "Disability certificate available",
                220.0,
                "",
                "",
                "");
          }

          //For partner
          else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.healthPartner == true) {
            healthPartner();
            return healthmultithreeContainer(
                """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
                "Kind of health insurance",
                ["Statutory", "Private", "Family", "None of them"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "None of them",
                "",
                "");
          } else {
            if (Questions.childrenYesHealth == "Childrenyes") {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 131(Partner)
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did you both have for your family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 131
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            } else {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            }
          }
        }

        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did a doctor certify the professional cause of job related health costs?');
          _insert(
              'Did a doctor certify the professional cause of job related health costs?',
              'No',
              'OK');
          if (Questions.haveDisabilityHealth == "Have a disability") {
            //This questions comes only when in "living situation" (having a disability) is selected
            //Question No 132
            //For No 430.0
            //For Yes 220.0
            return healthyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "Do ${Questions.healthYouIdentity} have a disability certificate or confirmation from the social services office?",
                "Disability certificate available",
                220.0,
                "",
                "",
                "");
          }

          //For partner
          else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.healthPartner == true) {
            healthPartner();
            return healthmultithreeContainer(
                """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
                "Kind of health insurance",
                ["Statutory", "Private", "Family", "None of them"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "None of them",
                "",
                "");
          } else {
            if (Questions.childrenYesHealth == "Childrenyes") {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 131(Partner)
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did you both have for your family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 131
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            } else {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            }
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did a doctor certify the professional cause of job related health costs?');
          _insert(
              'Did a doctor certify the professional cause of job related health costs?',
              'skip',
              'OK');
          if (Questions.haveDisabilityHealth == "Have a disability") {
            //This questions comes only when in "living situation" (having a disability) is selected
            //Question No 132
            //For No 430.0
            //For Yes 220.0
            return healthyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Health",
                "Do ${Questions.healthYouIdentity} have a disability certificate or confirmation from the social services office?",
                "Disability certificate available",
                220.0,
                "",
                "",
                "");
          }

          //For partner
          else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.healthPartner == true) {
            healthPartner();
            return healthmultithreeContainer(
                """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
                "Kind of health insurance",
                ["Statutory", "Private", "Family", "None of them"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "None of them",
                "",
                "");
          } else {
            if (Questions.childrenYesHealth == "Childrenyes") {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 131(Partner)
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did you both have for your family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 131
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            } else {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did a doctor certify the professional cause of job related health costs?');
          _insert(
              'Did a doctor certify the professional cause of job related health costs?',
              'Yes',
              'OK');
          //Question No 71
          return healthcalculationContainer("""
<p><strong>Job-related sickness costs</strong></p>
<p>Enter the expenses you had due to job-related sickness 2019.</p>
<p>Add up all your costs and enter the total here.</p>
<p>This includes the following expenses:</p>
<ul>
<li>medication</li>
<li>treatment cost</li>
<li>journeys to the doctor</li>
<li>necessary aids</li>
</ul>
<p>Job-related illnesses can be, for example, back problems in craftsmen or office workers.</p>
<p><strong>Important</strong>:</p>
<p>You need a <strong>doctor's note </strong>saying that your symptoms are job-related. In case the tax office asks you can use it to <strong>prove the necessity of treatments and medication</strong>.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "How much have ${Questions.healthYouIdentity} spent on work-related health issues?",
              "Work-related healthcare costs",
              430.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 71
      else if (widget.CheckCompleteQuestion ==
              "How much have ${Questions.healthYouIdentity} spent on work-related health issues?" &&
          widget.CheckQuestion == "Work-related healthcare costs") {
        if (Questions.haveDisabilityHealth == "Have a disability") {
          DbHelper.insatance.deleteWithquestion(
              'How much have spent on work-related health issues?');
          _insert('How much have spent on work-related health issues?',
              'Have a disability', 'OK');
          //This questions comes only when in "living situation" (having a disability) is selected
          //Question No 132
          //For No 430.0
          //For Yes 220.0
          return healthyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Health",
              "Do ${Questions.healthYouIdentity} have a disability certificate or confirmation from the social services office?",
              "Disability certificate available",
              220.0,
              "",
              "",
              "");
        }

        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.healthPartner == true) {
          healthPartner();
          return healthmultithreeContainer(
              """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
              "Kind of health insurance",
              ["Statutory", "Private", "Family", "None of them"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "None of them",
              "",
              "");
        } else {
          if (Questions.childrenYesHealth == "Childrenyes") {
            DbHelper.insatance.deleteWithquestion(
                'How much have spent on work-related health issues?');
            _insert('How much have spent on work-related health issues?',
                'Childrenyes', 'OK');
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              healthYouPartner();
              //Question No 131(Partner)
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did you both have for your family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 131
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          } else {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              healthYouPartner();
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          }
        }
      }

      // ====== Non work related Medical Expense Starts ====== //

      //Answer No 72 and 131 and 131(Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?" ||
              widget.CheckCompleteQuestion ==
                  "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?" ||
              widget.CheckCompleteQuestion ==
                  "What special health costs did you both have for your family?") &&
          (widget.CheckQuestion == "Treatment costs" ||
              widget.CheckQuestion == "Medical expenses")) {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Prescribed medication") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Prescribed medication',
                'OK');
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 73(Partner)
              return healthcalculationContainer("""
<p><strong>Cost of medication</strong></p>
<p>Enter the total you spent on medication in <strong>2019</strong>.</p>
<p>You can enter the cost of both over-the-counter and prescription medication here. The contraceptive pill is excluded.</p>
<p>It is <strong>important</strong> the medication was prescribed by a doctor. This can also include headache or vitamin pills.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "How much did you both spend in total on medication?",
                  "Medication costs",
                  220.0,
                  "calculation",
                  "",
                  "");
            } else {
              //Question No 73
              return healthcalculationContainer("""
<p><strong>Cost of medication</strong></p>
<p>Enter the total you spent on medication in <strong>2019</strong>.</p>
<p>You can enter the cost of both over-the-counter and prescription medication here. The contraceptive pill is excluded.</p>
<p>It is <strong>important</strong> the medication was prescribed by a doctor. This can also include headache or vitamin pills.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "How much did ${Questions.healthYouIdentity} spend in total on medication?",
                  "Medication costs",
                  220.0,
                  "calculation",
                  "",
                  "");
            }
          } else if (widget.CheckAnswer[m] == "Treatment by a doctor") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Treatment by a doctor',
                'OK');
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 77(Partner)
              return healthcalculationContainer("""
<p><strong>Cost of medication</strong></p>
<p>Enter the total you spent on medication in <strong>2019</strong>.</p>
<p>You can enter the cost of both over-the-counter and prescription medication here. The contraceptive pill is excluded.</p>
<p>It is <strong>important</strong> the medication was prescribed by a doctor. This can also include headache or vitamin pills.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "How much did you both spend in total for medical treatments?",
                  "Treatment costs",
                  220.0,
                  "calculation",
                  "",
                  "");
            } else {
              //Question No 77
              return healthcalculationContainer("""
<p><strong>Cost of medication</strong></p>
<p>Enter the total you spent on medication in <strong>2019</strong>.</p>
<p>You can enter the cost of both over-the-counter and prescription medication here. The contraceptive pill is excluded.</p>
<p>It is <strong>important</strong> the medication was prescribed by a doctor. This can also include headache or vitamin pills.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "How much did ${Questions.healthYouIdentity} spend in total for medical treatments?",
                  "Treatment costs",
                  220.0,
                  "calculation",
                  "",
                  "");
            }
          } else if (widget.CheckAnswer[m] ==
              "Trips to the doctor or to treatments") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Trips to the doctor or to treatments',
                'OK');
            //Question No 123
            return healthcalculationContainer("""
<p><strong>Journeys to doctor</strong></p>
<p>Please enter the number of doctors you travelled to.</p>
<p>You can write off the following journey costs:</p>
<ul>
<li>to doctors</li>
<li>to the pharmacy</li>
<li>to the optician</li>
<li>to a therapist</li>
<li>to appointments for therapeutic treatment</li>
</ul>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "To how many different doctors did ${Questions.healthYouIdentity} travel?",
                "Doctors",
                280.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Operations") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Operations',
                'OK');
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 80(Partner)
              return healthcalculationContainer("""
<p><strong>Expenses for operations</strong></p>
<p>If your health insurance provider did not cover any of the costs for surgeries you can enter them here. We are talking about the total amount for <strong>2019.</strong></p>
<p><strong>ATTENTION: COSMETIC SURGERY</strong></p>
<p>In general the tax office does <strong>not recognise</strong> cosmetic surgeries.</p>
<p>Only if you have a <strong>doctor's report</strong> that proves the urgent necessity of the surgery, then you may have a chance of the tax office recognising your costs.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "How much have you both spent on operations in total?",
                  "Operation costs",
                  220.0,
                  "calculation",
                  "",
                  "");
            } else {
              //Question No 80
              return healthcalculationContainer("""
<p><strong>Expenses for operations</strong></p>
<p>If your health insurance provider did not cover any of the costs for surgeries you can enter them here. We are talking about the total amount for <strong>2019.</strong></p>
<p><strong>ATTENTION: COSMETIC SURGERY</strong></p>
<p>In general the tax office does <strong>not recognise</strong> cosmetic surgeries.</p>
<p>Only if you have a <strong>doctor's report</strong> that proves the urgent necessity of the surgery, then you may have a chance of the tax office recognising your costs.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What did ${Questions.healthYouIdentity} spend in total on operations?",
                  "Operation costs",
                  220.0,
                  "calculation",
                  "",
                  "");
            }
          } else if (widget.CheckAnswer[m] == "Glasses") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Glasses',
                'OK');
            //Question No 83
            return healthcalculationContainer("""
<p><strong>Expenses for glasses</strong></p>
<p>If your health insurance provider did not cover any of the costs for surgeries you can enter them here. We are talking about the total amount for <strong>2019.</strong></p>
<p><strong>ATTENTION: COSMETIC SURGERY</strong></p>
<p>In general the tax office does <strong>not recognise</strong> cosmetic surgeries.</p>
<p>Only if you have a <strong>doctor's report</strong> that proves the urgent necessity of the surgery, then you may have a chance of the tax office recognising your costs.</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend on glasses?",
                "Glasses costs",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Contact lenses") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Contact lenses',
                'OK');
            //Question No 86
            return healthcalculationContainer("""
<p><strong>Expenses for contact lenses</strong></p>
<p>Enter the amount you spent on contact lenses. Only the amount from <strong>2019</strong> is relevant.</p>
<p>The <strong>requirement</strong> for you to write off the costs is that the contact lenses are medically necessary.</p>
<p><strong>Colorful</strong> contact lenses your wore as part of your Halloween costume are not covered by this.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend on contact lenses?",
                "Cost of contact lenses",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Hearing aid") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Hearing aid',
                'OK');
            //Question No 89
            return healthcalculationContainer("""
<p><strong>Costs for hearing aids</strong></p>
<p>Enter the amount you spent on hearing aids. Only the amount from <strong>2019</strong> is relevant. The requirement to write off this expense is that the hearing aids are medically necessary.</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend on hearing aids?",
                "Cost of hearing aid",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Dental treatment") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Dental treatment',
                'OK');
            //Question No 92
            return healthcalculationContainer("""
<p><strong>Costs for dental prostheses</strong></p>
<p>Enter the amount you spent on dental protheses. Only the amount from <strong>2019</strong> is relevant.</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend on dental implants, dentures, etc.?",
                "Cost of dental treatments",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Wheelchair / walking aid") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Wheelchair / walking aid',
                'OK');
            //Question No 95
            return healthcalculationContainer("""
<p><strong>Costs for wheelchair or walking aids</strong></p>
<p>Enter the amount you spent on a wheelchair or walking aids. Only the amount from 2019 is relevant.</p>
<p><strong>REQUIREMENT</strong></p>
<p>If your wheelchair or walking aid is medically necessary you can enter it here. Particularly healthy people will need a doctor's note proving this is the case.</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend overall on wheelchairs or walking aids?",
                "Costs for wheelchair",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Hospital stay") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Hospital stay',
                'OK');
            //Question No 98
            return healthcalculationContainer("""
<p><strong>Costs for hospital stays</strong></p>
<p>Please enter the amount of costs you had for hospital stays. Add the costs together and enter them here. You can find this information in the documentation of your hospital stay.</p>
<p><strong>YOUR TAXES</strong></p>
<p>During a hospital stay most non-private patients have to pay a daily fee. This is determined by room size, among other factors. A private room costs more than a two-bed or a shared room.</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} pay for your stay in hospital?",
                "Accommodation costs",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Nursing care") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Nursing care',
                'OK');
            //Question No 101
            return healthcalculationContainer("""
<p><strong>Expenses for nursing care</strong></p>
<p>Please enter the amount of expenses resulting from nursing care.</p>
<p>It is important that you only enter costs that were not covered by your health insurance provider. Only costs from <strong>2019</strong> relevant.</p>
<p>These costs can include employing nursing staff that cared for you.</p>
""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend on nursing care?",
                "Nursing care costs",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Health course") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Health course',
                'OK');
            //Question No 104
            return healthcalculationContainer("""
<p><strong>Health related costs</strong></p>
<p>Please enter how much you spent on health courses in the year 2019 in total.</p>
<p>Enter the total here.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "How much have ${Questions.healthYouIdentity} spent on healthcare workshops?",
                "Healthcare workshops",
                220.0,
                "calculation",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Other costs") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'Other costs',
                'OK');
            //Question No 107
//             return healthcalculationContainer(
//                 """<p><strong>Additional medical expenses</strong></p>
// <p>Please enter which additional medical expenses you had.</p>
// <p>For example, if went to an alternative practitioner, then enter here: a "alternative practitioner". If you want to claim any additional fees, press "Leave blank" to continue.</p>
// <p>Include medical expenses that you can deduct from the tax:</p>
// <ul>
// <li>physical therapy</li>
// <li>prescription fees</li>
// <li>alternative practitioner</li>
// <li>homeopath</li>
// <li>spa costs</li>
// <li>vaccinations before travel abroad</li>
// </ul>
// <p>These expenditures must have been prescribed by a doctor.</p>
// <p>&nbsp;</p>
// """,
//                 "",
//                 "Your healthcare costs",
//                 "What additional costs did ${Questions.healthYouIdentity} have (e.g. physical therapy, naturopathy homeopathy or rehabilitation costs)?",
//                 "Other costs",
//                 220.0,
//                 "calculation",
//                 "",
//                 "");

            return healthcalculationContainer(
                """<p><strong>Additional medical expenses</strong></p>
<p>Please enter which additional medical expenses you had.</p>
<p>For example, if went to an alternative practitioner, then enter here: a "alternative practitioner". If you want to claim any additional fees, press "Leave blank" to continue.</p>
<p>Include medical expenses that you can deduct from the tax:</p>
<ul>
<li>physical therapy</li>
<li>prescription fees</li>
<li>alternative practitioner</li>
<li>homeopath</li>
<li>spa costs</li>
<li>vaccinations before travel abroad</li>
</ul>
<p>These expenditures must have been prescribed by a doctor.</p>
<p>&nbsp;</p>
""",
                "",
                "Your healthcare costs",
                "What other costs name did ${Questions.healthYouIdentity} have for your non work related expense?",
                "Other costs name",
                220.0,
                "",
                "",
                "");
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'None',
                'OK');
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 76(Partner)
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                  "Nursing", 430.0, "", "", "");
            } else {
              //Question No 76
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                  "",
                  "Care of others",
                  "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                  "Free care of others",
                  430.0,
                  "",
                  "",
                  "");
            }
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'What special health costs did you both have for your family?');
            _insert(
                'What special health costs did you both have for your family?',
                'skip',
                'skip');
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 76(Partner)
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                  "Nursing", 430.0, "", "", "");
            } else {
              //Question No 76
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                  "",
                  "Care of others",
                  "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                  "Free care of others",
                  430.0,
                  "",
                  "",
                  "");
            }
          }
        }
      } else if ((widget.CheckCompleteQuestion ==
              "What other costs name did ${Questions.healthYouIdentity} have for your non work related expense?") &&
          widget.CheckQuestion == "Other costs name") {
        return healthcalculationContainer(
            """<p><strong>Additional medical expenses</strong></p>
<p>Please enter which additional medical expenses you had.</p>
<p>For example, if went to an alternative practitioner, then enter here: a "alternative practitioner". If you want to claim any additional fees, press "Leave blank" to continue.</p>
<p>Include medical expenses that you can deduct from the tax:</p>
<ul>
<li>physical therapy</li>
<li>prescription fees</li>
<li>alternative practitioner</li>
<li>homeopath</li>
<li>spa costs</li>
<li>vaccinations before travel abroad</li>
</ul>
<p>These expenditures must have been prescribed by a doctor.</p>
<p>&nbsp;</p>
""",
            "",
            "Your healthcare costs",
            "What other costs price did ${Questions.healthYouIdentity} have for your non work related expense?",
            "Other costs price",
            220.0,
            "calculation",
            "",
            "");
      } else if ((widget.CheckCompleteQuestion ==
              "What other costs price did ${Questions.healthYouIdentity} have for your non work related expense?") &&
          widget.CheckQuestion == "Other costs price") {
        return healthyesnoContainer("""

<p><strong>Reimbursement by health insurer</strong></p>
<p>If you received reimbursement from your health insurance provider in 2019 for the sickness costs you entered, select "Yes". This is also the case if you only received <strong>partial reimbursement</strong>.</p>
<p>If you did not receive any reimbursement then select "No".</p>
<p>You can find this information in your health documents. Your health insurer should have sent you a confirmation about the reimbursement.</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYouIdentity} receive reimbursement for this from ${Questions.healthYourIdentity} health insurance?",
            "Reimbursement of costs from health insurance",
            220.0,
            "",
            "",
            "");
      }

      // ====== Prescribed medication Starts ====== //

      //Answer No 73
      else if ((widget.CheckCompleteQuestion ==
                  "How much did ${Questions.healthYouIdentity} spend in total on medication?" ||
              widget.CheckCompleteQuestion ==
                  "How much did you both spend in total on medication?") &&
          widget.CheckQuestion == "Medication costs") {
        //Question No 74
        return healthyesnoContainer("""
<p><strong>Cost reimbursement of medication</strong></p>
<p>If your health insurance paid for your medication select "Yes". This is true also if you were only partially reimbursed.</p>
<p><strong>We will ask for the reimbursed amount separately.</strong></p>
<p>If your health insurance didn't pay for anything select "No".</p>
<p><strong>THESE ARE COSTS FOR MEDICATION</strong></p>
<p>You can enter both prescription-only and over-the-counter medication.</p>
<p>It is <strong>important</strong> they were prescribed to you by a doctor. This can also include headache or vitamin pills. The contraceptive pill is excluded from this.</p>
<p>&nbsp;</p>
""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of medication?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 74
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of medication?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of medication?');
          _insert('Did health insurance reimburse the cost of medication?',
              'No', 'OK');
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of medication?');
          _insert('Did health insurance reimburse the cost of medication?',
              'skip', 'skip');
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of medication?');
          _insert('Did health insurance reimburse the cost of medication?',
              'Yes', 'OK');
          //Question No 75
          return healthcalculationContainer("""

<p><strong>Cost reimbursement medication</strong></p>
<p>Please state the total amount your health insurance contributed toward your medication <strong>in 2019.</strong></p>
<p>THESE ARE COSTS FOR MEDICATION</p>
<p>You can enter both prescription-only and over-the-counter medication.</p>
<p>It is <strong>important</strong> they were prescribed to you by a doctor. This can also include headache or vitamin pills. The contraceptive pill is excluded from this.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed?",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 75
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?" &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }
      // ====== Prescribed medication Ends ====== //

      // ====== Treatment by a doctor Starts ====== //

      //Answer No 77
      else if ((widget.CheckCompleteQuestion ==
                  "How much did ${Questions.healthYouIdentity} spend in total for medical treatments?" ||
              widget.CheckCompleteQuestion ==
                  "How much did you both spend in total for medical treatments?") &&
          widget.CheckQuestion == "Treatment costs") {
        //Question No 78
        return healthyesnoContainer("""

<p>Enter the sum of your expenses for medical treatments <strong>in 2019.</strong></p>
<p>You may enter the following costs, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>Important:</strong> You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>


""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse your treatment costs?",
            "Reimbursements",
            430.0,
            "",
            "",
            "");
      }

      //Answer No 78
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse your treatment costs?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse your treatment costs?');
          _insert('Did health insurance reimburse your treatment costs?', 'No',
              'OK');
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse your treatment costs?');
          _insert('Did health insurance reimburse your treatment costs?',
              'skip', 'OK');
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse your treatment costs?');
          _insert('Did health insurance reimburse your treatment costs?', 'Yes',
              'OK');
          //Question No 79
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed?",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 79
      else if (widget.CheckCompleteQuestion ==
              " How much has been reimbursed?" &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Treatment by a doctor Ends ====== //

      // ====== Trips to the doctor or to treatments Starts ====== //
      //Answer No 123
      else if (widget.CheckCompleteQuestion ==
              "To how many different doctors did ${Questions.healthYouIdentity} travel?" &&
          widget.CheckQuestion == "Doctors") {
        //Question No 124
        return healthtwooptionContainer(
            """

<p><strong>Journey to doctor: location</strong></p>
<p>Here we want to know where you travelled to. First specify whether the journey to the doctor was within Germany or you had to travel abroad.</p>
<p>After this you can enter the actual journey costs.</p>
<p>&nbsp;</p>


""",
            "",
            "Your healthcare costs",
            "Where have ${Questions.healthYouIdentity} travelled to?",
            "${Questions.doctorTripLength}. drive to doctor",
            ["Germany", "Abroad"],
            430.0,
            "",
            Questions.doctorTripText,
            "");
      }

      //Answer No 124
      else if (widget.CheckCompleteQuestion ==
              "Where have ${Questions.healthYouIdentity} travelled to?" &&
          widget.CheckQuestion ==
              "${Questions.doctorTripLength}. drive to doctor") {
        if (widget.CheckAnswer[0] == "Germany") {
          DbHelper.insatance.deleteWithquestion('Where have travelled to?');
          _insert('Where have travelled to?', 'Germany', 'OK');
          //Question No 125
          return healthmultipleoptionsContainer(
              """

<p><strong>Journeys to doctor: means of transport</strong></p>
<p>Please state which means of transport you used to get to the doctor. You can select multiple answers.</p>
<p>Choose from the following answers by clicking and confirming:</p>
<p><strong>CAR</strong></p>
<p>You travelled with your own car to the doctor.</p>
<p><strong>BUS / TRAIN</strong></p>
<p>You used public transport to get to the doctor. Taxis also count.</p>
<p><strong>PLANE</strong></p>
<p>If you travelled by plane there is no commuting allowance. Here you have to enter the actual costs.</p>
<p><strong>BIKE</strong></p>
<p>You rode a bike to the doctor.</p>
<p><strong>ON FOOT</strong></p>
<p>You walked to the doctor</p>
<p>&nbsp;</p>

""",
              "",
              "Your healthcare costs",
              "How did ${Questions.healthYouIdentity} get there?",
              "Means of transport",
              ["By car", "Bus / train", "Airplane", "Bicycle", "On foot"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "",
              Questions.doctorTripText,
              "");
        } else if (widget.CheckAnswer[0] == "Abroad") {
          DbHelper.insatance.deleteWithquestion('Where have travelled to?');
          _insert('Where have travelled to?', 'Abroad', 'OK');
          //Question No 125
          return healthmultipleoptionsContainer(
              """

<p><strong>Journeys to doctor: means of transport</strong></p>
<p>Please state which means of transport you used to get to the doctor. You can select multiple answers.</p>
<p>Choose from the following answers by clicking and confirming:</p>
<p><strong>CAR</strong></p>
<p>You travelled with your own car to the doctor.</p>
<p><strong>BUS / TRAIN</strong></p>
<p>You used public transport to get to the doctor. Taxis also count.</p>
<p><strong>PLANE</strong></p>
<p>If you travelled by plane there is no commuting allowance. Here you have to enter the actual costs.</p>
<p><strong>BIKE</strong></p>
<p>You rode a bike to the doctor.</p>
<p><strong>ON FOOT</strong></p>
<p>You walked to the doctor</p>
<p>&nbsp;</p>

""",
              "",
              "Your healthcare costs",
              "How did ${Questions.healthYouIdentity} get there?",
              "Means of transport",
              ["By car", "Bus / train", "Airplane", "Bicycle", "On foot"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "",
              Questions.doctorTripText,
              "");
        }
      }

      //Answer No 125
      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.healthYouIdentity} get there?" &&
          widget.CheckQuestion == "Means of transport") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "By car") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'By car', 'OK');
            //Question No 126
            //Ya container baad ma change hoga
            return healthcalculationContainer("""

<p><strong>Journey to doctor: distance by car</strong></p>
<p>Here we want to know where you travelled to.</p>
<p>Enter the start and destination address. We will then calculate the distance.</p>
<p>After this you can enter the actual journey costs..</p>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "Please enter the start and end point of ${Questions.healthYourIdentity} route that ${Questions.healthYouIdentity} travelled by car.",
                "Distance by car",
                220.0,
                "",
                Questions.doctorTripText,
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'skip', 'OK');
            //Question No 126
            //Ya container baad ma change hoga
            return healthcalculationContainer("""

<p><strong>Journey to doctor: distance by car</strong></p>
<p>Here we want to know where you travelled to.</p>
<p>Enter the start and destination address. We will then calculate the distance.</p>
<p>After this you can enter the actual journey costs..</p>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "Please enter the start and end point of ${Questions.healthYourIdentity} route that ${Questions.healthYouIdentity} travelled by car.",
                "Distance by car",
                220.0,
                "",
                Questions.doctorTripText,
                "");
          } else if (widget.CheckAnswer[m] == "Bus / train") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'Bus / train', 'OK');
            //Bus/train and Airplace goes to same question
            //Question No 130
            return healthcalculationContainer("""

<p><strong>Actual costs for journeys to doctor</strong></p>
<p>Please enter your actual journey costs for doctor no. 1. In case you went there several times you need to sum up all the single receipts.</p>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend in total on trains to go to doctor no. ${Questions.doctorTripLength}?",
                "Amount",
                220.0,
                "calculation",
                Questions.doctorTripText,
                "");
          } else if (widget.CheckAnswer[m] == "Airplane") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'Airplane', 'OK');
            //Bus/train and Airplace goes to same question
            //Question No 130
            return healthcalculationContainer("""

<p><strong>Actual costs for journeys to doctor</strong></p>
<p>Please enter your actual journey costs for doctor no. 1. In case you went there several times you need to sum up all the single receipts.</p>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "How much did ${Questions.healthYouIdentity} spend in total on trains to go to doctor no. ${Questions.doctorTripLength}?",
                "Amount",
                220.0,
                "calculation",
                Questions.doctorTripText,
                "");
          } else if (widget.CheckAnswer[m] == "Bicycle") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'Bicycle', 'OK');
            if (Questions.doctorTripLength <= Questions.totalDoctorTrip) {
              //Question No 124
              return healthtwooptionContainer(
                  """

<p><strong>Journey to doctor: location</strong></p>
<p>Here we want to know where you travelled to. First specify whether the journey to the doctor was within Germany or you had to travel abroad.</p>
<p>After this you can enter the actual journey costs.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                  "",
                  "Your healthcare costs",
                  "Where have ${Questions.healthYouIdentity} travelled to?",
                  "${Questions.doctorTripLength}. drive to doctor",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.doctorTripText,
                  "");
            } else {
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                //Question No 76(Partner)
                return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                    "Nursing", 430.0, "", "", "");
              } else {
                //Question No 76
                return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                    "",
                    "Care of others",
                    "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                    "Free care of others",
                    430.0,
                    "",
                    "",
                    "");
              }
            }
          } else if (widget.CheckAnswer[m] == "On foot") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'On foot', 'OK');

            if (Questions.doctorTripLength <= Questions.totalDoctorTrip) {
              //Question No 124
              return healthtwooptionContainer(
                  """

<p><strong>Journey to doctor: location</strong></p>
<p>Here we want to know where you travelled to. First specify whether the journey to the doctor was within Germany or you had to travel abroad.</p>
<p>After this you can enter the actual journey costs.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                  "",
                  "Your healthcare costs",
                  "Where have ${Questions.healthYouIdentity} travelled to?",
                  "${Questions.doctorTripLength}. drive to doctor",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.doctorTripText,
                  "");
            } else {
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                //Question No 76(Partner)
                return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                    "Nursing", 430.0, "", "", "");
              } else {
                //Question No 76
                return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                    "",
                    "Care of others",
                    "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                    "Free care of others",
                    430.0,
                    "",
                    "",
                    "");
              }
            }
          }
        }
      }

      //By Car starts //
      //Answer No 126

      else if (widget.CheckCompleteQuestion ==
              "Please enter the start and end point of ${Questions.healthYourIdentity} route that ${Questions.healthYouIdentity} travelled by car." &&
          widget.CheckQuestion == "Distance by car") {
        DbHelper.insatance.deleteWithquestion(
            'Please enter the start and end point of route that travelled by car.');
        _insert(
            'Please enter the start and end point of route that travelled by car.',
            Questions.doctorTripText,
            'OK');
        //Question No 127
        return healthcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Your healthcare costs",
            "How often did ${Questions.healthYouIdentity} take the route to doctor No.${Questions.doctorTripLength} by car?",
            "Number of drives by car",
            220.0,
            "",
            Questions.doctorTripText,
            "");
      }

      //Answer No 127
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.healthYouIdentity} take the route to doctor No.${Questions.doctorTripLength} by car?" &&
          widget.CheckQuestion == "Number of drives by car") {
        DbHelper.insatance.deleteWithquestion(
            'How often did take the route to doctor by car?');
        _insert('How often did take the route to doctor by car?',
            Questions.doctorTripText, 'OK');
        //Question No 128
        return healthyesnoContainer("""

<p><strong>Cost reimbursement: journeys to doctor</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for journey costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>YOU CAN INCLUDE THE FOLLOWING JOURNEY COSTS:</strong></p>
<ul>
<li>to doctors</li>
<li>to the pharmacy</li>
<li>to the optician</li>
<li>to a therapist</li>
<li>to appointments for therapeutic treatment</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse ${Questions.healthYourIdentity} travel costs?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.doctorTripText,
            "");
      }

      //By Car ends //

      //By Bus/train Starts

//Answer No 130
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend in total on trains to go to doctor no. ${Questions.doctorTripLength}?" &&
          widget.CheckQuestion == "Amount") {
        DbHelper.insatance.deleteWithquestion(
            'How much did spend in total on trains to go to doctor?');
        _insert('How much did spend in total on trains to go to doctor?',
            Questions.doctorTripText, 'OK');
        //Question No 128
        return healthyesnoContainer("""

<p><strong>Cost reimbursement: journeys to doctor</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for journey costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>YOU CAN INCLUDE THE FOLLOWING JOURNEY COSTS:</strong></p>
<ul>
<li>to doctors</li>
<li>to the pharmacy</li>
<li>to the optician</li>
<li>to a therapist</li>
<li>to appointments for therapeutic treatment</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse ${Questions.healthYourIdentity} travel costs?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.doctorTripText,
            "");
      }

      //By Bus/train Ends

      //Answer No 128
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse ${Questions.healthYourIdentity} travel costs?" &&
          widget.CheckQuestion == "Reimbursement of costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'How much did spend in total on trains to go to doctor?');
          _insert('How much did spend in total on trains to go to doctor?',
              'No', 'OK');
          if (Questions.doctorTripLength <= Questions.totalDoctorTrip) {
            //Question No 124
            return healthtwooptionContainer(
                """

<p><strong>Journey to doctor: location</strong></p>
<p>Here we want to know where you travelled to. First specify whether the journey to the doctor was within Germany or you had to travel abroad.</p>
<p>After this you can enter the actual journey costs.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "Where have ${Questions.healthYouIdentity} travelled to?",
                "${Questions.doctorTripLength}. drive to doctor",
                ["Germany", "Abroad"],
                430.0,
                "",
                Questions.doctorTripText,
                "");
          } else {
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 76(Partner)
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                  "Nursing", 430.0, "", "", "");
            } else {
              //Question No 76
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                  "",
                  "Care of others",
                  "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                  "Free care of others",
                  430.0,
                  "",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'How much did spend in total on trains to go to doctor?');
          _insert('How much did spend in total on trains to go to doctor?',
              'skip', 'skip');

          if (Questions.doctorTripLength <= Questions.totalDoctorTrip) {
            //Question No 124
            return healthtwooptionContainer(
                """

<p><strong>Journey to doctor: location</strong></p>
<p>Here we want to know where you travelled to. First specify whether the journey to the doctor was within Germany or you had to travel abroad.</p>
<p>After this you can enter the actual journey costs.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "Where have ${Questions.healthYouIdentity} travelled to?",
                "${Questions.doctorTripLength}. drive to doctor",
                ["Germany", "Abroad"],
                430.0,
                "",
                Questions.doctorTripText,
                "");
          } else {
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 76(Partner)
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                  "Nursing", 430.0, "", "", "");
            } else {
              //Question No 76
              return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                  "",
                  "Care of others",
                  "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                  "Free care of others",
                  430.0,
                  "",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'How much did spend in total on trains to go to doctor?');
          _insert('How much did spend in total on trains to go to doctor?',
              'Yes', 'OK');
          //Question No 129
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""",
              "",
              "Your healthcare costs",
              "How much has been reimbursed?",
              "Reimbursement amount",
              220.0,
              "calculation",
              Questions.doctorTripText,
              "");
        }
      }

      //Answer No 129
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?      " &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.doctorTripLength <= Questions.totalDoctorTrip) {
          DbHelper.insatance
              .deleteWithquestion('How much has been reimbursed?');
          _insert(
              'How much has been reimbursed?', Questions.doctorTripText, 'OK');
          //Question No 124
          return healthtwooptionContainer(
              """

<p><strong>Journey to doctor: location</strong></p>
<p>Here we want to know where you travelled to. First specify whether the journey to the doctor was within Germany or you had to travel abroad.</p>
<p>After this you can enter the actual journey costs.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Your healthcare costs",
              "Where have ${Questions.healthYouIdentity} travelled to?",
              "${Questions.doctorTripLength}. drive to doctor",
              ["Germany", "Abroad"],
              430.0,
              "",
              Questions.doctorTripText,
              "");
        } else {
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        }
      }

      // ====== Trips to the doctor or to treatments Ends ====== //

      // ====== Operations Starts ====== //

      //Answer No 80 and 80(Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "What did ${Questions.healthYouIdentity} spend in total on operations?" ||
              widget.CheckCompleteQuestion ==
                  "How much have you both spent on operations in total?") &&
          widget.CheckQuestion == "Operation costs") {
        //Question No 81
        return healthyesnoContainer("""

<p><strong>Cost reimbursement for operations</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for operation costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>ATTENTION: COSMETIC SURGERY</strong></p>
<p>In general the tax office does <strong>not recognise</strong> cosmetic surgeries.</p>
<p>Only if you have a <strong>doctor's report</strong> that proves the urgent necessity of the surgery, then you may have a chance of the tax office recognising your costs.</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of operations?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 81
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of operations?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of operations?');
          _insert('Did health insurance reimburse the cost of operations?',
              'No', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of operations?');
          _insert('Did health insurance reimburse the cost of operations?',
              'skip', 'skip');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of operations?');
          _insert('Did health insurance reimburse the cost of operations?',
              'Yes', 'OK');
          //Question No 82
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "  How much has been reimbursed?",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 82
      else if (widget.CheckCompleteQuestion ==
              "  How much has been reimbursed?" &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Operations Ends ====== //

      // ====== Glasses Starts ====== //

      //Answer no 83
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on glasses?" &&
          widget.CheckQuestion == "Glasses costs") {
        //Question No 84
        return healthyesnoContainer("""

<p><strong>Cost reimbursement for glasses</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for costs for glasses, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>REQUIREMENT</strong></p>
<p>If the purchase of your glasses was medically necessary then you can enter the costs here. <strong>Normal sunglasses </strong>obviously do not count.</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of glasses?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 84
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of glasses?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of glasses?');
          _insert('Did health insurance reimburse the cost of glasses?', 'No',
              'OK');
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of glasses?');
          _insert('Did health insurance reimburse the cost of glasses?', 'skip',
              'skip');
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of glasses?');
          _insert('Did health insurance reimburse the cost of glasses?', 'Yes',
              'OK');
          //Question No 85
          return healthcalculationContainer("""

<p><strong>Cost reimbursement: journeys to doctor</strong></p>
<p>Please enter the amount of reimbursement you received from your health insurance provider in 2019 for journey costs.</p>
<p><strong>YOU CAN INCLUDE THE FOLLOWING JOURNEY COSTS:</strong></p>
<ul>
<li>to doctors</li>
<li>to the pharmacy</li>
<li>to the optician</li>
<li>to a therapist</li>
<li>to appointments for therapeutic treatment</li>
</ul>
<p>&nbsp;</p>

""", "", "Your healthcare costs", "How much has been  reimbursed?",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 85
      else if (widget.CheckCompleteQuestion ==
              "How much has been  reimbursed?" &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Glasses Ends ====== //

      // ====== Contact lenses Starts ====== //

      //Answer no 86
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on contact lenses?" &&
          widget.CheckQuestion == "Cost of contact lenses") {
        //Question No 87
        return healthyesnoContainer("""

<p><strong>Cost reimbursement for contact lenses</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for contact lense costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>REQUIREMENT</strong></p>
<p>The requirement for you to write off the costs is that the contact lenses are medically necessary. <strong>Colorful</strong> contact lenses your wore as part of your Halloween costume are not covered by this.</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of contact lenses?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 87
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of contact lenses?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of contact lenses?');
          _insert('Did health insurance reimburse the cost of contact lenses?',
              'No', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of contact lenses?');
          _insert('Did health insurance reimburse the cost of contact lenses?',
              'skip', 'skip');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of contact lenses?');
          _insert('Did health insurance reimburse the cost of contact lenses?',
              'Yes', 'OK');
          //Question No 88
          return healthcalculationContainer("""

<p><strong>Cost reimbursement for contact lenses</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for contact lense costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>REQUIREMENT</strong></p>
<p>The requirement for you to write off the costs is that the contact lenses are medically necessary. <strong>Colorful</strong> contact lenses your wore as part of your Halloween costume are not covered by this.</p>
<p>&nbsp;</p>

""", "", "Your healthcare costs", "How much has been reimburse?",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 88
      else if (widget.CheckCompleteQuestion == "How much has been reimburse?" &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Contact lenses Ends ====== //

      // ====== hearing aids Start  ====== //

      //Answer no 89
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on hearing aids?" &&
          widget.CheckQuestion == "Cost of hearing aid") {
        //Question No 90
        return healthyesnoContainer("""

<p><strong>Costs reimbursement for hearing aids</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for hearing aid costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of hearing aids?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 90
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of hearing aids?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of hearing aids?');
          _insert('Did health insurance reimburse the cost of hearing aids?',
              'No', 'OK');
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of hearing aids?');
          _insert('Did health insurance reimburse the cost of hearing aids?',
              'skip', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of hearing aids?');
          _insert('Did health insurance reimburse the cost of hearing aids?',
              'Yes', 'OK');
          //Question No 91
          return healthcalculationContainer("""

<p><strong>Cost reimbursement for contact lenses</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for contact lense costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>REQUIREMENT</strong></p>
<p>The requirement for you to write off the costs is that the contact lenses are medically necessary. <strong>Colorful</strong> contact lenses your wore as part of your Halloween costume are not covered by this.</p>
<p>&nbsp;</p>

""", "", "Your healthcare costs", "How much has reimburse?",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 91
      else if (widget.CheckCompleteQuestion == "How much has reimburse?" &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== hearing aids Ends  ====== //

      // ====== Dental treatment Starts ====== //

      //Answer no 92
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on dental implants, dentures, etc.?" &&
          widget.CheckQuestion == "Cost of dental treatments") {
        //Question No 93
        return healthyesnoContainer("""

<p><strong>Cost reimbursement for dental prostheses</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for dental prostheses costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the cost dental treatments?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 93
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the cost dental treatments?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of dental treatments?');
          _insert(
              'Did health insurance reimburse the cost of dental treatments?',
              'No',
              'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of dental treatments?');
          _insert(
              'Did health insurance reimburse the cost of dental treatments?',
              'skip',
              'skip');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of dental treatments?');
          _insert(
              'Did health insurance reimburse the cost of dental treatments?',
              'Yes',
              'OK');
          //Question No 94
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed? ",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 94
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed? " &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Dental treatment Ends ====== //

      // ====== Wheelchair / walking aid Starts ====== //

      //Answer no 95
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend overall on wheelchairs or walking aids?" &&
          widget.CheckQuestion == "Costs for wheelchair") {
        //Question No 96
        return healthyesnoContainer("""

<p><strong>Cost reimbursement for wheelchair or walking aids</strong></p>
<p>If you received subsidies from your health insurance provider in 2019 for wheelchair and walking aid costs, select "Yes". This is also the case if you only received partial reimbursement.</p>
<p><strong>We ask for the amount of reimbursement later.</strong></p>
<p>If you did not receive any subsidies then select "No".</p>
<p><strong>REQUIREMENT</strong></p>
<p>If your wheelchair or walking aid is medically necessary you can enter it here. Particularly healthy people will need a doctor's note proving this is the case.</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of a wheelchair or walking aid?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 96
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the cost of a wheelchair or walking aid?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of a wheelchair or walking aid?');
          _insert(
              'Did health insurance reimburse the cost of a wheelchair or walking aid?',
              'No',
              'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of a wheelchair or walking aid?');
          _insert(
              'Did health insurance reimburse the cost of a wheelchair or walking aid?',
              'skip',
              'skip');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse the cost of a wheelchair or walking aid?');
          _insert(
              'Did health insurance reimburse the cost of a wheelchair or walking aid?',
              'Yes',
              'OK');
          //Question No 97
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed?  ",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 97
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?  " &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Wheelchair / walking aid Ends ====== //

      // ====== Hospital stay Starts ====== //

      //Answer no 98
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} pay for your stay in hospital?" &&
          widget.CheckQuestion == "Accommodation costs") {
        //Question No 99
        return healthyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse the accommodation costs for your hospital stay?",
            "Healthcare reimbursement",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 99
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse the accommodation costs for your hospital stay?" &&
          widget.CheckQuestion == "Healthcare reimbursement") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'health insurance reimburse the accommodation costs for your hospital stay?');
          _insert(
              'health insurance reimburse the accommodation costs for your hospital stay?',
              'No',
              'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'health insurance reimburse the accommodation costs for your hospital stay?');
          _insert(
              'health insurance reimburse the accommodation costs for your hospital stay?',
              'skip',
              'skip');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'health insurance reimburse the accommodation costs for your hospital stay?');
          _insert(
              'health insurance reimburse the accommodation costs for your hospital stay?',
              'Yes',
              'OK');
          //Question No 100
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed?   ",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 100
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?   " &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Hospital stay Ends ====== //

      // ====== Nursing care Starts ====== //

      //Answer no 101
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on nursing care?" &&
          widget.CheckQuestion == "Nursing care costs") {
        //Question No 102
        return healthyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYourIdentity} health insurance reimburse ${Questions.healthYourIdentity} nursing care costs?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 102
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYourIdentity} health insurance reimburse ${Questions.healthYourIdentity} nursing care costs?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse nursing care costs?');
          _insert(
              'Did health insurance reimburse nursing care costs?', 'No', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse nursing care costs?');
          _insert('Did health insurance reimburse nursing care costs?', 'skip',
              'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse nursing care costs?');
          _insert('Did health insurance reimburse nursing care costs?', 'Yes',
              'OK');
          //Question No 103
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed?    ",
              "Reimbursement amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 103
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?    " &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Nursing care Ends ====== //

      // ====== Health course Starts ====== //

      //Answer no 104
      else if (widget.CheckCompleteQuestion ==
              "How much have ${Questions.healthYouIdentity} spent on healthcare workshops?" &&
          widget.CheckQuestion == "Healthcare workshops") {
        //Question No 105
        return healthyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Your healthcare costs",
            "Has ${Questions.healthYourIdentity} health insurance reimbursed ${Questions.healthYourIdentity} healthcare workshop costs?",
            "Reimbursements",
            220.0,
            "",
            "",
            "");
      }

      //Answer no 105
      else if (widget.CheckCompleteQuestion ==
              "Has ${Questions.healthYourIdentity} health insurance reimbursed ${Questions.healthYourIdentity} healthcare workshop costs?" &&
          widget.CheckQuestion == "Reimbursements") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse healthcare workshop costs?');
          _insert(
              'Did health insurance reimburse nursing care costs?', 'No', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse healthcare workshop costs?');
          _insert('Did health insurance reimburse nursing care costs?', 'skip',
              'skip');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did health insurance reimburse healthcare workshop costs?');
          _insert('Did health insurance reimburse nursing care costs?', 'Yes',
              'OK');

          //Question No 106
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed?     ",
              "Refund amount", 220.0, "calculation", "", "");
        }
      }

      //Answer No 106
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?     " &&
          widget.CheckQuestion == "Refund amount") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ====== Health course Ends ====== //

      // ======= Other costs Starts ====== //

      //Answer no 107
      else if (widget.CheckCompleteQuestion ==
              "What additional costs did ${Questions.healthYouIdentity} have (e.g. physical therapy, naturopathy homeopathy or rehabilitation costs)?" &&
          widget.CheckQuestion == "Other costs") {
        //Question No 108
        return healthcalculationContainer("""
<p><strong>Your other health costs</strong></p>
<p>You incurred additional costs related to your health.</p>
<p>Therefore please enter here how much you spent for treatments by an alternative practitioner, homeopath or similar.</p>
<p>Please enter the total amount. Note that these expenditures must have been prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Your healthcare costs",
            "How much did ${Questions.healthYouIdentity} spend on other costs?",
            "Amount of other costs",
            220.0,
            "calculation",
            "",
            "");
      }

      //Answer no 108
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on other costs?" &&
          widget.CheckQuestion == "Amount of other costs") {
        //Question No 109
        return healthyesnoContainer("""

<p><strong>Reimbursement by health insurer</strong></p>
<p>If you received reimbursement from your health insurance provider in 2019 for the sickness costs you entered, select "Yes". This is also the case if you only received <strong>partial reimbursement</strong>.</p>
<p>If you did not receive any reimbursement then select "No".</p>
<p>You can find this information in your health documents. Your health insurer should have sent you a confirmation about the reimbursement.</p>
<p>&nbsp;</p>

""",
            "",
            "Your healthcare costs",
            "Did ${Questions.healthYouIdentity} receive reimbursement for this from ${Questions.healthYourIdentity} health insurance?",
            "Reimbursement of costs from health insurance",
            220.0,
            "",
            "",
            "");
      }

      //Answer no 109
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive reimbursement for this from ${Questions.healthYourIdentity} health insurance?" &&
          widget.CheckQuestion ==
              "Reimbursement of costs from health insurance") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive reimbursement for this from health insurance?');
          _insert('Did receive reimbursement for this from health insurance?',
              'No', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive reimbursement for this from health insurance?');
          _insert('Did receive reimbursement for this from health insurance?',
              'skip', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 76(Partner)
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
                "Nursing", 430.0, "", "", "");
          } else {
            //Question No 76
            return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
                "",
                "Care of others",
                "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
                "Free care of others",
                430.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive reimbursement for this from health insurance?');
          _insert('Did receive reimbursement for this from health insurance?',
              'Yes', 'OK');

          //Question No 110
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""", "", "Your healthcare costs", "How much has been reimbursed?",
              "Health insurance reimbursement", 220.0, "calculation", "", "");
        }
      }

      //Answer No 110
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?" &&
          widget.CheckQuestion == "Health insurance reimbursement") {
        if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          //Question No 76(Partner)
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""", "", "Care of others", "Did either of you nurse a close person at home?",
              "Nursing", 430.0, "", "", "");
        } else {
          //Question No 76
          return healthyesnoContainer("""
<p><strong>Care of a person in their home</strong></p>
<p>Please state whether your provided care to a person close to you without payment in 2019. If this applies to you, then choose "Yes". Otherwise click "No".</p>
<p><strong>WHO COUNTS AS SOMEONE CLOSE TO YOU?</strong></p>
<ul>
<li>in-laws</li>
<li>friends</li>
<li>acquaintances</li>
<li>neighbours</li>
</ul>
<p><strong>WHEN DOES A PERSON COUNT AS IN NEED OF CARE?</strong></p>
<p>"People who due to a physical, mental or emotional illness or disability require a considerable or great degree of assistance to carry out their usual recurring daily activities in the long term. This is expected to be for at least six months" (&sect; 14 SGB XI).</p>
<p><strong>YOUR TAXES</strong></p>
<p>If you care for the person close to you free of charge, then you can make use of the <strong>standard care allowance up to a maximum 924 euros per year.</strong></p>
<p><strong>Important:</strong></p>
<p>If other people care for this person as well, then the <strong>standard care allowance is divided by the number of caring people.</strong></p>
<p><strong>&nbsp;</strong></p>
""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} nurse another person at home without payment?",
              "Free care of others",
              430.0,
              "",
              "",
              "");
        }
      }

      // ======= Other costs Ends ====== //

      // ====== Non work related Medical Expense Ends ====== //

      //Answer No 76 and 76 (Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "Did ${Questions.healthYouIdentity} nurse another person at home without payment?" ||
              widget.CheckCompleteQuestion ==
                  "Did either of you nurse a close person at home?") &&
          (widget.CheckQuestion == "Free care of others" ||
              widget.CheckQuestion == "Nursing")) {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'nurse another person at home without payment?');
          _insert('nurse another person at home without payment?', 'No', 'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 119(Partner)
            return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""", "", "Costs funeral", "Did one or both of you have any funeral costs?",
                "Costs funerals both", 220.0, "", "", "");
          } else {
            //Question No 119
            return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Costs funeral",
                "Did ${Questions.healthYouIdentity} have any funeral costs?",
                "Funeral costs",
                220.0,
                "",
                "",
                "");
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'nurse another person at home without payment?');
          _insert(
              'nurse another person at home without payment?', 'skip', 'skip');

          //Question No 119
          return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Costs funeral",
              "Did ${Questions.healthYouIdentity} have any funeral costs?",
              "Funeral costs",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'nurse another person at home without payment?');
          _insert('nurse another person at home without payment?', 'Yes', 'OK');
          //Question No 111
          return healthyesnoContainer("""

<p><strong>Care of several people</strong></p>
<p>Please state whether you provided care to more than one person in 2019.</p>
<p>Choose here '"Yes" if you cared for at least 2 people. If you cared for one person, choose "No".</p>
<p>&nbsp;</p>

""",
              "",
              "Care of others",
              "Did ${Questions.healthYouIdentity} care for more than one person?",
              "Care for multiple persons",
              220.0,
              "",
              "",
              "");
        }
      }

      //Answer No 111
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} care for more than one person?" &&
          widget.CheckQuestion == "Care for multiple persons") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Care for multiple persons');
          _insert('Care for multiple persons', 'No', 'OK');

          //Question No 114
          return healthcalculationContainer("""

<p><strong>Name of person in need of care</strong></p>
<p>What's the name of the person you care for?</p>
<p>Please enter here the <strong>first and last name</strong> of the person in need of care.</p>
<p>&nbsp;</p>

""",
              "",
              "Care of others",
              "What is the full name of the person ${Questions.healthYouIdentity} cared for?",
              "Name of the person",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Care for multiple persons');
          _insert('Care for multiple persons', 'skip', 'skip');

          //Question No 114
          return healthcalculationContainer("""

<p><strong>Name of person in need of care</strong></p>
<p>What's the name of the person you care for?</p>
<p>Please enter here the <strong>first and last name</strong> of the person in need of care.</p>
<p>&nbsp;</p>

""",
              "",
              "Care of others",
              "What is the full name of the person ${Questions.healthYouIdentity} cared for?",
              "Name of the person",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Care for multiple persons');
          _insert('Care for multiple persons', 'Yes', 'OK');

          //Question No 112
          return healthcalculationContainer("""

<p><strong>Care of several people</strong></p>
<p>Please state whether you provided care to more than one person in 2019.</p>
<p>Choose here '"Yes" if you cared for at least 2 people. If you cared for one person, choose "No".</p>
<p>&nbsp;</p>

""",
              "",
              "Care of others",
              "How many people did ${Questions.healthYouIdentity} take care of?",
              "Number of people cared for",
              220.0,
              "loop",
              "",
              "");
        }
      }

      //Answer No 112
      else if (widget.CheckCompleteQuestion ==
              "How many people did ${Questions.healthYouIdentity} take care of?" &&
          widget.CheckQuestion == "Number of people cared for") {
        DbHelper.insatance.deleteWithquestion('Number of people cared for');
        _insert('Number of people cared for', Questions.peopleCareText, 'OK');

        //Question No 113
        return healthcalculationContainer("""

<p><strong>Name of person in need of care</strong></p>
<p>What's the name of the person you care for?</p>
<p>Please enter here the <strong>first and last name</strong> of the person in need of care.</p>
<p>&nbsp;</p>

""",
            "",
            "Care of others",
            "What is the full name of the person that has been cared for?",
            "Name of the person",
            220.0,
            "",
            Questions.peopleCareText,
            "");
      }

      //Answer no 113 and Answer No 114
      else if ((widget.CheckCompleteQuestion ==
                  "What is the full name of the person that has been cared for?" ||
              widget.CheckCompleteQuestion ==
                  "What is the full name of the person ${Questions.healthYouIdentity} cared for?") &&
          widget.CheckQuestion == "Name of the person") {
        DbHelper.insatance.deleteWithquestion(
            'What is the full name of the person that has been cared for?');
        _insert('What is the full name of the person that has been cared for?',
            Questions.peopleCareText, 'OK');

        //Question No 115
        return healthaddressContainer("""

<p><strong>Address of person in need of care</strong></p>
<p>What's the Address of the person you care for?</p>
<p>Please enter here the <strong>Address</strong> of the person in need of care.</p>
<p>&nbsp;</p>

""",
            "",
            "Care of others",
            "What is the address of the person ${Questions.healthYouIdentity} cared for?",
            "Address of the person",
            220.0,
            "",
            Questions.peopleCareText,
            "");
      }

      //Answer no 115
      else if (widget.CheckCompleteQuestion ==
              "What is the address of the person ${Questions.healthYouIdentity} cared for?" &&
          widget.CheckQuestion == "Address of the person") {
        DbHelper.insatance
            .deleteWithquestion('What is the address of the person cared for?');
        _insert('What is the address of the person cared for?',
            Questions.peopleCareText, 'OK');

        //Question No 116
        return healthcalculationContainer("""

<p><strong>Relationship with person in need of care</strong></p>
<p>Please enter here what relationship you have to the person in need of care. If the person is a sibling, you enter "related" in the field.</p>
<p>There must be a close personal relationship between you and the person in need of care for the tax office to recognise the costs.</p>
<p>So, you should be <strong>related to or at least very good friends</strong> with this person. This may be the case, for example, in the following relationships:</p>
<ul>
<li>grandparents</li>
<li>parents</li>
<li>siblings</li>
<li>children</li>
<li>other relatives</li>
<li>friends</li>
<li>neighbours</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Care of others",
            "What kind of relationship is there to the person nursed?",
            "Relationship to this person",
            220.0,
            "",
            Questions.peopleCareText,
            "");
      }

      //Answer no 116
      else if (widget.CheckCompleteQuestion ==
              "What kind of relationship is there to the person nursed?" &&
          widget.CheckQuestion == "Relationship to this person") {
        DbHelper.insatance.deleteWithquestion(
            'What kind of relationship is there to the person nursed?');
        _insert('What kind of relationship is there to the person nursed?',
            Questions.peopleCareText, 'OK');

        //Question No 117
        return healthyesnoContainer("""

<p><strong>Number of carers</strong></p>
<p>Specify the exact number of other people who also cared for the person in need of care.</p>
<p><strong>The care costs must be divided by the number of carers.</strong></p>
<p>** Important:**</p>
<p>If other people help you to care for this person, then the standard care allowance is also divided by the number of carers. A professional nursing service or similar does not count.</p>
<p>&nbsp;</p>

""",
            "",
            "Care of others",
            "Did other people help ${Questions.healthYouIdentity} to care for this person?",
            "Other carers",
            220.0,
            "",
            Questions.peopleCareText,
            "");
      }

      //Answer No 117
      else if (widget.CheckCompleteQuestion ==
              "Did other people help ${Questions.healthYouIdentity} to care for this person?" &&
          widget.CheckQuestion == "Other carers") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did other people help to care for this person?');
          _insert('Did other people help to care for this person?', 'No', 'OK');

          if (Questions.peopleCareLength <= Questions.totalPeopleCare &&
              Questions.totalPeopleCare > 0) {
            //Question No 113
            return healthcalculationContainer("""

<p><strong>Name of person in need of care</strong></p>
<p>What's the name of the person you care for?</p>
<p>Please enter here the <strong>first and last name</strong> of the person in need of care.</p>
<p>&nbsp;</p>

""",
                "",
                "Care of others",
                "What is the full name of the person that has been cared for?",
                "Name of the person",
                220.0,
                "",
                Questions.peopleCareText,
                "");
          } else {
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 119(Partner)
              return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""", "", "Costs funeral", "Did one or both of you have any funeral costs?",
                  "Costs funerals both", 220.0, "", "", "");
            } else {
              //Question No 119
              return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""",
                  "",
                  "Costs funeral",
                  "Did ${Questions.healthYouIdentity} have any funeral costs?",
                  "Funeral costs",
                  220.0,
                  "",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did other people help to care for this person?');
          _insert(
              'Did other people help to care for this person?', 'skip', 'skip');

          if (Questions.peopleCareLength <= Questions.totalPeopleCare &&
              Questions.totalPeopleCare > 0) {
            //Question No 113
            return healthcalculationContainer("""

<p><strong>Name of person in need of care</strong></p>
<p>What's the name of the person you care for?</p>
<p>Please enter here the <strong>first and last name</strong> of the person in need of care.</p>
<p>&nbsp;</p>

""",
                "",
                "Care of others",
                "What is the full name of the person that has been cared for?",
                "Name of the person",
                220.0,
                "",
                Questions.peopleCareText,
                "");
          } else {
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 119(Partner)
              return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""", "", "Costs funeral", "Did one or both of you have any funeral costs?",
                  "Costs funerals both", 220.0, "", "", "");
            } else {
              //Question No 119
              return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""",
                  "",
                  "Costs funeral",
                  "Did ${Questions.healthYouIdentity} have any funeral costs?",
                  "Funeral costs",
                  220.0,
                  "",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did other people help to care for this person?');
          _insert(
              'Did other people help to care for this person?', 'Yes', 'OK');

          //Question No 118
          return healthcalculationContainer("""

<p><strong>Number of carers</strong></p>
<p>Specify the exact number of other people who also cared for the person in need of care.</p>
<p><strong>The care costs must be divided by the number of carers.</strong></p>
<p>** Important:**</p>
<p>If other people help you to care for this person, then the standard care allowance is also divided by the number of carers. A professional nursing service or similar does not count.</p>
<p>&nbsp;</p>

""", "", "Care of others", "How many other carers were there?",
              "Number of carers", 220.0, "", Questions.peopleCareText, "");
        }
      }

      //Answer no 118
      else if (widget.CheckCompleteQuestion ==
              "How many other carers were there?" &&
          widget.CheckQuestion == "Number of carers") {
        DbHelper.insatance
            .deleteWithquestion('How many other carers were there?');
        _insert('How many other carers were there?', Questions.peopleCareText,
            'OK');

        if (Questions.peopleCareLength <= Questions.totalPeopleCare &&
            Questions.totalPeopleCare > 0) {
          //Question No 113
          return healthcalculationContainer("""

<p><strong>Name of person in need of care</strong></p>
<p>What's the name of the person you care for?</p>
<p>Please enter here the <strong>first and last name</strong> of the person in need of care.</p>
<p>&nbsp;</p>

""",
              "",
              "Care of others",
              "What is the full name of the person that has been cared for?",
              "Name of the person",
              220.0,
              "",
              Questions.peopleCareText,
              "");
        } else {
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 119(Partner)
            return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""", "", "Costs funeral", "Did one or both of you have any funeral costs?",
                "Costs funerals both", 220.0, "", "", "");
          } else {
            //Question No 119
            return healthyesnoContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Costs funeral",
                "Did ${Questions.healthYouIdentity} have any funeral costs?",
                "Funeral costs",
                220.0,
                "",
                "",
                "");
          }
        }
      }

      //Answer No 119 and 119(Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "Did ${Questions.healthYouIdentity} have any funeral costs?" ||
              widget.CheckCompleteQuestion ==
                  "Did one or both of you have any funeral costs?") &&
          (widget.CheckQuestion == "Funeral costs" ||
              widget.CheckQuestion == "Costs funerals both")) {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Funeral costs');
          _insert('Funeral costs', 'No', 'OK');

          return FinishCategory("Health Category", "Finance Category", 5, true);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Funeral costs');
          _insert('Funeral costs', 'skip', 'OK');
          return FinishCategory("Health Category", "Finance Category", 5, true);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Funeral costs');
          _insert('Funeral costs', 'Yes', 'OK');
          //Question No 120
          return healthcalculationContainer("""

<p><strong>Funeral costs</strong></p>
<p>Please state whether you had any funeral expenses in <strong>2019</strong>. If this applies to you, then choose "Yes". Otherwise, click "No" to continue.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>You may only deduct funeral expenses for close relatives and loved ones. In some exceptions this also applies to close friends.</p>
<p><strong>COSTS FROM DEATH OF INDIVIDUAL:</strong></p>
<ul>
<li>death certificate</li>
<li>medical expenses</li>
<li>death certificate</li>
<li>coffin / urn</li>
</ul>
<p><strong>COSTS FOR FUNERAL SERVICE:</strong></p>
<ul>
<li>flowers</li>
<li>church</li>
<li>speaker / pastor</li>
</ul>
<p><strong>COSTS FOR GRAVE:</strong></p>
<ul>
<li>grave preparation</li>
<li>grave maintenance</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Costs funeral",
              "How much did ${Questions.healthYouIdentity} spend on the funeral?",
              "Amount of funeral costs",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 120
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.healthYouIdentity} spend on the funeral?" &&
          widget.CheckQuestion == "Amount of funeral costs") {
        //Question No 121
        return healthyesnoContainer("""

<p><strong>Inheritance</strong></p>
<p>Please state whether you received an inheritance in 2019.</p>
<p>This includes not only financial inheritance, but also real estate, or objects of value.</p>
<p><strong>You will be asked to enter the amount of the inheritance later.</strong></p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>&nbsp;</p>

""",
            "",
            "Costs funeral",
            "Did ${Questions.healthYouIdentity} receive an inheritance?",
            "Inheritance",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 121
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive an inheritance?" &&
          widget.CheckQuestion == "Inheritance") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Did receive an inheritance?');
          _insert('Did receive an inheritance?', 'No', 'OK');

          return FinishCategory("Health Category", "Finance Category", 5, true);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Did receive an inheritance?');
          _insert('Did receive an inheritance?', 'skip', 'skip');
          return FinishCategory("Health Category", "Finance Category", 5, true);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Did receive an inheritance?');
          _insert('Did receive an inheritance?', 'Yes', 'OK');
          //Question No 122
          return healthcalculationContainer("""

<p><strong>Tax value of heritage</strong></p>
<p>Please enter the total tax value of the inheritance that you received. This includes not only cash assets, but also bank deposits, securities, the market value of real estate, jewellery, or funeral expense insurance. If you are the beneficiary of the deceased's life insurance you need to also include this amount.</p>
<p><em>Attention</em>: If the inheritance you are entitled to is higher than the expenditure for the funeral, you cannot write the funeral expenses off! Only funeral costs which exceed the inheritance you are entitled to are tax deductible.</p>
<p>&nbsp;</p>

""", "", "Costs funeral", "What was the total tax value of the inheritance?",
              "Value of inheritance", 220.0, "calculation", "", "");
        }
      }

      //Answer No 122
      else if (widget.CheckCompleteQuestion ==
              "What was the total tax value of the inheritance?" &&
          widget.CheckQuestion == "Value of inheritance") {
        return FinishCategory("Health Category", "Finance Category", 5, true);
      }

      // ======= Have a disability certificate Starts (After Relation) ======= //

      //Answer No 132
      else if (widget.CheckCompleteQuestion ==
              "Do ${Questions.healthYouIdentity} have a disability certificate or confirmation from the social services office?" &&
          widget.CheckQuestion == "Disability certificate available") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Do have a disability certificate or confirmation from the social services office?');
          _insert(
              'Do have a disability certificate or confirmation from the social services office?',
              'No',
              'OK');

          //For partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.healthPartner == true) {
            healthPartner();
            return healthmultithreeContainer(
                """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
                "Kind of health insurance",
                ["Statutory", "Private", "Family", "None of them"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "None of them",
                "",
                "");
          } else {
            if (Questions.childrenYesHealth == "Childrenyes") {
              DbHelper.insatance.deleteWithquestion(
                  'Do have a disability certificate or confirmation from the social services office?');
              _insert(
                  'Do have a disability certificate or confirmation from the social services office?',
                  'Childrenyes',
                  'OK');

              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 131(Partner)
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did you both have for your family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 131
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            } else {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            }
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Do have a disability certificate or confirmation from the social services office?');
          _insert(
              'Do have a disability certificate or confirmation from the social services office?',
              'skip',
              'skip');

          //For partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.healthPartner == true) {
            healthPartner();
            return healthmultithreeContainer(
                """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
                "",
                "Health",
                "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
                "Kind of health insurance",
                ["Statutory", "Private", "Family", "None of them"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "None of them",
                "",
                "");
          } else {
            if (Questions.childrenYesHealth == "Childrenyes") {
              DbHelper.insatance.deleteWithquestion(
                  'Do have a disability certificate or confirmation from the social services office?');
              _insert(
                  'Do have a disability certificate or confirmation from the social services office?',
                  'Childrenyes',
                  'OK');
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 131(Partner)
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did you both have for your family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 131
                return healthmultipleoptionsContainer(
                    """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                    "",
                    "Your healthcare costs",
                    "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                    "Medical expenses",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            } else {
              //For you & partner
              if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
                healthYouPartner();
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              } else {
                //Question No 72
                return healthmultipleoptionsContainer(
                    "<h1>Coming Soon!</h1>",
                    "",
                    "Your healthcare costs",
                    "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                    "Treatment costs",
                    [
                      "Prescribed medication",
                      "Treatment by a doctor",
                      "Trips to the doctor or to treatments",
                      "Operations",
                      "Glasses",
                      "Contact lenses",
                      "Hearing aid",
                      "Dental treatment",
                      "Wheelchair / walking aid",
                      "Hospital stay",
                      "Nursing care",
                      "Health course",
                      "Other costs",
                      "None"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    220.0,
                    "None",
                    "",
                    "");
              }
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Do have a disability certificate or confirmation from the social services office?');
          _insert(
              'Do have a disability certificate or confirmation from the social services office?',
              'Childrenyes',
              'OK');
          //Question No 133
          return healthdateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Health",
              "Since when is the disability certificate valid?",
              "Valid since",
              220.0,
              "",
              "",
              "");
        }

        //  else if (widget.CheckAnswer[0] == "skip") {
        //   //Question No 133
        //   return healthdateContainer(
        //       "",
        //       "Health",
        //       "Since when is the disability certificate valid?",
        //       "Valid since",
        //       220.0,
        //       "",
        //       "",
        //       "");
        // }
      }

      //Answer No 133
      else if (widget.CheckCompleteQuestion ==
              "Since when is the disability certificate valid?" &&
          widget.CheckQuestion == "Valid since") {
        //Question No 134
        return healthyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "Is the certificate valid indefinitely?",
            "Valid indefinitely",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 134
      else if (widget.CheckCompleteQuestion ==
              "Is the certificate valid indefinitely?" &&
          widget.CheckQuestion == "Valid indefinitely") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Is the certificate valid indefinitely?');
          _insert('Is the certificate valid indefinitely?', 'No', 'OK');

          //Question No 135
          return healthdateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Health",
              "Until when is the disability certificate valid?",
              "Valid until",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Is the certificate valid indefinitely?');
          _insert('Is the certificate valid indefinitely?', 'skip', 'skip');

          //Question No 135
          return healthdateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Health",
              "Until when is the disability certificate valid?",
              "Valid until",
              220.0,
              "",
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Is the certificate valid indefinitely?');
          _insert('Is the certificate valid indefinitely?', 'Yes', 'OK');

          //Question No 136
          return healthcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Health",
              "What is the degree of disability?",
              "Degree of disability",
              430.0,
              "percentage",
              "",
              "");
        }
      }

      //Answer No 135
      else if (widget.CheckCompleteQuestion ==
              "Until when is the disability certificate valid?" &&
          widget.CheckQuestion == "Valid until") {
        //Question No 136
        return healthcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "What is the degree of disability?",
            "Degree of disability",
            430.0,
            "percentage",
            "",
            "");
      }

      //Answer No 136
      else if (widget.CheckCompleteQuestion ==
              "What is the degree of disability?" &&
          widget.CheckQuestion == "Degree of disability") {
        //Question No 137
        return healthdifferentoptionContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Health",
            "Does one of these apply to ${Questions.healthYouIdentity}?",
            "Criteria",
            [
              "Blind (code BI)",
              "I am permanently helpless (code H)",
              "I'm handicapped (codes G / aG)",
              "None of these"
            ],
            220.0,
            "",
            "",
            "");
      }

      //Answer No 137
      else if (widget.CheckCompleteQuestion ==
              "Does one of these apply to ${Questions.healthYouIdentity}?" &&
          widget.CheckQuestion == "Criteria") {
        //For partner
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.healthPartner == true) {
          healthPartner();
          return healthmultithreeContainer(
              """
<p><strong>Health insurance</strong></p>
<p><strong>STATUTORY</strong></p>
<p>Statutory health insurance contributions are usually deducted from your salary. Your employer does this for you.</p>
<p><strong>PRIVATE</strong></p>
<p>Contributions to the private health insurance are paid by yourself to the health insurance and are based on a contract between you and the insurance company.</p>
<p><strong>FAMILY</strong></p>
<p>If you do not have your own contributions and you are insured through your parents or partner, you can select this here.</p>
<p>&nbsp;</p>
""",
              "",
              "Health",
              "What kind of basic health insurance did ${Questions.healthYouIdentity} have in 2019?",
              "Kind of health insurance",
              ["Statutory", "Private", "Family", "None of them"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "None of them",
              "",
              "");
        }

        //For you & partner
        else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          healthYouPartner();
          //Question No 138(Partner)
          return healthyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Additional disability costs",
              "Did one or both of you have to change your home in 2019 due to disability?",
              "Home Modifications",
              220.0,
              "",
              "",
              "");
        } else {
          //Question No 138
          //For No 430.0
          //For Yes 220.0
          return healthyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Additional disability costs",
              "Did ${Questions.healthYouIdentity} have to make any changes to ${Questions.healthYourIdentity} home in 2019 due to ${Questions.healthYourIdentity} disability?",
              "Home Modifications",
              220.0,
              "",
              "",
              "");
        }
      }

      //Answer No 138 And Answer No 138 (Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "Did ${Questions.healthYouIdentity} have to make any changes to ${Questions.healthYourIdentity} home in 2019 due to ${Questions.healthYourIdentity} disability?" ||
              widget.CheckCompleteQuestion ==
                  "Did one or both of you have to change your home in 2019 due to disability?") &&
          widget.CheckQuestion == "Home Modifications") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did one or both of you have to change your home in 2019 due to disability?');
          _insert(
              'Did one or both of you have to change your home in 2019 due to disability?',
              'No',
              'OK');

          if (Questions.childrenYesHealth == "Childrenyes") {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 131(Partner)
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did you both have for your family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 131
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          } else {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did one or both of you have to change your home in 2019 due to disability?');
          _insert(
              'Did one or both of you have to change your home in 2019 due to disability?',
              'skip',
              'skip');

          if (Questions.childrenYesHealth == "Childrenyes") {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 131(Partner)
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did you both have for your family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 131
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          } else {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did one or both of you have to change your home in 2019 due to disability?');
          _insert(
              'Did one or both of you have to change your home in 2019 due to disability?',
              'Yes',
              'OK');

          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 139(Partner)
            return healthcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Additional disability costs",
                "How much were the total costs in 2019 for changes made to your home?",
                "Home renovation costs",
                220.0,
                "calculation",
                "",
                "");
          } else {
            //Question No 139
            return healthcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Additional disability costs",
                "How much did ${Questions.healthYouIdentity} spend in total in 2019 for changes made to ${Questions.healthYourIdentity} home?",
                "Home renovation costs",
                220.0,
                "calculation",
                "",
                "");
          }
        }
      }

      //Answer No 139 and Answer No 139(Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "How much did ${Questions.healthYouIdentity} spend in total in 2019 for changes made to ${Questions.healthYourIdentity} home?" ||
              widget.CheckCompleteQuestion ==
                  "How much were the total costs in 2019 for changes made to your home?") &&
          widget.CheckQuestion == "Home renovation costs") {
        //Question No 140
        //For No 430.0
        //For Yes 220.0
        return healthyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Additional disability costs",
            "Did ${Questions.healthYouIdentity} receive any reimbursements for the costs of renovating ${Questions.healthYourIdentity} home?",
            "Reimbursements for home renovation",
            220.0,
            "",
            "",
            "");
      }

      //Answer No 140
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.healthYouIdentity} receive any reimbursements for the costs of renovating ${Questions.healthYourIdentity} home?" &&
          widget.CheckQuestion == "Reimbursements for home renovation") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursements for the costs of renovating home?');
          _insert(
              'Did receive any reimbursements for the costs of renovating home?',
              'No',
              'OK');

          if (Questions.childrenYesHealth == "Childrenyes") {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 131(Partner)
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did you both have for your family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 131
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          } else {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursements for the costs of renovating home?');
          _insert(
              'Did receive any reimbursements for the costs of renovating home?',
              'skip',
              'skip');

          if (Questions.childrenYesHealth == "Childrenyes") {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 131(Partner)
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did you both have for your family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 131
              return healthmultipleoptionsContainer(
                  """
<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>
""",
                  "",
                  "Your healthcare costs",
                  "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                  "Medical expenses",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          } else {
            //For you & partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            } else {
              //Question No 72
              return healthmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Your healthcare costs",
                  "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                  "Treatment costs",
                  [
                    "Prescribed medication",
                    "Treatment by a doctor",
                    "Trips to the doctor or to treatments",
                    "Operations",
                    "Glasses",
                    "Contact lenses",
                    "Hearing aid",
                    "Dental treatment",
                    "Wheelchair / walking aid",
                    "Hospital stay",
                    "Nursing care",
                    "Health course",
                    "Other costs",
                    "None"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "None",
                  "",
                  "");
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did receive any reimbursements for the costs of renovating home?');
          _insert(
              'Did receive any reimbursements for the costs of renovating home?',
              'Yes',
              'OK');

          //Question No 141
          return healthcalculationContainer("""

<p><strong>Costs of medical treatment</strong></p>
<p>Enter the sum of the costs for medical treatments that were reimbursed in 2019 by your health insurance.</p>
<p>Costs for medical treatment include the following, for example:</p>
<ul>
<li>doctor</li>
<li>speech therapist</li>
<li>psychotherapist</li>
<li>physiotherapist</li>
<li>massage</li>
<li>hot packs</li>
<li>baths</li>
<li>enemas</li>
<li>spas and cures</li>
<li>vaccinations prior to traveling abroad</li>
</ul>
<p><strong>PRESCRIPTION</strong></p>
<p>You can enter your costs without any problem as long as they were prescribed by a doctor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


""",
              "",
              "Additional disability costs",
              "How much has been reimbursed?             ",
              "Reimbursement amount",
              220.0,
              "calculation",
              "",
              "");
        }
      }

      //Answer No 141
      else if (widget.CheckCompleteQuestion ==
              "How much has been reimbursed?             " &&
          widget.CheckQuestion == "Reimbursement amount") {
        if (Questions.childrenYesHealth == "Childrenyes") {
          DbHelper.insatance
              .deleteWithquestion('How much has been reimbursed?');
          _insert('How much has been reimbursed?', 'Childrenyes', 'OK');

          //For you & partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 131(Partner)
            return healthmultipleoptionsContainer(
                """

<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "What special health costs did you both have for your family?",
                "Medical expenses",
                [
                  "Prescribed medication",
                  "Treatment by a doctor",
                  "Trips to the doctor or to treatments",
                  "Operations",
                  "Glasses",
                  "Contact lenses",
                  "Hearing aid",
                  "Dental treatment",
                  "Wheelchair / walking aid",
                  "Hospital stay",
                  "Nursing care",
                  "Health course",
                  "Other costs",
                  "None"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "None",
                "",
                "");
          } else {
            //Question No 131
            return healthmultipleoptionsContainer(
                """

<p><strong>Health expenses</strong></p>
<p>Choose the options below that apply to you. You can choose several answers.</p>
<p><strong>Important:</strong></p>
<p>If the treatment has been prescribed by a doctor, you can easily state the costs that you incurred in the year 2019. Also, if you have been reimbursed part of the cost, you can specify it here. We will ask again later what costs have been reimbursed.</p>
<ul>
<li><strong>Medication</strong>: Not only can you list prescription drugs, but all the prescriptions prescribed by your doctor. These can also be headache tablets or vitamin pills. Kindly note that the medication needs to fight a disease (therefore, the contraceptive pill or pills for prevention are not deductible).</li>
<li><strong>Medical treatments:</strong> This can include for example, expenses for speech therapists, psychotherapists, physiotherapists, massages, vaccinations before a stay abroad, etc.</li>
<li><strong>Trips to doctors or places of treatments</strong>: Here we mean trips to doctors, pharmacies, therapists, surgery, etc.</li>
<li><strong>Operations:</strong> Medically necessary operations to cure or alleviate diseases can be included here. The cost of cosmetic surgery is not included.</li>
<li><strong>Glasses</strong>: Choose this item if you have bought medically necessary glasses. Normal sunglasses do not count.</li>
<li><strong>Contact lenses:</strong> Choose this item if you have bought medically necessary contact lenses. Colored fashion contact lenses do not count.</li>
<li><strong>Hearing aids:</strong> Spending on hearing aids that were medically necessary.</li>
<li><strong>Braces / dentures / prostheses</strong>: Did you have expenses for dental aids or partial / prostheses? Then choose this option.</li>
<li><strong>Wheelchair / walking aid: If</strong> you needed a wheelchair or walking aid and paid for it yourself.</li>
<li>Hospital stay: ** Please select this item for costs of a medically necessary hospital stay.</li>
<li><strong>Nursing services:</strong> Did you have to pay for your own care, e.g. through a nursing service, then choose this option.</li>
<li>** Health courses: ** You have attended health courses that your doctor has prescribed for you. You cannot, however, deduct expenses for preventive courses.</li>
<li><strong>Other costs:</strong> If you have other costs that don't fit in these categories, then choose "other costs". These include, for example, medication fees in the pharmacy, naturopaths or homeopaths.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Your healthcare costs",
                "What special health costs did ${Questions.healthYouIdentity} have for ${Questions.healthYourIdentity} family?",
                "Medical expenses",
                [
                  "Prescribed medication",
                  "Treatment by a doctor",
                  "Trips to the doctor or to treatments",
                  "Operations",
                  "Glasses",
                  "Contact lenses",
                  "Hearing aid",
                  "Dental treatment",
                  "Wheelchair / walking aid",
                  "Hospital stay",
                  "Nursing care",
                  "Health course",
                  "Other costs",
                  "None"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "None",
                "",
                "");
          }
        } else {
          //For you & partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 72
            return healthmultipleoptionsContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Your healthcare costs",
                "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                "Treatment costs",
                [
                  "Prescribed medication",
                  "Treatment by a doctor",
                  "Trips to the doctor or to treatments",
                  "Operations",
                  "Glasses",
                  "Contact lenses",
                  "Hearing aid",
                  "Dental treatment",
                  "Wheelchair / walking aid",
                  "Hospital stay",
                  "Nursing care",
                  "Health course",
                  "Other costs",
                  "None"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "None",
                "",
                "");
          } else {
            //Question No 72
            return healthmultipleoptionsContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Your healthcare costs",
                "Which non work related medical expenses would ${Questions.healthYouIdentity} like to write off?",
                "Treatment costs",
                [
                  "Prescribed medication",
                  "Treatment by a doctor",
                  "Trips to the doctor or to treatments",
                  "Operations",
                  "Glasses",
                  "Contact lenses",
                  "Hearing aid",
                  "Dental treatment",
                  "Wheelchair / walking aid",
                  "Hospital stay",
                  "Nursing care",
                  "Health course",
                  "Other costs",
                  "None"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "None",
                "",
                "");
          }
        }
      }

      // ======= Have a disability certificate Ends (After Relation) ======= //

    }
  }

  Widget healthmultithreeContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      List AnswerImages,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthMultiThreeContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 370.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthyesnoContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthYesNoContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthcalculationContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthCalculationContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthmultipleoptionsContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      List AnswerImages,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthMultipleOptionsContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 430.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthmultitwoContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      List AnswerImages,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthMultiTwoContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 320.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthaddressContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthAddressContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 210.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthtwooptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthTwoOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 280.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthdateContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthDateContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  Widget healthdifferentoptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      String Suggestion) {
    Questions.healthAnimatedContainer = animatedcontainer;
    return HealthDifferentOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 420.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  void healthPartner() {
    qu.HealthAddAnswer("Partner", "", "", "", [], 60.0);
    Questions.healthPartner = false;

    Questions.healthYouIdentity = "your partner";
    Questions.healthYourIdentity = "your partner";

    Questions.healthChildrenLength = 0;
    Questions.totalHealthChildren = 0;
    Questions.healthChildrenText = "";

    Questions.peopleCareLength = 0;
    Questions.totalPeopleCare = 0;
    Questions.peopleCareText = "";
    Questions.doctorTripLength = 0;
    Questions.totalDoctorTrip = 0;
    Questions.doctorTripText = "";
  }

  void healthYouPartner() {
    qu.HealthAddAnswer("You & Partner", "", "", "", [], 60.0);
    Questions.healthYouPartner = false;

    Questions.healthYouIdentity = "you";
    Questions.healthYourIdentity = "your";

    Questions.peopleCareLength = 0;
    Questions.totalPeopleCare = 0;
    Questions.peopleCareText = "";
    Questions.doctorTripLength = 0;
    Questions.totalDoctorTrip = 0;
    Questions.doctorTripText = "";
  }
}

//For show and index of small container
class SingleSmallContainer extends StatelessWidget {
  int currentIndex;
  List answerSubList = [];
  SingleSmallContainer({this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("Small Container Current index is:" + currentIndex.toString());

          if (currentIndex == 0) {
            Questions.healthAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HealthMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.healthAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.healthAnswerShow = [];
            Questions.healthAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HealthMainQuestions(
                  CheckCompleteQuestion: Questions
                      .healthAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.healthAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.healthAnswerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
          height: Questions.healthAnswerShow[currentIndex]['containerheight'],
          width: 450.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(
                  width: 1.0, color: Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8))),
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Text(Questions.answerShow[i]['question']),
                  Container(
                      width: 155.0,
                      //color: Colors.purple,
                      child: AutoSizeText(
                        Questions.healthAnswerShow[currentIndex]['question'],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        minFontSize: 14.0,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Row(
                    children: <Widget>[
                      //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
                      Container(
                          width: 140.0,
                          // color:Colors.blue,
                          child: AutoSizeText(
                            Questions.healthAnswerShow[currentIndex]['answer']
                                [0],
                            textAlign: TextAlign.end,
                            minFontSize: 14.0,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),
                          )),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 12.0,
                          color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF))
                    ],
                  )
                ],
              )),
        ));
  }
}

//For show and index of big container
class MultipleBigContainer extends StatelessWidget {
  int currentIndex;
  List answerSubList = [];
  MultipleBigContainer({this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("Big Coontainer Current index is:" + currentIndex.toString());

          if (currentIndex == 0) {
            Questions.healthAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HealthMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.healthAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.healthAnswerShow = [];
            Questions.healthAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HealthMainQuestions(
                  CheckCompleteQuestion: Questions
                      .healthAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.healthAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.healthAnswerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }

//        Navigator.of(context).pop();
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return mainQuestions(CheckQuestion : Questions.answerShow[currentIndex]['question'],CheckAnswer : [Questions.answerShow[currentIndex]['answer'][0]]);
//        }));
        },
        child: Container(
            color: Colors.white,
            height: 55.0,
            width: 450.0,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Text(Questions.answerShow[i]['question']),
                    Container(
                        width: 155.0,
                        //color: Colors.purple,
                        child: AutoSizeText(
                          Questions.healthAnswerShow[currentIndex]['question'],
                          style: TextStyle(
                              color: Color(0xFF9db2bc),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaBold'),
                          minFontSize: 14.0,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Row(
                      children: <Widget>[
                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
                        Container(
                            width: 140.0,
                            // color:Colors.blue,
                            child: AutoSizeText(
                              Questions.healthAnswerShow[currentIndex]['answer']
                                  [0],
                              textAlign: TextAlign.end,
                              minFontSize: 14.0,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'HelveticaBold',
                                  color:
                                      Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12.0,
                          color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
                        )
                      ],
                    )
                  ],
                ))));
  }
}
