import 'package:easy_taxx/livingsituation_flow/container1.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finishcategory.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_taxx/finance_flow/financemultipleoptionscontainer.dart';
import 'package:easy_taxx/finance_flow/financecalculationcontainer.dart';
import 'package:easy_taxx/finance_flow/financeyesnocontainer.dart';
import 'package:easy_taxx/finance_flow/financetwooptioncontainer.dart';
import 'package:easy_taxx/finance_flow/financemultitwocontainer.dart';
import 'package:easy_taxx/finance_flow/financedifferentoptioncontainer.dart';
import 'package:easy_taxx/finance_flow/financedatecontainer.dart';
import 'package:easy_taxx/finance_flow/financethreeoptioncontainer.dart';

class FinanceMainQuestions extends StatefulWidget {
  String CheckCompleteQuestion;
  String CheckQuestion;
  List CheckAnswer;

  FinanceMainQuestions(
      {Key key,
      this.CheckCompleteQuestion,
      this.CheckQuestion,
      this.CheckAnswer})
      : super(key: key);

  @override
  _FinanceMainQuestionsState createState() => _FinanceMainQuestionsState();
}

class _FinanceMainQuestionsState extends State<FinanceMainQuestions> {
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
    print("question length:" + Questions.financeAnswerShow.length.toString());

    for (k = l; k < Questions.financeAnswerShow.length; k++) {
      print("how manysdsdsd");
      screenHeightbig = 0.0;
      if (Questions.financeAnswerShow[k]['identity'] == "You" ||
          Questions.financeAnswerShow[k]['identity'] == "You & Partner" ||
          Questions.financeAnswerShow[k]['identity'] == "Partner") {
        screenHeight = screenHeight + 70.0;
      } else if (Questions.financeAnswerShow[k]['details'] == "") {
        screenHeight = screenHeight + 60.0;
        detail = true;
      } else {
        detailsHeight = Questions.financeAnswerShow[k]['details'];

        for (l = k; l < Questions.financeAnswerShow.length; l++) {
          if (Questions.financeAnswerShow[l]['details'] == detailsHeight) {
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
    screenHeight = screenHeight + Questions.financeAnimatedContainer;
    // screenHeight = screenHeight;
    print("Screen Height:" + screenHeight.toString());
//    print("Screen Height big:"+screenHeightbig.toString());

    detail = true;
  }

  void DynamicContainer() {
    hlength = 0;
    // print("question length:"+Questions.answerShow.length.toString());
    for (i = j; i < Questions.financeAnswerShow.length; i++) {
      print("value oif i is:" + i.toString());

      print("dat is:" + i.toString());
      //You and your and your partner identity
      if (Questions.financeAnswerShow[i]['identity'] == "You" ||
          Questions.financeAnswerShow[i]['identity'] == "You & Partner" ||
          Questions.financeAnswerShow[i]['identity'] == "Partner") {
        dynamicContainer.add(Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: Questions.financeAnswerShow[i]['containerheight'],
          width: 450.0,
          child: Text(Questions.financeAnswerShow[i]['identity'],
              style: TextStyle(fontSize: 40.0)),
        ));
      } else if (Questions.financeAnswerShow[i]['details'] == "") {
        dynamicContainer.add(SingleSmallContainer(currentIndex: i)
//            Container(
//              margin: EdgeInsets.only(
//                  top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
//              height: Questions.financeAnswerShow[i]['containerheight'],
//              width: 450.0,
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(7.0),
//                  border: Border.all(
//                      width: 1.0, color: Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8))
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
//                          child:AutoSizeText(Questions.financeAnswerShow[i]['question'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                      ),
//                      Row(children: <Widget>[
//                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                        Container(
//                            width: 140.0,
//                            // color:Colors.blue,
//                            child:AutoSizeText(Questions.financeAnswerShow[i]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
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
        detailOption = Questions.financeAnswerShow[i]['details'];
        print(detailOption);
        countLongContainer = 0;
//print("ahsjasjasksss");

        //set length of data in details that how much data comes
        for (co = i; co < Questions.financeAnswerShow.length; co++) {
          if (Questions.financeAnswerShow[co]['details'] == detailOption) {
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
          if (Questions.financeAnswerShow[j]['details'] == detailOption &&
              detail == true) {
            dynamicContainerbig.add(
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
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
                              Questions.financeAnswerShow[i]['details'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'HelveticaBold',
                                  fontSize: 15.0),
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
          if (Questions.financeAnswerShow[j]['details'] == detailOption &&
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
//                              child:AutoSizeText(Questions.financeAnswerShow[j]['question'],style: TextStyle(color: Colors.grey),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                          ),
//                          Row(children: <Widget>[
//                            //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                            Container(
//                                width: 140.0,
//                                // color:Colors.blue,
//                                child:AutoSizeText(Questions.financeAnswerShow[j]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(width: 1.0,
              //     color: Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8))
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
                            "Finance",
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

        //  AppBar(
        //   backgroundColor: Colors.white,
        //   leading: GestureDetector(
        //       onTap: () {
        //         Navigator.pushReplacementNamed(context, 'allCategoryScreen');
        //         //Navigator.pop(context);
        //       },
        //       child:Icon(Icons.arrow_back_ios,color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),size: 20.0)
        //   ),
        //     title: Text('Finances',style: TextStyle(color: Colors.black,fontSize: 14.0),),
        //     centerTitle: true,
        //     actions: <Widget>[
        //       Padding(
        //           padding: EdgeInsets.only(right: 18.0),
        //           child:GestureDetector(
        //               onTap: (){
        //                 print("skip");
        //               },
        //               child:Image(image:AssetImage("images/skip.png"),width: 23.0,height: 23.0,)
        //           )
        //       )
        //     ]
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
                          FinanceChangeContainer(),
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

  Widget FinanceChangeContainer() {
    if (Questions.financeAnswerShow.length == 0) {
      if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
        qu.FinanceAddAnswer("You", "", "", "", [], 60.0);
      }

      if (Questions.occupationMiniJobFinance == "Minijob") {
        //Question No 76
        return financedifferentoptionContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Finances",
            "Does ${Questions.financeYourIdentity} job meet one of the following criteria?",
            "Specialist activity",
            [
              "Official",
              "Managing director",
              "Judge",
              "Intern",
              "Soldier",
              "No"
            ],
            220.0,
            "",
            "",
            []);
      } else {
        //Question No 1
        //For 'Riester' pension and No 430.0
        //For Private pension with capital voting rights 280.0
        //For rest 220.0
        return financemultipleoptionsContainer(
            """

<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>

""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
            "Pensions/Life insurances",
            [
              "'Riester' pension",
              "Rürup pension",
              "Private pension with capital voting rights",
              "Private pension without capital voting rights",
              "Endowment insurance",
              "Life insurance",
              "Additional contribution statutory pension",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }
    } else {
      //Answer No 1
      if (widget.CheckCompleteQuestion ==
              "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?" &&
          widget.CheckQuestion == "Pensions/Life insurances") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "'Riester' pension") {
            //Agar living situation ki category ka occupation ma Studying select hoa to phir Question No 72 ai ga wrna wasa hi chalta rhega
            if (Questions.occupationStudyingFinance == "Studying" ||
                Questions.specialistActivityFinance == "Official" ||
                Questions.specialistActivityFinance == "Judge" ||
                Questions.specialistActivityFinance == "Soldier") {
              DbHelper.insatance.deleteWithquestion(
                  'Did have costs for any of the insurances listed here?');
              _insert('Did have costs for any of the insurances listed here?',
                  'Riester\' pension', 'OK');
              //Question No 72
              // return financecalculationContainer(
              //     "<h1>Coming Soon!</h1>",
              //     "",
              //     "Finances",
              //     "What was the sum of all contributions ${Questions.financeYouIdentity} have paid for all Riester contracts?",
              //     "Total contribution",
              //     220.0,
              //     "calculation",
              //     "", []);

              return financecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Finances",
                  "How much was the payment of Riester contract?",
                  "Payment contribution",
                  220.0,
                  "calculation",
                  "", []);
            } else {
              //Question No 2
              return financecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Finances",
                  "How much was the payment of Riester contract?",
                  "Payment contribution",
                  220.0,
                  "calculation",
                  "", []);
            }
          } else if (widget.CheckAnswer[m] == "Rürup pension") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'Rürup pension', 'OK');
            //Question No 3
            return financecalculationContainer(
                """

<p><strong>Contributions to Rürup pension</strong></p>
<p>Please enter the total amount you paid into your Rürup pension in 2019.</p>
<p><em>Please enter the total amount here.</em></p>
<p>You can find this information in the <strong>contribution certificate</strong> from your insurance company.</p>
<p> </p>

""",
                "",
                "Finances",
                "How much did ${Questions.financeYouIdentity} pay into ${Questions.financeYourIdentity} Rürup contract?",
                "Rürup contribution",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] ==
              "Private pension with capital voting rights") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'Private pension with capital voting rights', 'OK');
            //Question No 6
            //For Before 01.01.2005 220.0
            // For After 31.12.2004 430.0
            return financetwooptionContainer(
                """

<p><strong>Start date of pension with capital voting rights</strong></p>
<p>Please enter the start date of your pension with capital voting rights.</p>
<p>You can find the date on your policy documents from your insurer.</p>
<p>The start date does not have to be in 2019.</p>
<p>You can choose between 2 answers:</p>
<ul>
<li>Before 01.01.2005</li>
<li>After 31.12.2004</li>
</ul>
<p> </p>

""",
                "",
                "Finances",
                "When did ${Questions.financeYourIdentity} pension with capital voting rights begin and when did ${Questions.financeYouIdentity} make the first payment?",
                "Pension start date",
                ["Before 01.01.2005", "After 31.12.2004"],
                220.0,
                "",
                "",
                []);
          } else if (widget.CheckAnswer[m] ==
              "Private pension without capital voting rights") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'Private pension without capital voting rights', 'OK');
            //Question No 10
            //For Before 01.01.2005 220.0
            // For After 31.12.2004 430.0
            return financetwooptionContainer(
                """

<p><strong>Start date of pension with capital voting rights</strong></p>
<p>Please enter the start date of your pension with capital voting rights.</p>
<p>You can find the date on your policy documents from your insurer.</p>
<p>The start date does not have to be in 2019.</p>
<p>You can choose between 2 answers:</p>
<ul>
<li>Before 01.01.2005</li>
<li>After 31.12.2004</li>
</ul>
<p> </p>

""",
                "",
                "Finances",
                "When did ${Questions.financeYourIdentity} pension without capital voting rights begin and when did ${Questions.financeYouIdentity} make the first payment?",
                "Policy start date",
                ["Before 01.01.2005", "After 31.12.2004"],
                220.0,
                "",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "Endowment insurance") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'Endowment insurance', 'OK');
            //Question No 14
            //For Before 01.01.2005 220.0
            // For After 31.12.2004 430.0
            return financetwooptionContainer(
                """

<p><strong>Start date of endowment insurance</strong></p>
<p>Please enter the start date of your endowment insurance.</p>
<p>You can find the date on your policy documents from your insurer.</p>
<p>You can choose between 2 answers:</p>
<ul>
<li>Before 01.01.2005</li>
<li>After 31.12.2004</li>
</ul>
<p> </p>

""",
                "",
                "Finances",
                "When does ${Questions.financeYourIdentity} endowment insurance policy begin?",
                "Life insurance contract",
                ["Before 01.01.2005", "After 31.12.2004"],
                220.0,
                "",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "Life insurance") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'Life insurance', 'OK');
            //Question No 18
            return financecalculationContainer(
                """

<p><strong>Life insurance</strong></p>
<p>Enter here your annual contribution to your life insurance for 2019.</p>
<p>Life insurance is one of several types of insurance policies that is voluntary. It is used to protect survivors from financial ruin in the event of death.</p>
<p>The policy term and <strong>your annual contribution</strong> are stipulated <strong>in the contract</strong></p>
<p>MULTIPLE POLICIES</p>
<p>If you have multiple life policies, enter the total annual amount you paid into your policies.</p>
<p> </p>

""",
                "",
                "Finances",
                "How much did ${Questions.financeYouIdentity} pay into ${Questions.financeYourIdentity} life insurance policy?",
                "Contributions",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] ==
              "Additional contribution statutory pension") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'Additional contribution statutory pension', 'OK');
            //Question No 19
            return financecalculationContainer(
                """

<p><strong>Voluntary pension contributions</strong></p>
<p>Please enter the total amount you paid in additional pension contributions in 2019. This only includes contributions not based on the employment. If the contributions are included in the payslip (line 23), they can not be entered here, as the app takes them into account automatically.</p>
<p>If you are <strong>NOT</strong> obligated to pay into the statutory pension scheme and are not claiming a pension, you can <strong>voluntarily insure yourself</strong> and pay voluntary contributions.</p>
<p>This concerns in particular:</p>
<ul>
<li>self-employed / freelancers</li>
<li>housewives</li>
<li>househusbands</li>
</ul>
<p>If you voluntarily pay into the statutory pension scheme, you will find the amount of your contributions in your pension documents, such as the <strong>contribution certificate from the pension office.</strong></p>
<p><strong> </strong></p>

""",
                "",
                "Finances",
                "How much were ${Questions.financeYourIdentity} additional contributions to the statutory pension scheme (excluding amounts from the payslip)?",
                "Voluntary pension contributions",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'No', 'OK');
            //Question No 2
            return financemultipleoptionsContainer(
                """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
                "",
                "Finances",
                "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
                "Other contracts",
                [
                  "Additional unemployment insurance",
                  "Occupational disability",
                  "Car liability insurance",
                  "Liability",
                  "Legal protection",
                  "Professional liability",
                  "Accident insurance",
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
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any of the insurances listed here?');
            _insert('Did have costs for any of the insurances listed here?',
                'skip', 'OK');
            //Question No 2
            return financemultipleoptionsContainer(
                """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
                "",
                "Finances",
                "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
                "Other contracts",
                [
                  "Additional unemployment insurance",
                  "Occupational disability",
                  "Car liability insurance",
                  "Liability",
                  "Legal protection",
                  "Professional liability",
                  "Accident insurance",
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
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          }
        }
      } else if (widget.CheckCompleteQuestion ==
              "How much was the payment of Riester contract?" &&
          widget.CheckQuestion == "Payment contribution") {
        return financecalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Finances",
            "How much was the payment of Riester salary in 2018?",
            "Payment salary",
            220.0,
            "calculation",
            "", []);
      } else if (widget.CheckCompleteQuestion ==
              "How much was the payment of Riester salary in 2018?" &&
          widget.CheckQuestion == "Payment salary") {
        return financecalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Finances",
            "How much was the payment of Riester income replacement in 2018?",
            "Payment income",
            220.0,
            "calculation",
            "", []);
      } else if (widget.CheckCompleteQuestion ==
              "How much was the payment of Riester income replacement in 2018?" &&
          widget.CheckQuestion == "Payment income") {
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

      // ====== Insurances listed here Starts ====== //

      // ====== Rürup pension Starts ====== //

      //Answer No 3
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} pay into ${Questions.financeYourIdentity} Rürup contract?" &&
          widget.CheckQuestion == "Rürup contribution") {
        //Question No 4
        //For No 430.0
        //For Yes 220.0
        return financeyesnoContainer(
            """

<p><strong>Amount of refunds from Rürup pension</strong></p>
<p>Did you receive refunds from your Rürup pension in 2019?</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>Refunds are paid when you have paid <strong>too much</strong> in contributions or if you have <strong>cancelled the policy</strong>.</p>
<p>You can find this amount in your documents from your insurance company.</p>
<p> </p>

""",
            "",
            "Finances",
            "Have ${Questions.financeYouIdentity} received any reimbursements from ${Questions.financeYourIdentity} Rürup pension?",
            "Rürup refunds",
            220.0,
            "",
            "",
            []);
      }

      //Answer No 4
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} received any reimbursements from ${Questions.financeYourIdentity} Rürup pension?" &&
          widget.CheckQuestion == "Rürup refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have received any reimbursements from Rürup pension?');
          _insert('Have received any reimbursements from Rürup pension?', 'No',
              'OK');

          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have received any reimbursements from Rürup pension?');
          _insert('Have received any reimbursements from Rürup pension?',
              'skip', 'skip');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have received any reimbursements from Rürup pension?');
          _insert('Have received any reimbursements from Rürup pension?', 'Yes',
              'OK');
          //Question No 5
          return financecalculationContainer(
              """

<p><strong>Amount of refunds from Rürup pension</strong></p>
<p>Please enter the <strong>amount of refunds you received from your Rürup pension in 2019</strong>.</p>
<p><em>Enter the total amount.</em></p>
<p>You can find this amount in your documents that <strong>your insurance</strong> sent you.</p>
<p> </p>

""",
              "",
              "Finances",
              "How much did ${Questions.financeYouIdentity} receive?",
              "Refund amount Rürup",
              430.0,
              "calculation",
              "",
              []);
        }
      }

      //Answer No 5
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} receive?" &&
          widget.CheckQuestion == "Refund amount Rürup") {
        //Question No 2
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

// ====== Rürup pension Ends ====== //

// ====== Private pension with capital voting rights Starts ======

      //Answer No 6
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.financeYourIdentity} pension with capital voting rights begin and when did ${Questions.financeYouIdentity} make the first payment?" &&
          widget.CheckQuestion == "Pension start date") {
        if (widget.CheckAnswer[0] == "Before 01.01.2005") {
          DbHelper.insatance.deleteWithquestion(
              'When did pension with capital voting rights begin and when did make the first payment?');
          _insert(
              'When did pension with capital voting rights begin and when did make the first payment?',
              'Before 01.01.2005',
              'OK');
          //Question No 7
          return financecalculationContainer(
              """

<p><strong>Contributions to pension with capital voting rights</strong></p>
<p>Please enter the total amount you paid into your pension with capital voting rights in 2019.</p>
<p>You can find this information in you insurance documents or on your account statements.</p>
<p>Please note you need to enter the <strong>total amount</strong> for the whole year.</p>
<p> </p>

""",
              "",
              "Finances",
              "What contribution did ${Questions.financeYouIdentity} pay for ${Questions.financeYourIdentity} pension with capital voting rights?",
              "Contributions",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "After 31.12.2004") {
          DbHelper.insatance.deleteWithquestion(
              'When did pension with capital voting rights begin and when did make the first payment?');
          _insert(
              'When did pension with capital voting rights begin and when did make the first payment?',
              'After 31.12.2004',
              'OK');

          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'When did pension with capital voting rights begin and when did make the first payment?');
          _insert(
              'When did pension with capital voting rights begin and when did make the first payment?',
              'skip',
              'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        }
      }

      //Answer No 7
      else if (widget.CheckCompleteQuestion ==
              "What contribution did ${Questions.financeYouIdentity} pay for ${Questions.financeYourIdentity} pension with capital voting rights?" &&
          widget.CheckQuestion == "Contributions") {
        //Question No 8
        //For No 430.0
        //For Yes 220.0
        return financeyesnoContainer(
            """

<p><strong>Amount of refunds from pension with capital voting rights</strong></p>
<p>Did you receive refunds from your pension with capital voting rights?</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>Refunds are paid when you have paid <strong>too much</strong> in contributions or if you have <strong>cancelled the policy</strong>.</p>
<p>You can find this amount in documents that your insurance sent you.</p>
<p> </p>

""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} receive any reimbursement?",
            "Reimbursement",
            220.0,
            "",
            "",
            []);
      }

      //Answer No 8
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.financeYouIdentity} receive any reimbursement?" &&
          widget.CheckQuestion == "Reimbursement") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Did receive any reimbursement?');
          _insert('Did receive any reimbursement?', 'No', 'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Did receive any reimbursement?');
          _insert('Did receive any reimbursement?', 'skip', 'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Did receive any reimbursement?');
          _insert('Did receive any reimbursement?', 'Yes', 'OK');
          //Question No 9
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "How much did ${Questions.financeYouIdentity} receive?",
              "Refund amount",
              430.0,
              "calculation",
              "", []);
        }
      }

      //Answer No 9
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} receive?" &&
          widget.CheckQuestion == "Refund amount") {
        //Question No 2
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>
""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

// ====== Private pension with capital voting rights Ends ======

      // ====== Private pension without capital voting rights Starts ======
      //Answer No 10
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.financeYourIdentity} pension without capital voting rights begin and when did ${Questions.financeYouIdentity} make the first payment?" &&
          widget.CheckQuestion == "Policy start date") {
        if (widget.CheckAnswer[0] == "Before 01.01.2005") {
          DbHelper.insatance.deleteWithquestion(
              'When did pension without capital voting rights begin and when did make the first payment?');
          _insert(
              'When did pension without capital voting rights begin and when did make the first payment?',
              'Before 01.01.2005',
              'OK');
          //Question No 11
          return financecalculationContainer(
              """

<p><strong>Contributions to pension without capital voting rights</strong></p>
<p>Please enter the total amount you paid into your pension without capital voting rights in 2019. You can find this amount in you insurance documents or on your account statements.</p>
<p>Please note you need to enter the total amount for the whole year.</p>
<p> </p>
""",
              "",
              "Finances",
              "What contribution did ${Questions.financeYouIdentity} pay for ${Questions.financeYourIdentity} pension without capital voting rights?",
              "Contribution Riester",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "After 31.12.2004") {
          DbHelper.insatance.deleteWithquestion(
              'When did pension without capital voting rights begin and when did make the first payment?');
          _insert(
              'When did pension without capital voting rights begin and when did make the first payment?',
              'After 31.12.2004',
              'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'When did pension without capital voting rights begin and when did make the first payment?');
          _insert(
              'When did pension without capital voting rights begin and when did make the first payment?',
              'skip',
              'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        }
      }

      //Answer No 11
      else if (widget.CheckCompleteQuestion ==
              "What contribution did ${Questions.financeYouIdentity} pay for ${Questions.financeYourIdentity} pension without capital voting rights?" &&
          widget.CheckQuestion == "Contribution Riester") {
        //Question No 12
        //For No 430.0
        //For Yes 220.0
        return financeyesnoContainer(
            """

<p><strong>Amount of refunds from pension without capital voting rights</strong></p>
<p>Did you receive refunds from your pension without capital voting rights?</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>Refunds are paid when you have paid <strong>too much</strong> in contributions or if you have <strong>cancelled the policy.</strong></p>
<p>You can find this amount in documents that your insurance sent you.</p>
<p> </p>

""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} receive any reimbursement?",
            "Refund",
            220.0,
            "",
            "",
            []);
      }

      //Answer No 12
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.financeYouIdentity} receive any reimbursement?" &&
          widget.CheckQuestion == "Refund") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Did receive any reimbursement?');
          _insert('Did receive any reimbursement?', 'No', 'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Did receive any reimbursement?');
          _insert('Did receive any reimbursement?', 'skip', 'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Did receive any reimbursement?');
          _insert('Did receive any reimbursement?', 'Yes', 'OK');
          //Question No 13
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "How much did ${Questions.financeYouIdentity} receive?",
              "Amount of reimbursement",
              430.0,
              "calculation",
              "", []);
        }
      }

      //Answer No 13
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount of reimbursement") {
        //Question No 2
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>
""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

// ====== Private pension without capital voting rights Ends ======

// ====== Endowment insurance Starts ====== //

      //Answer No 14
      else if (widget.CheckCompleteQuestion ==
              "When does ${Questions.financeYourIdentity} endowment insurance policy begin?" &&
          widget.CheckQuestion == "Life insurance contract") {
        if (widget.CheckAnswer[0] == "Before 01.01.2005") {
          DbHelper.insatance.deleteWithquestion(
              'When does endowment insurance policy begin?');
          _insert('When does endowment insurance policy begin?',
              'Before 01.01.2005', 'OK');
          //Question No 15
          return financecalculationContainer(
              """

<p><strong>Contributions to endowment insurance</strong></p>
<p>Please enter the total amount you paid into your endowment insurance in 2019.</p>
<p>You can find this information in you insurance documents or on your account statements.</p>
<p><em>Please note you need to enter the </em><strong><em>total amount</em></strong><em> for the whole year.</em></p>
<p><em> </em></p>

""",
              "",
              "Finances",
              "How much did ${Questions.financeYouIdentity} pay into ${Questions.financeYourIdentity} endowment insurance policy?",
              "Contribution",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "After 31.12.2004") {
          DbHelper.insatance.deleteWithquestion(
              'When does endowment insurance policy begin?');
          _insert('When does endowment insurance policy begin?',
              'After 31.12.2004', 'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'When does endowment insurance policy begin?');
          _insert(
              'When does endowment insurance policy begin?', 'skip', 'skip');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        }
      }

      //Answer No 15
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} pay into ${Questions.financeYourIdentity} endowment insurance policy?" &&
          widget.CheckQuestion == "Contribution") {
        //Question No 16
        //For No 430.0
        //For Yes 220.0
        return financeyesnoContainer(
            """

<p><strong>Refunds from endowment insurance</strong></p>
<p>Did you receive refunds from your endowment insurance in 2019?</p>
<p>If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>You can find this amount in your documents that <strong>your insurance</strong> sent you relating to this refund.</p>
<p> </p>

""",
            "",
            "Finances",
            "Did you receive any refunds from ${Questions.financeYourIdentity} endowment insurance?",
            "Endowment insurance refund",
            220.0,
            "",
            "",
            []);
      }

      //Answer No 16
      else if (widget.CheckCompleteQuestion ==
              "Did you receive any refunds from ${Questions.financeYourIdentity} endowment insurance?" &&
          widget.CheckQuestion == "Endowment insurance refund") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any refunds from endowment insurance?');
          _insert('Did you receive any refunds from endowment insurance?', 'No',
              'OK');

          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any refunds from endowment insurance?');
          _insert('Did you receive any refunds from endowment insurance?',
              'skip', 'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any refunds from endowment insurance?');
          _insert('Did you receive any refunds from endowment insurance?',
              'Yes', 'OK');
          //Question No 17
          return financecalculationContainer(
              """

<p><strong>Amount of refunds from endowment insurance</strong></p>
<p>Please enter the amount of <strong>refunds you received in 2019 from your endowment insurance</strong>.</p>
<p><em>Enter the total amount.</em></p>
<p>You can find this amount in your documents that <strong>your insurance</strong> sent you relating to this refund.</p>
<p>-------------</p>
<ol>
<li>Q) When did your pension with capital voting rights begin and when did you make the first payment?</li>
</ol>
<p><strong>Start date of pension with capital voting rights</strong></p>
<p>Please enter the start date of your pension with capital voting rights.</p>
<p>You can find the date on your policy documents from your insurer.</p>
<p>The start date does not have to be in 2019.</p>
<p>You can choose between 2 answers:</p>
<ul>
<li>Before 01.01.2005</li>
<li>After 31.12.2004</li>
</ul>
<p> </p>

""",
              "",
              "Finances",
              "How much did ${Questions.financeYouIdentity} receive in refunds from your endowment insurance?",
              "Refunds",
              430.0,
              "calculation",
              "",
              []);
        }
      }

      //Answer No 17
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} receive in refunds from your endowment insurance?" &&
          widget.CheckQuestion == "Refunds") {
        //Question No 2
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>
""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

      // ====== Endowment insurance Ends ====== //

      // ====== Life insurance Starts ====== //

      //Answer No 18
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} pay into ${Questions.financeYourIdentity} life insurance policy?" &&
          widget.CheckQuestion == "Contributions") {
        //Question No 2
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>
""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

      // ====== Life insurance Ends ====== //

      // ====== Additional contribution statutory pension Starts ====== //

      //Answer No 19
      else if (widget.CheckCompleteQuestion ==
              "How much were ${Questions.financeYourIdentity} additional contributions to the statutory pension scheme (excluding amounts from the payslip)?" &&
          widget.CheckQuestion == "Voluntary pension contributions") {
        //Question No 20
        //For No 430.0
        //For Yes 220.0
        return financeyesnoContainer(
            """

<p><strong>Amount of refunds from state pension</strong></p>
<p>Please state whether you received refunds from the state pension in 2019 If this is the case, please select "Yes". If you did not receive any refunds, select "No".</p>
<p>This can be the case if through your job you have a <strong>different kind of pension scheme</strong> (e. g. civil servant).</p>
<p><strong>Important:</strong></p>
<p>Usually only amounts are reimbursed that you have paid in yourself.</p>
<p>You can find this amount in your documents from the state pension.</p>
<p> </p>

""",
            "",
            "Finances",
            "Have ${Questions.financeYouIdentity} received any reimbursement for contributions from ${Questions.financeYourIdentity} statutory pension payments?",
            "Pension refunds",
            220.0,
            "",
            "",
            []);
      }

      //Answer No 20
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} received any reimbursement for contributions from ${Questions.financeYourIdentity} statutory pension payments?" &&
          widget.CheckQuestion == "Pension refunds") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have received any reimbursement for contributions from statutory pension payments?');
          _insert(
              'Have received any reimbursement for contributions from statutory pension payments?',
              'No',
              'OK');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have received any reimbursement for contributions from statutory pension payments?');
          _insert(
              'Have received any reimbursement for contributions from statutory pension payments?',
              'skip',
              'skip');
          //Question No 2
          return financemultipleoptionsContainer(
              """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
              "Other contracts",
              [
                "Additional unemployment insurance",
                "Occupational disability",
                "Car liability insurance",
                "Liability",
                "Legal protection",
                "Professional liability",
                "Accident insurance",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have received any reimbursement for contributions from statutory pension payments?');
          _insert(
              'Have received any reimbursement for contributions from statutory pension payments?',
              'Yes',
              'OK');

          //Question No 21
          return financecalculationContainer(
              """

<p><strong>Amount of refunds from Riester pension</strong></p>
<p>Please enter the <strong>amount of refunds</strong> <strong>you received in 2019 from your Riester pension</strong>. We mean the total amount of refunds received for the whole of 2019.</p>
<p>You can find this amount in your documents that your insurer sent you relating to this refund.</p>
<p> </p>

""",
              "",
              "Finances",
              "How much reimbursement did ${Questions.financeYouIdentity} receive?",
              "Amount received (state pension)",
              430.0,
              "calculation",
              "",
              []);
        }
      }

      //Answer No 21
      else if (widget.CheckCompleteQuestion ==
              "How much reimbursement did ${Questions.financeYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount received (state pension)") {
        //Question No 2
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>
""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

      // ====== Additional contribution statutory pension Ends ====== //

      // ====== Insurances listed here Ends ====== //

      // ====== Any Other Insurance Policies Starts ====== //

      //Answer No 2
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?" &&
          widget.CheckQuestion == "Other contracts") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Additional unemployment insurance") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?',
                'Additional unemployment insurance', 'OK');

            //Question No 22
            return financecalculationContainer(
                """

<p><strong>Contributions to unemployment insurance</strong></p>
<p>Please enter the amount you paid for additional unemployment insurance in 2019. Please do not consider the amount withheld from your wages.</p>
<p>Please enter the total amount here.</p>
<p>You can find the amount on your certificate of insurance, which you received upon completion of the policy.</p>
<p><strong>Attention</strong></p>
<p>Please do not enter the amount which you can find on your annual payslip ('Lohnsteuerbescheinigung').</p>
<p> </p>

""",
                "",
                "Finances",
                "How much did ${Questions.financeYouIdentity} pay for additional unemployment insurance?",
                "Contribution",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "Occupational disability") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?',
                'Occupational disability', 'OK');

            //Question No 24
            return financecalculationContainer(
                """

<p><strong>Contributions to diability insurance</strong></p>
<p>Please enter the <strong>total amount for 2019</strong> that you paid for disability insurance.</p>
<p>You can find the amount on your certificate of insurance, which you received upon completion of the policy.</p>
<p>We need this information in order to claim these premiums as tax deductible.</p>
<p> </p>
<p> </p>

""",
                "",
                "Finances",
                "How much did ${Questions.financeYouIdentity} pay for disability insurance?",
                "Contribution",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "Car liability insurance") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?',
                'Car liability insurance', 'OK');

            //Question No 25
            return financecalculationContainer(
                """

<p><strong>Contributions to diability insurance</strong></p>
<p>Please enter the total amount for 2019 that you paid for disability insurance.</p>
<p>You can find the amount on your certificate of insurance, which you received upon completion of the policy.</p>
<p>We need this information in order to claim these premiums as tax deductible.</p>
<p> </p>

""",
                "",
                "Finances",
                "How much did ${Questions.financeYouIdentity} spend on liability car insurance?",
                "Amount",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "Liability") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?',
                'Liability', 'OK');

            //Question No 26
            return financeyesnoContainer(
                """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
                "",
                "Finances",
                "Do you have bank account fees more than 16 euro?",
                "Bank Account Fees",
                220.0,
                "",
                "",
                []);
          } else if (widget.CheckCompleteQuestion ==
                  "Do you have bank account fees more than 16 euro?" &&
              widget.CheckQuestion == "Bank Account Fees") {
            if (widget.CheckAnswer[0] == "Yes") {
              return financecalculationContainer(
                  """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
                  "",
                  "Finances",
                  "What is the amount of bank account fees?",
                  "Bank Account Fee",
                  220.0,
                  "calculation",
                  "",
                  []);
            } else if (widget.CheckAnswer[0] == "No") {
              return financeyesnoContainer(
                  """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
                  "",
                  "Finances",
                  "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
                  "Church membership {tax_year}",
                  220.0,
                  "",
                  "",
                  []);
            } else if (widget.CheckAnswer[0] == "skip") {
              return financeyesnoContainer(
                  """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
                  "",
                  "Finances",
                  "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
                  "Church membership {tax_year}",
                  220.0,
                  "",
                  "",
                  []);
            }
          } else if (widget.CheckAnswer[m] == "Legal protection") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?',
                'Legal protection', 'OK');

            //Question No 27
            return financemultitwoContainer(
                """

<p><strong>Legal expenses insurance</strong></p>
<p>Please select from options which risks your legal expenses insurance covers.</p>
<p>You can choose both options if you have combined insurance, covering family, employment and traffic disputes.</p>
<p><strong>PROFESSIONAL RISKS</strong></p>
<p>Your legal expenses insurance covers professional risks.</p>
<p><strong>OTHER RISKS</strong></p>
<p>Your legal expenses insurance covers other risks, such as family disputes.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Only part of your legal expenses insurance is tax deductible.</p>
<p>This means that only services in connection with <strong>your working life</strong> and also <strong>protection of employment rights</strong> may be taken into account.</p>
<p>If your legal expenses insurance only covers professional risks then you can claim the full amount. Otherwise you only claim part of the premium.</p>
<p> </p>
<p> </p>
<p> </p>

""",
                "",
                "Finances",
                "What risks does ${Questions.financeYourIdentity} legal expenses insurance cover?",
                "Covered risks",
                ["Professional risks", "Other risks"],
                ["images/disabilityoption.png", "images/alimonypaidoption.png"],
                220.0,
                "",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "Professional liability") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?',
                'Professional liability', 'OK');

            //Question No 29
            return financecalculationContainer(
                """

<p><strong>Legal expenses insurance: contributions</strong></p>
<p>So that we can determine exactly how much you can deduct from your tax, we need to know how much <strong>your annual premium</strong> for legal expenses insurance was in 2019.</p>
<p>If your legal expenses insurance only covers professional risks then you can claim the full amount.</p>
<p>If it's a combined legal expenses insurance, you can only write off services in connection with protection of your employment rights. Most insurers include this information of the invoice.</p>
<p>If you cannot find this information on your invoice, get in touch with your insurer.</p>
<p> </p>

""",
                "",
                "Finances",
                "How much did ${Questions.financeYouIdentity} pay for professional liability insurance?",
                "Amount",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "Accident insurance") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?',
                'Accident insurance', 'OK');

            //Question No 30
            return financecalculationContainer(
                """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
                "",
                "Finances",
                "How much have ${Questions.financeYouIdentity} spent on accident insurance?",
                "Amount accident insurance",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert(
                'Did have costs for any other insurance policies?', 'No', 'OK');

            //Question No 23
            return financeyesnoContainer(
                """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
                "",
                "Finances",
                "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
                "Church membership {tax_year}",
                220.0,
                "",
                "",
                []);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Did have costs for any other insurance policies?');
            _insert('Did have costs for any other insurance policies?', 'skip',
                'OK');

            //Question No 23
            return financeyesnoContainer(
                """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
                "",
                "Finances",
                "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
                "Church membership {tax_year}",
                220.0,
                "",
                "",
                []);
          }
        }
      } else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} pay for additional unemployment insurance?" &&
          widget.CheckQuestion == "Contribution") {
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Do you have bank account fees more than 16 euro?",
            "Bank Account Fees",
            220.0,
            "",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "Do you have bank account fees more than 16 euro?" &&
          widget.CheckQuestion == "Bank Account Fees") {
        if (widget.CheckAnswer[0] == "Yes") {
          return financecalculationContainer(
              """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
              "",
              "Finances",
              "What is the amount of bank account fees?",
              "Bank Account Fee",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "No") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }

      // ======  Additional unemployment insurance Starts =======

      //Answer No 22
      else if (widget.CheckCompleteQuestion ==
              "What is the amount of bank account fees?" &&
          widget.CheckQuestion == "Bank Account Fee") {
        //Question No 23
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
            "Church membership {tax_year}",
            220.0,
            "",
            "",
            []);
      }

      // ======  Additional unemployment insurance Ends =======

      // ======  Occupational disability Starts ======

      //Answer No 24
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} pay for disability insurance?" &&
          widget.CheckQuestion == "Contribution") {
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Do you have bank account fees more than 16 euro?",
            "Bank Account Fees",
            220.0,
            "",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "Do you have bank account fees more than 16 euro?" &&
          widget.CheckQuestion == "Bank Account Fees") {
        if (widget.CheckAnswer[0] == "Yes") {
          return financecalculationContainer(
              """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
              "",
              "Finances",
              "What is the amount of bank account fees?",
              "Bank Account Fee",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "No") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }
      // ======  Occupational disability Ends ======

      // ====== Car liability insurance Starts ======

      //Answer No 25
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} spend on liability car insurance?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 23
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Do you have bank account fees more than 16 euro?",
            "Bank Account Fees",
            220.0,
            "",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "Do you have bank account fees more than 16 euro?" &&
          widget.CheckQuestion == "Bank Account Fees") {
        if (widget.CheckAnswer[0] == "Yes") {
          return financecalculationContainer(
              """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
              "",
              "Finances",
              "What is the amount of bank account fees?",
              "Bank Account Fee",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "No") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }

      // ====== Car liability insurance Ends ======

      // ====== Liability Starts ======

      //Answer No 26
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} pay for liability insurance?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 23
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Do you have bank account fees more than 16 euro?",
            "Bank Account Fees",
            220.0,
            "",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "Do you have bank account fees more than 16 euro?" &&
          widget.CheckQuestion == "Bank Account Fees") {
        if (widget.CheckAnswer[0] == "Yes") {
          return financecalculationContainer(
              """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
              "",
              "Finances",
              "What is the amount of bank account fees?",
              "Bank Account Fee",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "No") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }

      // ====== Liability Ends ======

      // ====== Legal protection Starts ======

      //Answer No 27

      else if (widget.CheckCompleteQuestion ==
              "What risks does ${Questions.financeYourIdentity} legal expenses insurance cover?" &&
          widget.CheckQuestion == "Covered risks") {
        if (widget.CheckAnswer[0] == "Professional risks") {
          DbHelper.insatance.deleteWithquestion(
              'What risks does legal expenses insurance cover?');
          _insert('What risks does legal expenses insurance cover?',
              'Professional risks', 'OK');

          //Question No 28
          return financecalculationContainer(
              """

<p><strong>Legal expenses insurance: contributions</strong></p>
<p>So that we can determine exactly how much you can deduct from your tax, we need to know how much <strong>your annual premium</strong> for legal expenses insurance was in 2019.</p>
<p>If your legal expenses insurance only covers professional risks then you can claim the full amount.</p>
<p>If it's a combined legal expenses insurance, you can only write off services in connection with protection of your employment rights. Most insurers include this information of the invoice.</p>
<p>If you cannot find this information on your invoice, get in touch with your insurer.</p>
<p> </p>

""",
              "",
              "Finances",
              "How much did ${Questions.financeYouIdentity} spend on professional liability insurance?",
              "Professional risks",
              430.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Other risks") {
          DbHelper.insatance.deleteWithquestion(
              'What risks does legal expenses insurance cover?');
          _insert('What risks does legal expenses insurance cover?',
              'Other risks', 'OK');

          //Question No 23
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Do you have bank account fees more than 16 euro?",
              "Bank Account Fees",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckCompleteQuestion ==
                "Do you have bank account fees more than 16 euro?" &&
            widget.CheckQuestion == "Bank Account Fees") {
          if (widget.CheckAnswer[0] == "Yes") {
            return financecalculationContainer(
                """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
                "",
                "Finances",
                "What is the amount of bank account fees?",
                "Bank Account Fee",
                220.0,
                "calculation",
                "",
                []);
          } else if (widget.CheckAnswer[0] == "No") {
            return financeyesnoContainer(
                """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
                "",
                "Finances",
                "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
                "Church membership {tax_year}",
                220.0,
                "",
                "",
                []);
          } else if (widget.CheckAnswer[0] == "skip") {
            return financeyesnoContainer(
                """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
                "",
                "Finances",
                "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
                "Church membership {tax_year}",
                220.0,
                "",
                "",
                []);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'What risks does legal expenses insurance cover?');
          _insert(
              'What risks does legal expenses insurance cover?', 'skip', 'OK');

          //Question No 23
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }

      //Answer No 28
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} spend on professional liability insurance?" &&
          widget.CheckQuestion == "Professional risks") {
        //Question No 23
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Do you have bank account fees more than 16 euro?",
            "Bank Account Fees",
            220.0,
            "",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "Do you have bank account fees more than 16 euro?" &&
          widget.CheckQuestion == "Bank Account Fees") {
        if (widget.CheckAnswer[0] == "Yes") {
          return financecalculationContainer(
              """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
              "",
              "Finances",
              "What is the amount of bank account fees?",
              "Bank Account Fee",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "No") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }

      // ====== Legal protection Ends ======

      // ====== Professional liability Starts ======

      //Answer No 29
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} pay for professional liability insurance?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 23
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Do you have bank account fees more than 16 euro?",
            "Bank Account Fees",
            220.0,
            "",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "Do you have bank account fees more than 16 euro?" &&
          widget.CheckQuestion == "Bank Account Fees") {
        if (widget.CheckAnswer[0] == "Yes") {
          return financecalculationContainer(
              """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
              "",
              "Finances",
              "What is the amount of bank account fees?",
              "Bank Account Fee",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "No") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }

      // ====== Professional liability Ends ======

      // ====== Accident insurance Starts ======

      //Answer No 30
      else if (widget.CheckCompleteQuestion ==
              "How much have ${Questions.financeYouIdentity} spent on accident insurance?" &&
          widget.CheckQuestion == "Amount accident insurance") {
        //Question No 23
        return financeyesnoContainer(
            """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
            "",
            "Finances",
            "Do you have bank account fees more than 16 euro?",
            "Bank Account Fees",
            220.0,
            "",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "Do you have bank account fees more than 16 euro?" &&
          widget.CheckQuestion == "Bank Account Fees") {
        if (widget.CheckAnswer[0] == "Yes") {
          return financecalculationContainer(
              """

<p><strong>Accident insurance: contribution payment</strong></p>
<p>Please enter your <strong>annual contribution from 2019</strong> for your private accident insurance.</p>
<p>The amount can be found on your insurance certificate, which you received when the insurance was taken out.</p>
<p> </p>

""",
              "",
              "Finances",
              "What is the amount of bank account fees?",
              "Bank Account Fee",
              220.0,
              "calculation",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "No") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          return financeyesnoContainer(
              """

<p><strong>Church membership in tax year</strong></p>
<p>Please indicate here if you were a member of a church in 2019.</p>
<p> </p>

""",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?",
              "Church membership {tax_year}",
              220.0,
              "",
              "",
              []);
        }
      }

      // ====== Accident insurance Ends ======

      // ====== Any Other Insurance Policies Ends ====== //

      //Answer No 23
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} been a member of a church in 2019?" &&
          widget.CheckQuestion == "Church membership {tax_year}") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Have been a member of a church in 2019?');
          _insert('Have been a member of a church in 2019?', 'No', 'OK');

          //Question No 31
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} ever been a member of a church?",
              "Church membership",
              430.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Have been a member of a church in 2019?');
          _insert('Have been a member of a church in 2019?', 'skip', 'OK');

          //Question No 31
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Have ${Questions.financeYouIdentity} ever been a member of a church?",
              "Church membership",
              430.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Have been a member of a church in 2019?');
          _insert('Have been a member of a church in 2019?', 'Yes', 'OK');

          //Question No 33
          return financedifferentoptionContainer(
              """

<p><strong>Church membership</strong></p>
<p>To enter the church you belong to it is necessary to state the so called church tax code ('Kirchensteuermerkmal'). Choose the code that is listed on your annual payslip ('Lohnsteuerbescheinigung') for 2019.</p>
<p>You can find this code at the bottom left of your payslip where it says "Kirchensteuermerkmale".</p>
<p>"--" is also a church tax code. This code on your payslip means you do not pay any church tax.</p>
<p> </p>

""",
              "",
              "Finances",
              "What church did ${Questions.financeYouIdentity} belong to in 2019?",
              "Church tax",
              [
                "evangelisch",
                "römisch-katholisch",
                "altkatholisch",
                "evangelisch-reformiert",
                "französisch-reformiert",
                "freie Religionsgemeinschaft Alzey",
                "freireligiöse Gemeinde Offenbach",
                "Kirchensteuer der Freireligiösen Landesgemeinde Baden",
                "freireligöse Landesgemeinde Pfalz",
                "Kirchensteuer der Israelitischen Religionsgemeinschaft Baden",
                "Jüdische Kultusgemeinden Bad Kreuznach und Koblenz",
                "Kirchensteur der Israelitischen Religionsgemeinschaft Württemberg",
                "Saarland: israelitisch",
                "Jüdische Gemeinde Frankfurt",
                "Jüdische Gemeinde Hamburg",
                "israelitische Kultussteuer der Kultusberechtigten Gemeinden",
                "Landesverband der israelitischen Kultusgemeinden in Bayern",
                "Nordrhein-Westfalen: israelitisch (jüdisch)",
                "Evangelisch-Reformiert (Bückeberg)",
                "Evangelisch-Reformiert (Stadthagen)",
                "Other"
              ],
              220.0,
              "",
              "",
              []);
        }
      }

      //Answer No 31
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} ever been a member of a church?" &&
          widget.CheckQuestion == "Church membership") {
        if (widget.CheckAnswer[0] == "No" ||
            widget.CheckAnswer[0] == "Yes" ||
            widget.CheckAnswer[0] == "skip") {
          //For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.financePartner == true) {
            financePartner();

            if (Questions.occupationMiniJobFinance == "Minijob") {
              //Question No 76
              return financedifferentoptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Finances",
                  "Does ${Questions.financeYourIdentity} job meet one of the following criteria?",
                  "Specialist activity",
                  [
                    "Official",
                    "Managing director",
                    "Judge",
                    "Intern",
                    "Soldier",
                    "No"
                  ],
                  220.0,
                  "",
                  "",
                  []);
            } else {
              //Question No 1
              return financemultipleoptionsContainer(
                  """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
                  "",
                  "Finances",
                  "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
                  "Pensions/Life insurances",
                  [
                    "'Riester' pension",
                    "Rürup pension",
                    "Private pension with capital voting rights",
                    "Private pension without capital voting rights",
                    "Endowment insurance",
                    "Life insurance",
                    "Additional contribution statutory pension",
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
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  "",
                  []);
            }
          }

          // For You & Partner
          else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            financeYouPartner();
            //Question No 32(Partner)
            return financemultipleoptionsContainer(
                """<p><strong>Donations</strong></p>
<p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
<p>You can click multiple options. If you did not make a donation, click "No".</p>
<p><strong>Charity in Germany</strong></p>
<p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
<ul>
<li>Caritas Association</li>
<li>Bread for the World</li>
<li>Kindernothilfe</li>
</ul>
<p><strong>CHARITY IN EU / EEA</strong></p>
<p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
<p><strong>RELIGIOUS ORGANIZATION</strong></p>
<p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
<p><strong>POLITICAL PARTY</strong></p>
<p>Donations to national political parties are tax deductible and can be included here.</p>
<p>The parties include the following:</p>
<ul>
<li>CDU</li>
<li>SPD</li>
<li>DIE LINKE</li>
<li>Green Party ('GRÜNE') etc.</li>
</ul>
<p><strong>VOTERS' ASSOCIATIONS</strong></p>
<p>These are associations which do not claim the status of a political party.</p>
<p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
<p>Generally the following also belong to the national tax exempt organizations:</p>
<ul>
<li>churches</li>
<li>universities</li>
<li>national museums</li>
<li>non-profit associations and foundations</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>A donation is a <strong>something you give without any compensation</strong>.</p>
<p>You can donate the following, for example:</p>
<ul>
<li>money</li>
<li>old clothes</li>
<li>used items</li>
</ul>
<p> </p>
<p> </p>""",
                "",
                "Donations and membership fees",
                "Has one or both of you made a donation?",
                "Donations",
                [
                  "National charities",
                  "Charitable institutions (EU/EEA)",
                  "Religious community",
                  "Political party",
                  "Voter group",
                  "Other tax privileged organizations",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          } else {
            //Question No 32
            return financemultipleoptionsContainer(
                """<p><strong>Donations</strong></p>
<p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
<p>You can click multiple options. If you did not make a donation, click "No".</p>
<p><strong>Charity in Germany</strong></p>
<p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
<ul>
<li>Caritas Association</li>
<li>Bread for the World</li>
<li>Kindernothilfe</li>
</ul>
<p><strong>CHARITY IN EU / EEA</strong></p>
<p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
<p><strong>RELIGIOUS ORGANIZATION</strong></p>
<p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
<p><strong>POLITICAL PARTY</strong></p>
<p>Donations to national political parties are tax deductible and can be included here.</p>
<p>The parties include the following:</p>
<ul>
<li>CDU</li>
<li>SPD</li>
<li>DIE LINKE</li>
<li>Green Party ('GRÜNE') etc.</li>
</ul>
<p><strong>VOTERS' ASSOCIATIONS</strong></p>
<p>These are associations which do not claim the status of a political party.</p>
<p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
<p>Generally the following also belong to the national tax exempt organizations:</p>
<ul>
<li>churches</li>
<li>universities</li>
<li>national museums</li>
<li>non-profit associations and foundations</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>A donation is a <strong>something you give without any compensation</strong>.</p>
<p>You can donate the following, for example:</p>
<ul>
<li>money</li>
<li>old clothes</li>
<li>used items</li>
</ul>
<p> </p>
<p> </p>""",
                "",
                "Donations and membership fees",
                "Have ${Questions.financeYouIdentity} made a donation?",
                "Donations",
                [
                  "National charities",
                  "Charitable institutions (EU/EEA)",
                  "Religious community",
                  "Political party",
                  "Voter group",
                  "Other tax privileged organizations",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          }
        }
      }

      //Answer No 33
      else if (widget.CheckCompleteQuestion ==
              "What church did ${Questions.financeYouIdentity} belong to in 2019?" &&
          widget.CheckQuestion == "Church tax") {
        //Question No 34
        return financeyesnoContainer(
            """<p><strong>Change of religion</strong></p>
<p>Choose "Yes" if there is another religious designation on your annual payslip or you changed your religion. Otherwise click "No".</p>
<p>If you changed religion in 2019 you will find a second entry on your annual payslip.</p>
<p>This is the case if:</p>
<ul>
<li>You entered a religion</li>
<li>You left a religion</li>
<li>You changed religion.</li>
</ul>
<p> </p>
<p> </p>""",
            "",
            "Finances",
            "Did anything regarding ${Questions.financeYourIdentity} church membership change in 2019?",
            "Change of church membership",
            430.0,
            "",
            "",
            []);
      }

      //Answer No 34
      else if (widget.CheckCompleteQuestion ==
              "Did anything regarding ${Questions.financeYourIdentity} church membership change in 2019?" &&
          widget.CheckQuestion == "Change of church membership") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did anything regarding church membership change in 2019?');
          _insert('Did anything regarding church membership change in 2019?',
              'No', 'OK');

          //For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.financePartner == true) {
            financePartner();

            if (Questions.occupationMiniJobFinance == "Minijob") {
              //Question No 76
              return financedifferentoptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Finances",
                  "Does ${Questions.financeYourIdentity} job meet one of the following criteria?",
                  "Specialist activity",
                  [
                    "Official",
                    "Managing director",
                    "Judge",
                    "Intern",
                    "Soldier",
                    "No"
                  ],
                  220.0,
                  "",
                  "",
                  []);
            } else {
              //Question No 1
              return financemultipleoptionsContainer(
                  """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
                  "",
                  "Finances",
                  "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
                  "Pensions/Life insurances",
                  [
                    "'Riester' pension",
                    "Rürup pension",
                    "Private pension with capital voting rights",
                    "Private pension without capital voting rights",
                    "Endowment insurance",
                    "Life insurance",
                    "Additional contribution statutory pension",
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
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  "",
                  []);
            }
          }

          // For You & Partner
          else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            financeYouPartner();
            //Question No 32(Partner)
            return financemultipleoptionsContainer(
                """<p><strong>Donations</strong></p>
<p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
<p>You can click multiple options. If you did not make a donation, click "No".</p>
<p><strong>Charity in Germany</strong></p>
<p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
<ul>
<li>Caritas Association</li>
<li>Bread for the World</li>
<li>Kindernothilfe</li>
</ul>
<p><strong>CHARITY IN EU / EEA</strong></p>
<p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
<p><strong>RELIGIOUS ORGANIZATION</strong></p>
<p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
<p><strong>POLITICAL PARTY</strong></p>
<p>Donations to national political parties are tax deductible and can be included here.</p>
<p>The parties include the following:</p>
<ul>
<li>CDU</li>
<li>SPD</li>
<li>DIE LINKE</li>
<li>Green Party ('GRÜNE') etc.</li>
</ul>
<p><strong>VOTERS' ASSOCIATIONS</strong></p>
<p>These are associations which do not claim the status of a political party.</p>
<p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
<p>Generally the following also belong to the national tax exempt organizations:</p>
<ul>
<li>churches</li>
<li>universities</li>
<li>national museums</li>
<li>non-profit associations and foundations</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>A donation is a <strong>something you give without any compensation</strong>.</p>
<p>You can donate the following, for example:</p>
<ul>
<li>money</li>
<li>old clothes</li>
<li>used items</li>
</ul>
<p> </p>
<p> </p>""",
                "",
                "Donations and membership fees",
                "Has one or both of you made a donation?",
                "Donations",
                [
                  "National charities",
                  "Charitable institutions (EU/EEA)",
                  "Religious community",
                  "Political party",
                  "Voter group",
                  "Other tax privileged organizations",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          } else {
            //Question No 32
            return financemultipleoptionsContainer(
                """<p><strong>Donations</strong></p>
<p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
<p>You can click multiple options. If you did not make a donation, click "No".</p>
<p><strong>Charity in Germany</strong></p>
<p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
<ul>
<li>Caritas Association</li>
<li>Bread for the World</li>
<li>Kindernothilfe</li>
</ul>
<p><strong>CHARITY IN EU / EEA</strong></p>
<p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
<p><strong>RELIGIOUS ORGANIZATION</strong></p>
<p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
<p><strong>POLITICAL PARTY</strong></p>
<p>Donations to national political parties are tax deductible and can be included here.</p>
<p>The parties include the following:</p>
<ul>
<li>CDU</li>
<li>SPD</li>
<li>DIE LINKE</li>
<li>Green Party ('GRÜNE') etc.</li>
</ul>
<p><strong>VOTERS' ASSOCIATIONS</strong></p>
<p>These are associations which do not claim the status of a political party.</p>
<p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
<p>Generally the following also belong to the national tax exempt organizations:</p>
<ul>
<li>churches</li>
<li>universities</li>
<li>national museums</li>
<li>non-profit associations and foundations</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>A donation is a <strong>something you give without any compensation</strong>.</p>
<p>You can donate the following, for example:</p>
<ul>
<li>money</li>
<li>old clothes</li>
<li>used items</li>
</ul>
<p> </p>
<p> </p>""",
                "",
                "Donations and membership fees",
                "Have ${Questions.financeYouIdentity} made a donation?",
                "Donations",
                [
                  "National charities",
                  "Charitable institutions (EU/EEA)",
                  "Religious community",
                  "Political party",
                  "Voter group",
                  "Other tax privileged organizations",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did anything regarding church membership change in 2019?');
          _insert('Did anything regarding church membership change in 2019?',
              'skip', 'OK');

          //For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.financePartner == true) {
            financePartner();

            if (Questions.occupationMiniJobFinance == "Minijob") {
              //Question No 76
              return financedifferentoptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Finances",
                  "Does ${Questions.financeYourIdentity} job meet one of the following criteria?",
                  "Specialist activity",
                  [
                    "Official",
                    "Managing director",
                    "Judge",
                    "Intern",
                    "Soldier",
                    "No"
                  ],
                  220.0,
                  "",
                  "",
                  []);
            } else {
              //Question No 1
              return financemultipleoptionsContainer(
                  """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
                  "",
                  "Finances",
                  "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
                  "Pensions/Life insurances",
                  [
                    "'Riester' pension",
                    "Rürup pension",
                    "Private pension with capital voting rights",
                    "Private pension without capital voting rights",
                    "Endowment insurance",
                    "Life insurance",
                    "Additional contribution statutory pension",
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
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  "",
                  []);
            }
          }

          // For You & Partner
          else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            financeYouPartner();
            //Question No 32(Partner)
            return financemultipleoptionsContainer(
                """<p><strong>Donations</strong></p>
<p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
<p>You can click multiple options. If you did not make a donation, click "No".</p>
<p><strong>Charity in Germany</strong></p>
<p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
<ul>
<li>Caritas Association</li>
<li>Bread for the World</li>
<li>Kindernothilfe</li>
</ul>
<p><strong>CHARITY IN EU / EEA</strong></p>
<p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
<p><strong>RELIGIOUS ORGANIZATION</strong></p>
<p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
<p><strong>POLITICAL PARTY</strong></p>
<p>Donations to national political parties are tax deductible and can be included here.</p>
<p>The parties include the following:</p>
<ul>
<li>CDU</li>
<li>SPD</li>
<li>DIE LINKE</li>
<li>Green Party ('GRÜNE') etc.</li>
</ul>
<p><strong>VOTERS' ASSOCIATIONS</strong></p>
<p>These are associations which do not claim the status of a political party.</p>
<p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
<p>Generally the following also belong to the national tax exempt organizations:</p>
<ul>
<li>churches</li>
<li>universities</li>
<li>national museums</li>
<li>non-profit associations and foundations</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>A donation is a <strong>something you give without any compensation</strong>.</p>
<p>You can donate the following, for example:</p>
<ul>
<li>money</li>
<li>old clothes</li>
<li>used items</li>
</ul>
<p> </p>
<p> </p>""",
                "",
                "Donations and membership fees",
                "Has one or both of you made a donation?",
                "Donations",
                [
                  "National charities",
                  "Charitable institutions (EU/EEA)",
                  "Religious community",
                  "Political party",
                  "Voter group",
                  "Other tax privileged organizations",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          } else {
            //Question No 32
            return financemultipleoptionsContainer(
                """<p><strong>Donations</strong></p>
<p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
<p>You can click multiple options. If you did not make a donation, click "No".</p>
<p><strong>Charity in Germany</strong></p>
<p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
<ul>
<li>Caritas Association</li>
<li>Bread for the World</li>
<li>Kindernothilfe</li>
</ul>
<p><strong>CHARITY IN EU / EEA</strong></p>
<p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
<p><strong>RELIGIOUS ORGANIZATION</strong></p>
<p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
<p><strong>POLITICAL PARTY</strong></p>
<p>Donations to national political parties are tax deductible and can be included here.</p>
<p>The parties include the following:</p>
<ul>
<li>CDU</li>
<li>SPD</li>
<li>DIE LINKE</li>
<li>Green Party ('GRÜNE') etc.</li>
</ul>
<p><strong>VOTERS' ASSOCIATIONS</strong></p>
<p>These are associations which do not claim the status of a political party.</p>
<p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
<p>Generally the following also belong to the national tax exempt organizations:</p>
<ul>
<li>churches</li>
<li>universities</li>
<li>national museums</li>
<li>non-profit associations and foundations</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>A donation is a <strong>something you give without any compensation</strong>.</p>
<p>You can donate the following, for example:</p>
<ul>
<li>money</li>
<li>old clothes</li>
<li>used items</li>
</ul>
<p> </p>
<p> </p>""",
                "",
                "Donations and membership fees",
                "Have ${Questions.financeYouIdentity} made a donation?",
                "Donations",
                [
                  "National charities",
                  "Charitable institutions (EU/EEA)",
                  "Religious community",
                  "Political party",
                  "Voter group",
                  "Other tax privileged organizations",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did anything regarding church membership change in 2019?');
          _insert('Did anything regarding church membership change in 2019?',
              'Yes', 'OK');

          //Question No 35
          return financedateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "When did ${Questions.financeYouIdentity} change religion in 2019?",
              "Change of religion",
              220.0,
              "",
              "", []);
        }
      } else if (widget.CheckCompleteQuestion ==
              "What was your religion after?" &&
          widget.CheckQuestion == "Religion after") {
        return financemultipleoptionsContainer(
            """<p><strong>Donations</strong></p>
<p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
<p>You can click multiple options. If you did not make a donation, click "No".</p>
<p><strong>Charity in Germany</strong></p>
<p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
<ul>
<li>Caritas Association</li>
<li>Bread for the World</li>
<li>Kindernothilfe</li>
</ul>
<p><strong>CHARITY IN EU / EEA</strong></p>
<p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
<p><strong>RELIGIOUS ORGANIZATION</strong></p>
<p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
<p><strong>POLITICAL PARTY</strong></p>
<p>Donations to national political parties are tax deductible and can be included here.</p>
<p>The parties include the following:</p>
<ul>
<li>CDU</li>
<li>SPD</li>
<li>DIE LINKE</li>
<li>Green Party ('GRÜNE') etc.</li>
</ul>
<p><strong>VOTERS' ASSOCIATIONS</strong></p>
<p>These are associations which do not claim the status of a political party.</p>
<p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
<p>Generally the following also belong to the national tax exempt organizations:</p>
<ul>
<li>churches</li>
<li>universities</li>
<li>national museums</li>
<li>non-profit associations and foundations</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>A donation is a <strong>something you give without any compensation</strong>.</p>
<p>You can donate the following, for example:</p>
<ul>
<li>money</li>
<li>old clothes</li>
<li>used items</li>
</ul>
<p> </p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "Have ${Questions.financeYouIdentity} made a donation?",
            "Donations",
            [
              "National charities",
              "Charitable institutions (EU/EEA)",
              "Religious community",
              "Political party",
              "Voter group",
              "Other tax privileged organizations",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      } else if (widget.CheckCompleteQuestion ==
              "What was your religion before?" &&
          widget.CheckQuestion == "Religion before") {
        return financedifferentoptionContainer(
            """

<p><strong>Church membership</strong></p>
<p>To enter the church you belong to it is necessary to state the so called church tax code ('Kirchensteuermerkmal'). Choose the code that is listed on your annual payslip ('Lohnsteuerbescheinigung') for 2019.</p>
<p>You can find this code at the bottom left of your payslip where it says "Kirchensteuermerkmale".</p>
<p>"--" is also a church tax code. This code on your payslip means you do not pay any church tax.</p>
<p> </p>

""",
            "",
            "Finances",
            "What was your religion after?",
            "Religion after",
            [
              "evangelisch",
              "römisch-katholisch",
              "altkatholisch",
              "evangelisch-reformiert",
              "französisch-reformiert",
              "freie Religionsgemeinschaft Alzey",
              "freireligiöse Gemeinde Offenbach",
              "Kirchensteuer der Freireligiösen Landesgemeinde Baden",
              "freireligöse Landesgemeinde Pfalz",
              "Kirchensteuer der Israelitischen Religionsgemeinschaft Baden",
              "Jüdische Kultusgemeinden Bad Kreuznach und Koblenz",
              "Kirchensteur der Israelitischen Religionsgemeinschaft Württemberg",
              "Saarland: israelitisch",
              "Jüdische Gemeinde Frankfurt",
              "Jüdische Gemeinde Hamburg",
              "israelitische Kultussteuer der Kultusberechtigten Gemeinden",
              "Landesverband der israelitischen Kultusgemeinden in Bayern",
              "Nordrhein-Westfalen: israelitisch (jüdisch)",
              "Evangelisch-Reformiert (Bückeberg)",
              "Evangelisch-Reformiert (Stadthagen)",
              "Other"
            ],
            220.0,
            "",
            "",
            []);
      }

      //Answer No 35
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.financeYouIdentity} change religion in 2019?" &&
          widget.CheckQuestion == "Change of religion") {
        return financedifferentoptionContainer(
            """

<p><strong>Church membership</strong></p>
<p>To enter the church you belong to it is necessary to state the so called church tax code ('Kirchensteuermerkmal'). Choose the code that is listed on your annual payslip ('Lohnsteuerbescheinigung') for 2019.</p>
<p>You can find this code at the bottom left of your payslip where it says "Kirchensteuermerkmale".</p>
<p>"--" is also a church tax code. This code on your payslip means you do not pay any church tax.</p>
<p> </p>

""",
            "",
            "Finances",
            "What was your religion before?",
            "Religion before",
            [
              "evangelisch",
              "römisch-katholisch",
              "altkatholisch",
              "evangelisch-reformiert",
              "französisch-reformiert",
              "freie Religionsgemeinschaft Alzey",
              "freireligiöse Gemeinde Offenbach",
              "Kirchensteuer der Freireligiösen Landesgemeinde Baden",
              "freireligöse Landesgemeinde Pfalz",
              "Kirchensteuer der Israelitischen Religionsgemeinschaft Baden",
              "Jüdische Kultusgemeinden Bad Kreuznach und Koblenz",
              "Kirchensteur der Israelitischen Religionsgemeinschaft Württemberg",
              "Saarland: israelitisch",
              "Jüdische Gemeinde Frankfurt",
              "Jüdische Gemeinde Hamburg",
              "israelitische Kultussteuer der Kultusberechtigten Gemeinden",
              "Landesverband der israelitischen Kultusgemeinden in Bayern",
              "Nordrhein-Westfalen: israelitisch (jüdisch)",
              "Evangelisch-Reformiert (Bückeberg)",
              "Evangelisch-Reformiert (Stadthagen)",
              "Other"
            ],
            220.0,
            "",
            "",
            []);

        //For Partner
//         if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
//             Questions.financePartner == true) {
//           financePartner();

//           if (Questions.occupationMiniJobFinance == "Minijob") {
//             //Question No 76
//             return financedifferentoptionContainer(
//                 "<h1>Coming Soon!</h1>",
//                 "",
//                 "Finances",
//                 "Does ${Questions.financeYourIdentity} job meet one of the following criteria?",
//                 "Specialist activity",
//                 [
//                   "Official",
//                   "Managing director",
//                   "Judge",
//                   "Intern",
//                   "Soldier",
//                   "No"
//                 ],
//                 220.0,
//                 "",
//                 "",
//                 []);
//           } else {
//             //Question No 1
//             return financemultipleoptionsContainer(
//                 """<p><strong>Pension and life insurance</strong></p>
// <p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
// <p><strong>RIESTER PENSION</strong></p>
// <p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
// <p><strong>RÜRUP PENSION</strong></p>
// <p>If you have a Rürup pension insurance, enter the contributions here.</p>
// <p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
// <p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
// <p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
// <p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
// <p><strong>Capital voting rights explained</strong></p>
// <p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
// <p><strong>ENDOWMENT INSURANCE</strong></p>
// <p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
// <p><strong>LIFE INSURANCE</strong></p>
// <p>If you pay for life insurance, choose this point.</p>
// <p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
// <p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
// <p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
// <p> </p>""",
//                 "",
//                 "Finances",
//                 "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
//                 "Pensions/Life insurances",
//                 [
//                   "'Riester' pension",
//                   "Rürup pension",
//                   "Private pension with capital voting rights",
//                   "Private pension without capital voting rights",
//                   "Endowment insurance",
//                   "Life insurance",
//                   "Additional contribution statutory pension",
//                   "No"
//                 ],
//                 [
//                   "images/disabilityoption.png",
//                   "images/alimonypaidoption.png",
//                   "images/survivorspension.png",
//                   "images/check.png",
//                   "images/check.png",
//                   "images/check.png",
//                   "images/check.png",
//                   "images/check.png"
//                 ],
//                 220.0,
//                 "No",
//                 "",
//                 []);
//           }
//         }

//         // For You & Partner
//         else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
//           financeYouPartner();
//           //Question No 32(Partner)
//           return financemultipleoptionsContainer(
//               """<p><strong>Donations</strong></p>
// <p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
// <p>You can click multiple options. If you did not make a donation, click "No".</p>
// <p><strong>Charity in Germany</strong></p>
// <p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
// <ul>
// <li>Caritas Association</li>
// <li>Bread for the World</li>
// <li>Kindernothilfe</li>
// </ul>
// <p><strong>CHARITY IN EU / EEA</strong></p>
// <p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
// <p><strong>RELIGIOUS ORGANIZATION</strong></p>
// <p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
// <p><strong>POLITICAL PARTY</strong></p>
// <p>Donations to national political parties are tax deductible and can be included here.</p>
// <p>The parties include the following:</p>
// <ul>
// <li>CDU</li>
// <li>SPD</li>
// <li>DIE LINKE</li>
// <li>Green Party ('GRÜNE') etc.</li>
// </ul>
// <p><strong>VOTERS' ASSOCIATIONS</strong></p>
// <p>These are associations which do not claim the status of a political party.</p>
// <p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
// <p>Generally the following also belong to the national tax exempt organizations:</p>
// <ul>
// <li>churches</li>
// <li>universities</li>
// <li>national museums</li>
// <li>non-profit associations and foundations</li>
// </ul>
// <p><strong>YOUR TAXES</strong></p>
// <p>A donation is a <strong>something you give without any compensation</strong>.</p>
// <p>You can donate the following, for example:</p>
// <ul>
// <li>money</li>
// <li>old clothes</li>
// <li>used items</li>
// </ul>
// <p> </p>
// <p> </p>""",
//               "",
//               "Donations and membership fees",
//               "Has one or both of you made a donation?",
//               "Donations",
//               [
//                 "National charities",
//                 "Charitable institutions (EU/EEA)",
//                 "Religious community",
//                 "Political party",
//                 "Voter group",
//                 "Other tax privileged organizations",
//                 "No"
//               ],
//               [
//                 "images/disabilityoption.png",
//                 "images/alimonypaidoption.png",
//                 "images/survivorspension.png",
//                 "images/check.png",
//                 "images/check.png",
//                 "images/check.png",
//                 "images/check.png"
//               ],
//               220.0,
//               "No",
//               "",
//               []);
//         } else {
//           //Question No 32
//           return financemultipleoptionsContainer(
//               """<p><strong>Donations</strong></p>
// <p>If you donated something in 2019, then please select from the given answers what type of donation it was.</p>
// <p>You can click multiple options. If you did not make a donation, click "No".</p>
// <p><strong>Charity in Germany</strong></p>
// <p>This type of institution does not pursue any profit targets. They pursue social, cultural, or scientific objectives. Examples include the following:</p>
// <ul>
// <li>Caritas Association</li>
// <li>Bread for the World</li>
// <li>Kindernothilfe</li>
// </ul>
// <p><strong>CHARITY IN EU / EEA</strong></p>
// <p>This European foundation is designed to operate in the EU and the European Economic Area.</p>
// <p><strong>RELIGIOUS ORGANIZATION</strong></p>
// <p>Donations to religious organizations serve religious purposes. For example to religious organization can hold worship services, educate clergy and maintain the memory of the dead.</p>
// <p><strong>POLITICAL PARTY</strong></p>
// <p>Donations to national political parties are tax deductible and can be included here.</p>
// <p>The parties include the following:</p>
// <ul>
// <li>CDU</li>
// <li>SPD</li>
// <li>DIE LINKE</li>
// <li>Green Party ('GRÜNE') etc.</li>
// </ul>
// <p><strong>VOTERS' ASSOCIATIONS</strong></p>
// <p>These are associations which do not claim the status of a political party.</p>
// <p><strong>OTHER TAX EXEMPT INSTITUTIONS</strong></p>
// <p>Generally the following also belong to the national tax exempt organizations:</p>
// <ul>
// <li>churches</li>
// <li>universities</li>
// <li>national museums</li>
// <li>non-profit associations and foundations</li>
// </ul>
// <p><strong>YOUR TAXES</strong></p>
// <p>A donation is a <strong>something you give without any compensation</strong>.</p>
// <p>You can donate the following, for example:</p>
// <ul>
// <li>money</li>
// <li>old clothes</li>
// <li>used items</li>
// </ul>
// <p> </p>
// <p> </p>""",
//               "",
//               "Donations and membership fees",
//               "Have ${Questions.financeYouIdentity} made a donation?",
//               "Donations",
//               [
//                 "National charities",
//                 "Charitable institutions (EU/EEA)",
//                 "Religious community",
//                 "Political party",
//                 "Voter group",
//                 "Other tax privileged organizations",
//                 "No"
//               ],
//               [
//                 "images/disabilityoption.png",
//                 "images/alimonypaidoption.png",
//                 "images/survivorspension.png",
//                 "images/check.png",
//                 "images/check.png",
//                 "images/check.png",
//                 "images/check.png"
//               ],
//               220.0,
//               "No",
//               "",
//               []);
//         }
      }

      // ====== Donations and membership fees Starts ======= //

//Answer No 32 and 32(Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "Have ${Questions.financeYouIdentity} made a donation?" ||
              widget.CheckCompleteQuestion ==
                  "Has one or both of you made a donation?") &&
          widget.CheckQuestion == "Donations") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "National charities") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?', 'National charities', 'OK');

            //Question No 36
            //For No 340.0
            //For Yes 220.0
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Donations and membership fees",
                "Did ${Questions.financeYourIdentity} donations go to multiple charitable institutions in Germany?",
                "Multiple organizations",
                220.0,
                "",
                "", []);
          } else if (widget.CheckAnswer[m] ==
              "Charitable institutions (EU/EEA)") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?', 'Charitable institutions (EU/EEA)',
                'OK');

            //Question No 42
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Donations and membership fees",
                "Did ${Questions.financeYourIdentity} donations go to multiple charitable institutions in the EU?",
                "Multiple organizations",
                220.0,
                "",
                "", []);
          } else if (widget.CheckAnswer[m] == "Religious community") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?', 'Religious community', 'OK');

            //Question No 47
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Donations and membership fees",
                "Have ${Questions.financeYouIdentity} donated to several religious organizations?",
                "Several religious organizations",
                220.0,
                "",
                "", []);
          } else if (widget.CheckAnswer[m] == "Political party") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?', 'Political party', 'OK');

            //Question No 53
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Donations and membership fees",
                "Have ${Questions.financeYouIdentity} donated to several political parties?",
                "Multiple parties",
                220.0,
                "",
                "", []);
          } else if (widget.CheckAnswer[m] == "Voter group") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?', 'Voter group', 'OK');

            //Question No 60
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Donations and membership fees",
                "Have ${Questions.financeYouIdentity} donated to more than one voters association?",
                "Multiple organizations",
                220.0,
                "",
                "", []);
          } else if (widget.CheckAnswer[m] ==
              "Other tax privileged organizations") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?',
                'Other tax privileged organizations', 'OK');

            //Question No 66
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Donations and membership fees",
                "Have ${Questions.financeYouIdentity} donated to multiple projects?",
                "Multiple Projects",
                220.0,
                "",
                "", []);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?', 'No', 'OK');

            //For You & Partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 81
              return financeyesnoContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "",
                  "Have you agreed on joint property?",
                  "Joint property",
                  220.0,
                  "",
                  "", []);
            } else {
              return FinishCategory(
                  "Finances Category", "End Categories", 6, true);
            }
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Have made a donation?');
            _insert('Have made a donation?', 'skip', 'skip');

            //For You & Partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 81
              return financeyesnoContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "",
                  "Have you agreed on joint property?",
                  "Joint property",
                  220.0,
                  "",
                  "", []);
            } else {
              return FinishCategory(
                  "Finances Category", "End Categories", 6, true);
            }
          }
        }
      }

      // ====== National charities Starts ======

      //Answer No 36
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.financeYourIdentity} donations go to multiple charitable institutions in Germany?" &&
          widget.CheckQuestion == "Multiple organizations") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did donations go to multiple charitable institutions in Germany?');
          _insert(
              'Did donations go to multiple charitable institutions in Germany?',
              'No',
              'OK');

          //Question No 39
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?",
              "Confirmation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did donations go to multiple charitable institutions in Germany?');
          _insert(
              'Did donations go to multiple charitable institutions in Germany?',
              'skip',
              'skip');

          //Question No 39
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?",
              "Confirmation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did donations go to multiple charitable institutions in Germany?');
          _insert(
              'Did donations go to multiple charitable institutions in Germany?',
              'Yes',
              'OK');

          //Question No 37
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How many tax exempt organizations in Germany did ${Questions.financeYouIdentity} donate to?",
              "Number of organizations",
              340.0,
              "loop",
              "", []);
        }
      }

      //Answer No 37
      else if (widget.CheckCompleteQuestion ==
              "How many tax exempt organizations in Germany did ${Questions.financeYouIdentity} donate to?" &&
          widget.CheckQuestion == "Number of organizations") {
        //Question No 38
        return financethreeoptionContainer(
            """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?",
            "Donation confirmation no. ${Questions.financeOrganizationLength}",
            [
              "Donation receipt",
              "Account statement (in the case of donations up to 200EUR)",
              "Information was transmitted electronically"
            ],
            220.0,
            "",
            Questions.financeOrganizationText,
            []);
      }

      //Answer No 38 and Answer No 39
      else if (widget.CheckCompleteQuestion ==
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?" &&
          (widget.CheckQuestion ==
                  "Donation confirmation no. ${Questions.financeOrganizationLength}" ||
              widget.CheckQuestion == "Confirmation")) {
        if (widget.CheckAnswer[0] == "Donation receipt" ||
            widget.CheckAnswer[0] ==
                "Account statement (in the case of donations up to 200EUR)") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', widget.CheckAnswer[0],
              'OK');

          //Question No 40
          return financecalculationContainer(
              """<p><strong>Amount of donation to organization</strong></p>
<p>In order for us to calculate exactly how much of your donation you can write off, please enter the <strong>amount of your donation</strong> to this organization.</p>
<p>Please enter the total amount that you donated to this organization in 2019.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of this non-profit organization?",
              "Non-profit organization",
              220.0,
              "",
              Questions.financeOrganizationText,
              []);
        } else if (widget.CheckAnswer[0] ==
            "Information was transmitted electronically") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?',
              'Information was transmitted electronically', 'OK');

          //Question No 41
          //mgar isma agar 40 ka baad 41 aya to wo 41 iswala 41 sa alag khulega
          return financecalculationContainer(
              """<p><p><strong>Amount of donation to religious organization</strong></p>
<p>In order for us to calculate exactly how much of your donation to a religious organization you can write off, we need to know how much you donated.</p>
<p><em>Please enter the </em><strong><em>amount of your donation</em></strong><em> here.</em></p>
<p>Please enter the total amount that you donated to this religious organization in 2019.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much money did ${Questions.financeYouIdentity} donate to this non-profit organization?",
              "Donation amount",
              220.0,
              "calculation",
              Questions.financeOrganizationText,
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', 'skip', 'skip');

          //Question No 41
          //mgar isma agar 40 ka baad 41 aya to wo 41 iswala 41 sa alag khulega
          return financecalculationContainer(
              """<p><p><strong>Amount of donation to religious organization</strong></p>
<p>In order for us to calculate exactly how much of your donation to a religious organization you can write off, we need to know how much you donated.</p>
<p><em>Please enter the </em><strong><em>amount of your donation</em></strong><em> here.</em></p>
<p>Please enter the total amount that you donated to this religious organization in 2019.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much money did ${Questions.financeYouIdentity} donate to this non-profit organization?",
              "Donation amount",
              220.0,
              "calculation",
              Questions.financeOrganizationText,
              []);
        }
      }

      //Answer No 40
      else if (widget.CheckCompleteQuestion ==
              "What is the name of this non-profit organization?" &&
          widget.CheckQuestion == "Non-profit organization") {
        //Question No 41
        return financecalculationContainer(
            """<p><p><strong>Amount of donation to religious organization</strong></p>
<p>In order for us to calculate exactly how much of your donation to a religious organization you can write off, we need to know how much you donated.</p>
<p><em>Please enter the </em><strong><em>amount of your donation</em></strong><em> here.</em></p>
<p>Please enter the total amount that you donated to this religious organization in 2019.</p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "How much money did ${Questions.financeYouIdentity} donate to this non-profit organization?",
            "Donation amount",
            220.0,
            "calculation",
            Questions.financeOrganizationText,
            []);
      }

      //Answer No 41
      else if (widget.CheckCompleteQuestion ==
              "How much money did ${Questions.financeYouIdentity} donate to this non-profit organization?" &&
          widget.CheckQuestion == "Donation amount") {
        if (Questions.financeOrganizationLength <=
                Questions.totalFinanceOrganization &&
            Questions.totalFinanceOrganization > 0) {
          //Question No 38
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?",
              "Donation confirmation no. ${Questions.financeOrganizationLength}",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              Questions.financeOrganizationText,
              []);
        } else {
          //For You & Partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 81
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "",
                "Have you agreed on joint property?",
                "Joint property",
                220.0,
                "",
                "", []);
          } else {
            return FinishCategory(
                "Finances Category", "End Categories", 6, true);
          }
        }
      }

      // ====== National charities Ends ======

      // ====== Charitable institutions (EU/EEA) Starts ======

      //Answer No 42
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.financeYourIdentity} donations go to multiple charitable institutions in the EU?" &&
          widget.CheckQuestion == "Multiple organizations") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did donations go to multiple charitable institutions in the EU?');
          _insert(
              'Did donations go to multiple charitable institutions in the EU?',
              'No',
              'OK');

//Question No 45
          return financecalculationContainer(
              """<p><strong>Donations to charities in the EU</strong></p>
<p>Enter the name of the European charity to which you have donated.</p>
<p><strong>Your taxes</strong></p>
<p>Donations to charities that are based in other EU countries are tax deductible in Germany.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of the European organization?",
              "EU organization name",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did donations go to multiple charitable institutions in the EU?');
          _insert(
              'Did donations go to multiple charitable institutions in the EU?',
              'skip',
              'skip');

//Question No 45
          return financecalculationContainer(
              """<p><strong>Donations to charities in the EU</strong></p>
<p>Enter the name of the European charity to which you have donated.</p>
<p><strong>Your taxes</strong></p>
<p>Donations to charities that are based in other EU countries are tax deductible in Germany.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of the European organization?",
              "EU organization name",
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did donations go to multiple charitable institutions in the EU?');
          _insert(
              'Did donations go to multiple charitable institutions in the EU?',
              'Yes',
              'OK');

          //Question No 43
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How many organizations did ${Questions.financeYouIdentity} donate to?",
              "Number of organizations",
              220.0,
              "loop",
              "", []);
        }
      }

      //Answer No 43
      else if (widget.CheckCompleteQuestion ==
              "How many organizations did ${Questions.financeYouIdentity} donate to?" &&
          widget.CheckQuestion == "Number of organizations") {
        //Question No 44
        return financecalculationContainer(
            """<p><strong>Donations to charities in the EU</strong></p>
<p>Enter the name of the European charity to which you have donated.</p>
<p><strong>Your taxes</strong></p>
<p>Donations to charities that are based in other EU countries are tax deductible in Germany.</p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "What is the name of the European organization?",
            "${Questions.financeEuOrganizationLength}. European organizations",
            220.0,
            "",
            Questions.financeEuOrganizationText,
            []);
      }

      //Answer No 44 and Answer No 45
      else if (widget.CheckCompleteQuestion ==
              "What is the name of the European organization?" &&
          (widget.CheckQuestion ==
                  "${Questions.financeEuOrganizationLength}. European organizations" ||
              widget.CheckQuestion == "EU organization name")) {
        //Question No 46
        return financecalculationContainer(
            """<p><strong>Amount of donation to religious organization</strong></p>
<p>In order for us to calculate exactly how much of your donation to a religious organization you can write off, we need to know how much you donated.</p>
<p><em>Please enter the </em><strong><em>amount of your donation</em></strong><em> here.</em></p>
<p>Please enter the total amount that you donated to this religious organization in 2019.</p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "How much money did ${Questions.financeYouIdentity} donate to this organization?",
            "Donated amount",
            220.0,
            "calculation",
            Questions.financeEuOrganizationText,
            []);
      }

      //Answer No 46
      else if (widget.CheckCompleteQuestion ==
              "How much money did ${Questions.financeYouIdentity} donate to this organization?" &&
          widget.CheckQuestion == "Donated amount") {
        if (Questions.financeEuOrganizationLength <=
                Questions.totalFinanceEuOrganization &&
            Questions.totalFinanceEuOrganization > 0) {
          //Question No 44
          return financecalculationContainer(
              """<p><strong>Donations to charities in the EU</strong></p>
<p>Enter the name of the European charity to which you have donated.</p>
<p><strong>Your taxes</strong></p>
<p>Donations to charities that are based in other EU countries are tax deductible in Germany.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of the European organization?",
              "${Questions.financeEuOrganizationLength}. European organizations",
              220.0,
              "",
              Questions.financeEuOrganizationText,
              []);
        } else {
          //For You & Partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 81
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "",
                "Have you agreed on joint property?",
                "Joint property",
                220.0,
                "",
                "", []);
          } else {
            return FinishCategory(
                "Finances Category", "End Categories", 6, true);
          }
        }
      }

      // ====== Charitable institutions (EU/EEA) Ends ======

      // ====== Religious community Starts ====== //

      //Answer No 47
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} donated to several religious organizations?" &&
          widget.CheckQuestion == "Several religious organizations") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have donated to several religious organizations?');
          _insert(
              'Have donated to several religious organizations?', 'No', 'OK');

//Question No 50
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation? ",
              "Confirmation of donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have donated to several religious organizations?');
          _insert('Have donated to several religious organizations?', 'skip',
              'skip');

//Question No 50
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation? ",
              "Confirmation of donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have donated to several religious organizations?');
          _insert(
              'Have donated to several religious organizations?', 'Yes', 'OK');

          //Question No 48
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How many religious organizations did ${Questions.financeYouIdentity} donate to?",
              "Number of organizations",
              340.0,
              "loop",
              "", []);
        }
      }

      //Answer No 48
      else if (widget.CheckCompleteQuestion ==
              "How many religious organizations did ${Questions.financeYouIdentity} donate to?" &&
          widget.CheckQuestion == "Number of organizations") {
        //Question No 49
        return financethreeoptionContainer(
            """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation? ",
            "Donation confirmation no. ${Questions.financeReligiousLength}",
            [
              "Donation receipt",
              "Account statement (in the case of donations up to 200EUR)",
              "Information was transmitted electronically"
            ],
            220.0,
            "",
            Questions.financeReligiousText,
            []);
      }

      //Answer No 49 and Answer No 50

      else if (widget.CheckCompleteQuestion ==
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?" &&
          (widget.CheckQuestion ==
                  "Donation confirmation no. ${Questions.financeReligiousLength}" ||
              widget.CheckQuestion == "Confirmation of donation")) {
        if (widget.CheckAnswer[0] == "Donation receipt" ||
            widget.CheckAnswer[0] ==
                "Account statement (in the case of donations up to 200EUR)") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', widget.CheckAnswer[0],
              'OK');

          //Question No 51
          return financecalculationContainer(
              """<p><strong>Donations to religious organization</strong></p>
<p>Donations to religious organizations are tax deductible so enter the <strong>name</strong> of the religious organization you made a donation to.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of the religious community?",
              "Religious community",
              220.0,
              "",
              Questions.financeReligiousText,
              []);
        } else if (widget.CheckAnswer[0] ==
            "Information was transmitted electronically") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?',
              'Information was transmitted electronically', 'OK');
          //Question No 52
          //mgar isma agar 51 ka baad 52 aya to wo 51 iswala 52 sa alag khulega
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How much money did ${Questions.financeYouIdentity} donate?",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financeReligiousText, []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', 'skip', 'OK');

          //Question No 52
          //mgar isma agar 51 ka baad 52 aya to wo 51 iswala 52 sa alag khulega
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How much money did ${Questions.financeYouIdentity} donate?",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financeReligiousText, []);
        }
      }

      //Answer No 51
      else if (widget.CheckCompleteQuestion ==
              "What is the name of the religious community?" &&
          widget.CheckQuestion == "Religious community") {
        //Question No 52
        return financecalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Donations and membership fees",
            "How much money did ${Questions.financeYouIdentity} donate?",
            "Donated amount",
            220.0,
            "calculation",
            Questions.financeReligiousText, []);
      }

      //Answer No 52
      else if (widget.CheckCompleteQuestion ==
              "How much money did ${Questions.financeYouIdentity} donate?" &&
          widget.CheckQuestion == "Donated amount") {
        if (Questions.financeReligiousLength <=
                Questions.totalFinanceReligious &&
            Questions.totalFinanceReligious > 0) {
          //Question No 49
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation? ",
              "Donation confirmation no. ${Questions.financeReligiousLength}",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              Questions.financeReligiousText,
              []);
        } else {
          //For You & Partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 81
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "",
                "Have you agreed on joint property?",
                "Joint property",
                220.0,
                "",
                "", []);
          } else {
            return FinishCategory(
                "Finances Category", "End Categories", 6, true);
          }
        }
      }

      // ====== Religious community Ends ====== //

      // ====== Political party Starts ====== //
      //Answer No 53

      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} donated to several political parties?" &&
          widget.CheckQuestion == "Multiple parties") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Have donated to several political parties?');
          _insert('Have donated to several political parties?', 'No', 'OK');

//Question No 56
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?  ",
              "Confirmation of donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Have donated to several political parties?');
          _insert('Have donated to several political parties?', 'skip', 'skip');

//Question No 56
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?  ",
              "Confirmation of donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Have donated to several political parties?');
          _insert('Have donated to several political parties?', 'Yes', 'OK');

          //Question No 54
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How many parties did ${Questions.financeYouIdentity} donate to?",
              "Number of party donations",
              340.0,
              "loop",
              "", []);
        }
      }

      //Answer No 54

      else if (widget.CheckCompleteQuestion ==
              "How many parties did ${Questions.financeYouIdentity} donate to?" &&
          widget.CheckQuestion == "Number of party donations") {
        //Question No 55
        return financethreeoptionContainer(
            """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?  ",
            "Donation confirmation no. ${Questions.financePartyLength}",
            [
              "Donation receipt",
              "Account statement (in the case of donations up to 200EUR)",
              "Information was transmitted electronically"
            ],
            220.0,
            "",
            Questions.financePartyText,
            []);
      }

      //Answer No 55 And Answer No 56
      else if (widget.CheckCompleteQuestion ==
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?  " &&
          (widget.CheckQuestion ==
                  "Donation confirmation no. ${Questions.financePartyLength}" ||
              widget.CheckQuestion == "Confirmation of donation")) {
        if (widget.CheckAnswer[0] == "Donation receipt" ||
            widget.CheckAnswer[0] ==
                "Account statement (in the case of donations up to 200EUR)") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', widget.CheckAnswer[0],
              'OK');

          //Question No 57
          return financedifferentoptionContainer(
              """<p><strong>Donations to a political party</strong></p>
<p>Donations to political parties are tax deductible so enter <strong>which party</strong> you made a donation to.</p>
<p>You can select between the predefined options.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of this party?",
              "Name of the party",
              [
                "CDU",
                "SPD",
                "DIE LINKE",
                "GRÜNE",
                "CSU",
                "FDP",
                "FREIE WAHLER",
                "PIRATEN",
                "OTHER"
              ],
              220.0,
              "",
              Questions.financePartyText,
              []);
        } else if (widget.CheckAnswer[0] ==
            "Information was transmitted electronically") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?',
              'Information was transmitted electronically', 'OK');
//Question No 59
          return financecalculationContainer(
              """<p><strong>Amount of donation to political party</strong></p>
<p>Please enter you much you donated to the political party in 2019.</p>
<p>Please enter the total amount you donated to this party in 2019.</p>
<p>Donations to political parties are tax deductible up to a total amount of 3,300 euros per year for single people and 6,600 euros for married couples.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much did ${Questions.financeYouIdentity} donate to this party?",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financePartyText,
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', 'skip', 'skip');

//Question No 59
          return financecalculationContainer(
              """<p><strong>Amount of donation to political party</strong></p>
<p>Please enter you much you donated to the political party in 2019.</p>
<p>Please enter the total amount you donated to this party in 2019.</p>
<p>Donations to political parties are tax deductible up to a total amount of 3,300 euros per year for single people and 6,600 euros for married couples.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much did ${Questions.financeYouIdentity} donate to this party?",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financePartyText,
              []);
        }
      }

      //Answer No 57

      else if (widget.CheckCompleteQuestion ==
              "What is the name of this party?" &&
          widget.CheckQuestion == "Name of the party") {
        if (widget.CheckAnswer[0] == "OTHER") {
          DbHelper.insatance
              .deleteWithquestion('What is the name of this party?');
          _insert('What is the name of this party?', Questions.financePartyText,
              'OK');
//Question No 58
          return financecalculationContainer(
              """<p><strong>Donations to a political party</strong></p>
<p>Donations to political parties are tax deductible so enter <strong>which party</strong> you made a donation to.</p>
<p>You can select between the predefined options.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of the other party?",
              "Name of the party",
              220.0,
              "",
              Questions.financePartyText,
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What is the name of this party?');
          _insert('What is the name of this party?', 'skip', 'skip');

//Question No 58
          return financecalculationContainer(
              """<p><strong>Donations to a political party</strong></p>
<p>Donations to political parties are tax deductible so enter <strong>which party</strong> you made a donation to.</p>
<p>You can select between the predefined options.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of the other party?",
              "Name of the party",
              220.0,
              "",
              Questions.financePartyText,
              []);
        } else {
          //Question No 59
          return financecalculationContainer(
              """<p><strong>Amount of donation to political party</strong></p>
<p>Please enter you much you donated to the political party in 2019.</p>
<p>Please enter the total amount you donated to this party in 2019.</p>
<p>Donations to political parties are tax deductible up to a total amount of 3,300 euros per year for single people and 6,600 euros for married couples.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much did ${Questions.financeYouIdentity} donate to this party?",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financePartyText,
              []);
        }
      }

      //Answer No 58
      else if (widget.CheckCompleteQuestion ==
              "What is the name of the other party?" &&
          widget.CheckQuestion == "Name of the party") {
        DbHelper.insatance
            .deleteWithquestion('What is the name of this party?');
        _insert('What is the name of this party?', Questions.financePartyText,
            'OK');

        //Question No 59
        return financecalculationContainer(
            """<p><strong>Amount of donation to political party</strong></p>
<p>Please enter you much you donated to the political party in 2019.</p>
<p>Please enter the total amount you donated to this party in 2019.</p>
<p>Donations to political parties are tax deductible up to a total amount of 3,300 euros per year for single people and 6,600 euros for married couples.</p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "How much did ${Questions.financeYouIdentity} donate to this party?",
            "Donated amount",
            220.0,
            "calculation",
            Questions.financePartyText,
            []);
      }

//Answer No 59
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} donate to this party?" &&
          widget.CheckQuestion == "Donated amount") {
        if (Questions.financePartyLength <= Questions.totalFinanceParty &&
            Questions.totalFinanceParty > 0) {
          //Question No 55
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?  ",
              "Donation confirmation no. ${Questions.financePartyLength}",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              Questions.financePartyText,
              []);
        } else {
          //For You & Partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 81
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "",
                "Have you agreed on joint property?",
                "Joint property",
                220.0,
                "",
                "", []);
          } else {
            return FinishCategory(
                "Finances Category", "End Categories", 6, true);
          }
        }
      }

      // ====== Political party Ends ====== //

      // ====== Voter Group Starts ====== //

      //Answer No 60
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} donated to more than one voters association?" &&
          widget.CheckQuestion == "Multiple organizations") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have donated to more than one voters association?');
          _insert(
              'Have donated to more than one voters association?', 'No', 'OK');

          //Question No 63
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?   ",
              "Confirmation of Donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have donated to more than one voters association?');
          _insert('Have donated to more than one voters association?', 'skip',
              'skip');

          //Question No 63
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?   ",
              "Confirmation of Donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have donated to more than one voters association?');
          _insert(
              'Have donated to more than one voters association?', 'Yes', 'OK');

          //Question No 61
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How many voters' associations did ${Questions.financeYouIdentity} donate to?",
              "Number of voter groups",
              340.0,
              "loop",
              "", []);
        }
      }

      //Answer No 61
      else if (widget.CheckCompleteQuestion ==
              "How many voters' associations did ${Questions.financeYouIdentity} donate to?" &&
          widget.CheckQuestion == "Number of voter groups") {
        //Question No 62
        return financethreeoptionContainer(
            """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?   ",
            "Donation confirmation no. ${Questions.financeVoterLength}",
            [
              "Donation receipt",
              "Account statement (in the case of donations up to 200EUR)",
              "Information was transmitted electronically"
            ],
            220.0,
            "",
            Questions.financeVoterText,
            []);
      }

      //Answer No 62 and Answer No 63

      else if (widget.CheckCompleteQuestion ==
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?   " &&
          (widget.CheckQuestion ==
                  "Donation confirmation no. ${Questions.financeVoterLength}" ||
              widget.CheckQuestion == "Confirmation of donation")) {
        if (widget.CheckAnswer[0] == "Donation receipt" ||
            widget.CheckAnswer[0] ==
                "Account statement (in the case of donations up to 200EUR)") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', widget.CheckAnswer[0],
              'OK');

          //Question No 64
          return financecalculationContainer(
              """<p><strong>Donations to independent voters' associations</strong></p>
<p>Donations to independent voters' associations are tax deductible so enter <strong>which voters' association</strong> you made a donation to.</p>
<p>Enter the name of the voters' association for it in the field.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of the voters' association?",
              "Name of voter group",
              220.0,
              "",
              Questions.financeVoterText,
              []);
        } else if (widget.CheckAnswer[0] ==
            "Information was transmitted electronically") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?',
              'Information was transmitted electronically', 'OK');

          //Question No 65
          return financecalculationContainer(
              """<p><strong>Amount of donation to independent voters' association</strong></p>
<p>Please enter the amount of your donations to the voters' association. Note only donations from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>The tax relief is up to <strong>825 euros</strong> (single people) and 1,650 euros (couples).</p>
<p>If the donation amount is higher, the remaining balance cannot be claimed as special expense as it can with political parties.</p>
<p>The donations must be verified with a <strong>donation receipt</strong>.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much did ${Questions.financeYouIdentity} donate to the voters' association?",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financeVoterText,
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', 'skip', 'skip');

          //Question No 65
          return financecalculationContainer(
              """<p><strong>Amount of donation to independent voters' association</strong></p>
<p>Please enter the amount of your donations to the voters' association. Note only donations from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>The tax relief is up to <strong>825 euros</strong> (single people) and 1,650 euros (couples).</p>
<p>If the donation amount is higher, the remaining balance cannot be claimed as special expense as it can with political parties.</p>
<p>The donations must be verified with a <strong>donation receipt</strong>.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much did ${Questions.financeYouIdentity} donate to the voters' association?",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financeVoterText,
              []);
        }
      }

      //Answer No 64
      else if (widget.CheckCompleteQuestion ==
              "What is the name of the voters' association?" &&
          widget.CheckQuestion == "Name of voter group") {
        //Question No 65
        return financecalculationContainer(
            """<p><strong>Amount of donation to independent voters' association</strong></p>
<p>Please enter the amount of your donations to the voters' association. Note only donations from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>The tax relief is up to <strong>825 euros</strong> (single people) and 1,650 euros (couples).</p>
<p>If the donation amount is higher, the remaining balance cannot be claimed as special expense as it can with political parties.</p>
<p>The donations must be verified with a <strong>donation receipt</strong>.</p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "How much did ${Questions.financeYouIdentity} donate to the voters' association?",
            "Donated amount",
            220.0,
            "calculation",
            Questions.financeVoterText,
            []);
      }

      //Answer No 65
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.financeYouIdentity} donate to the voters' association?" &&
          widget.CheckQuestion == "Donated amount") {
        if (Questions.financeVoterLength <= Questions.totalFinanceVoter &&
            Questions.totalFinanceVoter > 0) {
          //Question No 62
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?   ",
              "Donation confirmation no. ${Questions.financeVoterLength}",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              Questions.financeVoterText,
              []);
        } else {
          //For You & Partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 81
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "",
                "Have you agreed on joint property?",
                "Joint property",
                220.0,
                "",
                "", []);
          } else {
            return FinishCategory(
                "Finances Category", "End Categories", 6, true);
          }
        }
      }

      // ====== Voter Group Ends ====== //

      // ====== Other tax privileged organizations Starts ====== //
      //Answer No 66
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.financeYouIdentity} donated to multiple projects?" &&
          widget.CheckQuestion == "Multiple Projects") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Have donated to multiple projects?');
          _insert('Have donated to multiple projects?', 'No', 'OK');

          //Question No 69
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?    ",
              "Confirmation of donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Have donated to multiple projects?');
          _insert('Have donated to multiple projects?', 'skip', 'skip');

          //Question No 69
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?    ",
              "Confirmation of donation",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Have donated to multiple projects?');
          _insert('Have donated to multiple projects?', 'Yes', 'OK');

          //Question No 67
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Donations and membership fees",
              "How many other projects did ${Questions.financeYouIdentity} donate to?",
              "Number of projects",
              340.0,
              "loop",
              "", []);
        }
      }

      //Answer No 67
      else if (widget.CheckCompleteQuestion ==
              "How many other projects did ${Questions.financeYouIdentity} donate to?" &&
          widget.CheckQuestion == "Number of projects") {
        //Question No 68
        return financethreeoptionContainer(
            """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?    ",
            "Donation confirmation no. ${Questions.financeProjectLength}",
            [
              "Donation receipt",
              "Account statement (in the case of donations up to 200EUR)",
              "Information was transmitted electronically"
            ],
            220.0,
            "",
            Questions.financeProjectText,
            []);
      }

      //Answer No 68 and Answer No 69
      else if (widget.CheckCompleteQuestion ==
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?    " &&
          (widget.CheckQuestion ==
                  "Donation confirmation no. ${Questions.financeProjectLength}" ||
              widget.CheckQuestion == "Confirmation of donation")) {
        if (widget.CheckAnswer[0] == "Donation receipt" ||
            widget.CheckAnswer[0] ==
                "Account statement (in the case of donations up to 200EUR)") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', widget.CheckAnswer[0],
              'OK');
          //Question No 70
          return financecalculationContainer(
              """<p><strong>Amount of donation to organization</strong></p>
<p>In order for us to calculate exactly how much of your donation you can write off, please enter the <strong>amount of your donation</strong> to this organization.</p>
<p>Please enter the total amount that you donated to this organization in 2019.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What is the name of this non-profit organization? ",
              "Name of organization",
              220.0,
              "",
              Questions.financeProjectText,
              []);
        } else if (widget.CheckAnswer[0] ==
            "Information was transmitted electronically") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?',
              'Information was transmitted electronically', 'OK');

          //Question No 71
          return financecalculationContainer(
              """<p><strong>Amount of donation to religious organization</strong></p>
<p>In order for us to calculate exactly how much of your donation to a religious organization you can write off, we need to know how much you donated.</p>
<p><em>Please enter the </em><strong><em>amount of your donation</em></strong><em> here.</em></p>
<p>Please enter the total amount that you donated to this religious organization in 2019.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much money did ${Questions.financeYouIdentity} donate to this organization? ",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financeProjectText,
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What evidence do have for donation?');
          _insert('What evidence do have for donation?', 'skip', 'skip');

          //Question No 71
          return financecalculationContainer(
              """<p><strong>Amount of donation to religious organization</strong></p>
<p>In order for us to calculate exactly how much of your donation to a religious organization you can write off, we need to know how much you donated.</p>
<p><em>Please enter the </em><strong><em>amount of your donation</em></strong><em> here.</em></p>
<p>Please enter the total amount that you donated to this religious organization in 2019.</p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "How much money did ${Questions.financeYouIdentity} donate to this organization? ",
              "Donated amount",
              220.0,
              "calculation",
              Questions.financeProjectText,
              []);
        }
      }

      //Answer No 70
      else if (widget.CheckCompleteQuestion ==
              "What is the name of this non-profit organization? " &&
          widget.CheckQuestion == "Name of organization") {
        //Question No 71
        return financecalculationContainer(
            """<p><strong>Amount of donation to religious organization</strong></p>
<p>In order for us to calculate exactly how much of your donation to a religious organization you can write off, we need to know how much you donated.</p>
<p><em>Please enter the </em><strong><em>amount of your donation</em></strong><em> here.</em></p>
<p>Please enter the total amount that you donated to this religious organization in 2019.</p>
<p> </p>""",
            "",
            "Donations and membership fees",
            "How much money did ${Questions.financeYouIdentity} donate to this organization? ",
            "Donated amount",
            220.0,
            "calculation",
            Questions.financeProjectText,
            []);
      }

      //Answer No 71
      else if (widget.CheckCompleteQuestion ==
              "How much money did ${Questions.financeYouIdentity} donate to this organization? " &&
          widget.CheckQuestion == "Donated amount") {
        if (Questions.financeProjectLength <= Questions.totalFinanceProject &&
            Questions.totalFinanceProject > 0) {
          //Question No 68
          return financethreeoptionContainer(
              """<p><strong>Confirmation of donation</strong></p>
<p>Please select what kind of confirmation you received for your donation. Click the option that applies to you.</p>
<p><strong>DONATION RECEIPT</strong></p>
<p>If you have donated to an organization you receive a receipt from this organization. You can claim back the value of the donation as a special expense allowance from the tax office. It serves as written proof.</p>
<p><strong>BANK STATEMENT (DONATIONS UP TO 200 EUROS)</strong></p>
<p>For donations up to 200 euro don't need a receipt, so no written proof. Simple proof, such as a copy of the bank transfer, is enough in this case.</p>
<p><strong>INFORMATION WAS SENT ELECTRONICALLY</strong></p>
<p>A donation receipt which was sent electronically from the recipient (the organization in recepit of donation) to the donor is allowed. <strong>Important</strong>: the file must be transferred as read-only. In addition, it must meet official guidelines.</p>
<p> </p>
<p> </p>""",
              "",
              "Donations and membership fees",
              "What evidence do ${Questions.financeYouIdentity} have for ${Questions.financeYourIdentity} donation?    ",
              "Donation confirmation no. ${Questions.financeProjectLength}",
              [
                "Donation receipt",
                "Account statement (in the case of donations up to 200EUR)",
                "Information was transmitted electronically"
              ],
              220.0,
              "",
              Questions.financeProjectText,
              []);
        } else {
          //For You & Partner
          if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            //Question No 81
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "",
                "Have you agreed on joint property?",
                "Joint property",
                220.0,
                "",
                "", []);
          } else {
            return FinishCategory(
                "Finances Category", "End Categories", 6, true);
          }
        }
      }

      // ====== Other tax privileged organizations Ends ====== //

      // ====== Donations and membership fees Ends ======= //

      //Studying 'Riester' Pension (Relation) Starts

      //Answer No 72
      else if (widget.CheckCompleteQuestion ==
              "What was the sum of all contributions ${Questions.financeYouIdentity} have paid for all Riester contracts?" &&
          widget.CheckQuestion == "Total contribution") {
        if (Questions.specialistActivityFinance == "Official") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'Official', 'OK');

          //Question No 78
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "How much salary as an official have ${Questions.financeYouIdentity} received in ${2019 - 1}?",
              "Salary in ${2019 - 1}",
              220.0,
              "calculation",
              "", []);
        } else if (Questions.specialistActivityFinance == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'skip', 'skip');

          //Question No 78
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "How much salary as an official have ${Questions.financeYouIdentity} received in ${2019 - 1}?",
              "Salary in ${2019 - 1}",
              220.0,
              "calculation",
              "", []);
        } else {
          //Question No 73
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "What was ${Questions.financeYourIdentity} total annual salary in ${2019 - 1}?",
              "Salary in ${2019 - 1}",
              220.0,
              "calculation",
              "", []);
        }
      }

      //Answer No 73
      else if (widget.CheckCompleteQuestion ==
              "What was ${Questions.financeYourIdentity} total annual salary in ${2019 - 1}?" &&
          widget.CheckQuestion == "Salary in ${2019 - 1}") {
        //Question No 74
        return financecalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Finances",
            "If ${Questions.financeYouIdentity} received income replacement benefits in ${2019 - 1}, what was the total amount of these?",
            "Compensation pay in ${2019 - 1}",
            280.0,
            "calculation",
            "", []);
      }

      //Answer no 74
      else if (widget.CheckCompleteQuestion ==
              "If ${Questions.financeYouIdentity} received income replacement benefits in ${2019 - 1}, what was the total amount of these?" &&
          widget.CheckQuestion == "Compensation pay in ${2019 - 1}") {
        if (Questions.specialistActivityFinance == "Judge" ||
            Questions.specialistActivityFinance == "Soldier") {
          //Question No 78
          return financecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "How much salary as an official have ${Questions.financeYouIdentity} received in ${2019 - 1}?",
              "Salary in ${2019 - 1}",
              220.0,
              "calculation",
              "", []);
        } else {
          //Question No 75
          return financetwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "For whom was the monthly child support assessed?",
              "Child support receiver",
              ["Me", "The other parent"],
              430.0,
              "",
              "",
              []);
        }
      }

      //Answer No 75
      else if (widget.CheckCompleteQuestion ==
              "For whom was the monthly child support assessed?" &&
          widget.CheckQuestion == "Child support receiver") {
        //Question No 2
        return financemultipleoptionsContainer(
            """

<p><strong>Other insurance</strong></p>
<p>Please select here the insurances for which you have paid 2019 contributions. You can also choose several options.</p>
<p><strong>ADDITIONAL UNEMPLOYMENT INSURANCE</strong></p>
<p>You had an additional insurance against unemployment in the year 2019 for which you paid contributions (not withheld by your employer). The insurance policy may have begun earlier.</p>
<p><strong>DISABILITY</strong></p>
<p>In 2019 you had an occupational disability insurance for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>CAR LIABILITY INSURANCE</strong></p>
<p>You had a liability insurance for your car in 2019 year and paid contributions. Please note that you <strong>may only deduct the motor vehicle liability. You cannot deduct the physical damage part. The insurance policy may have begun earlier.</strong></p>
<p><strong>LIABILITY</strong></p>
<p>In 2019 year, you had private liability insurance or other liability insurances (e.g. dog owner's liability insurance) for which you paid contributions during the year. The insurance policy may have begun earlier.</p>
<p><strong>LEGAL PROTECTION</strong></p>
<p>In the year 2019, you had legal expenses insurance for which you paid contributions. You may have completed the insurance earlier.</p>
<p><strong>PROFESSIONAL LIABILITY</strong></p>
<p>For many professions there is special liability insurance, e.g. for doctors, lawyers, accountants or teachers. You can deduct the full amount of the contributions of this professional liability insurance. The insurance policy may have begun earlier.</p>
<p><strong>ACCIDENT INSURANCE</strong></p>
<p>You can also enter your total contributions to an accident insurance from the year 2019 here. It is one of the private provisions that you can deduct from the tax.</p>
<p> </p>
""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any other insurance policies?",
            "Other contracts",
            [
              "Additional unemployment insurance",
              "Occupational disability",
              "Car liability insurance",
              "Liability",
              "Legal protection",
              "Professional liability",
              "Accident insurance",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);
      }

      //Studying 'Riester' Pension (Relation) Ends

      //Occupation Minijob Specialist Activity (Relation) Starts

      //Answer No 76
      else if (widget.CheckCompleteQuestion ==
              "Does ${Questions.financeYourIdentity} job meet one of the following criteria?" &&
          widget.CheckQuestion == "Specialist activity") {
        if (widget.CheckAnswer[0] == "Official") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'Official', 'OK');

          Questions.specialistActivityFinance = "Official";

          //Question No 77
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?",
              "Pension insurance exemption",
              220.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "Managing director") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'Managing director',
              'OK');

          Questions.specialistActivityFinance = "Managing director";

          //Question No 77
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?",
              "Pension insurance exemption",
              220.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "Judge") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'Judge', 'OK');

          Questions.specialistActivityFinance = "Judge";

          //Question No 77
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?",
              "Pension insurance exemption",
              220.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "Intern") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'Intern', 'OK');

          Questions.specialistActivityFinance = "Intern";

          //Question No 77
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?",
              "Pension insurance exemption",
              220.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "Soldier") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'Soldier', 'OK');

          Questions.specialistActivityFinance = "Soldier";

          //Question No 77
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?",
              "Pension insurance exemption",
              220.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'No', 'OK');

          Questions.specialistActivityFinance = "No";

          //Question No 77
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?",
              "Pension insurance exemption",
              220.0,
              "",
              "", []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('What was the sum of all contributions');
          _insert('What was the sum of all contributions', 'skip', 'skip');

          Questions.specialistActivityFinance = "No";

          //Question No 77
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?",
              "Pension insurance exemption",
              220.0,
              "",
              "", []);
        }
      }

      //Answer No 77
      else if (widget.CheckCompleteQuestion ==
              "Are ${Questions.financeYouIdentity} exempted from statutory pension insurance?" &&
          widget.CheckQuestion == "Pension insurance exemption") {
        if (Questions.specialistActivityFinance == "Official") {
          DbHelper.insatance.deleteWithquestion(
              'Are exempted from statutory pension insurance?');
          _insert('Are exempted from statutory pension insurance?', 'Official',
              'OK');

          //Question No 1
          return financemultipleoptionsContainer(
              """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
              "Pensions/Life insurances",
              [
                "'Riester' pension",
                "Rürup pension",
                "Private pension with capital voting rights",
                "Private pension without capital voting rights",
                "Endowment insurance",
                "Life insurance",
                "Additional contribution statutory pension",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (Questions.specialistActivityFinance == "Managing director" ||
            Questions.specialistActivityFinance == "Judge" ||
            Questions.specialistActivityFinance == "Intern" ||
            Questions.specialistActivityFinance == "Soldier" ||
            Questions.specialistActivityFinance == "No" ||
            Questions.specialistActivityFinance == "skip") {
          if (widget.CheckAnswer[0] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Are exempted from statutory pension insurance?');
            _insert(
                'Are exempted from statutory pension insurance?', 'No', 'OK');
            //Question No 1
            return financemultipleoptionsContainer(
                """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
                "",
                "Finances",
                "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
                "Pensions/Life insurances",
                [
                  "'Riester' pension",
                  "Rürup pension",
                  "Private pension with capital voting rights",
                  "Private pension without capital voting rights",
                  "Endowment insurance",
                  "Life insurance",
                  "Additional contribution statutory pension",
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
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          } else if (widget.CheckAnswer[0] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Are exempted from statutory pension insurance?');
            _insert('Are exempted from statutory pension insurance?', 'skip',
                'skip');

            //Question No 1
            return financemultipleoptionsContainer(
                """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
                "",
                "Finances",
                "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
                "Pensions/Life insurances",
                [
                  "'Riester' pension",
                  "Rürup pension",
                  "Private pension with capital voting rights",
                  "Private pension without capital voting rights",
                  "Endowment insurance",
                  "Life insurance",
                  "Additional contribution statutory pension",
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
                  "images/check.png"
                ],
                220.0,
                "No",
                "",
                []);
          } else if (widget.CheckAnswer[0] == "Yes") {
            DbHelper.insatance.deleteWithquestion(
                'Are exempted from statutory pension insurance?');
            _insert(
                'Are exempted from statutory pension insurance?', 'Yes', 'OK');

            //Question No 79
            return financeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Finances",
                "Are ${Questions.financeYouIdentity} entitled to a pension through ${Questions.financeYourIdentity} employment?",
                "Pension entitlement",
                220.0,
                "",
                "", []);
          }
        }
      }

//    //Answer No 78
      else if (widget.CheckCompleteQuestion ==
              "How much salary as an official have ${Questions.financeYouIdentity} received in ${2019 - 1}?" &&
          widget.CheckQuestion == "Salary in ${2019 - 1}") {
        //Question No 75
        return financetwooptionContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Finances",
            "For whom was the monthly child support assessed?",
            "Child support receiver",
            ["Me", "The other parent"],
            430.0,
            "",
            "",
            []);
      }

      //Answer No 79
      else if (widget.CheckCompleteQuestion ==
              "Are ${Questions.financeYouIdentity} entitled to a pension through ${Questions.financeYourIdentity} employment?" &&
          widget.CheckQuestion == "Pension entitlement") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Are entitled to a pension through employment?');
          _insert('Are entitled to a pension through employment?', 'No', 'OK');

          //Question No 1
          return financemultipleoptionsContainer(
              """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
              "Pensions/Life insurances",
              [
                "'Riester' pension",
                "Rürup pension",
                "Private pension with capital voting rights",
                "Private pension without capital voting rights",
                "Endowment insurance",
                "Life insurance",
                "Additional contribution statutory pension",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Are entitled to a pension through employment?');
          _insert(
              'Are entitled to a pension through employment?', 'skip', 'skip');

          //Question No 1
          return financemultipleoptionsContainer(
              """<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>""",
              "",
              "Finances",
              "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
              "Pensions/Life insurances",
              [
                "'Riester' pension",
                "Rürup pension",
                "Private pension with capital voting rights",
                "Private pension without capital voting rights",
                "Endowment insurance",
                "Life insurance",
                "Additional contribution statutory pension",
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
                "images/check.png"
              ],
              220.0,
              "No",
              "",
              []);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Are entitled to a pension through employment?');
          _insert('Are entitled to a pension through employment?', 'Yes', 'OK');

          //Question No 80
          return financeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Finances",
              "Are ${Questions.financeYouIdentity} entitled to a pension through ${Questions.financeYourIdentity} employment without having to pay contributions yourself?",
              "Claim without personal contribution",
              220.0,
              "",
              "", []);
        }
      }

      //Answer No 80
      else if (widget.CheckCompleteQuestion ==
              "Are ${Questions.financeYouIdentity} entitled to a pension through ${Questions.financeYourIdentity} employment without having to pay contributions yourself?" &&
          widget.CheckQuestion == "Claim without personal contribution") {
        //Question No 1
        return financemultipleoptionsContainer(
            """

<p><strong>Pension and life insurance</strong></p>
<p>Select here the types of insurance you paid in <strong>2019</strong>. You can choose multiple options.</p>
<p><strong>RIESTER PENSION</strong></p>
<p>Choose this item if you have a Riester contract in your name. You will receive a tax-free subsidy from the state when you have paid your minimum contribution.</p>
<p><strong>RÜRUP PENSION</strong></p>
<p>If you have a Rürup pension insurance, enter the contributions here.</p>
<p><strong>PENSION INSURANCE WITH CAPITAL VOTING RIGHTS</strong></p>
<p>You only have to provide this information if the insurance was taken out before 1.1.2005.</p>
<p><strong>PENSION INSURANCE WITHOUT CAPITAL VOTING RIGHTS</strong></p>
<p>Contributions to a pension insurance without capital voting rights can be entered here, if it concerns an <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong></p>
<p><strong>Capital voting rights explained</strong></p>
<p>In the case of insurance with voting rights, the insured person can choose to pay off the amount insured in one amount or in the form of a monthly pension at the end of the deposit period. You chose the respective option when concluding the contract. It is in your insurance documents.</p>
<p><strong>ENDOWMENT INSURANCE</strong></p>
<p>You can only enter contributions for an endowment insurance if you have a <strong>old contract (signed and first contribution payment made before 1.1.2005).</strong> As in the case of pension insurance, there are also contracts with and without capital rights for endowment life insurance policies.</p>
<p><strong>LIFE INSURANCE</strong></p>
<p>If you pay for life insurance, choose this point.</p>
<p><strong>ADDITIONAL CONTRIBUTION STATUTORY PENSION</strong></p>
<p>To increase your statutory pension you can also voluntarily pay additional contributions into the statutory pension scheme. If you have done this, select this point. Kindly note that contributions stated in the payslip are already considered by the app.</p>
<p>Choose this option even if you have paid contributions to other pension funds. Some other pension schemes provide security for freelancers. You can pay into these, for example, if you are a doctor (also dental or veterinary), pharmacist, architect, notary, lawyer, tax consultant, auditor, certified accountant, engineer or psychotherapist.</p>
<p> </p>

""",
            "",
            "Finances",
            "Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?",
            "Pensions/Life insurances",
            [
              "'Riester' pension",
              "Rürup pension",
              "Private pension with capital voting rights",
              "Private pension without capital voting rights",
              "Endowment insurance",
              "Life insurance",
              "Additional contribution statutory pension",
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
              "images/check.png"
            ],
            220.0,
            "No",
            "",
            []);

//      if(widget.CheckAnswer[0] == "No")
//      {
//        //Question No 1
//        return financemultipleoptionsContainer("","Finances","Did ${Questions.financeYouIdentity} have costs for any of the insurances listed here?","Pensions/Life insurances",["'Riester' pension","Rürup pension","Private pension with capital voting rights","Private pension without capital voting rights","Endowment insurance","Life insurance","Additional contribution statutory pension","No"],["images/disabilityoption.png","images/alimonypaidoption.png","images/survivorspension.png","images/check.png","images/check.png","images/check.png","images/check.png","images/check.png"],220.0,"No","",[]);
//      }
//
//      else if(widget.CheckAnswer[0] == "Yes")
//      {
//        //Question No 81
//        return financeyesnoContainer("","Finances","Are ${Questions.financeYouIdentity} entitled to a pension through ${Questions.financeYourIdentity} employment without having to pay contributions yourself?","Claim without personal contribution",220.0,"","",[]);
//      }

      }

      //Occupation Minijob Specialist Activity (Relation) Ends

      //For You & Partner Starts
      //Answer No 81
      else if (widget.CheckCompleteQuestion ==
              "Have you agreed on joint property?" &&
          widget.CheckQuestion == "Joint property") {
        return FinishCategory("Finances Category", "End Categories", 6, true);
      }
      //For You & Partner Ends

    }
  }

  Widget financemultipleoptionsContainer(
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
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceMultipleOptionsContainer(
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

  Widget financecalculationContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceCalculationContainer(
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

  Widget financeyesnoContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceYesNoContainer(
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

  Widget financetwooptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceTwoOptionContainer(
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

  Widget financemultitwoContainer(
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
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceMultiTwoContainer(
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

  Widget financedifferentoptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceDifferentOptionContainer(
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

  Widget financedateContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceDateContainer(
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

  Widget financethreeoptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData,
      List Suggestion) {
    Questions.financeAnimatedContainer = animatedcontainer;
    return FinanceThreeOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 340.0,
        additionalData: AdditionalData,
        multipleData: MultipleData,
        suggestion: Suggestion);
  }

  void financePartner() {
    qu.FinanceAddAnswer("Partner", "", "", "", [], 60.0);
    Questions.financePartner = false;

    Questions.financeYouIdentity = "your partner";
    Questions.financeYourIdentity = "your partner";

    Questions.specialistActivityFinance = "";
  }

  void financeYouPartner() {
    qu.FinanceAddAnswer("You & Partner", "", "", "", [], 60.0);

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
            Questions.financeAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FinanceMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList =
                Questions.financeAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.financeAnswerShow = [];
            Questions.financeAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FinanceMainQuestions(
                  CheckCompleteQuestion: Questions
                      .financeAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.financeAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.financeAnswerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
          height: Questions.financeAnswerShow[currentIndex]['containerheight'],
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
                        Questions.financeAnswerShow[currentIndex]['question'],
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
                            Questions.financeAnswerShow[currentIndex]['answer']
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
            Questions.financeAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FinanceMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList =
                Questions.financeAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.financeAnswerShow = [];
            Questions.financeAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FinanceMainQuestions(
                  CheckCompleteQuestion: Questions
                      .financeAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.financeAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.financeAnswerShow[currentIndex - 1]['answer'][0]
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
                          Questions.financeAnswerShow[currentIndex]['question'],
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
                              Questions.financeAnswerShow[currentIndex]
                                  ['answer'][0],
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
