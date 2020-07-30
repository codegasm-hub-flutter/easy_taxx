import 'package:easy_taxx/livingsituation_flow/container1.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finishcategory.dart';
import 'package:easy_taxx/family_flow/familycalculationcontainer.dart';
import 'package:easy_taxx/family_flow/familydatecontainer.dart';
import 'package:easy_taxx/family_flow/familymultipleoptionscontainer.dart';
import 'package:easy_taxx/family_flow/familyyesnocontainer.dart';
import 'package:easy_taxx/family_flow/familythreeoptioncontainer.dart';
import 'package:easy_taxx/family_flow/familydifferentoptioncontainer.dart';
import 'package:easy_taxx/family_flow/familyaddresscontainer.dart';
import 'package:easy_taxx/family_flow/familytwooptioncontainer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_taxx/family_flow/familymultithreecontainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyMainQuestions extends StatefulWidget {
  String CheckCompleteQuestion;
  String CheckQuestion;
  List CheckAnswer;

  FamilyMainQuestions(
      {Key key,
      this.CheckCompleteQuestion,
      this.CheckQuestion,
      this.CheckAnswer})
      : super(key: key);

  @override
  _FamilyMainQuestionsState createState() => _FamilyMainQuestionsState();
}

class _FamilyMainQuestionsState extends State<FamilyMainQuestions> {
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
  String checkShared = "";
  final dbHelper = DbHelper.insatance;
  int dob;

  Future<int> _setIntKey(int v) async {
    final prefs = await SharedPreferences.getInstance();
    // write
    await prefs.setInt('year', v);
  }

  Future<String> _getIntKey() async {
    final prefs = await SharedPreferences.getInstance();
    // read
    final int myInt = prefs.getInt('year') ?? '';
    dob = myInt;

    print(dob);
  }

  Future<String> _getStringKey() async {
    final prefs = await SharedPreferences.getInstance();
    // read
    final String myString = prefs.getString('Alimony') ?? '';
    if (myString == 'yes') {
      setState(() {
        checkShared = "yes";
      });
    } else {
      setState(() {
        checkShared = "no";
      });
    }

    print(myString);
  }

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
    _getIntKey();
    _getStringKey();
    //timer();
    Screenheight();
    DynamicContainer();
  }

  void Screenheight() {
    print("question length:" + Questions.familyAnswerShow.length.toString());

    for (k = l; k < Questions.familyAnswerShow.length; k++) {
      print("how manysdsdsd");
      screenHeightbig = 0.0;
      if (Questions.familyAnswerShow[k]['identity'] == "You" ||
          Questions.familyAnswerShow[k]['identity'] == "You & Partner" ||
          Questions.familyAnswerShow[k]['identity'] == "Partner") {
        screenHeight = screenHeight + 70.0;
      } else if (Questions.familyAnswerShow[k]['details'] == "") {
        screenHeight = screenHeight + 60.0;
        detail = true;
      } else {
        detailsHeight = Questions.familyAnswerShow[k]['details'];

        for (l = k; l < Questions.familyAnswerShow.length; l++) {
          if (Questions.familyAnswerShow[l]['details'] == detailsHeight) {
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
    screenHeight = screenHeight + Questions.familyAnimatedContainer;
    // screenHeight = screenHeight;
    print("Screen Height:" + screenHeight.toString());
//    print("Screen Height big:"+screenHeightbig.toString());

    detail = true;
  }

  void DynamicContainer() {
    hlength = 0;
    // print("question length:"+Questions.answerShow.length.toString());
    for (i = j; i < Questions.familyAnswerShow.length; i++) {
      print("value oif i is:" + i.toString());

      print("dat is:" + i.toString());
      //You and your and your partner identity
      if (Questions.familyAnswerShow[i]['identity'] == "You" ||
          Questions.familyAnswerShow[i]['identity'] == "You & Partner" ||
          Questions.familyAnswerShow[i]['identity'] == "Partner") {
        dynamicContainer.add(Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: Questions.familyAnswerShow[i]['containerheight'],
          width: 450.0,
          child: Text(Questions.familyAnswerShow[i]['identity'],
              style: TextStyle(fontSize: 40.0)),
        ));
      } else if (Questions.familyAnswerShow[i]['details'] == "") {
        dynamicContainer.add(SingleSmallContainer(currentIndex: i)
//            Container(
//              margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
//              height: Questions.familyAnswerShow[i]['containerheight'],
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
//                          child:AutoSizeText(Questions.familyAnswerShow[i]['question'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                      ),
//                      Row(children: <Widget>[
//                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                        Container(
//                            width: 140.0,
//                            // color:Colors.blue,
//                            child:AutoSizeText(Questions.familyAnswerShow[i]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
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
        detailOption = Questions.familyAnswerShow[i]['details'];
        print(detailOption);
        countLongContainer = 0;
//print("ahsjasjasksss");

        //set length of data in details that how much data comes
        for (co = i; co < Questions.familyAnswerShow.length; co++) {
          if (Questions.familyAnswerShow[co]['details'] == detailOption) {
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
          if (Questions.familyAnswerShow[j]['details'] == detailOption &&
              detail == true) {
            dynamicContainerbig.add(
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
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
                              Questions.familyAnswerShow[i]['details'],
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

            dynamicContainerbig.add(Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Container(
                  margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  height: 2.0,
                  color: Color(0xfff2f6ff),
                )));
            //so that details data not come again and again
            detail = false;
          }
          // after details data
          if (Questions.familyAnswerShow[j]['details'] == detailOption &&
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
//                              child:AutoSizeText(Questions.familyAnswerShow[j]['question'],style: TextStyle(color: Colors.grey),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                          ),
//                          Row(children: <Widget>[
//                            //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                            Container(
//                                width: 140.0,
//                                // color:Colors.blue,
//                                child:AutoSizeText(Questions.familyAnswerShow[j]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
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

            dynamicContainerbig.add(Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Container(
                  margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  height: j == countLongContainer - 1 ? 0.0 : 1.0,
                  color: Color(0xfff2f6ff),
                )));
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
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                height: 105,
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
                            "Family",
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
        //   backgroundColor: Colors.white,
        //   leading: GestureDetector(
        //       onTap: (){
        //         Navigator.pushReplacementNamed(context, 'allCategoryScreen');
        //         //  Navigator.pop(context);
        //       },
        //       child:Icon(Icons.arrow_back_ios,color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),size: 20.0)
        //   ),
        //     title: Text('Family',style: TextStyle(color: Colors.black,fontSize: 14.0),),
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
                          FamilyChangeContainer(),
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

  Widget FamilyChangeContainer() {
    if (Questions.familyAnswerShow.length == 0) {
      if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
        qu.FamilyAddAnswer("You & Partner", "", "", "", [], 60.0);
        Questions.familyFirst = "First Question";
        Questions.familyYou = true;
        Questions.familyPartnerSingleMove = true;
        Questions.familyPartnerYouSingleMove = true;
        Questions.familyPartnerYouSecondMove = true;
        //Question No 1(Partner)

        if (checkShared == 'yes') {
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Alimony Paid?",
              "What kind of alimony did you paid?",
              "Alimony Paid?",
              [
                "Pension rights adjustment.",
                "Prevention of an adjustmnet.",
                "Alimony to ex."
              ],
              430.0,
              "",
              "Alimony Paid?");
        } else {
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "",
              "How many children do you have?",
              "Number of children",
              220.0,
              "loop",
              "");
        }
        // if (checkShared == 'yes') {
        //   return familythreeoptionContainer(
        //       """<h1>Coming Soon!</h1>""",
        //       "",
        //       "Alimony Paid?",
        //       "What kind of alimony did you paid?",
        //       "Alimony Paid?",
        //       [
        //         "Pension rights adjustment.",
        //         "Prevention of an adjustmnet.",
        //         "Alimony to ex."
        //       ],
        //       430.0,
        //       "",
        //       "Alimony Paid?");
        // } else {
        //   return familycalculationContainer("""<h1>Coming Soon!</h1>""",
        //       "",
        //       "",
        //       "How many children do you both have?",
        //       "Number of children",
        //       220.0,
        //       "loop",
        //       "");
        // }
      } else {
        //Question No 1
        if (checkShared == 'yes') {
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Alimony Paid?",
              "What kind of alimony did you paid?",
              "Alimony Paid?",
              [
                "Pension rights adjustment.",
                "Prevention of an adjustmnet.",
                "Alimony to ex."
              ],
              430.0,
              "",
              "Alimony Paid?");
        } else {
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "",
              "How many children do you have?",
              "Number of children",
              220.0,
              "loop",
              "");
        }
      }
    } else if (Questions.familyFirst == "First Question") {
      Questions.familyFirst = "";
      //Question No 1(Partner)
      return familycalculationContainer("""
        <h1>Coming Soon!</h1>
        """, "", "", "How many children do you both have?",
          "Number of children", 220.0, "loop", "");
    } else {
      //Answer No 1(Partner)
      if ((widget.CheckCompleteQuestion == "How many children do you have?" ||
              widget.CheckCompleteQuestion ==
                  "How many children do you both have?") &&
          widget.CheckQuestion == "Number of children") {
        DbHelper.insatance
          ..deleteWithquestion('How many children do you have?');
        _insert('How many children do you have?', Questions.childText, 'OK');

        //Question No 2
        return familycalculationContainer(
            """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
            "",
            "Child ${Questions.childLength}",
            "What is your child's first name?",
            "First name child",
            220.0,
            "",
            Questions.childText);
      }
      if ((widget.CheckCompleteQuestion == "How many children do you have?" ||
              widget.CheckCompleteQuestion ==
                  "How many children do you both have?") &&
          widget.CheckQuestion == "skip") {
        //Question No 2
        return familycalculationContainer(
            """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
            "",
            "Child ${Questions.childLength}",
            "What is your child's first name?",
            "First name child",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "What kind of alimony did you paid?" &&
          widget.CheckQuestion == "Alimony Paid?") {
        if (widget.CheckAnswer[0] == "Pension rights adjustment.") {
          return familyyesnoContainer(
              """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
              "",
              "Recipient Declare Money.",
              "Does the recipient declare the money in tax return?",
              "Recipient Declare Money.",
              220.0,
              "",
              "Recipient Declare Money.");
        } else if (widget.CheckAnswer[0] == "Prevention of an adjustmnet.") {
          return familyyesnoContainer(
              """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
              "",
              "Recipient Declare Money.",
              "Does the recipient declare the money in tax return?",
              "Recipient Declare Money Prevention.",
              220.0,
              "",
              "Recipient Declare Money Prevention.");
        } else if (widget.CheckAnswer[0] == "Alimony to ex.") {
          return familyyesnoContainer(
              """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
              "",
              "Recipient Declare Money.",
              "Does the recipient declare the money in tax return?",
              "Recipient Declare Money Ex.",
              220.0,
              "",
              "Recipient Declare Money Ex.");
        }
      } else if (widget.CheckCompleteQuestion ==
              "Does the recipient declare the money in tax return?" &&
          widget.CheckQuestion == "Recipient Declare Money Prevention.") {
        if (widget.CheckAnswer[0] == "Yes") {
          return familycalculationContainer(
            """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
            "",
            "Prevention Adjustment Payment.",
            "How much you pay on prevention adjustment?",
            "Prevention Adjustment Payment.",
            220.0,
            "",
            "Prevention Adjustment Payment.",
          );
        } else if (widget.CheckAnswer[0] == "No") {
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "",
              "How many children do you have?",
              "Number of children",
              220.0,
              "loop",
              "");
        }
      } else if (widget.CheckCompleteQuestion ==
              "Does the recipient declare the money in tax return?" &&
          widget.CheckQuestion == "Recipient Declare Money Ex.") {
        if (widget.CheckAnswer[0] == "Yes") {
          return familycalculationContainer(
            """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
            "",
            "Prevention Adjustment Payment.",
            "How much you pay on Ex alimony adjustment?",
            "Prevention Adjustment Payment.",
            220.0,
            "",
            "Prevention Adjustment Payment.",
          );
        } else if (widget.CheckAnswer[0] == "No") {
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "",
              "How many children do you have?",
              "Number of children",
              220.0,
              "loop",
              "");
        }
      } else if (widget.CheckCompleteQuestion ==
              "How much you pay on prevention adjustment?" &&
          widget.CheckQuestion == "Prevention Adjustment Payment.") {
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "",
            "How many children do you have?",
            "Number of children",
            220.0,
            "loop",
            "");
      } else if (widget.CheckCompleteQuestion ==
              "How much you pay on Ex alimony adjustment?" &&
          widget.CheckQuestion == "Prevention Adjustment Payment.") {
        return familycalculationContainer(
          """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
          "",
          "Amount Paid For Health.",
          "How much you pay on Ex alimony adjustment for health and nursing care?",
          "Amount Paid For Health.",
          220.0,
          "",
          "Calculation",
        );
      } else if (widget.CheckCompleteQuestion ==
              "How much you pay on Ex alimony adjustment for health and nursing care?" &&
          widget.CheckQuestion == "Amount Paid For Health.") {
        return familyyesnoContainer(
            """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
            "",
            "Received Refunds.",
            "Did you receive any refunds from the health and nursing care?",
            "Received Refunds.",
            220.0,
            "",
            "Received Refunds.");
      } else if (widget.CheckCompleteQuestion ==
              "Did you receive any refunds from the health and nursing care?" &&
          widget.CheckQuestion == "Received Refunds.") {
        if (widget.CheckAnswer[0] == "Yes") {
          return familycalculationContainer(
            """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
            "",
            "Refund Amount.",
            "How much refund have you received?",
            "Refund Amount.",
            220.0,
            "",
            "Calculation",
          );
        } else if (widget.CheckAnswer[0] == "No") {
          return familycalculationContainer("""<h1>Coming Soon</h1>""",
              "",
              "TAX ID Of Recipient.",
              "What is the TAX ID of recipient?",
              "TAX ID Of Recipient.",
              220.0,
              "",
              "TAX ID Of Recipient.");
        }
      }
//        else if (widget.CheckCompleteQuestion ==
//               "How much refund have you received?" &&
//           widget.CheckQuestion == "Refund Amount.") {
//         return familycalculationContainer("""
// <p><strong>Entitlement to sick pay</strong></p>
// <p>Please enter the amount of your contribution to your health and nursing care insurance that entitles you to sick pay.</p>
// <p>You can find this information on your <strong>certificate of insurance</strong>.</p>
// <p>The contribution for entitlement to sick pay is <strong>not fully tax deductible</strong>.</p>
// <p>&nbsp;</p>
// """,
//             "",
//             "Alimony",
//             "What share of the premiums for health and nursing care insurance entitled you to sick pay?",
//             "Share entitling to sick pay",
//             220.0,
//             "calculation",
//             "");
//       }
      else if (widget.CheckCompleteQuestion ==
              "How much refund have you received?" &&
          widget.CheckQuestion == "Refund Amount.") {
        return familycalculationContainer("""<h1>Coming Soon</h1>""",
            "",
            "TAX ID Of Recipient.",
            "What is the TAX ID of recipient?",
            "TAX ID Of Recipient.",
            220.0,
            "",
            "TAX ID Of Recipient.");
      } else if (widget.CheckCompleteQuestion ==
              "Does the recipient declare the money in tax return?" &&
          widget.CheckQuestion == "Recipient Declare Money.") {
        if (widget.CheckAnswer[0] == "No") {
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "",
              "How many children do you have?",
              "Number of children",
              220.0,
              "loop",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Payment Reason?",
              "What is the reason of payment?",
              "Payment Reason?",
              220.0,
              "",
              "Payment Reason?");
        }
      } else if (widget.CheckCompleteQuestion ==
              "What is the reason of payment?" &&
          widget.CheckQuestion == "Payment Reason?") {
        return familydateContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Date Of First Payment.",
            "When did you make your first payment?",
            "Date Of First Payment.",
            430.0,
            "",
            "Date Of First Payment.");
      } else if (widget.CheckCompleteQuestion ==
              "When did you make your first payment?" &&
          widget.CheckQuestion == "Date Of First Payment.") {
        return familycalculationContainer("""<h1>Coming Soon</h1>""",
            "",
            "Amount Of Payment.",
            "What is the amount of first payment?",
            "Amount Of Payment.",
            220.0,
            "",
            "calculation");
      } else if (widget.CheckCompleteQuestion ==
              "What is the amount of first payment?" &&
          widget.CheckQuestion == "Amount Of Payment.") {
        return familycalculationContainer("""<h1>Coming Soon</h1>""",
            "",
            "Name Of Recipient.",
            "What is the name of recipient?",
            "Name Of Recipient.",
            220.0,
            "",
            "Name Of Recipient.");
      } else if (widget.CheckCompleteQuestion ==
              "What is the name of recipient?" &&
          widget.CheckQuestion == "Name Of Recipient.") {
        return familycalculationContainer("""<h1>Coming Soon</h1>""",
            "",
            "Name Of Recipient.",
            "What is the TAX ID of recipient?",
            "TAX ID Of Recipient.",
            220.0,
            "",
            "TAX ID Of Recipient.");
      } else if (widget.CheckCompleteQuestion ==
              "What is the TAX ID of recipient?" &&
          widget.CheckQuestion == "TAX ID Of Recipient.") {
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "",
            "How many children do you have?",
            "Number of children",
            220.0,
            "loop",
            "");
      }

      //Answer No 2
      else if (widget.CheckCompleteQuestion ==
              "What is your child's first name?" &&
          widget.CheckQuestion == "First name child") {
        DbHelper.insatance..deleteWithquestion('First name child');
        _insert('First name child', Questions.childText, 'OK');
        //For You relation
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.familyYou == true) {
          Questions.familyYou = false;
          qu.FamilyAddAnswer("You", "", "", "", [], 60.0);
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else if (Questions.familyYou == false) {
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else {
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 3
      else if (widget.CheckCompleteQuestion ==
              "What is ${Questions.childFirstName}'s last name?" &&
          widget.CheckQuestion == "Child's last name") {
        DbHelper.insatance..deleteWithquestion('Child\'s last name');
        _insert('Child\'s last name', Questions.childText, 'OK');

        print(Questions.childText + "this is dateee");

        //Question No 4
        return familydateContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "When was ${Questions.childFirstName} born?",
            "Child's date of birth",
            430.0,
            "",
            Questions.childText);
      }

      //Answer No 4
      else if (widget.CheckCompleteQuestion ==
              "When was ${Questions.childFirstName} born?" &&
          widget.CheckQuestion == "Child's date of birth") {
        DbHelper.insatance..deleteWithquestion('Child\'s date of birth');
        _insert('Child\'s date of birth', Questions.childText, 'OK');

        print(int.parse(widget.CheckAnswer.toString().substring(1, 5))
                .toString() +
            " this is answerr");

        setState(() {
          _setIntKey(int.parse(widget.CheckAnswer.toString().substring(1, 5)));
          _getIntKey();
        });
        print(dob.toString() + "dobbbb");

        if (int.parse(widget.CheckAnswer.toString().substring(1, 5)) <= 1993) {
          return familymultipleoptionsContainer(
              """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Have you had any of the following expenses for your child?",
              "Expenses child",
              [
                "Care costs",
                "School fees",
                "Health insurance contributions",
                "Costs due to disability",
                "None of this applies"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              430.0,
              "None of this applies",
              Questions.childText);
        } else
          //Question No 5
          return familymultipleoptionsContainer(
              """<p><strong>Living situation of your child</strong></p>
<p>Choose the options that apply to you here. You can choose several answers.</p>
<p><strong>WITH US PARENTS</strong></p>
<p>Your child lives with you. You live in a household with your (spouse) partner and your child.</p>
<p><strong>PATCHWORK FAMILY</strong></p>
<p>A patchwork family is when at least one partner brings one or more children into the new relationship. You don't have to be married. Both partners can have children and bring them into the new relationship.</p>
<p><strong>ONLY WITH ME</strong></p>
<p>You live alone with your child, so separate from the other parent and are therefore a single parent.</p>
<p><strong>WITH THE OTHER PARENT</strong></p>
<p>The other parent lives with the child because you are separated, for example.</p>
<p><strong>AT THE TRAINING LOCATION</strong></p>
<p>Your child has started an apprenticeship or a degree and moved to the place of training.</p>
<p><strong>WITH STEP-GRANDPARENTS OR GRANDPARENTS</strong></p>
<p>Your child lives in the household of grandparents or stepparents.</p>
<p><strong>SOMEWHERE ELSE</strong></p>
<p>None of the above options applies to your child.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Where did your child live?",
              "Living situation child",
              [
                "With us parents",
                "Patchwork family",
                "Only with me",
                "With the other parent",
                "At place of training",
                "With Step-/Grandparents",
                "Somewhere else"
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
              430.0,
              "",
              Questions.childText);
      }

      //Answer No 6
      else if (widget.CheckCompleteQuestion ==
              "Have you had any of the following expenses for your child?" &&
          widget.CheckQuestion == "Expenses for child") {
        return familyyesnoContainer("""<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did you live together at any time of the year with the other parent in one household?",
            "Joint household",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 5
      else if (widget.CheckCompleteQuestion == "Where did your child live?" &&
          widget.CheckQuestion == "Living situation child") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "With us parents") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert('Where did your child live?', Questions.childText, 'OK');

            //Question No 6
            //For Costs due to diability 220.0
            //For rest 430.0
            Questions.childrenLive = "With us parents";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert('Where did your child live?', 'skip', 'OK');

            //Question No 6
            //For Costs due to diability 220.0
            //For rest 430.0
            Questions.childrenLive = "skip";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Patchwork family") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert('Where did your child live?', 'Patchwork family', 'OK');

            //Question No 6
            Questions.childrenLive = "Patchwork family";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Only with me") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert('Where did your child live?', 'Only with me', 'OK');

            //Question No 6
            Questions.childrenLive = "Only with me";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "With the other parent") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert(
                'Where did your child live?', 'With the other parent', 'OK');

            //Question No 6
            Questions.childrenLive = "With the other parent";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "At place of training") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert('Where did your child live?', 'At place of training', 'OK');

            //Question No 6
            Questions.childrenLive = "At place of training";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "With Step-/Grandparents") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert(
                'Where did your child live?', 'With Step-/Grandparents', 'OK');

            //Question No 6
            Questions.childrenLive = "With Step-/Grandparents";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Somewhere else") {
            DbHelper.insatance
              ..deleteWithquestion('Where did your child live?');
            _insert('Where did your child live?', 'Somewhere else', 'OK');

            //Question No 6
            Questions.childrenLive = "Somewhere else";
            return familymultipleoptionsContainer(
                """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Have you had any of the following expenses for your child?",
                "Expenses child",
                [
                  "Care costs",
                  "School fees",
                  "Health insurance contributions",
                  "Costs due to disability",
                  "None of this applies"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          }
        }
      }

      //  else if (widget.CheckCompleteQuestion ==
      //         "How was your child cared for?" &&
      //     widget.CheckQuestion == "Childcare costs") {

      //     }

      //Answer No 6
      else if (widget.CheckCompleteQuestion ==
              "Have you had any of the following expenses for your child?" &&
          widget.CheckQuestion == "Expenses child") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Care costs") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Have you had any of the following expenses for your child?');
            _insert(
                'Have you had any of the following expenses for your child?',
                'Care costs',
                'OK');

            Questions.childrenExpense = "Care costs";

            if (dob > 1993 && dob < 2006) {
              if (Questions.childrenLive == "With us parents") {
                //Question No 7
                return familymultipleoptionsContainer(
                    """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "How was your child cared for?",
                    "Childcare costs",
                    [
                      // "Nursery / kindergarten",
                      // "Child minder",
                      "Nanny",
                      "Babysitter",
                      "Au pair",
                      "None of these"
                    ],
                    [
                      // "images/disabilityoption.png",
                      // "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    430.0,
                    "None of this applies",
                    Questions.childText);
              } else if (Questions.childrenLive == "Patchwork family") {
                //Question No 8
                return familymultipleoptionsContainer(
                    """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "How was your child cared for?",
                    "Childcare costs",
                    [
                      // "Nursery / kindergarten",
                      // "Child minder",
                      "Nanny",
                      "Babysitter",
                      "Au pair",
                      "None of these"
                    ],
                    [
                      // "images/disabilityoption.png",
                      // "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    430.0,
                    "None of this applies",
                    Questions.childText);
              } else if (Questions.childrenLive == "Only with me") {
                //Question No 9
                return familymultipleoptionsContainer(
                    """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "How was your child cared for?",
                    "Childcare costs",
                    [
                      // "Nursery / kindergarten",
                      // "Child minder",
                      "Nanny",
                      "Babysitter",
                      "Au pair",
                      "None of these"
                    ],
                    [
                      // "images/disabilityoption.png",
                      // "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    430.0,
                    "None of this applies",
                    Questions.childText);
              } else if (Questions.childrenLive == "skip") {
                //Question No 9
                return familymultipleoptionsContainer(
                    """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "How was your child cared for?",
                    "Childcare costs",
                    [
                      // "Nursery / kindergarten",
                      // "Child minder",
                      "Nanny",
                      "Babysitter",
                      "Au pair",
                      "None of these"
                    ],
                    [
                      // "images/disabilityoption.png",
                      // "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    430.0,
                    "None of this applies",
                    Questions.childText);
              } else if (Questions.childrenLive == "With the other parent" ||
                  Questions.childrenLive == "At place of training" ||
                  Questions.childrenLive == "With Step-/Grandparents" ||
                  Questions.childrenLive == "Somewhere else") {
                //Question No 10
                return familymultipleoptionsContainer(
                    """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "How was your child cared for?",
                    "Childcare costs",
                    [
                      // "Nursery / kindergarten",
                      // "Child minder",
                      "Nanny",
                      "Babysitter",
                      "Au pair",
                      "None of these"
                    ],
                    [
                      // "images/disabilityoption.png",
                      // "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/check.png",
                      "images/check.png"
                    ],
                    430.0,
                    "None of this applies",
                    Questions.childText);
              } else if (widget.CheckAnswer[m] == "Care costs") {
                return familyyesnoContainer(
                    """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Did you live together at any time of the year with the other parent in one household?",
                    "Joint household",
                    220.0,
                    "",
                    Questions.childText);
              }
            } else {
              return FinishCategory(
                  "Family Category", "Health Category", 4, true);
            }
          } else if (widget.CheckAnswer[m] == "School fees") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Have you had any of the following expenses for your child?');
            _insert(
                'Have you had any of the following expenses for your child?',
                'School fees',
                'OK');

            Questions.childrenExpense = "School fees";
            if (dob > 1993 && dob < 2006) {
              if (Questions.childrenLive == "With us parents") {
                //Question No 7
                return familyyesnoContainer(
                    """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Do you know the details of the other parent?",
                    "Other parent's details",
                    220.0,
                    "",
                    Questions.childText);
              } else if (Questions.childrenLive == "Patchwork family") {
                //Question No 8
                return familydifferentoptionContainer(
                    """<p><strong>Relationship with child</strong></p>
<p>Please specify what type of relationship you had to the child. Type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p><strong>GRANDCHILD</strong></p>
<p>You can also specify grandchildren. But only under the conditions that you have an obligation to support the child and the child lives with you.</p>
<p><strong>STEPCHILD</strong></p>
<p>Stepchildren are treated in a similar way to grandchildren. You can deduct expenditures if the child lives in your household and you have an obligation to support them.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "What relationship existed between you and the child?",
                    "Relationship to child",
                    [
                      "Biological child",
                      "Adopted child",
                      "Foster child",
                      "Grandchild",
                      "Stepchild"
                    ],
                    220.0,
                    "",
                    Questions.childText);
              } else if (Questions.childrenLive == "Only with me") {
                //Question No 9
                return familycalculationContainer(
                    """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Enter your child's Tax-ID.",
                    "Tax-ID child",
                    220.0,
                    "tax",
                    Questions.childText);
              } else if (Questions.childrenLive == "skip") {
                //Question No 9
                return familycalculationContainer(
                    """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Enter your child's Tax-ID.",
                    "Tax-ID child",
                    220.0,
                    "tax",
                    Questions.childText);
              } else if (Questions.childrenLive == "With the other parent" ||
                  Questions.childrenLive == "At place of training" ||
                  Questions.childrenLive == "With Step-/Grandparents" ||
                  Questions.childrenLive == "Somewhere else") {
                //Question No 10
                return familycalculationContainer(
                    """<p><strong>Number of places of residence of your child</strong></p>
<p>Please enter here in how many places your child lived in 2019. For this, you enter the exact number of locations.</p>
<p><strong>Important:</strong></p>
<p>If your child moved with you, you do not need to specify this here. Only relevant are the addresses and places where your child did not live together with you, for example, because your child was living with the other parent or was staying abroad.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "In how many different places has your child lived?",
                    "Number of places lived",
                    220.0,
                    "loop",
                    Questions.childText);
              }
            } else {
              return FinishCategory(
                  "Family Category", "Health Category", 4, true);
            }
          } else if (widget.CheckAnswer[m] ==
              "Health insurance contributions") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Have you had any of the following expenses for your child?');
            _insert(
                'Have you had any of the following expenses for your child?',
                'Health insurance contributions',
                'OK');

            Questions.childrenExpense = "Health insurance contributions";

            if (dob > 1993 && dob < 2006) {
              if (Questions.childrenLive == "With us parents") {
                //Question No 7
                return familyyesnoContainer(
                    """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Do you know the details of the other parent?",
                    "Other parent's details",
                    220.0,
                    "",
                    Questions.childText);
              } else if (Questions.childrenLive == "Patchwork family") {
                //Question No 8
                return familydifferentoptionContainer(
                    """<p><strong>Relationship with child</strong></p>
<p>Please specify what type of relationship you had to the child. Type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p><strong>GRANDCHILD</strong></p>
<p>You can also specify grandchildren. But only under the conditions that you have an obligation to support the child and the child lives with you.</p>
<p><strong>STEPCHILD</strong></p>
<p>Stepchildren are treated in a similar way to grandchildren. You can deduct expenditures if the child lives in your household and you have an obligation to support them.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "What relationship existed between you and the child?",
                    "Relationship to child",
                    [
                      "Biological child",
                      "Adopted child",
                      "Foster child",
                      "Grandchild",
                      "Stepchild"
                    ],
                    220.0,
                    "",
                    Questions.childText);
              } else if (Questions.childrenLive == "Only with me") {
                //Question No 9
                return familycalculationContainer(
                    """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Enter your child's Tax-ID.",
                    "Tax-ID child",
                    220.0,
                    "tax",
                    Questions.childText);
              } else if (Questions.childrenLive == "skip") {
                //Question No 9
                return familycalculationContainer(
                    """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Enter your child's Tax-ID.",
                    "Tax-ID child",
                    220.0,
                    "tax",
                    Questions.childText);
              } else if (Questions.childrenLive == "With the other parent" ||
                  Questions.childrenLive == "At place of training" ||
                  Questions.childrenLive == "With Step-/Grandparents" ||
                  Questions.childrenLive == "Somewhere else") {
                //Question No 10
                return familycalculationContainer(
                    """<p><strong>Number of places of residence of your child</strong></p>
<p>Please enter here in how many places your child lived in 2019. For this, you enter the exact number of locations.</p>
<p><strong>Important:</strong></p>
<p>If your child moved with you, you do not need to specify this here. Only relevant are the addresses and places where your child did not live together with you, for example, because your child was living with the other parent or was staying abroad.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "In how many different places has your child lived?",
                    "Number of places lived",
                    220.0,
                    "loop",
                    Questions.childText);
              }
            } else {
              return FinishCategory(
                  "Family Category", "Health Category", 4, true);
            }
          } else if (widget.CheckAnswer[m] == "Costs due to disability") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Have you had any of the following expenses for your child?');
            _insert(
                'Have you had any of the following expenses for your child?',
                'Costs due to disability',
                'OK');

            Questions.childrenExpense = "Costs due to disability";
//            //Question No 153
            return familyyesnoContainer(
                """<p><strong>Transfer of disability flat-rate allowance</strong></p>
<p>Please state if you wish to transfer the disability flat-rate allowance for your child <strong>to yourself</strong>. If so, then select "Yes", otherwise click "No".</p>
<p>Even if your child has no taxable income, because for instance they are still a minor, they cannot benefit from the disability flat-rate allowance. However, if you transfer this allowance over to you, you can claim this amount.</p>
<p><strong>YOUR TAXES</strong></p>
<p>This flat-rate allowance covers <strong>the standard, regular costs</strong> which occur because of your child's disability.</p>
<p>With this amount, all costs would be covered.</p>
<p>These include, for example:</p>
<ul>
<li>medication</li>
<li>walking aids (e.g. wheelchair)</li>
</ul>
<p>The amount depends on the <strong>degree of disability</strong> of your child.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Do you wish to transfer your child's disability flat-rate amount to yourself?",
                "Transfer of flat-rate amount",
                220.0,
                "",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "None of this applies") {
            DbHelper.insatance.deleteWithquestion(
                'Have you had any of the following expenses for your child?');
            _insert(
                'Have you had any of the following expenses for your child?',
                'None of this applies',
                'OK');

            Questions.childrenExpense = "None of this applies";
            if (dob > 1993 && dob < 2006) {
              if (Questions.childrenLive == "With us parents") {
                //Question No 7
                return familyyesnoContainer(
                    """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Do you know the details of the other parent?",
                    "Other parent's details",
                    220.0,
                    "",
                    Questions.childText);
              } else if (Questions.childrenLive == "Patchwork family") {
                //Question No 8
                return familydifferentoptionContainer(
                    """<p><strong>Relationship with child</strong></p>
<p>Please specify what type of relationship you had to the child. Type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p><strong>GRANDCHILD</strong></p>
<p>You can also specify grandchildren. But only under the conditions that you have an obligation to support the child and the child lives with you.</p>
<p><strong>STEPCHILD</strong></p>
<p>Stepchildren are treated in a similar way to grandchildren. You can deduct expenditures if the child lives in your household and you have an obligation to support them.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "What relationship existed between you and the child?",
                    "Relationship to child",
                    [
                      "Biological child",
                      "Adopted child",
                      "Foster child",
                      "Grandchild",
                      "Stepchild"
                    ],
                    220.0,
                    "",
                    Questions.childText);
              } else if (Questions.childrenLive == "Only with me") {
                //Question No 9
                return familycalculationContainer(
                    """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Enter your child's Tax-ID.",
                    "Tax-ID child",
                    220.0,
                    "tax",
                    Questions.childText);
              } else if (Questions.childrenLive == "With the other parent" ||
                  Questions.childrenLive == "At place of training" ||
                  Questions.childrenLive == "With Step-/Grandparents" ||
                  Questions.childrenLive == "Somewhere else") {
                //Question No 10
                return familycalculationContainer(
                    """<p><strong>Number of places of residence of your child</strong></p>
<p>Please enter here in how many places your child lived in 2019. For this, you enter the exact number of locations.</p>
<p><strong>Important:</strong></p>
<p>If your child moved with you, you do not need to specify this here. Only relevant are the addresses and places where your child did not live together with you, for example, because your child was living with the other parent or was staying abroad.</p>
<p> </p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "In how many different places has your child lived?",
                    "Number of places lived",
                    220.0,
                    "loop",
                    Questions.childText);
              } else {
                Questions.childrenExpense = "skip";
                //Question No 9
                return familycalculationContainer(
                    """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                    "",
                    "Child ${Questions.childLength}",
                    "Enter your child's Tax-ID.",
                    "Tax-ID child",
                    220.0,
                    "tax",
                    Questions.childText);
              }
            } else {
              return FinishCategory(
                  "Family Category", "Health Category", 4, true);
            }
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Have you had any of the following expenses for your child?');
            _insert(
                'Have you had any of the following expenses for your child?',
                'skip',
                'skip');

            Questions.childrenExpense = "skip";
            //Question No 9
            return familycalculationContainer(
                """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Enter your child's Tax-ID.",
                "Tax-ID child",
                220.0,
                "tax",
                Questions.childText);
          }
        }
      }

      //Answer No 8
      else if (widget.CheckCompleteQuestion ==
              "What relationship existed between you and the child?" &&
          widget.CheckQuestion == "Relationship to child") {
        DbHelper.insatance.deleteWithquestion(
            'What relationship existed between you and the child?');
        _insert('What relationship existed between you and the child?',
            Questions.childText, 'OK');

        //Question No 41
        return familyyesnoContainer(
            """<p><strong>Parent-child relationship</strong></p>
<p>Choose the answer "Yes", if the parent-child relationship existed for the whole of <strong>2019</strong>. Otherwise click "No".</p>
<p>A parent-child relationship includes a biological child, an adopted child or a foster child.</p>
<p><strong>Attention:</strong></p>
<p>If your child was born in 2019, the parent-child relationship <strong>didn't</strong> exist throughout the whole year.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did the parent-child relationship between you and the child last the entire year?",
            "Year-round parent-child relationship",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 9
      else if (widget.CheckCompleteQuestion == "Enter your child's Tax-ID." &&
          widget.CheckQuestion == "Tax-ID child") {
        DbHelper.insatance.deleteWithquestion('Enter your child\'s Tax-ID.');
        _insert('Enter your child\'s Tax-ID.', Questions.childText, 'OK');

        //Question No 7
        return familyyesnoContainer(
            """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Do you know the details of the other parent?",
            "Other parent's details",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 10
      else if (widget.CheckCompleteQuestion ==
              "In how many different places has your child lived?" &&
          widget.CheckQuestion == "Number of places lived") {
        DbHelper.insatance.deleteWithquestion(
            'In how many different places has your child lived?');
        _insert('In how many different places has your child lived?',
            Questions.childText, 'OK');

        //Question No 11
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What was the address of your child?",
            "Address child",
            220.0,
            "",
            Questions.childAddressText);
      }

      //Answer No 11
      else if (widget.CheckCompleteQuestion ==
              "What was the address of your child?" &&
          widget.CheckQuestion == "Address child") {
        DbHelper.insatance
            .deleteWithquestion('What was the address of your child?');
        _insert(
            'What was the address of your child?', Questions.childText, 'OK');

        //Question No 12
        //Ya container badd ma change hoga
        return familydateContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "When did your child live there?",
            "Period living there",
            220.0,
            "",
            Questions.childAddressText);
      }

      //Answer No 12
      else if (widget.CheckCompleteQuestion ==
              "When did your child live there?" &&
          widget.CheckQuestion == "Period living there") {
        DbHelper.insatance
            .deleteWithquestion('When did your child live there?');
        _insert('When did your child live there?', Questions.childText, 'OK');

        if (Questions.childAddressLength <= Questions.totalChildAddress) {
          //Question No 11
          return familyaddressContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What was the address of your child?",
              "Address child",
              220.0,
              "",
              Questions.childAddressText);
        } else {
          //Question No 7
          return familyyesnoContainer(
              """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Do you know the details of the other parent?",
              "Other parent's details",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 7
      else if (widget.CheckCompleteQuestion ==
              "Do you know the details of the other parent?" &&
          widget.CheckQuestion == "Other parent's details") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Do you know the details of the other parent?');
          _insert('Do you know the details of the other parent?', 'No', 'OK');

          //Question No 13
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Please choose the reason why you do not know the details of the other parent.",
              "Reason",
              [
                "No contact",
                "Not possible to get details",
                "Officially unascertainable"
              ],
              430.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Do you know the details of the other parent?');
          _insert('Do you know the details of the other parent?', 'Yes', 'OK');

          //Question No 14
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the other parent's full name?",
              "Name of other parent",
              220.0,
              "",
              Questions.childText);
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Do you know the details of the other parent?');
          _insert(
              'Do you know the details of the other parent?', 'skip', 'skip');

          //Question No 13
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Please choose the reason why you do not know the details of the other parent.",
              "Reason",
              [
                "No contact",
                "Not possible to get details",
                "Officially unascertainable"
              ],
              430.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 13
      else if (widget.CheckCompleteQuestion ==
              "Please choose the reason why you do not know the details of the other parent." &&
          widget.CheckQuestion == "Reason") {
        if (widget.CheckAnswer[0] == "No contact" ||
            widget.CheckAnswer[0] == "Not possible to get details" ||
            widget.CheckAnswer[0] == "Officially unascertainable") {
          DbHelper.insatance.deleteWithquestion(
              'reason why you do not know the details of the other parent');
          _insert('reason why you do not know the details of the other parent',
              widget.CheckAnswer[0], 'OK');

          //Children Lives
          if (Questions.childrenLive == "With us parents" ||
              Questions.childrenLive == "Somewhere else") {
            if (Questions.childrenExpense == "Care costs") {
              //Question No 60
              return familymultipleoptionsContainer(
                  """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "How was your child cared for?",
                  "Childcare costs",
                  [
                    "Nursery / kindergarten",
                    "Child minder",
                    "Nanny",
                    "Babysitter",
                    "Au pair",
                    "Daycare center"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  430.0,
                  "None of this applies",
                  Questions.childText);
            } else if (Questions.childrenExpense == "School fees") {
              //Question No 61
              return familycalculationContainer(
                  """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "For how many schools did you pay tuition fees?",
                  "Schools attended",
                  430.0,
                  "loop",
                  Questions.childText);
            } else if (Questions.childrenExpense == "skip") {
              //Question No 61
              return familycalculationContainer(
                  """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "For how many schools did you pay tuition fees?",
                  "Schools attended",
                  430.0,
                  "loop",
                  Questions.childText);
            } else if (Questions.childrenExpense ==
                "Health insurance contributions") {
              //Question No 62
              return familytwooptionContainer(
                  """<p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "What type of contract is the health insurance policy?",
                  "Supplementary health insurance",
                  ["Domestic health insurance", "Foreign health insurance"],
                  430.0,
                  "",
                  Questions.childText);
            } else if (Questions.childrenExpense == "Costs due to disability" ||
                Questions.childrenExpense == "None of this applies") {
              //Question No 63
              return familydifferentoptionContainer(
                  """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                  "Benefits office",
                  [
                    "Baden-Württemberg Ost",
                    "Baden-Württemberg West",
                    "Bayern Nord",
                    "Bayern Süd",
                    "Berlin-Brandenburg",
                    "Hessen",
                    "Niedersachsen-Bremen",
                    "Nord",
                    "Nordrhein-Westfalen Nord",
                    "Nordrhein-Westfalen Ost",
                    "Nordrhein-Westfalen West",
                    "Rheinland-Pfalz-Saarland",
                    "Sachsen",
                    "Sachsen-Anhalt - Thüringen",
                    "Other"
                  ],
                  220.0,
                  "",
                  Questions.childText);
            }
          } else if (Questions.childrenLive == "Only with me") {
            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "skip") {
            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "With the other parent") {
            //Question No 38
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Did the other parent request a transfer of the allowance for childcare, education or training needs?",
                "Allowance transfer",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "At place of training") {
            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "With Step-/Grandparents") {
            //Question No 39
            return familyyesnoContainer(
                """<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>""",
                "",
                "Child ${Questions.childLength}",
                "Do you want to transfer the child allowance to the step or grandparents?",
                "Allowance transfer",
                220.0,
                "",
                Questions.childText);
          }
        } else if (Questions.childrenLive == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'reason why you do not know the details of the other parent');
          _insert('reason why you do not know the details of the other parent',
              'skip', 'skip');

          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 14
      else if (widget.CheckCompleteQuestion ==
              "What is the other parent's full name?" &&
          widget.CheckQuestion == "Name of other parent") {
        DbHelper.insatance.deleteWithquestion(
            'reason why you do not know the details of the other parent');
        _insert('reason why you do not know the details of the other parent',
            Questions.childText, 'OK');

        //Question No 15
        return familydateContainer("""<h1>Coming Soon!</h1>
""",
            "",
            "Child ${Questions.childLength}",
            "What is the other parent's date of birth?",
            "Date of birth other parent",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 15
      else if (widget.CheckCompleteQuestion ==
              "What is the other parent's date of birth?" &&
          widget.CheckQuestion == "Date of birth other parent") {
        DbHelper.insatance
            .deleteWithquestion('What is the other parent\'s date of birth?');
        _insert('What is the other parent\'s date of birth?',
            Questions.childText, 'OK');

        //Question No 16
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the other parent's (last known) address?",
            "Address other parent",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 16
      else if (widget.CheckCompleteQuestion ==
              "What is the other parent's (last known) address?" &&
          widget.CheckQuestion == "Address other parent") {
        DbHelper.insatance.deleteWithquestion(
            'What is the other parent\'s (last known) address?');
        _insert('What is the other parent\'s (last known) address?',
            Questions.childText, 'OK');

        //Question No 17
        //For No 430.0
        //For Yes 220.0
        return familyyesnoContainer(
            """<p><strong>Parent-child relationship</strong></p>
<p>Choose the answer "Yes", if the parent-child relationship between the child and the other parent existed for the whole of <strong>2019</strong>. Otherwise, click "No".</p>
<p>A parent-child relationship includes a biological child, an adopted child or a foster child.</p>
<p><strong>Attention</strong>: If your child was born in 2019, the parent-child relationship <strong>didn't</strong> exist throughout the whole year.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did the parent-child relationship between your child and the other parent last the entire year?",
            "Year-round parent-child relationship",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 17
      else if (widget.CheckCompleteQuestion ==
              "Did the parent-child relationship between your child and the other parent last the entire year?" &&
          widget.CheckQuestion == "Year-round parent-child relationship") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship', 'No', 'OK');

          //Question No 18
          return familythreeoptionContainer(
              """ <h1>Coming Soon!</h1> """,
              "",
              "Child ${Questions.childLength}",
              "How did the relationship change in 2019?",
              "Change parent-child relationship",
              ["It began", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship', 'Yes', 'OK');

          //Children Lives
          if (Questions.childrenLive == "With us parents" ||
              Questions.childrenLive == "Somewhere else") {
            if (Questions.childrenExpense == "Care costs") {
              //Question No 60
              return familymultipleoptionsContainer(
                  """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "How was your child cared for?",
                  "Childcare costs",
                  [
                    "Nursery / kindergarten",
                    "Child minder",
                    "Nanny",
                    "Babysitter",
                    "Au pair",
                    "Daycare center"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  430.0,
                  "None of this applies",
                  Questions.childText);
            } else if (Questions.childrenExpense == "School fees") {
              //Question No 61
              return familycalculationContainer(
                  """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "For how many schools did you pay tuition fees?",
                  "Schools attended",
                  430.0,
                  "loop",
                  Questions.childText);
            } else if (Questions.childrenExpense ==
                "Health insurance contributions") {
              //Question No 62
              return familytwooptionContainer(
                  """<p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "What type of contract is the health insurance policy?",
                  "Supplementary health insurance",
                  ["Domestic health insurance", "Foreign health insurance"],
                  430.0,
                  "",
                  Questions.childText);
            } else if (Questions.childrenExpense == "Costs due to disability" ||
                Questions.childrenExpense == "None of this applies" ||
                Questions.childrenExpense == "skip") {
              //Question No 63
              return familydifferentoptionContainer(
                  """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                  "Benefits office",
                  [
                    "Baden-Württemberg Ost",
                    "Baden-Württemberg West",
                    "Bayern Nord",
                    "Bayern Süd",
                    "Berlin-Brandenburg",
                    "Hessen",
                    "Niedersachsen-Bremen",
                    "Nord",
                    "Nordrhein-Westfalen Nord",
                    "Nordrhein-Westfalen Ost",
                    "Nordrhein-Westfalen West",
                    "Rheinland-Pfalz-Saarland",
                    "Sachsen",
                    "Sachsen-Anhalt - Thüringen",
                    "Other"
                  ],
                  220.0,
                  "",
                  Questions.childText);
            }
          } else if (Questions.childrenLive == "Only with me") {
            DbHelper.insatance
                .deleteWithquestion('Year-round parent-child relationship');
            _insert('Year-round parent-child relationship', 'Yes', 'OK');

            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "skip") {
            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "With the other parent") {
            //Question No 38
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Did the other parent request a transfer of the allowance for childcare, education or training needs?",
                "Allowance transfer",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "At place of training") {
            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "With Step-/Grandparents") {
            //Question No 39
            return familyyesnoContainer(
                """<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>""",
                "",
                "Child ${Questions.childLength}",
                "Do you want to transfer the child allowance to the step or grandparents?",
                "Allowance transfer",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship', 'skip', 'skip');

          //Question No 18
          return familythreeoptionContainer(
              """ <h1>Coming Soon!</h1> """,
              "",
              "Child ${Questions.childLength}",
              "How did the relationship change in 2019?",
              "Change parent-child relationship",
              ["It began", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 18
      else if (widget.CheckCompleteQuestion ==
              "How did the relationship change in 2019?" &&
          widget.CheckQuestion == "Change parent-child relationship") {
        if (widget.CheckAnswer[0] == "It began") {
          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship', 'It began', 'OK');

          //Question No 19
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent-child relationship start?",
              "Start parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship', 'skip', 'skip');

          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship', 'skip', 'skip');

          //Question No 19
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent-child relationship start?",
              "Start parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "It ended") {
          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship', 'It ended', 'OK');

          //Question No 20
          //For No 430.0
          //For Yes 220.0
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Did the parent-child relationship end due to the death of the other parent?",
              "End due to death",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "It existed temporarily") {
          DbHelper.insatance
              .deleteWithquestion('Year-round parent-child relationship');
          _insert('Year-round parent-child relationship',
              'It existed temporarily', 'OK');

          //Question No 21
          //Ya container change hoga
          return familydateContainer("""
		<h1>Coming Soon!</h1>
	      """,
              "",
              "Child ${Questions.childLength}",
              "From when to when did the parent-child relationship last?",
              "Duration parent-child relationship",
              430.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 19
      else if (widget.CheckCompleteQuestion ==
              "When did the parent-child relationship start?" &&
          widget.CheckQuestion == "Start parent-child relationship") {
        DbHelper.insatance.deleteWithquestion(
            'When did the parent-child relationship start?');
        _insert('When did the parent-child relationship start?',
            Questions.childText, 'OK');

        //Children Lives
        if (Questions.childrenLive == "With us parents" ||
            Questions.childrenLive == "Somewhere else") {
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense == "skip") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        } else if (Questions.childrenLive == "Only with me") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "skip") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "With the other parent") {
          //Question No 38
          return familyyesnoContainer("""
<h1>Coming Soon!</h1>
""",
              "",
              "Child ${Questions.childLength}",
              "Did the other parent request a transfer of the allowance for childcare, education or training needs?",
              "Allowance transfer",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "At place of training") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "With Step-/Grandparents") {
          //Question No 39
          return familyyesnoContainer("""
<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>
""",
              "",
              "Child ${Questions.childLength}",
              "Do you want to transfer the child allowance to the step or grandparents?",
              "Allowance transfer",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 20
      else if (widget.CheckCompleteQuestion ==
              "Did the parent-child relationship end due to the death of the other parent?" &&
          widget.CheckQuestion == "End due to death") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship end due to the death of the other parent?');
          _insert(
              'Did the parent-child relationship end due to the death of the other parent?',
              'No',
              'OK');

          //Children Lives
          if (Questions.childrenLive == "With us parents" ||
              Questions.childrenLive == "Somewhere else" ||
              Questions.childrenLive == "skip") {
            if (Questions.childrenExpense == "Care costs") {
              //Question No 60
              return familymultipleoptionsContainer(
                  """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "How was your child cared for?",
                  "Childcare costs",
                  [
                    "Nursery / kindergarten",
                    "Child minder",
                    "Nanny",
                    "Babysitter",
                    "Au pair",
                    "Daycare center"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  430.0,
                  "None of this applies",
                  Questions.childText);
            } else if (Questions.childrenExpense == "School fees") {
              //Question No 61
              return familycalculationContainer(
                  """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "For how many schools did you pay tuition fees?",
                  "Schools attended",
                  430.0,
                  "loop",
                  Questions.childText);
            } else if (Questions.childrenExpense ==
                "Health insurance contributions") {
              //Question No 62
              return familytwooptionContainer(
                  """<p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "What type of contract is the health insurance policy?",
                  "Supplementary health insurance",
                  ["Domestic health insurance", "Foreign health insurance"],
                  430.0,
                  "",
                  Questions.childText);
            } else if (Questions.childrenExpense == "Costs due to disability" ||
                Questions.childrenExpense == "None of this applies") {
              //Question No 63
              return familydifferentoptionContainer(
                  """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                  "Benefits office",
                  [
                    "Baden-Württemberg Ost",
                    "Baden-Württemberg West",
                    "Bayern Nord",
                    "Bayern Süd",
                    "Berlin-Brandenburg",
                    "Hessen",
                    "Niedersachsen-Bremen",
                    "Nord",
                    "Nordrhein-Westfalen Nord",
                    "Nordrhein-Westfalen Ost",
                    "Nordrhein-Westfalen West",
                    "Rheinland-Pfalz-Saarland",
                    "Sachsen",
                    "Sachsen-Anhalt - Thüringen",
                    "Other"
                  ],
                  220.0,
                  "",
                  Questions.childText);
            }
          } else if (Questions.childrenLive == "Only with me") {
            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "With the other parent") {
            //Question No 38
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Did the other parent request a transfer of the allowance for childcare, education or training needs?",
                "Allowance transfer",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "At place of training") {
            //Question No 23
            return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to request more than 50% of the child allowance?",
                "Share child allowance",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "With Step-/Grandparents") {
            //Question No 39
            return familyyesnoContainer(
                """<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>""",
                "",
                "Child ${Questions.childLength}",
                "Do you want to transfer the child allowance to the step or grandparents?",
                "Allowance transfer",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship end due to the death of the other parent?');
          _insert(
              'Did the parent-child relationship end due to the death of the other parent?',
              'Yes',
              'OK');

          //Question No 22
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent-child relationship end?",
              "End parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship end due to the death of the other parent?');
          _insert(
              'Did the parent-child relationship end due to the death of the other parent?',
              'skip',
              'skip');

          //Question No 22
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent-child relationship end?",
              "End parent-child relationship",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 22
      else if (widget.CheckCompleteQuestion ==
              "When did the parent-child relationship end?" &&
          widget.CheckQuestion == "End parent-child relationship") {
        //Children Lives
        if (Questions.childrenLive == "With us parents" ||
            Questions.childrenLive == "Somewhere else") {
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense == "skip") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        } else if (Questions.childrenLive == "Only with me") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "skip") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "With the other parent") {
          //Question No 38
          return familyyesnoContainer("""
<h1>Coming Soon!</h1>
""",
              "",
              "Child ${Questions.childLength}",
              "Did the other parent request a transfer of the allowance for childcare, education or training needs?",
              "Allowance transfer",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "At place of training") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "With Step-/Grandparents") {
          //Question No 39
          return familyyesnoContainer("""
<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>
""",
              "",
              "Child ${Questions.childLength}",
              "Do you want to transfer the child allowance to the step or grandparents?",
              "Allowance transfer",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 21
      else if (widget.CheckCompleteQuestion ==
              "From when to when did the parent-child relationship last?" &&
          widget.CheckQuestion == "Duration parent-child relationship") {
        //Children Lives
        if (Questions.childrenLive == "With us parents" ||
            Questions.childrenLive == "Somewhere else") {
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense == "skip") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        } else if (Questions.childrenLive == "Only with me") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "skip") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "With the other parent") {
          //Question No 38
          return familyyesnoContainer("""
<h1>Coming Soon!</h1>
""",
              "",
              "Child ${Questions.childLength}",
              "Did the other parent request a transfer of the allowance for childcare, education or training needs?",
              "Allowance transfer",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "At place of training") {
          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "With Step-/Grandparents") {
          //Question No 39
          return familyyesnoContainer("""
<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>
""",
              "",
              "Child ${Questions.childLength}",
              "Do you want to transfer the child allowance to the step or grandparents?",
              "Allowance transfer",
              220.0,
              "",
              Questions.childText);
        }
      }

      // ====== Patchwork Family Starts ====== //

      //Answer no 41
      else if (widget.CheckCompleteQuestion ==
              "Did the parent-child relationship between you and the child last the entire year?" &&
          widget.CheckQuestion == "Year-round parent-child relationship") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between you and the child last the entire year?');
          _insert(
              'Did the parent-child relationship between you and the child last the entire year?',
              'No',
              'OK');

          //Question No 43
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "How has the parent-child relationship changed during 2019?",
              "Change parent-child relationship",
              ["It began", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between you and the child last the entire year?');
          _insert(
              'Did the parent-child relationship between you and the child last the entire year?',
              'Yes',
              'OK');

          //Question No 42
          return familyyesnoContainer(
              """<p><strong>Relationship with another person</strong></p>
<p>Answer this question with "Yes", if your child had a parent-child relationship with another person. Parent-child relationship means in this case that your child was supervised by someone else and was raised by them.</p>
<p>We are still talking about the year 2019.</p>""",
              "",
              "Child ${Questions.childLength}",
              "Did the child have parent-child relations with another person?",
              "Other person",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between you and the child last the entire year?');
          _insert(
              'Did the parent-child relationship between you and the child last the entire year?',
              'skip',
              'skip');

          //Question No 43
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "How has the parent-child relationship changed during 2019?",
              "Change parent-child relationship",
              ["It began", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 43
      else if (widget.CheckCompleteQuestion ==
              "How has the parent-child relationship changed during 2019?" &&
          widget.CheckQuestion == "Change parent-child relationship") {
        if (widget.CheckAnswer[0] == "It began") {
          DbHelper.insatance.deleteWithquestion(
              'How has the parent-child relationship changed during 2019?');
          _insert('How has the parent-child relationship changed during 2019?',
              'It began', 'OK');

          //Question No 44
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent - child relationship start?",
              "Start parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'How has the parent-child relationship changed during 2019?');
          _insert('How has the parent-child relationship changed during 2019?',
              'skip', 'skip');

          //Question No 44
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent - child relationship start?",
              "Start parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "It ended") {
          DbHelper.insatance.deleteWithquestion(
              'How has the parent-child relationship changed during 2019?');
          _insert('How has the parent-child relationship changed during 2019?',
              'It ended', 'OK');

          //Question No 45
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent - child relationship end?",
              "End parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "It existed temporarily") {
          DbHelper.insatance.deleteWithquestion(
              'How has the parent-child relationship changed during 2019?');
          _insert('How has the parent-child relationship changed during 2019?',
              'It existed temporarily', 'OK');

          //Question no 46
          //Ya container change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "How long did the parent-child relationship last?",
              "Duration parent-child relationship",
              430.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 44
      else if (widget.CheckCompleteQuestion ==
              "When did the parent - child relationship start?" &&
          widget.CheckQuestion == "Start parent-child relationship") {
        DbHelper.insatance.deleteWithquestion(
            'When did the parent - child relationship start?');
        _insert('When did the parent - child relationship start?',
            Questions.childText, 'OK');

        //Question No 42
        return familyyesnoContainer(
            """<p><strong>Relationship with another person</strong></p>
<p>Answer this question with "Yes", if your child had a parent-child relationship with another person. Parent-child relationship means in this case that your child was supervised by someone else and was raised by them.</p>
<p>We are still talking about the year 2019.</p>""",
            "",
            "Child ${Questions.childLength}",
            "Did the child have parent-child relations with another person?",
            "Other person",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 45
      else if (widget.CheckCompleteQuestion ==
              "When did the parent - child relationship end?" &&
          widget.CheckQuestion == "End parent-child relationship") {
        DbHelper.insatance.deleteWithquestion(
            'When did the parent - child relationship end?');
        _insert('When did the parent - child relationship end?',
            Questions.childText, 'OK');

        //Question No 42
        return familyyesnoContainer(
            """<p><strong>Relationship with another person</strong></p>
<p>Answer this question with "Yes", if your child had a parent-child relationship with another person. Parent-child relationship means in this case that your child was supervised by someone else and was raised by them.</p>
<p>We are still talking about the year 2019.</p>""",
            "",
            "Child ${Questions.childLength}",
            "Did the child have parent-child relations with another person?",
            "Other person",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 46
      else if (widget.CheckCompleteQuestion ==
              "How long did the parent-child relationship last?" &&
          widget.CheckQuestion == "Duration parent-child relationship") {
        DbHelper.insatance.deleteWithquestion(
            'How long did the parent-child relationship last?');
        _insert('How long did the parent-child relationship last?',
            Questions.childText, 'OK');

        //Question No 42
        return familyyesnoContainer(
            """<p><strong>Relationship with another person</strong></p>
<p>Answer this question with "Yes", if your child had a parent-child relationship with another person. Parent-child relationship means in this case that your child was supervised by someone else and was raised by them.</p>
<p>We are still talking about the year 2019.</p>""",
            "",
            "Child ${Questions.childLength}",
            "Did the child have parent-child relations with another person?",
            "Other person",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 42
      else if (widget.CheckCompleteQuestion ==
              "Did the child have parent-child relations with another person?" &&
          widget.CheckQuestion == "Other person") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did the child have parent-child relations with another person?');
          _insert(
              'Did the child have parent-child relations with another person?',
              'No',
              'OK');

          //Question No 47
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Why was there no parental relationship to another person?",
              "Reason",
              ["Parent died", "Parent unknown", "No contact"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did the child have parent-child relations with another person?');
          _insert(
              'Did the child have parent-child relations with another person?',
              'skip',
              'skip');

          //Question No 47
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Why was there no parental relationship to another person?",
              "Reason",
              ["Parent died", "Parent unknown", "No contact"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did the child have parent-child relations with another person?');
          _insert(
              'Did the child have parent-child relations with another person?',
              'Yes',
              'OK');

          //Question No 49
          return familyyesnoContainer(
              """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Do you know the address of the other parent?",
              "Address of the other parent",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 47
      else if (widget.CheckCompleteQuestion ==
              "Why was there no parental relationship to another person?" &&
          widget.CheckQuestion == "Reason") {
        if (widget.CheckAnswer[0] == "Parent died") {
          DbHelper.insatance.deleteWithquestion(
              'Why was there no parental relationship to another person?');
          _insert('Why was there no parental relationship to another person?',
              'Parent died', 'OK');

          //Question No 48
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the other parent die?",
              "Date of death",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Parent unknown") {
          DbHelper.insatance.deleteWithquestion(
              'Why was there no parental relationship to another person?');
          _insert('Why was there no parental relationship to another person?',
              'Parent unknown', 'OK');

          //Question No 23
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to request more than 50% of the child allowance?",
              "Share child allowance",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "No contact") {
          DbHelper.insatance.deleteWithquestion(
              'Why was there no parental relationship to another person?');
          _insert('Why was there no parental relationship to another person?',
              'No contact', 'OK');

          //Question No 49
          return familyyesnoContainer(
              """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Do you know the address of the other parent?",
              "Address of the other parent",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Why was there no parental relationship to another person?');
          _insert('Why was there no parental relationship to another person?',
              'skip', 'OK');

          //Question No 49
          return familyyesnoContainer(
              """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Do you know the address of the other parent?",
              "Address of the other parent",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 48
      else if (widget.CheckCompleteQuestion ==
              "When did the other parent die?" &&
          widget.CheckQuestion == "Date of death") {
        DbHelper.insatance.deleteWithquestion('When did the other parent die?');
        _insert('When did the other parent die?', Questions.childText, 'OK');

        //Question No 23
        return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Would you like to request more than 50% of the child allowance?",
            "Share child allowance",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 49
      else if (widget.CheckCompleteQuestion ==
              "Do you know the address of the other parent?" &&
          widget.CheckQuestion == "Address of the other parent") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Do you know the address of the other parent?');
          _insert('Do you know the address of the other parent?', 'No', 'OK');

          //Question No 50
          return familythreeoptionContainer(
              """<p><strong>Parent-child relationship to other parent</strong></p>
<p>Please specify what type of relationship your child had to the other parent. The type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What type of parent-child relationship was there between your child and the other parent?",
              "Type of relationship",
              ["Biological child", "Adopted child", "Foster child"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Do you know the address of the other parent?');
          _insert('Do you know the address of the other parent?', 'Yes', 'OK');

          //Question No 51
          return familythreeoptionContainer(
              """<p><strong>Parent-child relationship to other parent</strong></p>
<p>Please specify what type of relationship your child had to the other parent. The type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What type of parent-child relationship was there between your child and the other parent?",
              "Type of relationship",
              ["Biological child", "Adopted child", "Foster child"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Do you know the address of the other parent?');
          _insert(
              'Do you know the address of the other parent?', 'skip', 'skip');

          //Question No 50
          return familythreeoptionContainer(
              """<p><strong>Parent-child relationship to other parent</strong></p>
<p>Please specify what type of relationship your child had to the other parent. The type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What type of parent-child relationship was there between your child and the other parent?",
              "Type of relationship",
              ["Biological child", "Adopted child", "Foster child"],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 50
      else if (widget.CheckCompleteQuestion ==
              "Please state here the reason why the details of the other parent are unknown." &&
          widget.CheckQuestion == "Reason") {
        DbHelper.insatance
            .deleteWithquestion('Reason of the other parent are unknown');
        _insert('Reason of the other parent are unknown', Questions.childText,
            'OK');

        //Question No 23
        return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Would you like to request more than 50% of the child allowance?",
            "Share child allowance",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 51
      else if (widget.CheckCompleteQuestion ==
              "What type of parent-child relationship was there between your child and the other parent?" &&
          widget.CheckQuestion == "Type of relationship") {
        DbHelper.insatance.deleteWithquestion(
            'What type of parent-child relationship was there between your child and the other parent?');
        _insert(
            'What type of parent-child relationship was there between your child and the other parent?',
            Questions.childText,
            'OK');

        //Question No 52
        return familyyesnoContainer(
            """<p><strong>Parent-child relationship</strong></p>
<p>Choose the answer "Yes", if the parent-child relationship between the child and the other parent existed for the whole of <strong>2019</strong>. Otherwise, click "No".</p>
<p>A parent-child relationship includes a biological child, an adopted child or a foster child.</p>
<p><strong>Attention</strong>: If your child was born in 2019, the parent-child relationship <strong>didn't</strong> exist throughout the whole year.</p>
<p> </p><p><strong>Parent-child relationship</strong></p>
<p>Choose the answer "Yes", if the parent-child relationship between the child and the other parent existed for the whole of <strong>2019</strong>. Otherwise, click "No".</p>
<p>A parent-child relationship includes a biological child, an adopted child or a foster child.</p>
<p><strong>Attention</strong>: If your child was born in 2019, the parent-child relationship <strong>didn't</strong> exist throughout the whole year.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did the parent-child relationship between ${Questions.childFirstName} and the other parent last the entire year ?",
            "Year-round parent-child relationship",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 52
      else if (widget.CheckCompleteQuestion ==
              "Did the parent-child relationship between ${Questions.childFirstName} and the other parent last the entire year ?" &&
          widget.CheckQuestion == "Year-round parent-child relationship") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between and the other parent last the entire year?');
          _insert(
              'Did the parent-child relationship between and the other parent last the entire year?',
              'No',
              'OK');

          //Question No 53
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "How has the parent - child relationship changed during 2019?",
              "Change parent-child relationship",
              ["It began", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between and the other parent last the entire year?');
          _insert(
              'Did the parent-child relationship between and the other parent last the entire year?',
              'Yes',
              'OK');

          //Question No 57
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the other parent's full name?",
              "Name of the person",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between and the other parent last the entire year?');
          _insert(
              'Did the parent-child relationship between and the other parent last the entire year?',
              'skip',
              'skip');

          //Question No 53
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "How has the parent - child relationship changed during 2019?",
              "Change parent-child relationship",
              ["It began", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 53
      else if (widget.CheckCompleteQuestion ==
              "How has the parent - child relationship changed during 2019?" &&
          widget.CheckQuestion == "Change parent-child relationship") {
        if (widget.CheckAnswer[0] == "It began") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between and the other parent last the entire year?');
          _insert(
              'Did the parent-child relationship between and the other parent last the entire year?',
              'It began',
              'OK');

          //Question No 54
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent-child relationships start?",
              "Start parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between and the other parent last the entire year?');
          _insert(
              'Did the parent-child relationship between and the other parent last the entire year?',
              'skip',
              'skip');

          //Question No 54
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent-child relationships start?",
              "Start parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "It ended") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between and the other parent last the entire year?');
          _insert(
              'Did the parent-child relationship between and the other parent last the entire year?',
              'It ended',
              'OK');

          //Question No 55
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When did the parent-child relationships end?",
              "End parent-child relationship",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "It existed temporarily") {
          DbHelper.insatance.deleteWithquestion(
              'Did the parent-child relationship between and the other parent last the entire year?');
          _insert(
              'Did the parent-child relationship between and the other parent last the entire year?',
              'It existed temporarily',
              'OK');

          //Question no 56
          //Ya container change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>
""",
              "",
              "Child ${Questions.childLength}",
              "How long did the parent-child relationships last?",
              "Duration parent-child relationship",
              430.0,
              "",
              Questions.childText);
        }
      }

//Answer No 54
      else if (widget.CheckCompleteQuestion ==
              "When did the parent-child relationships start?" &&
          widget.CheckQuestion == "Start parent-child relationship") {
        DbHelper.insatance.deleteWithquestion(
            'When did the parent-child relationships start?');
        _insert('When did the parent-child relationships start?',
            Questions.childText, 'OK');

        //Question No 57
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the other parent's full name?",
            "Name of the person",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 55
      else if (widget.CheckCompleteQuestion ==
              "When did the parent-child relationships end?" &&
          widget.CheckQuestion == "End parent-child relationship") {
        DbHelper.insatance
            .deleteWithquestion('When did the parent-child relationships end?');
        _insert('When did the parent-child relationships end?',
            Questions.childText, 'OK');

        //Question No 58
        return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Did the parent-child relationships end due to the death of the other parent?",
            "End due to death",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 56
      else if (widget.CheckCompleteQuestion ==
              "How long did the parent-child relationships last?" &&
          widget.CheckQuestion == "Duration parent-child relationship") {
        DbHelper.insatance.deleteWithquestion(
            'How long did the parent-child relationships last?');
        _insert('How long did the parent-child relationships last?',
            Questions.childText, 'OK');

        //Question No 57
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the other parent's full name?",
            "Name of the person",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "Did the parent-child relationships end due to the death of the other parent?" &&
          widget.CheckQuestion == "End due to death") {
        DbHelper.insatance.deleteWithquestion(
            'Did the parent-child relationships end due to the death of the other parent?');
        _insert(
            'Did the parent-child relationships end due to the death of the other parent?',
            Questions.childText,
            'OK');

        //Question No 57
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the other parent's full name?",
            "Name of the person",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 57
      else if (widget.CheckCompleteQuestion ==
              "What is the other parent's full name?" &&
          widget.CheckQuestion == "Name of the person") {
        DbHelper.insatance
            .deleteWithquestion('What is the other parent\'s full name?');
        _insert('What is the other parent\'s full name?', Questions.childText,
            'OK');

        //Question No 58
        return familydateContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the other parent's date of birth?",
            "Date of birth of the person",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 58
      else if (widget.CheckCompleteQuestion ==
              "What is the other parent's date of birth?" &&
          widget.CheckQuestion == "Date of birth of the person") {
        DbHelper.insatance
            .deleteWithquestion('What is the other parent\'s date of birth?');
        _insert('What is the other parent\'s date of birth?',
            Questions.childText, 'OK');

        //Question No 59
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the other parent's (last known) address?",
            "Address of the person",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 59
      else if (widget.CheckCompleteQuestion ==
              "What is the other parent's (last known) address?" &&
          widget.CheckQuestion == "Address of the person") {
        DbHelper.insatance.deleteWithquestion(
            'What is the other parent\'s (last known) address?');
        _insert('What is the other parent\'s (last known) address?',
            Questions.childText, 'OK');

        //Question No 23
        return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Would you like to request more than 50% of the child allowance?",
            "Share child allowance",
            220.0,
            "",
            Questions.childText);
      }

      // ====== Patchwork Family Ends ====== //

      //Iska baad care costs wagera ka ho

// ====== Only with me Starts and At place of training And Patch work family Starts ======
      //Answer No 23
      else if (widget.CheckCompleteQuestion ==
              "Would you like to request more than 50% of the child allowance?" &&
          widget.CheckQuestion == "Share child allowance") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to request more than 50% of the child allowance?');
          _insert(
              'Would you like to request more than 50% of the child allowance?',
              'No',
              'OK');

          if (Questions.childrenLive == "Only with me") {
            //Question No 24
            return familyyesnoContainer(
                """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did ${Questions.childFirstName} live with you the whole year?",
                "All year",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "At place of training" ||
              Questions.childrenLive == "Patchwork family") {
            //child expenses
            if (Questions.childrenExpense == "Care costs") {
              //Question No 60
              return familymultipleoptionsContainer(
                  """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "How was your child cared for?",
                  "Childcare costs",
                  [
                    "Nursery / kindergarten",
                    "Child minder",
                    "Nanny",
                    "Babysitter",
                    "Au pair",
                    "Daycare center"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  430.0,
                  "None of this applies",
                  Questions.childText);
            } else if (Questions.childrenExpense == "School fees") {
              //Question No 61
              return familycalculationContainer(
                  """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "For how many schools did you pay tuition fees?",
                  "Schools attended",
                  430.0,
                  "loop",
                  Questions.childText);
            } else if (Questions.childrenExpense ==
                "Health insurance contributions") {
              //Question No 62
              return familytwooptionContainer(
                  """<p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "What type of contract is the health insurance policy?",
                  "Supplementary health insurance",
                  ["Domestic health insurance", "Foreign health insurance"],
                  430.0,
                  "",
                  Questions.childText);
            } else if (Questions.childrenExpense == "Costs due to disability" ||
                Questions.childrenExpense == "None of this applies") {
              //Question No 63
              return familydifferentoptionContainer(
                  """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                  "Benefits office",
                  [
                    "Baden-Württemberg Ost",
                    "Baden-Württemberg West",
                    "Bayern Nord",
                    "Bayern Süd",
                    "Berlin-Brandenburg",
                    "Hessen",
                    "Niedersachsen-Bremen",
                    "Nord",
                    "Nordrhein-Westfalen Nord",
                    "Nordrhein-Westfalen Ost",
                    "Nordrhein-Westfalen West",
                    "Rheinland-Pfalz-Saarland",
                    "Sachsen",
                    "Sachsen-Anhalt - Thüringen",
                    "Other"
                  ],
                  220.0,
                  "",
                  Questions.childText);
            }
          }
          if (Questions.childrenLive == "skip") {
            //Question No 24
            return familyyesnoContainer(
                """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did ${Questions.childFirstName} live with you the whole year?",
                "All year",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to request more than 50% of the child allowance?');
          _insert(
              'Would you like to request more than 50% of the child allowance?',
              'Yes',
              'OK');

          //Question No 33
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Why are you requesting the child allowance transfer?",
              "Reason",
              [
                "Alimony not paid",
                "Inability to pay",
                "I'm raising the child on my own"
              ],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to request more than 50% of the child allowance?');
          _insert(
              'Would you like to request more than 50% of the child allowance?',
              'skip',
              'skip');

          //Question No 33
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Why are you requesting the child allowance transfer?",
              "Reason",
              [
                "Alimony not paid",
                "Inability to pay",
                "I'm raising the child on my own"
              ],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 24
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.childFirstName} live with you the whole year?" &&
          widget.CheckQuestion == "All year") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Did live with you the whole year?');
          _insert('Did live with you the whole year?', 'No', 'OK');

          //Question No 25
          return familydateContainer(
              """<p><strong>Period of common living</strong></p>
<p>State here the exact <strong>time period</strong> in which your child lived with you in the <strong>same</strong> apartment or house.</p>
<p>Only the time in 2019 is relevant.</p>
<p>This information is important so you can profit from <strong>tax benefits</strong>.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "From when to when was ${Questions.childFirstName} offcially registered at your place?",
              "Registered period",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Did live with you the whole year?');
          _insert('Did live with you the whole year?', 'Yes', 'OK');

          //Question No 26
          return familyyesnoContainer(
              """<p><strong>Child benefit pay received</strong></p>
<p>If you are single and your child (for whom you receive monthly child benefits) only lives with you, it is possible to claim an allowance for single parenting.</p>
<p>If the child is registered with both parents, and only one parent is single, the single parent will receive the allowance. This applies regardless of who receives the child benefits. If this is the case, you can also choose "Yes" here.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive child benefit pay for ${Questions.childFirstName}?",
              "Child benefit received",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Did live with you the whole year?');
          _insert('Did live with you the whole year?', 'skip', 'skip');

          //Question No 25
          return familydateContainer(
              """<p><strong>Period of common living</strong></p>
<p>State here the exact <strong>time period</strong> in which your child lived with you in the <strong>same</strong> apartment or house.</p>
<p>Only the time in 2019 is relevant.</p>
<p>This information is important so you can profit from <strong>tax benefits</strong>.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "From when to when was ${Questions.childFirstName} offcially registered at your place?",
              "Registered period",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer no 25
      else if (widget.CheckCompleteQuestion ==
              "From when to when was ${Questions.childFirstName} offcially registered at your place?" &&
          widget.CheckQuestion == "Registered period") {
        DbHelper.insatance
            .deleteWithquestion('Did live with you the whole year?');
        _insert('Did live with you the whole year?', Questions.childText, 'OK');

        //Question No 26
        return familyyesnoContainer(
            """<p><strong>Child benefit pay received</strong></p>
<p>If you are single and your child (for whom you receive monthly child benefits) only lives with you, it is possible to claim an allowance for single parenting.</p>
<p>If the child is registered with both parents, and only one parent is single, the single parent will receive the allowance. This applies regardless of who receives the child benefits. If this is the case, you can also choose "Yes" here.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive child benefit pay for ${Questions.childFirstName}?",
            "Child benefit received",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 26
      else if (widget.CheckCompleteQuestion ==
              "Did you receive child benefit pay for ${Questions.childFirstName}?" &&
          widget.CheckQuestion == "Child benefit received") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Child benefit received');
          _insert('Child benefit received', 'No', 'OK');

          //child expenses
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "skip") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Child benefit received');
          _insert('Child benefit received', 'Yes', 'OK');

          //Question No 27
          return familyyesnoContainer("""<p><strong>Child benefits</strong></p>
<p>Please enter whether you received <strong>child benefits</strong> for the entire year of 2019.</p>
<p>This information is important, because <strong>single parents</strong> in receipt of child benefits are also entitled to <strong>tax relief</strong>. This may also be granted pro rata for the time in which you received child benefits.</p>
<p>Check your account statements. In addition to the amount of child benefits and the child benefit number, you will also find the time period for which the amount is allocated. Child benefits are paid out monthly.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive child benefits for ${Questions.childFirstName} for the whole year?",
              "Year-round child benefit",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Child benefit received');
          _insert('Child benefit received', 'skip', 'skip');

          //Question No 27
          return familyyesnoContainer("""<p><strong>Child benefits</strong></p>
<p>Please enter whether you received <strong>child benefits</strong> for the entire year of 2019.</p>
<p>This information is important, because <strong>single parents</strong> in receipt of child benefits are also entitled to <strong>tax relief</strong>. This may also be granted pro rata for the time in which you received child benefits.</p>
<p>Check your account statements. In addition to the amount of child benefits and the child benefit number, you will also find the time period for which the amount is allocated. Child benefits are paid out monthly.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive child benefits for ${Questions.childFirstName} for the whole year?",
              "Year-round child benefit",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 27
      else if (widget.CheckCompleteQuestion ==
              "Did you receive child benefits for ${Questions.childFirstName} for the whole year?" &&
          widget.CheckQuestion == "Year-round child benefit") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive child benefits for for the whole year?');
          _insert('Did you receive child benefits for for the whole year?',
              'No', 'OK');

          //Question no 28
          //Ya container bad ma change hoga
          return familydateContainer(
              """<p><strong>Period of receipt of child benefits</strong></p>
<p>Please enter the <strong>exact time period in 2019</strong> in which you received child benefits.</p>
<p>Check your account statements. In addition to the amount of child benefits and the child benefit number, you will also find the time period for which the amount is allocated. Child benefits are paid out monthly.</p>
<p>This information is important, because <strong>single parents</strong> in receipt of child benefits are also entitled to <strong>tax relief</strong>. This may also be granted pro rata for the time in which you received child benefits.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "During which period did you receive child benefits?",
              "Period child benefit",
              220.0,
              "",
              Questions.childAddressText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive child benefits for for the whole year?');
          _insert('Did you receive child benefits for for the whole year?',
              'skip', 'skip');

          //Question no 28
          //Ya container bad ma change hoga
          return familydateContainer(
              """<p><strong>Period of receipt of child benefits</strong></p>
<p>Please enter the <strong>exact time period in 2019</strong> in which you received child benefits.</p>
<p>Check your account statements. In addition to the amount of child benefits and the child benefit number, you will also find the time period for which the amount is allocated. Child benefits are paid out monthly.</p>
<p>This information is important, because <strong>single parents</strong> in receipt of child benefits are also entitled to <strong>tax relief</strong>. This may also be granted pro rata for the time in which you received child benefits.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "During which period did you receive child benefits?",
              "Period child benefit",
              220.0,
              "",
              Questions.childAddressText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive child benefits for for the whole year?');
          _insert('Did you receive child benefits for for the whole year?',
              'Yes', 'OK');

          //Question No 29
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Was your partner living with you the entire year?",
              "Year round with you",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 28
      else if (widget.CheckCompleteQuestion ==
              "During which period did you receive child benefits?" &&
          widget.CheckQuestion == "Period child benefit") {
        DbHelper.insatance.deleteWithquestion(
            'During which period did you receive child benefits?');
        _insert('During which period did you receive child benefits?',
            Questions.childText, 'OK');

        //Question No 29
        return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Was your partner living with you the entire year?",
            "Year round with you",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 29
      else if (widget.CheckCompleteQuestion ==
              "Was your partner living with you the entire year?" &&
          widget.CheckQuestion == "Year round with you") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Was your partner living with you the entire year?');
          _insert(
              'Was your partner living with you the entire year?', 'No', 'OK');

          //Question no 30
          //Ya container bad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When was your partner living with you?",
              "Period with partner",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Was your partner living with you the entire year?');
          _insert(
              'Was your partner living with you the entire year?', 'Yes', 'OK');

          //Question No 31
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is your partner's first and last name?",
              "Name of partner",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Was your partner living with you the entire year?');
          _insert('Was your partner living with you the entire year?', 'skip',
              'skip');

          //Question no 30
          //Ya container bad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When was your partner living with you?",
              "Period with partner",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 30
      else if (widget.CheckCompleteQuestion ==
              "When was your partner living with you?" &&
          widget.CheckQuestion == "Period with partner") {
        DbHelper.insatance
            .deleteWithquestion('When was your partner living with you?');
        _insert('When was your partner living with you?', Questions.childText,
            'OK');

        //Question No 31
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is your partner's first and last name?",
            "Name of partner",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 31
      else if (widget.CheckCompleteQuestion ==
              "What is your partner's first and last name?" &&
          widget.CheckQuestion == "Name of partner") {
        DbHelper.insatance
            .deleteWithquestion('What is your partner\'s first and last name?');
        _insert('What is your partner\'s first and last name?',
            Questions.childText, 'OK');

        //Question No 32
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What was your partner's occupation?",
            "Occupation partner",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 32
      else if (widget.CheckCompleteQuestion ==
              "What was your partner's occupation?" &&
          widget.CheckQuestion == "Occupation partner") {
        DbHelper.insatance
            .deleteWithquestion('What was your partner\'s occupation?');
        _insert(
            'What was your partner\'s occupation?', Questions.childText, 'OK');

        //child expenses
        if (Questions.childrenExpense == "Care costs") {
          //Question No 60
          return familymultipleoptionsContainer(
              """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How was your child cared for?",
              "Childcare costs",
              [
                "Nursery / kindergarten",
                "Child minder",
                "Nanny",
                "Babysitter",
                "Au pair",
                "Daycare center"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              430.0,
              "None of this applies",
              Questions.childText);
        } else if (Questions.childrenExpense == "School fees") {
          //Question No 61
          return familycalculationContainer(
              """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "For how many schools did you pay tuition fees?",
              "Schools attended",
              430.0,
              "loop",
              Questions.childText);
        } else if (Questions.childrenExpense == "skip") {
          //Question No 61
          return familycalculationContainer(
              """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "For how many schools did you pay tuition fees?",
              "Schools attended",
              430.0,
              "loop",
              Questions.childText);
        } else if (Questions.childrenExpense ==
            "Health insurance contributions") {
          //Question No 62
          return familytwooptionContainer(
              """<p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What type of contract is the health insurance policy?",
              "Supplementary health insurance",
              ["Domestic health insurance", "Foreign health insurance"],
              430.0,
              "",
              Questions.childText);
        } else if (Questions.childrenExpense == "Costs due to disability" ||
            Questions.childrenExpense == "None of this applies") {
          //Question No 63
          return familydifferentoptionContainer(
              """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
              "Benefits office",
              [
                "Baden-Württemberg Ost",
                "Baden-Württemberg West",
                "Bayern Nord",
                "Bayern Süd",
                "Berlin-Brandenburg",
                "Hessen",
                "Niedersachsen-Bremen",
                "Nord",
                "Nordrhein-Westfalen Nord",
                "Nordrhein-Westfalen Ost",
                "Nordrhein-Westfalen West",
                "Rheinland-Pfalz-Saarland",
                "Sachsen",
                "Sachsen-Anhalt - Thüringen",
                "Other"
              ],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 33
      else if (widget.CheckCompleteQuestion ==
              "Why are you requesting the child allowance transfer?" &&
          widget.CheckQuestion == "Reason") {
        if (widget.CheckAnswer[0] == "Alimony not paid") {
          DbHelper.insatance.deleteWithquestion(
              'Why are you requesting the child allowance transfer?');
          _insert('Why are you requesting the child allowance transfer?',
              'Alimony not paid', 'OK');

          //Question No 34
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Can you prove that the other parent paid less than 75% of the agreed child support?",
              "Under 75%",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Inability to pay") {
          DbHelper.insatance.deleteWithquestion(
              'Why are you requesting the child allowance transfer?');
          _insert('Why are you requesting the child allowance transfer?',
              'Inability to pay', 'OK');

          //Question No 35
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive any support payments according to the Unterhaltsvorschussgesetz?",
              "Child Support acc. to law",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "I'm raising the child on my own") {
          DbHelper.insatance.deleteWithquestion(
              'Why are you requesting the child allowance transfer?');
          _insert('Why are you requesting the child allowance transfer?',
              'I\'m raising the child on my own', 'OK');

          //Question No 37
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "For what period was your child registered at your residence only?",
              "Child's residence",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Why are you requesting the child allowance transfer?');
          _insert('Why are you requesting the child allowance transfer?',
              'skip', 'skip');

          //Question No 37
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "For what period was your child registered at your residence only?",
              "Child's residence",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 34
      else if (widget.CheckCompleteQuestion ==
              "Can you prove that the other parent paid less than 75% of the agreed child support?" &&
          widget.CheckQuestion == "Under 75%") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Can you prove that the other parent paid less than 75% of the agreed child support?');
          _insert(
              'Can you prove that the other parent paid less than 75% of the agreed child support?',
              'No',
              'OK');

          if (Questions.childrenLive == "Only with me") {
            //Question No 24
            return familyyesnoContainer(
                """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did ${Questions.childFirstName} live with you the whole year?",
                "All year",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "skip") {
            //Question No 24
            return familyyesnoContainer(
                """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did ${Questions.childFirstName} live with you the whole year?",
                "All year",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "At place of training" ||
              Questions.childrenLive == "Patchwork family") {
            //child expenses
            if (Questions.childrenExpense == "Care costs") {
              //Question No 60
              return familymultipleoptionsContainer(
                  """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "How was your child cared for?",
                  "Childcare costs",
                  [
                    "Nursery / kindergarten",
                    "Child minder",
                    "Nanny",
                    "Babysitter",
                    "Au pair",
                    "Daycare center"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  430.0,
                  "None of this applies",
                  Questions.childText);
            } else if (Questions.childrenExpense == "School fees") {
              //Question No 61
              return familycalculationContainer(
                  """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "For how many schools did you pay tuition fees?",
                  "Schools attended",
                  430.0,
                  "loop",
                  Questions.childText);
            } else if (Questions.childrenExpense ==
                "Health insurance contributions") {
              //Question No 62
              return familytwooptionContainer(
                  """<p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "What type of contract is the health insurance policy?",
                  "Supplementary health insurance",
                  ["Domestic health insurance", "Foreign health insurance"],
                  430.0,
                  "",
                  Questions.childText);
            } else if (Questions.childrenExpense == "Costs due to disability" ||
                Questions.childrenExpense == "None of this applies") {
              //Question No 63
              return familydifferentoptionContainer(
                  """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                  "Benefits office",
                  [
                    "Baden-Württemberg Ost",
                    "Baden-Württemberg West",
                    "Bayern Nord",
                    "Bayern Süd",
                    "Berlin-Brandenburg",
                    "Hessen",
                    "Niedersachsen-Bremen",
                    "Nord",
                    "Nordrhein-Westfalen Nord",
                    "Nordrhein-Westfalen Ost",
                    "Nordrhein-Westfalen West",
                    "Rheinland-Pfalz-Saarland",
                    "Sachsen",
                    "Sachsen-Anhalt - Thüringen",
                    "Other"
                  ],
                  220.0,
                  "",
                  Questions.childText);
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Can you prove that the other parent paid less than 75% of the agreed child support?');
          _insert(
              'Can you prove that the other parent paid less than 75% of the agreed child support?',
              'Yes',
              'OK');

          //Question No 35
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive any support payments according to the Unterhaltsvorschussgesetz?",
              "Child Support acc. to law",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Can you prove that the other parent paid less than 75% of the agreed child support?');
          _insert(
              'Can you prove that the other parent paid less than 75% of the agreed child support?',
              'skip',
              'skip');

          //Question No 35
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive any support payments according to the Unterhaltsvorschussgesetz?",
              "Child Support acc. to law",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer no 35
      else if (widget.CheckCompleteQuestion ==
              "Did you receive any support payments according to the Unterhaltsvorschussgesetz?" &&
          widget.CheckQuestion == "Child Support acc. to law") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any support payments according to the Unterhaltsvorschussgesetz?');
          _insert(
              'Did you receive any support payments according to the Unterhaltsvorschussgesetz?',
              'No',
              'OK');

          if (Questions.childrenLive == "Only with me") {
            //Question No 24
            return familyyesnoContainer(
                """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did ${Questions.childFirstName} live with you the whole year?",
                "All year",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "skip") {
            //Question No 24
            return familyyesnoContainer(
                """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did ${Questions.childFirstName} live with you the whole year?",
                "All year",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "At place of training" ||
              Questions.childrenLive == "Patchwork family") {
            //child expenses
            if (Questions.childrenExpense == "Care costs") {
              //Question No 60
              return familymultipleoptionsContainer(
                  """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "How was your child cared for?",
                  "Childcare costs",
                  [
                    "Nursery / kindergarten",
                    "Child minder",
                    "Nanny",
                    "Babysitter",
                    "Au pair",
                    "Daycare center"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  430.0,
                  "None of this applies",
                  Questions.childText);
            } else if (Questions.childrenExpense == "School fees") {
              //Question No 61
              return familycalculationContainer(
                  """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "For how many schools did you pay tuition fees?",
                  "Schools attended",
                  430.0,
                  "loop",
                  Questions.childText);
            } else if (Questions.childrenExpense ==
                "Health insurance contributions") {
              //Question No 62
              return familytwooptionContainer(
                  """<p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "What type of contract is the health insurance policy?",
                  "Supplementary health insurance",
                  ["Domestic health insurance", "Foreign health insurance"],
                  430.0,
                  "",
                  Questions.childText);
            } else if (Questions.childrenExpense == "Costs due to disability" ||
                Questions.childrenExpense == "None of this applies" ||
                Questions.childrenExpense == "skip") {
              //Question No 63
              return familydifferentoptionContainer(
                  """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                  "",
                  "Child ${Questions.childLength}",
                  "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                  "Benefits office",
                  [
                    "Baden-Württemberg Ost",
                    "Baden-Württemberg West",
                    "Bayern Nord",
                    "Bayern Süd",
                    "Berlin-Brandenburg",
                    "Hessen",
                    "Niedersachsen-Bremen",
                    "Nord",
                    "Nordrhein-Westfalen Nord",
                    "Nordrhein-Westfalen Ost",
                    "Nordrhein-Westfalen West",
                    "Rheinland-Pfalz-Saarland",
                    "Sachsen",
                    "Sachsen-Anhalt - Thüringen",
                    "Other"
                  ],
                  220.0,
                  "",
                  Questions.childText);
            }
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any support payments according to the Unterhaltsvorschussgesetz?');
          _insert(
              'Did you receive any support payments according to the Unterhaltsvorschussgesetz?',
              'Yes',
              'OK');

          //Question No 36
          //Ya container bad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "From when to when did you receive support payments according to the Unterhaltsvorschussgesetz?",
              "Period support payments",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive any support payments according to the Unterhaltsvorschussgesetz?');
          _insert(
              'Did you receive any support payments according to the Unterhaltsvorschussgesetz?',
              'skip',
              'OK');

          //Question No 36
          //Ya container bad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "From when to when did you receive support payments according to the Unterhaltsvorschussgesetz?",
              "Period support payments",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 36
      else if (widget.CheckCompleteQuestion ==
              "From when to when did you receive support payments according to the Unterhaltsvorschussgesetz?" &&
          widget.CheckQuestion == "Period support payments") {
        if (Questions.childrenLive == "Only with me") {
          //Question No 24
          return familyyesnoContainer(
              """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did ${Questions.childFirstName} live with you the whole year?",
              "All year",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "At place of training" ||
            Questions.childrenLive == "Patchwork family") {
          //child expenses
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense == "skip") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        }
      }

      //Answer No 37
      else if (widget.CheckCompleteQuestion ==
              "For what period was your child registered at your residence only?" &&
          widget.CheckQuestion == "Child's residence") {
        if (Questions.childrenLive == "Only with me") {
          //Question No 24
          return familyyesnoContainer(
              """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did ${Questions.childFirstName} live with you the whole year?",
              "All year",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "skip") {
          //Question No 24
          return familyyesnoContainer(
              """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did ${Questions.childFirstName} live with you the whole year?",
              "All year",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "At place of training" ||
            Questions.childrenLive == "Patchwork family") {
          //child expenses
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        }
      } else if (widget.CheckCompleteQuestion ==
              "For what period was your child registered at your residence only?" &&
          widget.CheckQuestion == "Child's residence") {
        DbHelper.insatance.deleteWithquestion(
            'For what period was your child registered at your residence only?');
        _insert(
            'For what period was your child registered at your residence only?',
            Questions.childText,
            'OK');

        if (Questions.childrenLive == "Only with me") {
          //Question No 24
          return familyyesnoContainer(
              """<p><strong>Living with your child</strong></p>
<p>Please state whether you lived together with your child for the <strong>entire calendar year of 2019.</strong></p>
<p>You should also choose "Yes" if your child lived away from home temporarily (e.g. for professional training), but still belonged to your household.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did ${Questions.childFirstName} live with you the whole year?",
              "All year",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childrenLive == "skip") {
          //Question No 61
          return familycalculationContainer(
              """<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "For how many schools did you pay tuition fees?",
              "Schools attended",
              430.0,
              "loop",
              Questions.childText);
        } else if (Questions.childrenLive == "At place of training" ||
            Questions.childrenLive == "Patchwork family") {
          //child expenses
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        }
      }
// ====== Only with me Ends and At place of training And Patch work family Ends ======

      // ====== With the other parent Starts ======

      //Answer No 38
      else if (widget.CheckCompleteQuestion ==
              "Did the other parent request a transfer of the allowance for childcare, education or training needs?" &&
          widget.CheckQuestion == "Allowance transfer") {
        if (widget.CheckAnswer[0] == "No" ||
            widget.CheckAnswer[0] == "Yes" ||
            widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did the other parent request a transfer of the allowance for childcare, education or training needs?');
          _insert(
              'Did the other parent request a transfer of the allowance for childcare, education or training needs?',
              widget.CheckAnswer[0],
              widget.CheckAnswer[0]);

          //child expenses
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense == "skip") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        }
      }

      // ====== With the other parent Ends ======

      // ====== With the Step/grand parent Starts ======

      //Answer No 39
      else if (widget.CheckCompleteQuestion ==
              "Do you want to transfer the child allowance to the step or grandparents?" &&
          widget.CheckQuestion == "Allowance transfer") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Do you want to transfer the child allowance to the step or grandparents?');
          _insert(
              'Do you want to transfer the child allowance to the step or grandparents?',
              'No',
              'OK');

          //child expenses
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          }

          //child expenses
          else if (Questions.childrenExpense == "skip") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p><p><strong>Childcare for children over 14 years</strong></p>
<p>Please select which childcare costs you had in <strong>2019</strong>. You can select several answers here.</p>
<p>Childcare costs are tax deductible until your child <strong>turns 14</strong>.</p>
<p><strong>Exception:</strong></p>
<p>Your child is over 14 years old, has not yet reached the age of 25 and is unable to support themselves due to a physical, mental or emotional disability.</p>
<p>In this case, you can also deduct the <strong>typical</strong> childcare costs (fees for childminder, nanny, au-pair, etc.) from the tax.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/check.png",
                  "images/check.png"
                ],
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Do you want to transfer the child allowance to the step or grandparents?');
          _insert(
              'Do you want to transfer the child allowance to the step or grandparents?',
              'Yes',
              'OK');

          //Question No 40
          return familyyesnoContainer(
              """<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p> </p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you fill in annex K for the transfer of the child allowance?",
              "Annex K",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Do you want to transfer the child allowance to the step or grandparents?');
          _insert(
              'Do you want to transfer the child allowance to the step or grandparents?',
              'skip',
              'skip');

          //Question No 40
          return familyyesnoContainer(
              """<p><strong>Driver's license</strong></p>
<p>Enter here the total amount you paid for your work driver's license. Note that this is all about spending in 2019.</p>
<p><strong>Please note:</strong></p>
<p>Only professional drivers are allowed to deduct their expenses for a driver's license in the narrow framework from the tax. The driving license must be a basic requirement for the learned profession.</p>
<p>This applies, for example, to the following occupations:</p>
<ul>
<li><strong>Truck driver</strong> - Class C, CE, C1 and C1E driving license</li>
<li><strong>Bus driver</strong> - Class D, D1, DE or D1E driving license</li>
<li><strong>Taxi driver</strong> - passenger ticket (P-bill)</li>
<li><strong>driving instructor</strong> - driving license of all classes that offer them</li>
</ul>
<p><strong>You can not deduct your private driving license class B!</strong></p>
<p> </p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you fill in annex K for the transfer of the child allowance?",
              "Annex K",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 40
      else if (widget.CheckCompleteQuestion ==
              "Did you fill in annex K for the transfer of the child allowance?" &&
          widget.CheckQuestion == "Annex K") {
        if (widget.CheckAnswer[0] == "No" ||
            widget.CheckAnswer[0] == "Yes" ||
            widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you fill in annex K for the transfer of the child allowance?');
          _insert(
              'Did you fill in annex K for the transfer of the child allowance?',
              widget.CheckAnswer[0],
              widget.CheckAnswer[0]);

          //child expenses
          if (Questions.childrenExpense == "Care costs") {
            //Question No 60
            return familymultipleoptionsContainer(
                """<p><strong>Childcare costs</strong></p>
<p>Please indicate here which childcare costs you had in <strong>2019</strong> year. You can select several answers here. We then ask about the various childcare costs individually.</p>
<p>Typical childcare costs, which you can select here and deduct afterwards are, for example, expenses for:</p>
<p><strong>NURSERY / KINDERGARTEN</strong></p>
<p>The nursery looks after children up to the age of 3. The care is provided by educators and usually in mixed age groups.</p>
<p>The nursery cares for children from 3 to about 7 years. There are educators, social educators, nannies and social assistants again.</p>
<p>The kindergarten is more about a preschool education and the development of the child to become more independent.</p>
<p><strong>NANNY</strong></p>
<p>A childminder is seen as a day care person who temporarily cares for children. The childminder can provide childcare both in the caregiver's household and in their own household.</p>
<p>They usually look after 1 to 5 children at the same time. In addition, childminders must demonstrate pedagogical skills and have completed a child's first-aid course.</p>
<p><strong>NANNY</strong></p>
<p>A nanny is a <strong>domestic employee</strong> or more rarely a <strong>independent entrepreneur</strong>.</p>
<p>Their tasks include childcare, education and accompaniment in school matters of children.</p>
<p>Nannies usually work in the family home.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters only look after your children by the hour. This usually happens in the afternoon or in the evenings, when the parents are out of the house.</p>
<p>This type of employment is especially popular with students who want to earn some money.</p>
<p>Primarily, babies and toddlers are cared for.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people between the ages of 18 and 30 who are single, without children, traveling to a foreign country for a limited time to live with a host family.</p>
<p>The task of the au pair is to support the family as a temporary member of the family with childcare and light housework.</p>
<p>For this support, they receive from the host family free accommodation, meals and a pocket money.</p>
<p><strong>Important!</strong> An au pair is neither a maid nor a nanny.</p>
<p><strong>AFTER-SCHOOL CLUB</strong></p>
<p>The after-school club is also an educational facility where children up to 14 years of age are cared for. Above all, after-school clubs care for children after school.</p>
<p>The duties of an after-school club include assistance with homework and providing sports activities.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How was your child cared for?",
                "Childcare costs",
                [
                  "Nursery / kindergarten",
                  "Child minder",
                  "Nanny",
                  "Babysitter",
                  "Au pair",
                  "Daycare center"
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
                430.0,
                "None of this applies",
                Questions.childText);
          } else if (Questions.childrenExpense == "School fees") {
            //Question No 61
            return familycalculationContainer("""
<p><strong>School fees</strong></p>
<p>Please enter the number of schools your child attended to which you paid fees <strong>in 2019.</strong></p>
<p>Please note that you can write off school fees if your child attended a private school which offers a recognised leaving certificate or professional qualification.</p>
<p> </p>
<p> </p>
""",
                "",
                "Child ${Questions.childLength}",
                "For how many schools did you pay tuition fees?",
                "Schools attended",
                430.0,
                "loop",
                Questions.childText);
          } else if (Questions.childrenExpense ==
              "Health insurance contributions") {
            //Question No 62
            return familytwooptionContainer(
                """ <p><strong>Health insurance</strong></p>
<p>Please indicate the type of health insurance that has been taken out for the child.</p>
<p>Choose whether you have domestic or foreign health insurance.</p>
<p>Foreign health insurance should not be confused with foreign travel health insurance. Rather, it is an insurance contract concluded with a health insurance institution located abroad.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What type of contract is the health insurance policy?",
                "Supplementary health insurance",
                ["Domestic health insurance", "Foreign health insurance"],
                430.0,
                "",
                Questions.childText);
          } else if (Questions.childrenExpense == "Costs due to disability" ||
              Questions.childrenExpense == "None of this applies") {
            //Question No 63
            return familydifferentoptionContainer(
                """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
                "Benefits office",
                [
                  "Baden-Württemberg Ost",
                  "Baden-Württemberg West",
                  "Bayern Nord",
                  "Bayern Süd",
                  "Berlin-Brandenburg",
                  "Hessen",
                  "Niedersachsen-Bremen",
                  "Nord",
                  "Nordrhein-Westfalen Nord",
                  "Nordrhein-Westfalen Ost",
                  "Nordrhein-Westfalen West",
                  "Rheinland-Pfalz-Saarland",
                  "Sachsen",
                  "Sachsen-Anhalt - Thüringen",
                  "Other"
                ],
                220.0,
                "",
                Questions.childText);
          }
        }
      }

      // ====== With the Step/grand parent Ends ======

      // ====== Care costs Starts ======

      //Answer No 60
      else if (widget.CheckCompleteQuestion ==
              "How was your child cared for?" &&
          widget.CheckQuestion == "Childcare costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Nursery / kindergarten") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'Nursery / kindergarten',
                'OK');

            //Question No 64
            return familycalculationContainer(
                """<p><strong>Number of nurseries or kindergartens</strong></p>
<p>Please state here how many nurseries or kindergartens your child attended in <strong>2019</strong>.</p>
<p>The number of facilities is relevant at this point. If your child changed group within the same kindergarten this is not relevant.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "For how many kindergartens did you have costs?",
                "Kindergartens attended",
                220.0,
                "loop",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Child minder") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'Child minder', 'OK');
//Question No 82
            return familycalculationContainer(
                """<p><strong>Number of childminders</strong></p>
<p>Please enter the number of childminders that looked after your child.</p>
<p>If a childminder was substituted due to sickness, you do not need to count this as en extra childminder.</p>
<p>What is relevant is the number of different childminders who invoiced you in 2019.</p>
<p><strong>CHILDMINDER</strong></p>
<p>A childminder is viewed as daycare person that temporarily takes care of children. The childminder can child care both in the custodial household, as well as in their own household.</p>
<p>A childminder typically looks after 1 to 5 children at the same time. In addition, childminders must have completed an educational qualification and a child first aid course.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How many child minders did you pay for?",
                "Number of child minders",
                220.0,
                "loop",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Nanny") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'Nanny', 'OK');

//Question No 91
            return familycalculationContainer(
                """<p><strong>Kindergarten: childcare costs</strong></p>
<p>Enter here your childcare costs for the <strong>kindergarten</strong> in 2019.</p>
<p>You usually pay monthly contributions. You can find the respective amounts either on your account statement or in the invoices which the kindergarten sent you.</p>
<p><em>Add up the monthly amounts for 2019 and enter the total here.</em></p>
<p><strong>IMPORTANT:</strong></p>
<p>The cost of meals / catering may <strong>not</strong> be taken into account. Please do not include them</p>
<p>If the cost of childcare and catering are not individually identified in your invoices, you have to estimate them.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How many nannies did you pay?",
                "Number of nannies",
                220.0,
                "loop",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Babysitter") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'Babysitter', 'OK');

//Question No 100
            return familycalculationContainer(
                """<p><strong>Number of babysitters</strong></p>
<p>Please enter the number of babysitters that looked after your child.</p>
<p>What is relevant is the number of different babysitters who invoiced you in 2019.</p>
<p>If a babysitter was substituted due to sickness, you do not need to count this as en extra babysitter.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters take care of your children, however, only by the hour. Usually this is done in the afternoon or in the evening when the parents are out of the house.</p>
<p>This type of employment is especially popular for pupils and students who want to earn some extra money.</p>
<p>Babies and young children are cared for primarily.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How many babysitters did you pay for?",
                "Number of babysitters",
                220.0,
                "loop",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'skip', 'OK');

//Question No 100
            return familycalculationContainer(
                """<p><strong>Number of babysitters</strong></p>
<p>Please enter the number of babysitters that looked after your child.</p>
<p>What is relevant is the number of different babysitters who invoiced you in 2019.</p>
<p>If a babysitter was substituted due to sickness, you do not need to count this as en extra babysitter.</p>
<p><strong>BABYSITTER</strong></p>
<p>Babysitters take care of your children, however, only by the hour. Usually this is done in the afternoon or in the evening when the parents are out of the house.</p>
<p>This type of employment is especially popular for pupils and students who want to earn some extra money.</p>
<p>Babies and young children are cared for primarily.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How many babysitters did you pay for?",
                "Number of babysitters",
                220.0,
                "loop",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Au pair") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'Au pair', 'OK');

//Question no 109
            return familycalculationContainer(
                """<p><strong>Number of au pairs</strong></p>
<p>Please enter the number of au pairs that looked after your child.</p>
<p>What is relevant is the number of different au pairs who looked after your child in 2019.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people aged 18 to 30, single, traveling without children for a limited period of time in a foreign country, to live with a host family.</p>
<p>The task of an au pair is to support the family with childcare and light housework.</p>
<p>For this support, the au pair receives free accommodation, meals and pocket money from the host family.</p>
<p><strong>Important!</strong> an au pair is not a maid or a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How many au pairs did you pay for?",
                "Number of au pairs",
                220.0,
                "loop",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "Daycare center") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'Daycare center', 'OK');

            //Question No 120
            return familycalculationContainer(
                """<p><strong>Number of after-school clubs</strong></p>
<p>Please state here how many after-school clubs your child attended in <strong>2019</strong>.</p>
<p>The number of facilities is relevant at this point. If your child changed group within the same after-school club this is not relevant.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How many different daycare centers has your child attended?",
                "Number of daycare centers",
                220.0,
                "loop",
                Questions.childText);
          } else if (widget.CheckAnswer[m] == "None of these") {
            DbHelper.insatance
                .deleteWithquestion('How was your child cared for?');
            _insert('How was your child cared for?', 'None of these', 'OK');

//Question no 109
            return familycalculationContainer(
                """<p><strong>Number of au pairs</strong></p>
<p>Please enter the number of au pairs that looked after your child.</p>
<p>What is relevant is the number of different au pairs who looked after your child in 2019.</p>
<p><strong>AU PAIR</strong></p>
<p>Au pairs include young people aged 18 to 30, single, traveling without children for a limited period of time in a foreign country, to live with a host family.</p>
<p>The task of an au pair is to support the family with childcare and light housework.</p>
<p>For this support, the au pair receives free accommodation, meals and pocket money from the host family.</p>
<p><strong>Important!</strong> an au pair is not a maid or a nanny.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How many au pairs did you pay for?",
                "Number of au pairs",
                220.0,
                "loop",
                Questions.childText);
          }
        }
      }

      // ====== Kindergarten Starts ====== //

      //Answere No 64
      else if (widget.CheckCompleteQuestion ==
              "For how many kindergartens did you have costs?" &&
          widget.CheckQuestion == "Kindergartens attended") {
        DbHelper.insatance.deleteWithquestion(
            'For how many kindergartens did you have costs?');
        _insert('For how many kindergartens did you have costs?',
            Questions.kindergartenText, 'OK');

        //Question No 65
        return familycalculationContainer(
            """<p><strong>Kindergarten: childcare costs</strong></p>
<p>Enter here your childcare costs for the <strong>kindergarten</strong> in 2019.</p>
<p>You usually pay monthly contributions. You can find the respective amounts either on your account statement or in the invoices which the kindergarten sent you.</p>
<p><em>Add up the monthly amounts for 2019 and enter the total here.</em></p>
<p><strong>IMPORTANT:</strong></p>
<p>The cost of meals / catering may <strong>not</strong> be taken into account. Please do not include them</p>
<p>If the cost of childcare and catering are not individually identified in your invoices, you have to estimate them.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "How much have you paid for the kindergarten?",
            "Cost kindergarten",
            220.0,
            "calculation",
            Questions.kindergartenText);
      }

      //Answer No 65
      else if (widget.CheckCompleteQuestion ==
              "How much have you paid for the kindergarten?" &&
          widget.CheckQuestion == "Cost kindergarten") {
        DbHelper.insatance
            .deleteWithquestion('How much have you paid for the kindergarten?');
        _insert('How much have you paid for the kindergarten?',
            Questions.kindergartenText, 'OK');

        //Question No 66
        return familycalculationContainer(
            """<p><strong>Kindergarten: childcare costs of other parent</strong></p>
<p>Please enter here the total childcare costs for the <strong>kindergarten</strong> in 2019 carried by the other parent.</p>
<p>Usually the other parent will pay monthly contributions. They can find the respective amounts either on their account statement or on the invoices which the kindergarten sent them. Please ask about these amounts if you do not know them.</p>
<p><em>Add up the monthly amounts for 2019 and enter the total here.</em></p>
<p><strong>IMPORTANT:</strong></p>
<p>The cost of meals / catering may not be taken into account. Please do not include them</p>
<p>If the cost of childcare and catering are <strong>not</strong> individually identified in your invoices, you have to estimate them.</p>""",
            "",
            "Child ${Questions.childLength}",
            "How much did the other parent pay for the kindergarten?",
            "Amount kindergarten (partner)",
            220.0,
            "calculation",
            Questions.kindergartenText);
      }

      //Answer No 66
      else if (widget.CheckCompleteQuestion ==
              "How much did the other parent pay for the kindergarten?" &&
          widget.CheckQuestion == "Amount kindergarten (partner)") {
        DbHelper.insatance.deleteWithquestion(
            'How much did the other parent pay for the kindergarten?');
        _insert('How much did the other parent pay for the kindergarten?',
            Questions.kindergartenText, 'OK');

        //Question No 67
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Please enter the name of the kindergarten.",
            "Name kindergarten",
            220.0,
            "",
            Questions.kindergartenText);
      }

      //Answer No 67
      else if (widget.CheckCompleteQuestion ==
              "Please enter the name of the kindergarten." &&
          widget.CheckQuestion == "Name kindergarten") {
        DbHelper.insatance
            .deleteWithquestion('Please enter the name of the kindergarten');
        _insert('Please enter the name of the kindergarten',
            Questions.kindergartenText, 'OK');

        //Question No 68
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the address of the kindergarten?",
            "Address kindergarten",
            220.0,
            "",
            Questions.kindergartenText);
      }

      //Answer No 68
      else if (widget.CheckCompleteQuestion ==
              "What is the address of the kindergarten?" &&
          widget.CheckQuestion == "Address kindergarten") {
        DbHelper.insatance
            .deleteWithquestion('What is the address of the kindergarten?');
        _insert('What is the address of the kindergarten?',
            Questions.kindergartenText, 'OK');

        //Question No 69
        return familydateContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "From what period did your child attend?",
            "Period kindergarten",
            220.0,
            "",
            Questions.kindergartenText);
      }

      //Answer No 69
      else if (widget.CheckCompleteQuestion ==
              "From what period did your child attend?" &&
          widget.CheckQuestion == "Period kindergarten") {
        DbHelper.insatance
            .deleteWithquestion('From what period did your child attend?');
        _insert('From what period did your child attend?',
            Questions.kindergartenText, 'OK');

        //Question No 70
        return familyyesnoContainer(
            """<p><strong>Support from the employer: kindergarten</strong></p>
<p>Choose the answer "Yes" if you received grants from your employer for childcare in a kindergarten. Otherwise click "No".</p>
<p><strong>YOUR TAXES</strong></p>
<p>Your employer support you with <strong>childcare costs</strong>.</p>
<p>This can be through: 1 <strong>services</strong> (an in-house kindergarten) <strong>or</strong> 2. <strong>benefits</strong> (subsidies for kindergarten, after-school clubs, childminders, etc.)</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive financial support from your employer for childcare at a kindergarten?",
            "Grants kindergarten",
            220.0,
            "",
            Questions.kindergartenText);
      }

      //Answer No 70
      else if (widget.CheckCompleteQuestion ==
              "Did you receive financial support from your employer for childcare at a kindergarten?" &&
          widget.CheckQuestion == "Grants kindergarten") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare at a kindergarten?');
          _insert(
              'Did you receive financial support from your employer for childcare at a kindergarten?',
              'No',
              'OK');

          if (Questions.kindergartenLength <= Questions.totalKindergarten) {
            //Question No 65
            return familycalculationContainer(
                """<p><strong>Kindergarten: childcare costs</strong></p>
<p>Enter here your childcare costs for the <strong>kindergarten</strong> in 2019.</p>
<p>You usually pay monthly contributions. You can find the respective amounts either on your account statement or in the invoices which the kindergarten sent you.</p>
<p><em>Add up the monthly amounts for 2019 and enter the total here.</em></p>
<p><strong>IMPORTANT:</strong></p>
<p>The cost of meals / catering may <strong>not</strong> be taken into account. Please do not include them</p>
<p>If the cost of childcare and catering are not individually identified in your invoices, you have to estimate them.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How much have you paid for the kindergarten?",
                "Cost kindergarten",
                220.0,
                "calculation",
                Questions.kindergartenText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare at a kindergarten?');
          _insert(
              'Did you receive financial support from your employer for childcare at a kindergarten?',
              'Yes',
              'OK');

          //Question No 71
          return familycalculationContainer(
              """<p><strong>Amount of grants for childcare costs</strong></p>
<p>Please enter here how much you received in childcare grants from your employer in 2019.</p>
<p><strong>Add up these up and enter the total here.</strong></p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What was the amount of grant you received?",
              "Amount of grants",
              220.0,
              "calculation",
              Questions.kindergartenText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare at a kindergarten?');
          _insert(
              'Did you receive financial support from your employer for childcare at a kindergarten?',
              'skip',
              'skip');

          //Question No 71
          return familycalculationContainer(
              """<p><strong>Amount of grants for childcare costs</strong></p>
<p>Please enter here how much you received in childcare grants from your employer in 2019.</p>
<p><strong>Add up these up and enter the total here.</strong></p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What was the amount of grant you received?",
              "Amount of grants",
              220.0,
              "calculation",
              Questions.kindergartenText);
        }
      }

      //Answer No 71
      else if (widget.CheckCompleteQuestion ==
              "What was the amount of grant you received?" &&
          widget.CheckQuestion == "Amount of grants") {
        DbHelper.insatance
            .deleteWithquestion('What was the amount of grant you received?');
        _insert('What was the amount of grant you received?',
            Questions.kindergartenText, 'OK');

        //Question No 72
        return familydateContainer(
            """<p><strong>Grants from employer: time period</strong></p>
<p>If you received any grants from your employer in 2019 for <strong>childcare</strong> (kindergarten / daycare fees, subsidies for the childminder etc.) then enter the <strong>time period</strong> here.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "From when to when were you getting grants for child care?",
            "Period grant",
            220.0,
            "",
            Questions.kindergartenText);
      }

      //Answer No 72
      else if (widget.CheckCompleteQuestion ==
              "From when to when were you getting grants for child care?" &&
          widget.CheckQuestion == "Period grant") {
        DbHelper.insatance.deleteWithquestion(
            'From when to when were you getting grants for child care?');
        _insert('From when to when were you getting grants for child care?',
            Questions.childText, 'OK');

        if (Questions.kindergartenLength <= Questions.totalKindergarten) {
          //Question No 65
          return familycalculationContainer(
              """<p><strong>Kindergarten: childcare costs</strong></p>
<p>Enter here your childcare costs for the <strong>kindergarten</strong> in 2019.</p>
<p>You usually pay monthly contributions. You can find the respective amounts either on your account statement or in the invoices which the kindergarten sent you.</p>
<p><em>Add up the monthly amounts for 2019 and enter the total here.</em></p>
<p><strong>IMPORTANT:</strong></p>
<p>The cost of meals / catering may <strong>not</strong> be taken into account. Please do not include them</p>
<p>If the cost of childcare and catering are not individually identified in your invoices, you have to estimate them.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How much have you paid for the kindergarten?",
              "Cost kindergarten",
              220.0,
              "calculation",
              Questions.kindergartenText);
        } else {
          //Question No 73
          return familyyesnoContainer("""<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you live together at any time of the year with the other parent in one household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        }
      }

      // ====== Kindergarten Ends ====== //

      // ====== Child Minder Starts ====== //

      //Answer no 82
      else if (widget.CheckCompleteQuestion ==
              "How many child minders did you pay for?" &&
          widget.CheckQuestion == "Number of child minders") {
        DbHelper.insatance
            .deleteWithquestion('How many child minders did you pay for?');
        _insert('How many child minders did you pay for?',
            Questions.childMinderText, 'OK');

        //Question No 83
        return familycalculationContainer(
            """<p><strong>Childminder costs</strong></p>
<p>Please enter the costs you had for the <strong>childminder</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "How much did you pay the child minder?",
            "Cost child minder",
            220.0,
            "calculation",
            Questions.childMinderText);
      }

      //Answer no 83
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay the child minder?" &&
          widget.CheckQuestion == "Cost child minder") {
        DbHelper.insatance
            .deleteWithquestion('How much did you pay the child minder?');
        _insert('How much did you pay the child minder?',
            Questions.childMinderText, 'OK');

        //Question No 84
        return familycalculationContainer(
            """<p><strong>Childminder costs of other parent</strong></p>
<p>Please enter the total costs incurred by the other parent for the <strong>childminder</strong> in 2019.</p>
<p>If unknown please ask the other parent about the amount of the costs.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "How much did the other parent pay the child minder?",
            "Amount child minder (partner)",
            220.0,
            "calculation",
            Questions.childMinderText);
      }

      //Answer No 84
      else if (widget.CheckCompleteQuestion ==
              "How much did the other parent pay the child minder?" &&
          widget.CheckQuestion == "Amount child minder (partner)") {
        DbHelper.insatance.deleteWithquestion(
            'How much did the other parent pay the child minder?');
        _insert('How much did the other parent pay the child minder?',
            Questions.childMinderText, 'OK');

        //Question No 85
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Please enter name and surname of the child minder.",
            "Name child minder",
            220.0,
            "calculation",
            Questions.childMinderText);
      }

      //Answer No 85
      else if (widget.CheckCompleteQuestion ==
              "Please enter name and surname of the child minder." &&
          widget.CheckQuestion == "Name child minder") {
        DbHelper.insatance.deleteWithquestion(
            'Please enter name and surname of the child minder');
        _insert('Please enter name and surname of the child minder',
            Questions.childMinderText, 'OK');

        //Question No 86
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the address of the child minder?",
            "Address childminder",
            220.0,
            "",
            Questions.childMinderText);
      }

      //Answer No 86
      else if (widget.CheckCompleteQuestion ==
              "What is the address of the child minder?" &&
          widget.CheckQuestion == "Address childminder") {
        DbHelper.insatance
            .deleteWithquestion('What is the address of the child minder?');
        _insert('What is the address of the child minder?',
            Questions.childMinderText, 'OK');

        //Question No 87
        //Ya container baad ma change hoga
        return familydateContainer(
            """<p><strong>Time period: childminder</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your child was cared for by a childminder.</p>
<p>You don't have to work out vacation, illness, or other absences.</p>
<p>If you specified that your child was supervised by several childminders, the periods of time for each childminder are recorded separately.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "When was your child taken care of by the child minder?",
            "Period child minder",
            220.0,
            "",
            Questions.childMinderText);
      }

      //Answer No 87
      else if (widget.CheckCompleteQuestion ==
              "When was your child taken care of by the child minder?" &&
          widget.CheckQuestion == "Period child minder") {
        DbHelper.insatance.deleteWithquestion(
            'When was your child taken care of by the child minder?');
        _insert('When was your child taken care of by the child minder?',
            Questions.childMinderText, 'OK');

        //Question No 88
        //Ya container baad ma change hoga
        return familyyesnoContainer(
            """<p><strong>Support from the employer: childminder</strong></p>
<p>Choose the answer "Yes" if you in 2019 received grants from your employer for childcare by a childminder. Otherwise click "No".</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive financial support from your employer for childcare from a childminder?",
            "Grants child minder",
            220.0,
            "",
            Questions.childMinderText);
      }

      //Answer No 88
      else if (widget.CheckCompleteQuestion ==
              "Did you receive financial support from your employer for childcare from a childminder?" &&
          widget.CheckQuestion == "Grants child minder") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a childminder?');
          _insert(
              'Did you receive financial support from your employer for childcare from a childminder?',
              'No',
              'OK');

          if (Questions.childMinderLength <= Questions.totalChildMinder) {
            //Question No 83
            return familycalculationContainer(
                """<p><strong>Childminder costs</strong></p>
<p>Please enter the costs you had for the <strong>childminder</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How much did you pay the child minder?",
                "Cost child minder",
                220.0,
                "calculation",
                Questions.childMinderText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a childminder?');
          _insert(
              'Did you receive financial support from your employer for childcare from a childminder?',
              'Yes',
              'OK');

          //Question No 89
          return familycalculationContainer(
              """<p><strong>Amount of grants for childcare costs</strong></p>
<p>Please enter here how much you received in childcare grants from your employer in 2019.</p>
<p><strong>Add up these and enter the total here.</strong></p>
<p>For example, these could be (pro-rata) grants for a childminder.</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How much was the grant you got?",
              "Amount of grants",
              220.0,
              "calculation",
              Questions.childMinderText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a childminder?');
          _insert(
              'Did you receive financial support from your employer for childcare from a childminder?',
              'skip',
              'skip');

          //Question No 89
          return familycalculationContainer(
              """<p><strong>Amount of grants for childcare costs</strong></p>
<p>Please enter here how much you received in childcare grants from your employer in 2019.</p>
<p><strong>Add up these and enter the total here.</strong></p>
<p>For example, these could be (pro-rata) grants for a childminder.</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How much was the grant you got?",
              "Amount of grants",
              220.0,
              "calculation",
              Questions.childMinderText);
        }
      }

      //Answer No 89
      else if (widget.CheckCompleteQuestion ==
              "How much was the grant you got?" &&
          widget.CheckQuestion == "Amount of grants" &&
          Questions.childMinderText.contains("CHILD MINDER")) {
        DbHelper.insatance
            .deleteWithquestion('How much was the grant you got?');
        _insert(
            'How much was the grant you got?', Questions.childMinderText, 'OK');

        //Question No 90
        //Ya container baad ma change hoga
        return familydateContainer(
            """<p><strong>Childcare grants: time period</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your employer paid you childcare grants.</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "When did you receive grants for childcare?",
            "Period financial support",
            220.0,
            "",
            Questions.childMinderText);
      }

      //Answer No 90
      else if (widget.CheckCompleteQuestion ==
              "When did you receive grants for childcare?" &&
          widget.CheckQuestion == "Period financial support" &&
          Questions.childMinderText.contains("CHILD MINDER")) {
        DbHelper.insatance
            .deleteWithquestion('When did you receive grants for childcare?');
        _insert('When did you receive grants for childcare?',
            Questions.childText, 'OK');

        if (Questions.childMinderLength <= Questions.totalChildMinder) {
          //Question No 83
          return familycalculationContainer(
              """<p><strong>Childminder costs</strong></p>
<p>Please enter the costs you had for the <strong>childminder</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay the child minder?",
              "Cost child minder",
              220.0,
              "calculation",
              Questions.childMinderText);
        } else {
          //Question No 73
          return familyyesnoContainer("""<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you live together at any time of the year with the other parent in one household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        }
      }

      // ====== Child Minder Ends ====== //

      // ====== Nanny Starts ====== //

      //Answer No 91
      else if (widget.CheckCompleteQuestion ==
              "How many nannies did you pay?" &&
          widget.CheckQuestion == "Number of nannies") {
        DbHelper.insatance.deleteWithquestion('How many nannies did you pay?');
        _insert('How many nannies did you pay?', Questions.nannyText, 'OK');

        //Question No 92
        return familycalculationContainer("""<p><strong>Nanny costs</strong></p>
<p>Please enter the costs you had for the <strong>nanny</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "How much did you pay the nanny?",
            "Cost nanny",
            220.0,
            "calculation",
            Questions.nannyText);
      }

      //Answer No 92
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay the nanny?" &&
          widget.CheckQuestion == "Cost nanny") {
        DbHelper.insatance
            .deleteWithquestion('How much did you pay the nanny?');
        _insert('How much did you pay the nanny?', Questions.nannyText, 'OK');

        //Question No 93
        return familycalculationContainer(
            """<p><strong>Nanny costs of other parent</strong></p>
<p>Please enter the total costs incurred by the other parent for the <strong>nanny</strong> in 2019.</p>
<p>If unknown please ask the other parent about the amount of the costs.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "How much did the other parent pay the nanny?",
            "Amount nanny (partner)",
            220.0,
            "calculation",
            Questions.nannyText);
      }

      //Answer No 93
      else if (widget.CheckCompleteQuestion ==
              "How much did the other parent pay the nanny?" &&
          widget.CheckQuestion == "Amount nanny (partner)") {
        DbHelper.insatance
            .deleteWithquestion('How much did the other parent pay the nanny?');
        _insert('How much did the other parent pay the nanny?',
            Questions.nannyText, 'OK');

        //Question No 94
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the name and surname of the nanny?",
            "Name nanny",
            220.0,
            "",
            Questions.nannyText);
      }

      //Answer No 94
      else if (widget.CheckCompleteQuestion ==
              "What is the name and surname of the nanny?" &&
          widget.CheckQuestion == "Name nanny") {
        DbHelper.insatance
            .deleteWithquestion('What is the name and surname of the nanny?');
        _insert('What is the name and surname of the nanny?',
            Questions.nannyText, 'OK');

        //Question No 95
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the address of the nanny?",
            "Address nanny",
            220.0,
            "",
            Questions.nannyText);
      }

      //Answer No 95
      else if (widget.CheckCompleteQuestion ==
              "What is the address of the nanny?" &&
          widget.CheckQuestion == "Address nanny") {
        DbHelper.insatance
            .deleteWithquestion('What is the address of the nanny?');
        _insert('What is the address of the nanny?', Questions.nannyText, 'OK');

        //Question No 96
        //ya container baad ma change hoga
        return familydateContainer("""<p><strong>Time period: nanny</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your child was cared for by a nanny.</p>
<p>You don't have to work out vacation, illness, or other absences.</p>
<p>If you specified that your child was supervised by several nannies, the periods of time for each nanny are recorded separately.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "When did the nanny take care of your child?",
            "Period nanny",
            220.0,
            "",
            Questions.nannyText);
      }

      //Answer No 96
      else if (widget.CheckCompleteQuestion ==
              "When did the nanny take care of your child?" &&
          widget.CheckQuestion == "Period nanny") {
        DbHelper.insatance
            .deleteWithquestion('When did the nanny take care of your child?');
        _insert('When did the nanny take care of your child?',
            Questions.nannyText, 'OK');

        //Question No 97
        return familyyesnoContainer(
            """<p><strong>Support from the employer: nanny</strong></p>
<p>Did your employer pay childcare grants, for example reimbursement for a nanny?</p>
<p>Choose the answer "Yes" if you in 2016 received these type of grants Otherwise click "No".</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive financial support from your employer for childcare from a nanny?",
            "Grants nanny care",
            220.0,
            "",
            Questions.nannyText);
      }

      //Answer No 97

      else if (widget.CheckCompleteQuestion ==
              "Did you receive financial support from your employer for childcare from a nanny?" &&
          widget.CheckQuestion == "Grants nanny care") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a nanny?');
          _insert(
              'Did you receive financial support from your employer for childcare from a nanny?',
              'No',
              'OK');

          if (Questions.nannyLength <= Questions.totalNanny) {
            //Question No 92
            return familycalculationContainer(
                """<p><strong>Nanny costs</strong></p>
<p>Please enter the costs you had for the <strong>nanny</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How much did you pay the nanny?",
                "Cost nanny",
                220.0,
                "calculation",
                Questions.nannyText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a nanny?');
          _insert(
              'Did you receive financial support from your employer for childcare from a nanny?',
              'skip',
              'skip');

          if (Questions.nannyLength <= Questions.totalNanny) {
            //Question No 92
            return familycalculationContainer(
                """<p><strong>Nanny costs</strong></p>
<p>Please enter the costs you had for the <strong>nanny</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How much did you pay the nanny?",
                "Cost nanny",
                220.0,
                "calculation",
                Questions.nannyText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a nanny?');
          _insert(
              'Did you receive financial support from your employer for childcare from a nanny?',
              'Yes',
              'OK');

          //Question No 98
          return familycalculationContainer(
              """<p><strong>Amount of grants for childcare costs</strong></p>
<p>Please enter here how much you received in childcare grants from your employer in 2019.</p>
<p><strong>Add up these and enter the total here.</strong></p>
<p>For example, these could be (pro-rata) grants for a childminder.</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How much was the grant you got?",
              "Amount of grants",
              220.0,
              "calculation",
              Questions.nannyText);
        }
      }

      //Answer No 98
      else if (widget.CheckCompleteQuestion ==
              "How much was the grant you got?" &&
          widget.CheckQuestion == "Amount of grants" &&
          Questions.nannyText.contains("NANNY")) {
        DbHelper.insatance
            .deleteWithquestion('How much was the grant you got?');
        _insert('How much was the grant you got?', Questions.nannyText, 'OK');

        //Question No 99
        //ya container baad ma change hoga

        return familydateContainer(
            """<p><strong>Childcare grants: time period</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your employer paid you childcare grants.</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "When did you receive grants for childcare?",
            "Period financial support",
            220.0,
            "",
            Questions.nannyText);
      }

      //Answer No 99
      else if (widget.CheckCompleteQuestion ==
              "When did you receive grants for childcare?" &&
          widget.CheckQuestion == "Period financial support" &&
          Questions.nannyText.contains("NANNY")) {
        if (Questions.nannyLength <= Questions.totalNanny) {
          DbHelper.insatance
              .deleteWithquestion('When did you receive grants for childcare?');
          _insert('When did you receive grants for childcare?',
              Questions.nannyText, 'OK');

          //Question No 92
          return familycalculationContainer(
              """<p><strong>Nanny costs</strong></p>
<p>Please enter the costs you had for the <strong>nanny</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay the nanny?",
              "Cost nanny",
              220.0,
              "calculation",
              Questions.nannyText);
        } else {
          //Question No 73
          return familyyesnoContainer("""<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you live together at any time of the year with the other parent in one household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        }
      }
      // ====== Nanny Ends ====== //

      // ======= Babysitter Starts =======

      //Answer No 100
      else if (widget.CheckCompleteQuestion ==
              "How many babysitters did you pay for?" &&
          widget.CheckQuestion == "Number of babysitters") {
        DbHelper.insatance
            .deleteWithquestion('How many babysitters did you pay for?');
        _insert('How many babysitters did you pay for?',
            Questions.babySitterText, 'OK');

        //Question No 101
        return familycalculationContainer(
            """<p><strong>Babysitter costs</strong></p>
<p>Please enter the total costs you had for the <strong>babysitter</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "How much did you pay the babysitter?",
            "Babysitter cost",
            220.0,
            "calculation",
            Questions.babySitterText);
      }

      //Answer No 101
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay the babysitter?" &&
          widget.CheckQuestion == "Babysitter cost") {
        DbHelper.insatance
            .deleteWithquestion('How much did you pay the babysitter?');
        _insert('How much did you pay the babysitter?',
            Questions.babySitterText, 'OK');

        //Question No 102
        return familycalculationContainer(
            """<p><strong>Babysitter costs of other parent</strong></p>
<p>Please enter the total costs incurred by the other parent for the <strong>babysitter</strong> in 2019.</p>
<p>If unknown please ask the other parent about the amount of the costs.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "How much did the other parent pay the babysitter?",
            "Amount babysitter partner",
            220.0,
            "calculation",
            Questions.babySitterText);
      }

      //Answer No 102
      else if (widget.CheckCompleteQuestion ==
              "How much did the other parent pay the babysitter?" &&
          widget.CheckQuestion == "Amount babysitter partner") {
        DbHelper.insatance.deleteWithquestion(
            'How much did the other parent pay the babysitter?');
        _insert('How much did the other parent pay the babysitter?',
            Questions.babySitterText, 'OK');

        //Question No 103
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the babysitter's full name?",
            "Name babysitter",
            220.0,
            "calculation",
            Questions.babySitterText);
      }

      //Answer No 103
      else if (widget.CheckCompleteQuestion ==
              "What is the babysitter's full name?" &&
          widget.CheckQuestion == "Name babysitter") {
        DbHelper.insatance
            .deleteWithquestion('What is the babysitters full name?');
        _insert('What is the babysitters full name?', Questions.babySitterText,
            'OK');

        //Question No 104
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the babysitter's address?",
            "Address babysitter",
            220.0,
            "",
            Questions.babySitterText);
      }

      //Answer No 104
      else if (widget.CheckCompleteQuestion ==
              "What is the babysitter's address?" &&
          widget.CheckQuestion == "Address babysitter") {
        DbHelper.insatance
            .deleteWithquestion('What is the babysitters address?');
        _insert(
            'What is the babysitters address?', Questions.babySitterText, 'OK');

        //Question No 105
        //Ya container baad ma change hoga
        return familydateContainer(
            """<p><strong>Time period: babysitter</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your child was cared for by a babysitter.</p>
<p>You don't have to work out vacation, illness, or other absences.</p>
<p>If you specified that your child was supervised by several babysitters, the periods of time for each babysitter are recorded separately.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "When did the babysitter take care of your child?",
            "Period babysitter care",
            220.0,
            "",
            Questions.babySitterText);
      }

      //Answer No 105
      else if (widget.CheckCompleteQuestion ==
              "When did the babysitter take care of your child?" &&
          widget.CheckQuestion == "Period babysitter care") {
        DbHelper.insatance.deleteWithquestion(
            'When did the babysitter take care of your child?');
        _insert('When did the babysitter take care of your child?',
            Questions.babySitterText, 'OK');

        //Question No 106
        return familyyesnoContainer(
            """<p><strong>Support from the employer: babysiter</strong></p>
<p>Choose the answer "Yes" If you in 2019 received grants from your employer for childcare by a babysitter. Otherwise click "No".</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive financial support from your employer for childcare from a babysitter?",
            "Grants babysitter care",
            220.0,
            "",
            Questions.babySitterText);
      }

      //Answer no 106
      else if (widget.CheckCompleteQuestion ==
              "Did you receive financial support from your employer for childcare from a babysitter?" &&
          widget.CheckQuestion == "Grants babysitter care") {
        if (widget.CheckAnswer[0] == "No") {
          if (Questions.babySitterLength <= Questions.totalBabySitter) {
            DbHelper.insatance.deleteWithquestion(
                'Did you receive financial support from your employer for childcare from a babysitter?');
            _insert(
                'Did you receive financial support from your employer for childcare from a babysitter?',
                'No',
                'OK');

            //Question No 101
            return familycalculationContainer(
                """<p><strong>Babysitter costs</strong></p>
<p>Please enter the total costs you had for the <strong>babysitter</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How much did you pay the babysitter?",
                "Babysitter cost",
                220.0,
                "calculation",
                Questions.babySitterText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a babysitter?');
          _insert(
              'Did you receive financial support from your employer for childcare from a babysitter?',
              'skip',
              'skip');

          if (Questions.babySitterLength <= Questions.totalBabySitter) {
            //Question No 101
            return familycalculationContainer(
                """<p><strong>Babysitter costs</strong></p>
<p>Please enter the total costs you had for the <strong>babysitter</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "How much did you pay the babysitter?",
                "Babysitter cost",
                220.0,
                "calculation",
                Questions.babySitterText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from a babysitter?');
          _insert(
              'Did you receive financial support from your employer for childcare from a babysitter?',
              'Yes',
              'OK');

          //Question No 107
          return familycalculationContainer(
              """<p><strong>Amount of subsidies for childcare</strong></p>
<p>If you received grants from the employer for the <strong>childcare</strong> (kindergarten / daycare fees, grants for childminder etc.) please enter <strong>how much</strong> you received.</p>
<p>Only the amount you received in 2019 is relevant.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What was the amount of the grant you received?",
              "Amount of grants",
              220.0,
              "calculation",
              Questions.babySitterText);
        }
      }

      //Answer No 107
      else if (widget.CheckCompleteQuestion ==
              "What was the amount of the grant you received?" &&
          widget.CheckQuestion == "Amount of grants") {
        DbHelper.insatance.deleteWithquestion(
            'What was the amount of the grant you received?');
        _insert('What was the amount of the grant you received?',
            Questions.babySitterText, 'OK');

        //Question No 108
        //Ya container baad ma change hoga
        return familydateContainer(
            """<p><strong>Childcare grants: time period</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your employer paid you childcare grants.</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "When did you receive grants for childcare?",
            "Period financial support",
            220.0,
            "",
            Questions.babySitterText);
      }

      //Answer No 108
      else if (widget.CheckCompleteQuestion ==
              "When did you receive grants for childcare?" &&
          widget.CheckQuestion == "Period financial support" &&
          Questions.babySitterText.contains("BABYSITTER")) {
        DbHelper.insatance
            .deleteWithquestion('When did you receive grants for childcare?');
        _insert('When did you receive grants for childcare?',
            Questions.babySitterText, 'OK');

        if (Questions.babySitterLength <= Questions.totalBabySitter) {
          //Question No 101
          return familycalculationContainer(
              """<p><strong>Babysitter costs</strong></p>
<p>Please enter the total costs you had for the <strong>babysitter</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay the babysitter?",
              "Babysitter cost",
              220.0,
              "calculation",
              Questions.babySitterText);
        } else {
          //Question No 73
          return familyyesnoContainer("""<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you live together at any time of the year with the other parent in one household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        }
      }

      // ======= Babysitter Ends =======

      //Au pair starts
      //Answer No 109
      else if (widget.CheckCompleteQuestion ==
              "How many au pairs did you pay for?" &&
          widget.CheckQuestion == "Number of au pairs") {
        DbHelper.insatance
            .deleteWithquestion('How many au pairs did you pay for?');
        _insert(
            'How many au pairs did you pay for?', Questions.aupairText, 'OK');

        //Question no 110
        return familycalculationContainer("""
<p><strong>Au pair costs</strong></p>
<p>Please enter the costs you had for the <strong>au pair</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>
""", "", "Child ${Questions.childLength}", "How much did you pay the au pair?",
            "Cost au pair", 220.0, "calculation", Questions.aupairText);
      }

      //Answer No 110
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay the au pair?" &&
          widget.CheckQuestion == "Cost au pair") {
        DbHelper.insatance
            .deleteWithquestion('How much did you pay the au pair?');
        _insert(
            'How much did you pay the au pair?', Questions.aupairText, 'OK');

        //Question no 111
        return familycalculationContainer(
            """<p><strong>Au pair costs of other parent</strong></p>
<p>Please enter the total costs incurred by the other parent for the <strong>au pair</strong> in 2019.</p>
<p>If unknown please ask the other parent about the amount of the costs.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
""",
            "",
            "Child ${Questions.childLength}",
            "How much did the other parent pay the au pair?",
            "Amount au pair (partner)",
            220.0,
            "calculation",
            Questions.aupairText);
      }

      //Answer No 111
      else if (widget.CheckCompleteQuestion ==
              "How much did the other parent pay the au pair?" &&
          widget.CheckQuestion == "Amount au pair (partner)") {
        DbHelper.insatance.deleteWithquestion(
            'How much did the other parent pay the au pair?');
        _insert('How much did the other parent pay the au pair?',
            Questions.aupairText, 'OK');

        //Question no 112
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the au pair's full name?",
            "Name au pair",
            220.0,
            "",
            Questions.aupairText);
      }

      //Answer No 112
      else if (widget.CheckCompleteQuestion ==
              "What is the au pair's full name?" &&
          widget.CheckQuestion == "Name au pair") {
        DbHelper.insatance
            .deleteWithquestion('What is the au pairs full name?');
        _insert('What is the au pairs full name?', Questions.aupairText, 'OK');

        //Question no 113
        return familyaddressContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What is the address of the au pair?",
            "Address au pair",
            220.0,
            "",
            Questions.aupairText);
      }

      //Answer no 113
      else if (widget.CheckCompleteQuestion ==
              "What is the address of the au pair?" &&
          widget.CheckQuestion == "Address au pair") {
        DbHelper.insatance
            .deleteWithquestion('What is the address of the au pair?');
        _insert(
            'What is the address of the au pair?', Questions.aupairText, 'OK');

        //Question no 114
        //ya container baad ma change hoga
        return familydateContainer(
            """<p><strong>Time period: au pair</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your child was cared for by an au pair.</p>
<p>You don't have to work out vacation, illness, or other absences.</p>
<p>If you specified that your child was supervised by several au pairs, the periods of time for each au pair are recorded separately.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "From when to when was the au pair caring for your child?",
            "Period au pair",
            220.0,
            "",
            Questions.aupairText);
      }

//Answer no 114
      else if (widget.CheckCompleteQuestion ==
              "From when to when was the au pair caring for your child?" &&
          widget.CheckQuestion == "Period au pair") {
        DbHelper.insatance.deleteWithquestion(
            'From when to when was the au pair caring for your child?');
        _insert('From when to when was the au pair caring for your child?',
            Questions.aupairText, 'OK');

        //Question no 115
        return familyyesnoContainer(
            """<p><strong>Amount of childcare</strong></p>
<p>Choose "Yes", if you agreed beforehand how much you're paying the au pair for childcare. Otherwise click "No".</p>
<p>An au pair more tasks than just childcare or household help.</p>
<p>For tax purposes, only the <strong>childcare costs</strong> are relevant.</p>
<p>The costs for example for housework are <strong>NOT</strong> tax deductible and should not be included. For this reason, it is important that is clearly defined, <strong>how much</strong> you are paying the au pair for <strong>childcare</strong>.</p>""",
            "",
            "Child ${Questions.childLength}",
            "Did you agree on the salary component of the au pair's pay in advance?",
            "Agreement au pair",
            220.0,
            "",
            Questions.aupairText);
      }

      //Answer No 115
      else if (widget.CheckCompleteQuestion ==
              "Did you agree on the salary component of the au pair's pay in advance?" &&
          widget.CheckQuestion == "Agreement au pair") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you agree on the salary component of the au pairs pay in advance?');
          _insert(
              'Did you agree on the salary component of the au pairs pay in advance?',
              'No',
              'OK');

          //Question no 117
          return familyyesnoContainer("""
<p><strong>Support from the employer: au pair</strong></p>
<p>Choose the answer "Yes" If you in 2019 received grants from your employer for childcare by an au pair. Otherwise click "No".</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>
""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive financial support from your employer for childcare from an au pair?",
              "Grants au pair care",
              220.0,
              "",
              Questions.aupairText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you agree on the salary component of the au pairs pay in advance?');
          _insert(
              'Did you agree on the salary component of the au pairs pay in advance?',
              'skip',
              'skip');

          //Question no 117
          return familyyesnoContainer("""
<p><strong>Support from the employer: au pair</strong></p>
<p>Choose the answer "Yes" If you in 2019 received grants from your employer for childcare by an au pair. Otherwise click "No".</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>
""",
              "",
              "Child ${Questions.childLength}",
              "Did you receive financial support from your employer for childcare from an au pair?",
              "Grants au pair care",
              220.0,
              "",
              Questions.aupairText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you agree on the salary component of the au pairs pay in advance?');
          _insert(
              'Did you agree on the salary component of the au pairs pay in advance?',
              'Yes',
              'OK');

          //Question No 116
          return familycalculationContainer("""
<p><strong>Amount of childcare costs</strong></p>
<p>Please enter the costs you had for the au pair. Here we mean the childcare costs for your child in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p> </p>
<p> </p>
""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay the au pair for taking care of your child?",
              "Childcare costs",
              220.0,
              "",
              Questions.aupairText);
        }
      }

      //Answer No 116
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay the au pair for taking care of your child?" &&
          widget.CheckQuestion == "Childcare costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much did you pay the au pair for taking care of your child?');
        _insert(
            'How much did you pay the au pair for taking care of your child?',
            Questions.aupairText,
            'OK');

        //Question no 117
        return familyyesnoContainer("""
<p><strong>Support from the employer: au pair</strong></p>
<p>Choose the answer "Yes" If you in 2019 received grants from your employer for childcare by an au pair. Otherwise click "No".</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>
""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive financial support from your employer for childcare from an au pair?",
            "Grants au pair care",
            220.0,
            "",
            Questions.aupairText);
      }

//Answer No 117
      else if (widget.CheckCompleteQuestion ==
              "Did you receive financial support from your employer for childcare from an au pair?" &&
          widget.CheckQuestion == "Grants au pair care") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from an au pair?');
          _insert(
              'Did you receive financial support from your employer for childcare from an au pair?',
              'No',
              'OK');

          if (Questions.aupairLength <= Questions.totalAupair) {
            //Question no 110
            return familycalculationContainer("""
<p><strong>Au pair costs</strong></p>
<p>Please enter the costs you had for the <strong>au pair</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>

""", "", "Child ${Questions.childLength}", "How much did you pay the au pair?",
                "Cost au pair", 220.0, "calculation", Questions.aupairText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from an au pair?');
          _insert(
              'Did you receive financial support from your employer for childcare from an au pair?',
              'skip',
              'skip');

          if (Questions.aupairLength <= Questions.totalAupair) {
            //Question no 110
            return familycalculationContainer("""
<p><strong>Au pair costs</strong></p>
<p>Please enter the costs you had for the <strong>au pair</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p> </p>
<p> </p>

""", "", "Child ${Questions.childLength}", "How much did you pay the au pair?",
                "Cost au pair", 220.0, "calculation", Questions.aupairText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare from an au pair?');
          _insert(
              'Did you receive financial support from your employer for childcare from an au pair?',
              'Yes',
              'OK');

          //Question No 118
          return familycalculationContainer("""
<p><strong>Amount of subsidies for childcare</strong></p>
<p>If you received grants from the employer for the <strong>childcare</strong> (kindergarten / daycare fees, grants for childminder etc.) please enter <strong>how much</strong> you received.</p>
<p>Only the amount you received in 2019 is relevant.</p>
<p> </p>

""",
              "",
              "Child ${Questions.childLength}",
              "What was the amount of the grant you have received?",
              "Amount of grants",
              220.0,
              "calculation",
              Questions.aupairText);
        }
      }

      //Answer No 118
      else if (widget.CheckCompleteQuestion ==
              "What was the amount of the grant you have received?" &&
          widget.CheckQuestion == "Amount of grants") {
        DbHelper.insatance.deleteWithquestion(
            'What was the amount of the grant you have received?');
        _insert('What was the amount of the grant you have received?',
            Questions.aupairText, 'OK');

        //Question No 119
        //ya container baad ma change hoga
        return familydateContainer("""

<p><strong>Childcare grants: time period</strong></p>
<p>With the help of our calendar here choose the time period in 2019 in which your employer paid you childcare grants.</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p> </p>
<p> </p>

""",
            "",
            "Child ${Questions.childLength}",
            "When did you receive grants for childcare?",
            "Period financial support",
            220.0,
            "",
            Questions.aupairText);
      }

      //Answer No 119
      else if (widget.CheckCompleteQuestion ==
              "When did you receive grants for childcare?" &&
          widget.CheckQuestion == "Period financial support" &&
          Questions.aupairText.contains("AU PAIR")) {
        if (Questions.aupairLength <= Questions.totalAupair) {
          //Question no 110
          return familycalculationContainer("""
<p><strong>Au pair costs</strong></p>
<p>Please enter the costs you had for the <strong>au pair</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p>&nbsp;</p>


""", "", "Child ${Questions.childLength}", "How much did you pay the au pair?",
              "Cost au pair", 220.0, "calculation", Questions.aupairText);
        } else {
          //Question No 73
          return familyyesnoContainer("""<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you live together at any time of the year with the other parent in one household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Au pair ends

// ===== Day Care starts ======
      //Answer No 120
      else if (widget.CheckCompleteQuestion ==
              "How many different daycare centers has your child attended?" &&
          widget.CheckQuestion == "Number of daycare centers") {
        DbHelper.insatance.deleteWithquestion(
            'How many different daycare centers has your child attended?');
        _insert('How many different daycare centers has your child attended?',
            Questions.dayCareText, 'OK');

        //Question no 121
        return familycalculationContainer("""
<p><strong>Childcare costs for after-school clubs</strong></p>
<p>Please enter the costs you had for the <strong>after-school clubs</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p>&nbsp;</p>


""",
            "",
            "Child ${Questions.childLength}",
            "How much have you paid for the daycare center?",
            "Cost daycare center",
            220.0,
            "calculation",
            Questions.dayCareText);
      }

      //Answer No 121
      else if (widget.CheckCompleteQuestion ==
              "How much have you paid for the daycare center?" &&
          widget.CheckQuestion == "Cost daycare center") {
        DbHelper.insatance.deleteWithquestion(
            'How much have you paid for the daycare center?');
        _insert('How much have you paid for the daycare center?',
            Questions.dayCareText, 'OK');

        //Question no 122
        return familycalculationContainer("""

<p><strong>After-school club costs of other parent</strong></p>
<p>Please enter the total costs incurred by the other parent for <strong>after-school clubs</strong> in 2019.</p>
<p>If unknown please ask the other parent about the amount of the costs.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "How much did the other parent pay toward the daycare center?",
            "Amount daycare center (partner)",
            220.0,
            "calculation",
            Questions.dayCareText);
      }

      //Answer No 122
      else if (widget.CheckCompleteQuestion ==
              "How much did the other parent pay toward the daycare center?" &&
          widget.CheckQuestion == "Amount daycare center (partner)") {
        DbHelper.insatance.deleteWithquestion(
            'How much did the other parent pay toward the daycare center?');
        _insert('How much did the other parent pay toward the daycare center?',
            Questions.dayCareText, 'OK');

        //Question no 123
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "What was your child's daycare center called?",
            "Name daycare center",
            220.0,
            "",
            Questions.dayCareText);
      }

      //Answer No 123
      else if (widget.CheckCompleteQuestion ==
              "What was your child's daycare center called?" &&
          widget.CheckQuestion == "Name daycare center") {
        DbHelper.insatance
            .deleteWithquestion('What was your childs daycare center called?');
        _insert('What was your childs daycare center called?',
            Questions.dayCareText, 'OK');

        //Question no 124
        return familyaddressContainer("""<h1>Coming Soon!</h1>
""",
            "",
            "Child ${Questions.childLength}",
            "What is the daycare center's address?",
            "Address Daycare center",
            220.0,
            "",
            Questions.dayCareText);
      }

      //Answer No 124
      else if (widget.CheckCompleteQuestion ==
              "What is the daycare center's address?" &&
          widget.CheckQuestion == "Address Daycare center") {
        DbHelper.insatance
            .deleteWithquestion('What is the daycare centers address?');
        _insert('What is the daycare centers address?', Questions.dayCareText,
            'OK');

        //Question no 125
        //yaha container change hoga
        return familydateContainer("""

<p>&nbsp;<strong>Time period: after-school clubs</strong></p>
<p>With the help of our calendar select the time period in 2019 which your child attended this after school club.</p>
<p>You don't have to figure out vacation, illness, or other absences.</p>
<p>The time periods are recorded separately for each individual after-school club.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "when did your child attend this daycare center?",
            "Duration Daycare",
            220.0,
            "",
            Questions.dayCareText);
      }

      //Answer No 125
      else if (widget.CheckCompleteQuestion ==
              "when did your child attend this daycare center?" &&
          widget.CheckQuestion == "Duration Daycare") {
        DbHelper.insatance
            .deleteWithquestion('What is the daycare centers address?');
        _insert('What is the daycare centers address?', Questions.dayCareText,
            'OK');

        //Question no 126
        return familyyesnoContainer("""

<p><strong>Grants for childcare costs</strong></p>
<p>Choose the answer "Yes" if you in 2019 received grants from your employer for childcare in the form of an after-school club. Otherwise click "No".</p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive financial support from your employer for childcare at a day center?",
            "Grants daycare center",
            220.0,
            "",
            Questions.dayCareText);
      }

      //Answer No 126
      else if (widget.CheckCompleteQuestion ==
              "Did you receive financial support from your employer for childcare at a day center?" &&
          widget.CheckQuestion == "Grants daycare center") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare at a day center?');
          _insert(
              'Did you receive financial support from your employer for childcare at a day center?',
              'No',
              'OK');

          if (Questions.dayCareLength <= Questions.totalDayCare) {
            //Question no 121
            return familycalculationContainer("""
<p><strong>Childcare costs for after-school clubs</strong></p>
<p>Please enter the costs you had for the <strong>after-school clubs</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p>&nbsp;</p>
""",
                "",
                "Child ${Questions.childLength}",
                "How much have you paid for the daycare center?",
                "Cost daycare center",
                220.0,
                "calculation",
                Questions.dayCareText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare at a day center?');
          _insert(
              'Did you receive financial support from your employer for childcare at a day center?',
              'skip',
              'skip');

          if (Questions.dayCareLength <= Questions.totalDayCare) {
            //Question no 121
            return familycalculationContainer("""
<p><strong>Childcare costs for after-school clubs</strong></p>
<p>Please enter the costs you had for the <strong>after-school clubs</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p>&nbsp;</p>
""",
                "",
                "Child ${Questions.childLength}",
                "How much have you paid for the daycare center?",
                "Cost daycare center",
                220.0,
                "calculation",
                Questions.dayCareText);
          } else {
            //Question No 73
            return familyyesnoContainer(
                """<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Did you live together at any time of the year with the other parent in one household?",
                "Joint household",
                220.0,
                "",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive financial support from your employer for childcare at a day center?');
          _insert(
              'Did you receive financial support from your employer for childcare at a day center?',
              'Yes',
              'OK');

          //Question No 127
          return familycalculationContainer("""

<p><strong>Amount of grants for childcare costs</strong></p>
<p>Please enter here how much you received in childcare grants from your employer in 2019.</p>
<p><strong>Add up these up and enter the total here.</strong></p>
<p>Your employer must pay these subsidies in addition to your wages.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "What was the amount of the grant have you received?",
              "Grant amount",
              220.0,
              "calculation",
              Questions.aupairText);
        }
      }

      //Answer No 127
      else if (widget.CheckCompleteQuestion ==
              "What was the amount of the grant have you received?" &&
          widget.CheckQuestion == "Grant amount") {
        DbHelper.insatance.deleteWithquestion(
            'What was the amount of the grant have you received?');
        _insert('What was the amount of the grant have you received?',
            Questions.dayCareText, 'OK');

        //Question No 128
//yaha container change hoga
        return familydateContainer("""

<p><strong>Time period of childcare grants</strong></p>
<p>Please specify for which time period your employer paid childcare grants in 2019.</p>
<p>Your employer must have paid these grants in addition to your wages.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "When did you receive grants for childcare?",
            "Period financial support",
            220.0,
            "",
            Questions.dayCareText);
      }

      //Answer No 128
      else if (widget.CheckCompleteQuestion ==
              "When did you receive grants for childcare?" &&
          widget.CheckQuestion == "Period financial support" &&
          Questions.dayCareText.contains("DAYCARE CENTER")) {
        if (Questions.dayCareLength <= Questions.totalDayCare) {
          //Question no 121
          return familycalculationContainer("""

<p><strong>Childcare costs for after-school clubs</strong></p>
<p>Please enter the costs you had for the <strong>after-school clubs</strong> in 2019.</p>
<p>Costs such as lunch money or toy expenses are <strong>NOT</strong> tax deductible so please don't include these.</p>
<p>If these costs are not individually identified, you have to estimate the costs.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "How much have you paid for the daycare center?",
              "Cost daycare center",
              220.0,
              "calculation",
              Questions.dayCareText);
        } else {
          //Question No 73
          return familyyesnoContainer("""<p><strong>Living together</strong></p>
<p>Please state whether during 2019 you lived together with the other parent. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p><strong>Important:</strong></p>
<p>The amount of time you lived together has no bearing. Choose "Yes" even if you only lived together for one day.</p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Did you live together at any time of the year with the other parent in one household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        }
      }

// ===== Day Care ends =======

      //Answer No 73
      else if (widget.CheckCompleteQuestion ==
              "Did you live together at any time of the year with the other parent in one household?" &&
          widget.CheckQuestion == "Joint household") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you live together at any time of the year with the other parent in one household?');
          _insert(
              'Did you live together at any time of the year with the other parent in one household?',
              'No',
              'OK');

          //Question No 74
          //Ya container baad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When was your child living with you?",
              "Your household",
              220.0,
              "",
              Questions.childText);
        }
        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you live together at any time of the year with the other parent in one household?');
          _insert(
              'Did you live together at any time of the year with the other parent in one household?',
              'skip',
              'skip');

          //Question No 74
          //Ya container baad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "When was your child living with you?",
              "Your household",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you live together at any time of the year with the other parent in one household?');
          _insert(
              'Did you live together at any time of the year with the other parent in one household?',
              'Yes',
              'OK');

          //Question No 78
          return familyyesnoContainer("""

<p><strong>Joint household</strong></p>
<p>Please state whether <strong>for the whole of 2019</strong> you lived with the other parent in a joint household. If this applies to you, choose "Yes". Otherwise click "No".</p>
<p>A joint household is when both parents run the household together.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "Did you have a joint household with the other parent throughout the year?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer no 74
      else if (widget.CheckCompleteQuestion ==
              "When was your child living with you?" &&
          widget.CheckQuestion == "Your household") {
        DbHelper.insatance
            .deleteWithquestion('When was your child living with you?');
        _insert(
            'When was your child living with you?', Questions.childText, 'OK');

        //Question No 75
        return familyyesnoContainer("""

<p><strong>Division of childcare cost</strong></p>
<p>Select the answer * "Yes" *, if you want to equally divide the maximum amount between you. If you want to divide the amount differently, choose "No". Please note that in this case, the other parent must give their consent and you must file a joint application for this.</p>
<p><strong>YOUR TAXES</strong></p>
<p>In a separate tax assessment, each parent can deduct childcare costs that they incurred themselves. However, no more than half of the maximum amount of 4,000 euros.</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Would you like to split the maximum amount of your expenses for childcare costs between you evenly?",
            "Split equally",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 75
      else if (widget.CheckCompleteQuestion ==
              "Would you like to split the maximum amount of your expenses for childcare costs between you evenly?" &&
          widget.CheckQuestion == "Split equally") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to split the maximum amount of your expenses for childcare costs between you evenly?');
          _insert(
              'Would you like to split the maximum amount of your expenses for childcare costs between you evenly?',
              'No',
              'OK');

          //Question No 77
          return familycalculationContainer("""

<p><strong>Your maximum allowance for childcare costs</strong></p>
<p>Enter here the percentage of childcare costs which you paid for your child. This only involves the costs from 2019.</p>
<p>Usually the maximum allowance for childcare expenses is divided evenly. You can choose a different split, for example if you carried the entire costs yourself. To do this, the other parent must give their consent. This is done through an informal request.</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "What was your share of the maximum amount?",
              "Maximum amount",
              220.0,
              "percent",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to split the maximum amount of your expenses for childcare costs between you evenly?');
          _insert(
              'Would you like to split the maximum amount of your expenses for childcare costs between you evenly?',
              'skip',
              'skip');

          //Question No 77
          return familycalculationContainer("""

<p><strong>Your maximum allowance for childcare costs</strong></p>
<p>Enter here the percentage of childcare costs which you paid for your child. This only involves the costs from 2019.</p>
<p>Usually the maximum allowance for childcare expenses is divided evenly. You can choose a different split, for example if you carried the entire costs yourself. To do this, the other parent must give their consent. This is done through an informal request.</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "What was your share of the maximum amount?",
              "Maximum amount",
              220.0,
              "percent",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to split the maximum amount of your expenses for childcare costs between you evenly?');
          _insert(
              'Would you like to split the maximum amount of your expenses for childcare costs between you evenly?',
              'Yes',
              'OK');

          //Question no 63
          return familydifferentoptionContainer(
              """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
              "Benefits office",
              [
                "Baden-Württemberg Ost",
                "Baden-Württemberg West",
                "Bayern Nord",
                "Bayern Süd",
                "Berlin-Brandenburg",
                "Hessen",
                "Niedersachsen-Bremen",
                "Nord",
                "Nordrhein-Westfalen Nord",
                "Nordrhein-Westfalen Ost",
                "Nordrhein-Westfalen West",
                "Rheinland-Pfalz-Saarland",
                "Sachsen",
                "Sachsen-Anhalt - Thüringen",
                "Other"
              ],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 77
      else if (widget.CheckCompleteQuestion ==
              "What was your share of the maximum amount?" &&
          widget.CheckQuestion == "Maximum amount") {
        DbHelper.insatance
            .deleteWithquestion('What was your share of the maximum amount?');
        _insert('What was your share of the maximum amount?',
            Questions.childText, 'OK');

        //Question no 63
        return familydifferentoptionContainer(
            """

<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
            "Benefits office",
            [
              "Baden-Württemberg Ost",
              "Baden-Württemberg West",
              "Bayern Nord",
              "Bayern Süd",
              "Berlin-Brandenburg",
              "Hessen",
              "Niedersachsen-Bremen",
              "Nord",
              "Nordrhein-Westfalen Nord",
              "Nordrhein-Westfalen Ost",
              "Nordrhein-Westfalen West",
              "Rheinland-Pfalz-Saarland",
              "Sachsen",
              "Sachsen-Anhalt - Thüringen",
              "Other"
            ],
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 78
      else if (widget.CheckCompleteQuestion ==
              "Did you have a joint household with the other parent throughout the year?" &&
          widget.CheckQuestion == "Joint household") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you have a joint household with the other parent throughout the year?');
          _insert(
              'Did you have a joint household with the other parent throughout the year?',
              'No',
              'OK');

          //Question no 79
          //Ya container baad ma change hoga
          return familydateContainer("""

<p><strong>Time period of joint household</strong></p>
<p>Please enter here the time period in which you shared a joint household with the other parent of the child.</p>
<p>Only the time period in 2019 is relevant.</p>
<p>The essential characteristic of a joint household is shared finances.</p>
<p>If you are living together in a shared flat and have separate finances, this is not a joint household.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "When did you live in a joint household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you have a joint household with the other parent throughout the year?');
          _insert(
              'Did you have a joint household with the other parent throughout the year?',
              'skip',
              'skip');

          //Question no 79
          //Ya container baad ma change hoga
          return familydateContainer("""

<p><strong>Time period of joint household</strong></p>
<p>Please enter here the time period in which you shared a joint household with the other parent of the child.</p>
<p>Only the time period in 2019 is relevant.</p>
<p>The essential characteristic of a joint household is shared finances.</p>
<p>If you are living together in a shared flat and have separate finances, this is not a joint household.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "When did you live in a joint household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you have a joint household with the other parent throughout the year?');
          _insert(
              'Did you have a joint household with the other parent throughout the year?',
              'Yes',
              'OK');

          //Question no 81
          return familyyesnoContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Has the child been living in your household the entire year?",
              "Household with child",
              220.0,
              "",
              Questions.childText);
        }
      }

//Answer No 79
      else if (widget.CheckCompleteQuestion ==
              "When did you live in a joint household?" &&
          widget.CheckQuestion == "Joint household") {
        DbHelper.insatance
            .deleteWithquestion('When did you live in a joint household?');
        _insert('When did you live in a joint household?', Questions.childText,
            'OK');

        //Question No 80
        //Ya container baad ma change hoga
        return familydateContainer("""

<p><strong>Time period of separate households</strong></p>
<p>Please enter here the time period in which you did not share a joint household with the other parent of the child.</p>
<p>The essential characteristic of a joint household is shared finances.</p>
<p>If you are living together in a shared flat and have separate finances, this is not a joint household.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "For what period were you and the other parent living separately?",
            "Separate households",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 80
      else if (widget.CheckCompleteQuestion ==
              "For what period were you and the other parent living separately?" &&
          widget.CheckQuestion == "Separate households") {
        DbHelper.insatance.deleteWithquestion(
            'For what period were you and the other parent living separately?');
        _insert(
            'For what period were you and the other parent living separately?',
            Questions.childText,
            'OK');

        //Question No 74
        //Ya container baad ma change hoga
        return familydateContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "When was your child living with you?",
            "Your household",
            220.0,
            "",
            Questions.childText);
      }

//Answer No 81
      else if (widget.CheckCompleteQuestion ==
              "Has the child been living in your household the entire year?" &&
          widget.CheckQuestion == "Household with child") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Has the child been living in your household the entire year?');
          _insert(
              'Has the child been living in your household the entire year?',
              'No',
              'OK');

          //Question no 82
          //Ya container baad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>
""",
              "",
              "Child ${Questions.childLength}",
              "When did your child live in the joint household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Has the child been living in your household the entire year?');
          _insert(
              'Has the child been living in your household the entire year?',
              'skip',
              'skip');

          //Question no 82
          //Ya container baad ma change hoga
          return familydateContainer("""<h1>Coming Soon!</h1>
""",
              "",
              "Child ${Questions.childLength}",
              "When did your child live in the joint household?",
              "Joint household",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Has the child been living in your household the entire year?');
          _insert(
              'Has the child been living in your household the entire year?',
              'Yes',
              'OK');

          //Question No 75
          return familyyesnoContainer("""

<p><strong>Division of childcare cost</strong></p>
<p>Select the answer * "Yes" *, if you want to equally divide the maximum amount between you. If you want to divide the amount differently, choose "No". Please note that in this case, the other parent must give their consent and you must file a joint application for this.</p>
<p><strong>YOUR TAXES</strong></p>
<p>In a separate tax assessment, each parent can deduct childcare costs that they incurred themselves. However, no more than half of the maximum amount of 4,000 euros.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to split the maximum amount of your expenses for childcare costs between you evenly?",
              "Split equally",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 82
      else if (widget.CheckCompleteQuestion ==
              "When did your child live in the joint household?" &&
          widget.CheckQuestion == "Joint household") {
        DbHelper.insatance.deleteWithquestion(
            'When did your child live in the joint household?');
        _insert('When did your child live in the joint household?',
            Questions.childText, 'OK');

        //Question No 75
        return familyyesnoContainer("""

<p><strong>Division of childcare cost</strong></p>
<p>Select the answer * "Yes" *, if you want to equally divide the maximum amount between you. If you want to divide the amount differently, choose "No". Please note that in this case, the other parent must give their consent and you must file a joint application for this.</p>
<p><strong>YOUR TAXES</strong></p>
<p>In a separate tax assessment, each parent can deduct childcare costs that they incurred themselves. However, no more than half of the maximum amount of 4,000 euros.</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Would you like to split the maximum amount of your expenses for childcare costs between you evenly?",
            "Split equally",
            220.0,
            "",
            Questions.childText);
      }

      // ====== Care costs Ends ======

      // ====== Schools attended Starts ======

      //Answer No 61
      else if (widget.CheckCompleteQuestion ==
              "For how many schools did you pay tuition fees?" &&
          widget.CheckQuestion == "Schools attended") {
        DbHelper.insatance.deleteWithquestion(
            'For how many schools did you pay tuition fees?');
        _insert('For how many schools did you pay tuition fees?',
            Questions.schoolText, 'OK');

        //Question No 129
        return familydifferentoptionContainer(
            """

<p><strong>School fees &ndash; Brief summary</strong></p>
<ul>
<li>Indicate which type of graduation certificate is provided by the school to which you have paid the tuition fee.</li>
<li>Choose from the given possibilities.</li>
<li>Use the school's homepage if you are unsure.</li>
</ul>
<p><strong>WANT TO KNOW MORE? CONTINUE READING HERE.</strong></p>
<p>Things to keep in mind:</p>
<p>From the school that you paid tuition for A, choose the appropriate graduation certificate.</p>
<p><strong>Where can you find this information?</strong></p>
<p>You can find this information on the school's website or in other admittance paperwork for A.</p>
<p><strong>Why is this information needed?</strong></p>
<p>Paid tuition is only tax-relevant if the school provides a recognised qualification. This means a general or vocational graduation certificate, this may include primary school.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "What type of certification is getting from school no. ${Questions.schoolLength}?",
            "Certification Type",
            [
              "Secondary school diploma",
              "(Technical) university entrance qualification",
              "Primary school diploma",
              "Vocational training",
              "Bachelor/Master/Diploma",
              "None"
            ],
            220.0,
            "",
            Questions.schoolText);
      }

      //Answer No 129

      else if (widget.CheckCompleteQuestion ==
              "What type of certification is getting from school no. ${Questions.schoolLength}?" &&
          widget.CheckQuestion == "Certification Type") {
        if (widget.CheckAnswer[0] == "Secondary school diploma" ||
            widget.CheckAnswer[0] ==
                "(Technical) university entrance qualification" ||
            widget.CheckAnswer[0] == "Primary school diploma") {
          DbHelper.insatance.deleteWithquestion(
              'What type of certification is getting from school');
          _insert('What type of certification is getting from school',
              widget.CheckAnswer[0], 'OK');

          //Question No 130

          return familycalculationContainer("""

<p><strong>School fees: tuition costs</strong></p>
<p>Please enter how much paid in total school fees in 2019. This is only cost for actual tuition. Catering and accommodation costs should not be included.</p>
<p><strong>Important:</strong> The school must offer a recognised leaving certificate. This is usually a certificate in general eduction or a professional qualification.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "How much have you paid for lessons?",
              "Tuition fees",
              220.0,
              "calculation",
              Questions.schoolText);
        } else if (widget.CheckAnswer[0] == "Vocational training" ||
            widget.CheckAnswer[0] == "Bachelor/Master/Diploma" ||
            widget.CheckAnswer[0] == "None") {
          DbHelper.insatance.deleteWithquestion(
              'What type of certification is getting from school');
          _insert('What type of certification is getting from school',
              widget.CheckAnswer[0], 'OK');

          if (Questions.schoolLength <= Questions.totalSchool) {
            //Question No 129
            return familydifferentoptionContainer(
                """

<p><strong>School fees &ndash; Brief summary</strong></p>
<ul>
<li>Indicate which type of graduation certificate is provided by the school to which you have paid the tuition fee.</li>
<li>Choose from the given possibilities.</li>
<li>Use the school's homepage if you are unsure.</li>
</ul>
<p><strong>WANT TO KNOW MORE? CONTINUE READING HERE.</strong></p>
<p>Things to keep in mind:</p>
<p>From the school that you paid tuition for A, choose the appropriate graduation certificate.</p>
<p><strong>Where can you find this information?</strong></p>
<p>You can find this information on the school's website or in other admittance paperwork for A.</p>
<p><strong>Why is this information needed?</strong></p>
<p>Paid tuition is only tax-relevant if the school provides a recognised qualification. This means a general or vocational graduation certificate, this may include primary school.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Child ${Questions.childLength}",
                "What type of certification is getting from school no. ${Questions.schoolLength}?",
                "Certification Type",
                [
                  "Secondary school diploma",
                  "(Technical) university entrance qualification",
                  "Primary school diploma",
                  "Vocational training",
                  "Bachelor/Master/Diploma",
                  "None"
                ],
                220.0,
                "",
                Questions.schoolText);
          } else {
            //Question No 133
            return familyyesnoContainer("""

<p><strong>Division of school fees</strong></p>
<p>Please state whether the maximum allowance for school fees is to be divided equally with you and your partner. If this applies to you, then select "Yes", otherwise click "No". Even if you're not married, you can choose a different split. This can be useful in certain cases.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can write off 30% of the paid school fees up to a maximum of 5,000 euros. As a couple, this maximum allowance is equally divided among you so that you and your partner could each deduct a maximum of 2,500 euros. However, you can choose a different split.</p>
<p><strong>EXAMPLE TO CLARIFY:</strong></p>
<p>your daughter goes to a private school and you paid 11,000 euros in school fees in 2019. Of this amount, you paid 10,000 euros and your partner 1,000 euros.</p>
<p>If you split the maximum allowance equally, you could write off 30% of 10,000 euros = 3,000 euros, up to a maximum, however, of only 2,500 euros in your tax return. With your partner, it would be 30% of 1,000 euros = 300 euros. As a result, 500 euros of the total possible deductible amount could not be written off.</p>
<p>If you choose a different ratio, for example, in proportion to the paid expenses, the maximum amount could be written off. Then, you could deduct the full 3,000 euros.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Child ${Questions.childLength}",
                "Would you like to split the maximum amount of your expenses for school fees between you evenly?",
                "50-50 split school fees",
                220.0,
                "",
                Questions.childText);
          }
        }
      }

      //Answer No 130
      else if (widget.CheckCompleteQuestion ==
              "How much have you paid for lessons?" &&
          widget.CheckQuestion == "Tuition fees") {
        DbHelper.insatance
            .deleteWithquestion('How much have you paid for lessons?');
        _insert(
            'How much have you paid for lessons?', Questions.schoolText, 'OK');

        //Question No 131
        return familycalculationContainer("""

<p><strong>School fees paid by other parent: tuition costs</strong></p>
<p>Please enter how much the other parent paid in total school fees in 2019. This is only cost for actual tuition. Catering and accommodation costs should not be included.</p>
<p><strong>Important</strong>: The school must offer a recognised leaving certificate. This is usually a certificate in general eduction or a professional qualification.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "How much did the other parent pay toward school fees?",
            "Amount school fees (partner)",
            220.0,
            "calculation",
            Questions.schoolText);
      }

      //Answer No 131
      else if (widget.CheckCompleteQuestion ==
              "How much did the other parent pay toward school fees?" &&
          widget.CheckQuestion == "Amount school fees (partner)") {
        DbHelper.insatance.deleteWithquestion(
            'How much did the other parent pay toward school fees?');
        _insert('How much did the other parent pay toward school fees?',
            Questions.schoolText, 'OK');

        //Question No 132
        return familycalculationContainer("""<h1>Coming Soon!</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Which school did your child attend?",
            "Name of school",
            220.0,
            "",
            Questions.schoolText);
      }

      //Answer No 132
      else if (widget.CheckCompleteQuestion ==
              "Which school did your child attend?" &&
          widget.CheckQuestion == "Name of school") {
        DbHelper.insatance
            .deleteWithquestion('Which school did your child attend?');
        _insert(
            'Which school did your child attend?', Questions.schoolText, 'OK');

        if (Questions.schoolLength <= Questions.totalSchool) {
          //Question No 129
          return familydifferentoptionContainer(
              """

<p><strong>School fees &ndash; Brief summary</strong></p>
<ul>
<li>Indicate which type of graduation certificate is provided by the school to which you have paid the tuition fee.</li>
<li>Choose from the given possibilities.</li>
<li>Use the school's homepage if you are unsure.</li>
</ul>
<p><strong>WANT TO KNOW MORE? CONTINUE READING HERE.</strong></p>
<p>Things to keep in mind:</p>
<p>From the school that you paid tuition for A, choose the appropriate graduation certificate.</p>
<p><strong>Where can you find this information?</strong></p>
<p>You can find this information on the school's website or in other admittance paperwork for A.</p>
<p><strong>Why is this information needed?</strong></p>
<p>Paid tuition is only tax-relevant if the school provides a recognised qualification. This means a general or vocational graduation certificate, this may include primary school.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "What type of certification is getting from school no. ${Questions.schoolLength}?",
              "Certification Type",
              [
                "Secondary school diploma",
                "(Technical) university entrance qualification",
                "Primary school diploma",
                "Vocational training",
                "Bachelor/Master/Diploma",
                "None"
              ],
              220.0,
              "",
              Questions.schoolText);
        } else {
          //Question No 133
          return familyyesnoContainer("""

<p><strong>Division of school fees</strong></p>
<p>Please state whether the maximum allowance for school fees is to be divided equally with you and your partner. If this applies to you, then select "Yes", otherwise click "No". Even if you're not married, you can choose a different split. This can be useful in certain cases.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can write off 30% of the paid school fees up to a maximum of 5,000 euros. As a couple, this maximum allowance is equally divided among you so that you and your partner could each deduct a maximum of 2,500 euros. However, you can choose a different split.</p>
<p><strong>EXAMPLE TO CLARIFY:</strong></p>
<p>your daughter goes to a private school and you paid 11,000 euros in school fees in 2019. Of this amount, you paid 10,000 euros and your partner 1,000 euros.</p>
<p>If you split the maximum allowance equally, you could write off 30% of 10,000 euros = 3,000 euros, up to a maximum, however, of only 2,500 euros in your tax return. With your partner, it would be 30% of 1,000 euros = 300 euros. As a result, 500 euros of the total possible deductible amount could not be written off.</p>
<p>If you choose a different ratio, for example, in proportion to the paid expenses, the maximum amount could be written off. Then, you could deduct the full 3,000 euros.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "Would you like to split the maximum amount of your expenses for school fees between you evenly?",
              "50-50 split school fees",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 133
      else if (widget.CheckCompleteQuestion ==
              "Would you like to split the maximum amount of your expenses for school fees between you evenly?" &&
          widget.CheckQuestion == "50-50 split school fees") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to split the maximum amount of your expenses for school fees between you evenly?');
          _insert(
              'Would you like to split the maximum amount of your expenses for school fees between you evenly?',
              'No',
              'OK');

          //Question no 134
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What was your share of the total amount?",
              "Your share",
              220.0,
              "percent",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to split the maximum amount of your expenses for school fees between you evenly?');
          _insert(
              'Would you like to split the maximum amount of your expenses for school fees between you evenly?',
              'skip',
              'skip');

          //Question no 134
          return familycalculationContainer("""<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What was your share of the total amount?",
              "Your share",
              220.0,
              "percent",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Would you like to split the maximum amount of your expenses for school fees between you evenly?');
          _insert(
              'Would you like to split the maximum amount of your expenses for school fees between you evenly?',
              'Yes',
              'OK');

//Question no 63
          return familydifferentoptionContainer(
              """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
              "Benefits office",
              [
                "Baden-Württemberg Ost",
                "Baden-Württemberg West",
                "Bayern Nord",
                "Bayern Süd",
                "Berlin-Brandenburg",
                "Hessen",
                "Niedersachsen-Bremen",
                "Nord",
                "Nordrhein-Westfalen Nord",
                "Nordrhein-Westfalen Ost",
                "Nordrhein-Westfalen West",
                "Rheinland-Pfalz-Saarland",
                "Sachsen",
                "Sachsen-Anhalt - Thüringen",
                "Other"
              ],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 134
      else if (widget.CheckCompleteQuestion ==
              "What was your share of the total amount?" &&
          widget.CheckQuestion == "Your share") {
        DbHelper.insatance
            .deleteWithquestion('What was your share of the total amount?');
        _insert('What was your share of the total amount?', 'Yes', 'OK');

        //Question no 63
        return familydifferentoptionContainer(
            """

<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
            "Benefits office",
            [
              "Baden-Württemberg Ost",
              "Baden-Württemberg West",
              "Bayern Nord",
              "Bayern Süd",
              "Berlin-Brandenburg",
              "Hessen",
              "Niedersachsen-Bremen",
              "Nord",
              "Nordrhein-Westfalen Nord",
              "Nordrhein-Westfalen Ost",
              "Nordrhein-Westfalen West",
              "Rheinland-Pfalz-Saarland",
              "Sachsen",
              "Sachsen-Anhalt - Thüringen",
              "Other"
            ],
            220.0,
            "",
            Questions.childText);
      }

      // ====== Schools attended Ends ======

      // ====== Health Insurance Contribution Starts ======

      //Answer No 62
      else if (widget.CheckCompleteQuestion ==
              "What type of contract is the health insurance policy?" &&
          widget.CheckQuestion == "Supplementary health insurance") {
        if (widget.CheckAnswer[0] == "Domestic health insurance") {
          DbHelper.insatance.deleteWithquestion(
              'What type of contract is the health insurance policy?');
          _insert('What type of contract is the health insurance policy?',
              'Domestic health insurance', 'OK');

          //Question No 135
          return familytwooptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Who is the contractual partner of this health insurance?",
              "Contracting party",
              ["Me", "My child"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Foreign health insurance") {
          DbHelper.insatance.deleteWithquestion(
              'What type of contract is the health insurance policy?');
          _insert('What type of contract is the health insurance policy?',
              'Foreign health insurance', 'OK');

          //Question No 148
          return familytwooptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Who is the contractual partner of this health insurance?",
              "Contracting party",
              ["Me", "My child"],
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer no 135
      else if (widget.CheckCompleteQuestion ==
              "Who is the contractual partner of this health insurance?" &&
          widget.CheckQuestion == "Contracting party") {
        if (widget.CheckAnswer[0] == "Me") {
          DbHelper.insatance.deleteWithquestion(
              'Who is the contractual partner of this health insurance?');
          _insert('Who is the contractual partner of this health insurance?',
              'Me', 'OK');

          //Question No 136

          return familycalculationContainer("""
<p><strong>Your child's health insurance contributions</strong></p>
<p>Please indicate how high the contributions were for your child's basic health insurance. Remember, only contributions from 2019 are relevant.</p>
<p><strong>Please enter the total</strong>.</p>
<p>Then we can make them tax deductible.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay for the basic health insurance of your child?",
              "Basic child health insurance",
              220.0,
              "calculation",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "My child") {
          DbHelper.insatance.deleteWithquestion(
              'Who is the contractual partner of this health insurance?');
          _insert('Who is the contractual partner of this health insurance?',
              'My child', 'OK');

          //Question No 141

          return familycalculationContainer("""
<p><strong>Your child's health insurance contributions</strong></p>
<p>Please indicate how high the contributions were for your child's basic health insurance. Remember, only contributions from 2019 are relevant.</p>
<p><strong>Please enter the total</strong>.</p>
<p>Then we can make them tax deductible.</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay for the basic health insurance for your child?",
              "Basic child health insurance",
              220.0,
              "calculation",
              Questions.childText);
        }
      }

      //Answer No 136
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay for the basic health insurance of your child?" &&
          widget.CheckQuestion == "Basic child health insurance") {
        DbHelper.insatance.deleteWithquestion(
            'How much did you pay for the basic health insurance of your child?');
        _insert(
            'How much did you pay for the basic health insurance of your child?',
            Questions.childText,
            'OK');

        //Question No 137

        return familycalculationContainer("""
<p><strong>Your child's basic nursing care insurance</strong></p>
<p>Please indicate how high the contributions were for your child's basic nursing care insurance. Remember, only contributions from 2019 are relevant.</p>
<p><strong>Please enter the total.</strong></p>
<p>Then we can make them tax deductible.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "How much did you pay for the basic nursing care insurance for your child?",
            "Basic nursing care insurance - child",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 137
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay for the basic nursing care insurance for your child?" &&
          widget.CheckQuestion == "Basic nursing care insurance - child") {
        DbHelper.insatance.deleteWithquestion(
            'How much did you pay for the basic nursing care insurance for your child?');
        _insert(
            'How much did you pay for the basic nursing care insurance for your child?',
            Questions.childText,
            'OK');

        //Question No 138
        return familyyesnoContainer("""

<p><strong>Rebates from your child's insurance</strong></p>
<p>Please state whether you received any rebates from the health and nursing care insurance of your child in 2019. Choose "Yes" or "No" accordingly.</p>
<p>These reduce the deductible amount of health and nursing care insurance contributions.</p>
<p>You can find this information in your health insurance documents.</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive refunds from your child's health insurance?",
            "Health insurance refunds - child",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 138
      else if (widget.CheckCompleteQuestion ==
              "Did you receive refunds from your child's health insurance?" &&
          widget.CheckQuestion == "Health insurance refunds - child") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive refunds from your childs health insurance?');
          _insert('Did you receive refunds from your childs health insurance?',
              'No', 'OK');

          //QuestionNo 139
          return familycalculationContainer("""

<p><strong>Your child's supplementary health &amp; nursing care insurance</strong></p>
<p>Please enter here how high the contributions were for the additional health and nursing care insurance of your child. Note that we mean contributions you've paid in 2019.</p>
<p><strong>Please enter the total.</strong></p>
<p>This could be:</p>
<ul>
<li>contributions for optional supplementary nursing care insurance</li>
<li>fees for optional services (for example dental insurance)</li>
<li>foreign travel insurance</li>
</ul>
<p>By entering the total we can correctly determine what amount can be written off.</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay for supplementary health and nursing care insurance for your child?",
              "Supplementary health insurance",
              220.0,
              "calculation",
              Questions.childText);
        }
        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive refunds from your childs health insurance?');
          _insert('Did you receive refunds from your childs health insurance?',
              'skip', 'skip');

          //QuestionNo 139
          return familycalculationContainer("""

<p><strong>Your child's supplementary health &amp; nursing care insurance</strong></p>
<p>Please enter here how high the contributions were for the additional health and nursing care insurance of your child. Note that we mean contributions you've paid in 2019.</p>
<p><strong>Please enter the total.</strong></p>
<p>This could be:</p>
<ul>
<li>contributions for optional supplementary nursing care insurance</li>
<li>fees for optional services (for example dental insurance)</li>
<li>foreign travel insurance</li>
</ul>
<p>By entering the total we can correctly determine what amount can be written off.</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "How much did you pay for supplementary health and nursing care insurance for your child?",
              "Supplementary health insurance",
              220.0,
              "calculation",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive refunds from your childs health insurance?');
          _insert('Did you receive refunds from your childs health insurance?',
              'Yes', 'OK');

          //Question No 140
          return familycalculationContainer("""

<p><strong>Amount of rebates from your child's insurance</strong></p>
<p>Please state how much you received in rebates from the health &amp; nursing care insurance of your child. Please note we are talking about rebates from 2019.</p>
<p>These reduce the deductible amount of health and nursing care insurance contributions.</p>
<p>You can find this information in your health insurance. documents.</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "How much did you receive in refunds?",
              "Health insurance refunds - child",
              220.0,
              "calculation",
              Questions.childText);
        }
      }

      //Answer No 140
      else if (widget.CheckCompleteQuestion ==
              "How much did you receive in refunds?" &&
          widget.CheckQuestion == "Health insurance refunds - child") {
        DbHelper.insatance
            .deleteWithquestion('How much did you receive in refunds?');
        _insert(
            'How much did you receive in refunds?', Questions.childText, 'OK');

        //QuestionNo 139
        return familycalculationContainer("""
<p><strong>Your child's supplementary health &amp; nursing care insurance</strong></p>
<p>Please enter here how high the contributions were for the additional health and nursing care insurance of your child. Note that we mean contributions you've paid in 2019.</p>
<p><strong>Please enter the total.</strong></p>
<p>This could be:</p>
<ul>
<li>contributions for optional supplementary nursing care insurance</li>
<li>fees for optional services (for example dental insurance)</li>
<li>foreign travel insurance</li>
</ul>
<p>By entering the total we can correctly determine what amount can be written off.</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "How much did you pay for supplementary health and nursing care insurance for your child?",
            "Supplementary health insurance",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 139
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay for supplementary health and nursing care insurance for your child?" &&
          widget.CheckQuestion == "Supplementary health insurance") {
        DbHelper.insatance.deleteWithquestion(
            'How much did you pay for supplementary health and nursing care insurance for your child?');
        _insert(
            'How much did you pay for supplementary health and nursing care insurance for your child?',
            Questions.childText,
            'OK');

        //Question no 63
        return familydifferentoptionContainer(
            """

<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
            "Benefits office",
            [
              "Baden-Württemberg Ost",
              "Baden-Württemberg West",
              "Bayern Nord",
              "Bayern Süd",
              "Berlin-Brandenburg",
              "Hessen",
              "Niedersachsen-Bremen",
              "Nord",
              "Nordrhein-Westfalen Nord",
              "Nordrhein-Westfalen Ost",
              "Nordrhein-Westfalen West",
              "Rheinland-Pfalz-Saarland",
              "Sachsen",
              "Sachsen-Anhalt - Thüringen",
              "Other"
            ],
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 141
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay for the basic health insurance for your child?" &&
          widget.CheckQuestion == "Basic child health insurance") {
        DbHelper.insatance.deleteWithquestion(
            'How much did you pay for the basic health insurance for your child?');
        _insert(
            'How much did you pay for the basic health insurance for your child?',
            Questions.childText,
            'OK');

        //Question No 142
        return familycalculationContainer("""

<p><strong>Entitled to sick pay: child</strong></p>
<p>You can find this information on your <strong>certificate of insurance</strong>.</p>
<p>The contribution for entitlement to sick pay is <strong>not fully tax deductible</strong>.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "How much the refunds relate to contributions that entitle your child to sick pay?",
            "Thereof sick pay",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 142
      else if (widget.CheckCompleteQuestion ==
              "How much the refunds relate to contributions that entitle your child to sick pay?" &&
          widget.CheckQuestion == "Thereof sick pay") {
        DbHelper.insatance.deleteWithquestion(
            'How much the refunds relate to contributions that entitle your child to sick pay?');
        _insert(
            'How much the refunds relate to contributions that entitle your child to sick pay?',
            Questions.childText,
            'OK');

        //Question No 143
        return familycalculationContainer("""

<p><strong>Your child's basic nursing care insurance</strong></p>
<p>Please indicate how high the contributions were for your child's basic nursing care insurance. Remember, only contributions from 2019 are relevant.</p>
<p><strong>Please enter the total.</strong></p>
<p>Then we can make them tax deductible.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "How much did you pay for the basic nursing care insurance for your child?",
            "Basic nursing care insurance for child",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 143
      else if (widget.CheckCompleteQuestion ==
              "How much did you pay for the basic nursing care insurance for your child?" &&
          widget.CheckQuestion == "Basic nursing care insurance for child") {
        DbHelper.insatance.deleteWithquestion(
            'How much did you pay for the basic nursing care insurance for your child?');
        _insert(
            'How much did you pay for the basic nursing care insurance for your child?',
            Questions.childText,
            'OK');

        //Question No 144
        return familyyesnoContainer("""

<p><strong>Rebates from your child's insurance</strong></p>
<p>Please state whether you received any rebates from the health and nursing care insurance of your child in 2019. Choose "Yes" or "No" accordingly.</p>
<p>These reduce the deductible amount of health and nursing care insurance contributions.</p>
<p>You can find this information in your health insurance documents.</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive refunds from your health insurance?",
            "Health insurance refunds - child",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 144
      else if (widget.CheckCompleteQuestion ==
              "Did you receive refunds from your health insurance?" &&
          widget.CheckQuestion == "Health insurance refunds - child") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive refunds from your health insurance?');
          _insert('Did you receive refunds from your health insurance?', 'No',
              'OK');

          //QuestionNo 145

        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive refunds from your health insurance?');
          _insert('Did you receive refunds from your health insurance?', 'skip',
              'skip');

          //QuestionNo 145

        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive refunds from your health insurance?');
          _insert('Did you receive refunds from your health insurance?', 'Yes',
              'OK');

          //Question No 147
          return familycalculationContainer("""

<p><strong>Amount of rebates from your child's insurance</strong></p>
<p>Please state how much you received in rebates from the health &amp; nursing care insurance of your child. Please note we are talking about rebates from 2019.</p>
<p>These reduce the deductible amount of health and nursing care insurance contributions.</p>
<p>You can find this information in your health insurance. documents.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "What was the amount of the refund you received from your child's health insurance?",
              "Refund amount - child",
              220.0,
              "calculation",
              Questions.childText);
        }
      }

      //Answer No 147
      else if (widget.CheckCompleteQuestion ==
              "What was the amount of the refund you received from your child's health insurance?" &&
          widget.CheckQuestion == "Refund amount - child") {
        DbHelper.insatance.deleteWithquestion(
            'What was the amount of the refund you received from your childs health insurance?');
        _insert(
            'What was the amount of the refund you received from your childs health insurance?',
            Questions.childText,
            'OK');

        //Question No 148
        return familycalculationContainer("""

<p><strong>Entitled to sick pay: child</strong></p>
<p>You can find this information on your <strong>certificate of insurance</strong>.</p>
<p>The contribution for entitlement to sick pay is <strong>not fully tax deductible</strong>.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "How much of the refund relates to contributions that entitle your child to sick pay?",
            "Refund of child sick pay",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 148
      else if (widget.CheckCompleteQuestion ==
              "How much of the refund relates to contributions that entitle your child to sick pay?" &&
          widget.CheckQuestion == "Refund of child sick pay") {
        DbHelper.insatance.deleteWithquestion(
            'How much of the refund relates to contributions that entitle your child to sick pay?');
        _insert(
            'How much of the refund relates to contributions that entitle your child to sick pay?',
            Questions.childText,
            'OK');

        //QuestionNo 145
        return familyyesnoContainer("""

<p><strong>Health insurance grants for your child</strong></p>
<p>Please state whether you received grants for your child's health insurance. Please note that this is the grants from the year 2019. If this applies to you, select 'Yes'. Otherwise click "No".</p>
<p>For example, your employer may have paid out grants to you.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Has your child received grants for health insurance from third parties?",
            "Grants third parties",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 145
      else if (widget.CheckCompleteQuestion ==
              "Has your child received grants for health insurance from third parties?" &&
          widget.CheckQuestion == "Grants third parties") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Has your child received grants for health insurance from third parties?');
          _insert(
              'Has your child received grants for health insurance from third parties?',
              'No',
              'OK');

          //Question no 63
          return familydifferentoptionContainer(
              """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
              "Benefits office",
              [
                "Baden-Württemberg Ost",
                "Baden-Württemberg West",
                "Bayern Nord",
                "Bayern Süd",
                "Berlin-Brandenburg",
                "Hessen",
                "Niedersachsen-Bremen",
                "Nord",
                "Nordrhein-Westfalen Nord",
                "Nordrhein-Westfalen Ost",
                "Nordrhein-Westfalen West",
                "Rheinland-Pfalz-Saarland",
                "Sachsen",
                "Sachsen-Anhalt - Thüringen",
                "Other"
              ],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Has your child received grants for health insurance from third parties?');
          _insert(
              'Has your child received grants for health insurance from third parties?',
              'skip',
              'skip');

          //Question no 63
          return familydifferentoptionContainer(
              """<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
              "Benefits office",
              [
                "Baden-Württemberg Ost",
                "Baden-Württemberg West",
                "Bayern Nord",
                "Bayern Süd",
                "Berlin-Brandenburg",
                "Hessen",
                "Niedersachsen-Bremen",
                "Nord",
                "Nordrhein-Westfalen Nord",
                "Nordrhein-Westfalen Ost",
                "Nordrhein-Westfalen West",
                "Rheinland-Pfalz-Saarland",
                "Sachsen",
                "Sachsen-Anhalt - Thüringen",
                "Other"
              ],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Has your child received grants for health insurance from third parties?');
          _insert(
              'Has your child received grants for health insurance from third parties?',
              'Yes',
              'OK');

          //Question No 146
          return familycalculationContainer("""

<p><strong>Health insurance grants for your child</strong></p>
<p>Please state the total health insurance grants you received for your child's health insurance. Please note we only mean grants from the 2019. If this applies to you, select 'Yes'. Otherwise click "No".</p>
<p>For example, your employer may have paid out grants to you.</p>
<p>You can find this information in the corresponding documents from your employer.</p>
<p>&nbsp;</p>

""", "", "Child ${Questions.childLength}", "What was the amount of the grants?",
              "Grant amount", 220.0, "calculation", Questions.childText);
        }
      }

      //Answer No 146
      else if (widget.CheckCompleteQuestion ==
              "What was the amount of the grants?" &&
          widget.CheckQuestion == "Grant amount") {
        DbHelper.insatance
            .deleteWithquestion('What was the amount of the grants?');
        _insert(
            'What was the amount of the grants?', Questions.childText, 'OK');

        //Question no 63
        return familydifferentoptionContainer(
            """

<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
            "Benefits office",
            [
              "Baden-Württemberg Ost",
              "Baden-Württemberg West",
              "Bayern Nord",
              "Bayern Süd",
              "Berlin-Brandenburg",
              "Hessen",
              "Niedersachsen-Bremen",
              "Nord",
              "Nordrhein-Westfalen Nord",
              "Nordrhein-Westfalen Ost",
              "Nordrhein-Westfalen West",
              "Rheinland-Pfalz-Saarland",
              "Sachsen",
              "Sachsen-Anhalt - Thüringen",
              "Other"
            ],
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 148
      else if (widget.CheckCompleteQuestion ==
              "How much was paid for the foreign health insurance?" &&
          widget.CheckQuestion == "Amount foreign health insurance") {
        DbHelper.insatance.deleteWithquestion(
            'How much was paid for the foreign health insurance?');
        _insert('How much was paid for the foreign health insurance?',
            Questions.childText, 'OK');

        //Question No 149
        return familycalculationContainer("""
<p><strong>Contribution amount to the the foreign long-term care insurance</strong></p>
<p>Please enter here the <strong>contribution amount from the year 2019 to the foreign long-term care (nursing) insurance.</strong></p>
<p>The amount is stated on the insurance certificate that was issued when the insurance was taken out.</p>
<p>Do not enter any amounts on the income tax certificate in line 26 ("Arbeitnehmerbeitr&auml;ge zur sozialen Pflegeversicherung").</p>
<p>Foreign health insurance is insurance taken out abroad (not travel insurance).</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "How much did you pay for the foreign long-term care (nursing) insurance?",
            "Amount foreign long-term insurance",
            220.0,
            "calculation",
            Questions.childText);
      }

      //Answer No 149
      else if (widget.CheckCompleteQuestion ==
              "How much was paid for the foreign health insurance?" &&
          widget.CheckQuestion == "Amount foreign health insurance") {
        DbHelper.insatance.deleteWithquestion(
            'How much was paid for the foreign health insurance?');
        _insert('How much was paid for the foreign health insurance?',
            Questions.childText, 'OK');

        //Question No 150
        return familyyesnoContainer("""
<p><strong>Child premium refunds</strong></p>
<p>Indicate here whether 2019 contributions for the child's foreign health insurance were refunded. Choose "Yes" or "No".</p>
<p>Refunds reduce the deductible health and nursing insurance contributions.</p>
<p>This information can be found in the health insurance documents.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Did you receive reimbursements from the health insurance provider?",
            "Reimbursement",
            220.0,
            "",
            Questions.childText);
      }

//Answer No 150
      else if (widget.CheckCompleteQuestion ==
              "Did you receive reimbursements from the health insurance provider?" &&
          widget.CheckQuestion == "Reimbursement") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive reimbursements from the health insurance provider?');
          _insert(
              'Did you receive reimbursements from the health insurance provider?',
              'No',
              'OK');

          //Question no 151
          return familycalculationContainer("""
<p><strong>Claim for sick pay: child</strong></p>
<p>This information is contained in the <strong>Bescheinigung der Krankenkasse</strong> (certificate of health coverage).</p>
<p>However, the contribution portion that results in an entitlement to sick pay is <strong>not fully deductible</strong>.</p>

""",
              "",
              "Child ${Questions.childLength}",
              "How much of your contribution entitles you to sick pay?",
              "Sick pay claim",
              220.0,
              "calculation",
              Questions.childText);
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive reimbursements from the health insurance provider?');
          _insert(
              'Did you receive reimbursements from the health insurance provider?',
              'skip',
              'skip');

          //Question no 151
          return familycalculationContainer("""
<p><strong>Claim for sick pay: child</strong></p>
<p>This information is contained in the <strong>Bescheinigung der Krankenkasse</strong> (certificate of health coverage).</p>
<p>However, the contribution portion that results in an entitlement to sick pay is <strong>not fully deductible</strong>.</p>

""",
              "",
              "Child ${Questions.childLength}",
              "How much of your contribution entitles you to sick pay?",
              "Sick pay claim",
              220.0,
              "calculation",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did you receive reimbursements from the health insurance provider?');
          _insert(
              'Did you receive reimbursements from the health insurance provider?',
              'Yes',
              'OK');

          //Question no 152
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "What amount was reimbursed?",
              "Sick pay claim",
              220.0,
              "Amount reimbursement",
              Questions.childText);
        }
      }

      //Answer No 152
      else if (widget.CheckCompleteQuestion == "What amount was reimbursed?" &&
          widget.CheckQuestion == "Amount reimbursement") {
        DbHelper.insatance.deleteWithquestion('What amount was reimbursed?');
        _insert('What amount was reimbursed?', Questions.childText, 'OK');

        //Question no 151
        return familycalculationContainer("""
<p><strong>Claim for sick pay: child</strong></p>
<p>This information is contained in the <strong>Bescheinigung der Krankenkasse</strong> (certificate of health coverage).</p>
<p>However, the contribution portion that results in an entitlement to sick pay is <strong>not fully deductible</strong>.</p>
""",
            "",
            "Child ${Questions.childLength}",
            "How much of your contribution entitles you to sick pay?",
            "Sick pay claim",
            220.0,
            "calculation",
            Questions.childText);
      }

//Answer No 151
      else if (widget.CheckCompleteQuestion ==
              "How much of your contribution entitles you to sick pay?" &&
          widget.CheckQuestion == "Sick pay claim") {
        DbHelper.insatance.deleteWithquestion(
            'How much of your contribution entitles you to sick pay?');
        _insert('How much of your contribution entitles you to sick pay?',
            Questions.childText, 'OK');

        //Question no 63
        return familydifferentoptionContainer(
            """

<p><strong>Designated benefits office</strong></p>
<p>Please select you designated benefits office that is responsible for your child benefits.</p>
<p>If you're unsure which benefits office responsible, look on your bank statement and search for the transfer of the child benefits.</p>
<p>&nbsp;</p>

""",
            "",
            "Child ${Questions.childLength}",
            "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?",
            "Benefits office",
            [
              "Baden-Württemberg Ost",
              "Baden-Württemberg West",
              "Bayern Nord",
              "Bayern Süd",
              "Berlin-Brandenburg",
              "Hessen",
              "Niedersachsen-Bremen",
              "Nord",
              "Nordrhein-Westfalen Nord",
              "Nordrhein-Westfalen Ost",
              "Nordrhein-Westfalen West",
              "Rheinland-Pfalz-Saarland",
              "Sachsen",
              "Sachsen-Anhalt - Thüringen",
              "Other"
            ],
            220.0,
            "",
            Questions.childText);
      }

      // ====== Health Insurance Contributions End ======

      // ====Cost due to disability Starts ====== //

      //Answer No 153
      else if (widget.CheckCompleteQuestion ==
              "Do you wish to transfer your child's disability flat-rate amount to yourself?" &&
          widget.CheckQuestion == "Transfer of flat-rate amount") {
        if (widget.CheckAnswer[0] == "No") {
          return familymultipleoptionsContainer(
              """<p><strong>Living situation of your child</strong></p>
<p>Choose the options that apply to you here. You can choose several answers.</p>
<p><strong>WITH US PARENTS</strong></p>
<p>Your child lives with you. You live in a household with your (spouse) partner and your child.</p>
<p><strong>PATCHWORK FAMILY</strong></p>
<p>A patchwork family is when at least one partner brings one or more children into the new relationship. You don't have to be married. Both partners can have children and bring them into the new relationship.</p>
<p><strong>ONLY WITH ME</strong></p>
<p>You live alone with your child, so separate from the other parent and are therefore a single parent.</p>
<p><strong>WITH THE OTHER PARENT</strong></p>
<p>The other parent lives with the child because you are separated, for example.</p>
<p><strong>AT THE TRAINING LOCATION</strong></p>
<p>Your child has started an apprenticeship or a degree and moved to the place of training.</p>
<p><strong>WITH STEP-GRANDPARENTS OR GRANDPARENTS</strong></p>
<p>Your child lives in the household of grandparents or stepparents.</p>
<p><strong>SOMEWHERE ELSE</strong></p>
<p>None of the above options applies to your child.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "Where did your child live?",
              "Living situation child",
              [
                "With us parents",
                "Patchwork family",
                "Only with me",
                "With the other parent",
                "At place of training",
                "With Step-/Grandparents",
                "Somewhere else"
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
              430.0,
              "",
              Questions.childText);
//           DbHelper.insatance.deleteWithquestion(
//               'Do you wish to transfer your childs disability flat-rate amount to yourself?');
//           _insert(
//               'Do you wish to transfer your childs disability flat-rate amount to yourself?',
//               'No',
//               'OK');

//           if (Questions.childrenLive == "With us parents") {
//             //Question No 7
//             return familyyesnoContainer(
//                 """<p><strong>Address of the other parent</strong></p>
// <p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
// <p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
// <p> </p>""",
//                 "",
//                 "Child ${Questions.childLength}",
//                 "Do you know the details of the other parent?",
//                 "Other parent's details",
//                 220.0,
//                 "",
//                 Questions.childText);
//           } else if (Questions.childrenLive == "Patchwork family") {
//             //Question No 8
//             return familydifferentoptionContainer(
//                 """<p><strong>Relationship with child</strong></p>
// <p>Please specify what type of relationship you had to the child. Type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
// <p><strong>BIOLOGICAL CHILD</strong></p>
// <p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
// <p><strong>ADOPTED CHILD</strong></p>
// <p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
// <p><strong>FOSTER CHILD</strong></p>
// <p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
// <p><strong>GRANDCHILD</strong></p>
// <p>You can also specify grandchildren. But only under the conditions that you have an obligation to support the child and the child lives with you.</p>
// <p><strong>STEPCHILD</strong></p>
// <p>Stepchildren are treated in a similar way to grandchildren. You can deduct expenditures if the child lives in your household and you have an obligation to support them.</p>
// <p> </p>
// <p> </p>""",
//                 "",
//                 "Child ${Questions.childLength}",
//                 "What relationship existed between you and the child?",
//                 "Relationship to child",
//                 [
//                   "Biological child",
//                   "Adopted child",
//                   "Foster child",
//                   "Grandchild",
//                   "Stepchild"
//                 ],
//                 220.0,
//                 "",
//                 Questions.childText);
//           } else if (Questions.childrenLive == "Only with me") {
//             //Question No 9
//             return familycalculationContainer(
//                 """<p><strong>Your child's tax ID</strong></p>
// <p>Please your child's tax ID number.</p>
// <p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
// <p> </p>""",
//                 "",
//                 "Child ${Questions.childLength}",
//                 "Enter your child's Tax-ID.",
//                 "Tax-ID child",
//                 220.0,
//                 "tax",
//                 Questions.childText);
//           } else if (Questions.childrenLive == "With the other parent" ||
//               Questions.childrenLive == "At place of training" ||
//               Questions.childrenLive == "With Step-/Grandparents" ||
//               Questions.childrenLive == "Somewhere else") {
//             //Question No 10
//             return familycalculationContainer(
//                 """<p><strong>Number of places of residence of your child</strong></p>
// <p>Please enter here in how many places your child lived in 2019. For this, you enter the exact number of locations.</p>
// <p><strong>Important:</strong></p>
// <p>If your child moved with you, you do not need to specify this here. Only relevant are the addresses and places where your child did not live together with you, for example, because your child was living with the other parent or was staying abroad.</p>
// <p> </p>
// <p> </p>""",
//                 "",
//                 "Child ${Questions.childLength}",
//                 "In how many different places has your child lived?",
//                 "Number of places lived",
//                 220.0,
//                 "loop",
//                 Questions.childText);
//           }
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Do you wish to transfer your childs disability flat-rate amount to yourself?');
          _insert(
              'Do you wish to transfer your childs disability flat-rate amount to yourself?',
              'skip',
              'skip');

          if (Questions.childrenLive == "With us parents") {
            //Question No 7
            return familyyesnoContainer(
                """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Do you know the details of the other parent?",
                "Other parent's details",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "Patchwork family") {
            //Question No 8
            return familydifferentoptionContainer(
                """<p><strong>Relationship with child</strong></p>
<p>Please specify what type of relationship you had to the child. Type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p><strong>GRANDCHILD</strong></p>
<p>You can also specify grandchildren. But only under the conditions that you have an obligation to support the child and the child lives with you.</p>
<p><strong>STEPCHILD</strong></p>
<p>Stepchildren are treated in a similar way to grandchildren. You can deduct expenditures if the child lives in your household and you have an obligation to support them.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What relationship existed between you and the child?",
                "Relationship to child",
                [
                  "Biological child",
                  "Adopted child",
                  "Foster child",
                  "Grandchild",
                  "Stepchild"
                ],
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "Only with me") {
            //Question No 9
            return familycalculationContainer(
                """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Enter your child's Tax-ID.",
                "Tax-ID child",
                220.0,
                "tax",
                Questions.childText);
          } else if (Questions.childrenLive == "skip") {
            //Question No 9
            return familycalculationContainer(
                """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Enter your child's Tax-ID.",
                "Tax-ID child",
                220.0,
                "tax",
                Questions.childText);
          } else if (Questions.childrenLive == "With the other parent" ||
              Questions.childrenLive == "At place of training" ||
              Questions.childrenLive == "With Step-/Grandparents" ||
              Questions.childrenLive == "Somewhere else") {
            //Question No 10
            return familycalculationContainer(
                """<p><strong>Number of places of residence of your child</strong></p>
<p>Please enter here in how many places your child lived in 2019. For this, you enter the exact number of locations.</p>
<p><strong>Important:</strong></p>
<p>If your child moved with you, you do not need to specify this here. Only relevant are the addresses and places where your child did not live together with you, for example, because your child was living with the other parent or was staying abroad.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "In how many different places has your child lived?",
                "Number of places lived",
                220.0,
                "loop",
                Questions.childText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Do you wish to transfer your childs disability flat-rate amount to yourself?');
          _insert(
              'Do you wish to transfer your childs disability flat-rate amount to yourself?',
              'Yes',
              'OK');

          //Question No 154
          return familythreeoptionContainer(
              """
<p><strong>Codes of your child's disability</strong></p>
<p>Please state here, under which disability your child suffers. Select this from the given answers.</p>
<p>You can find this information on your child's disability pass. The type of disability has a designated code.</p>
<ul>
<li>Blind or visually impaired - code <strong>BI</strong></li>
<li>Constantly helpless - code <strong>H</strong></li>
<li>Physically handicapped - codes <strong>G</strong> &amp; <strong>aG</strong> (extremely physically handicapped)</li>
<li>Generally impaired - the degree of disability is noted on the disability pass</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Child ${Questions.childLength}",
              "What impairment does ${Questions.childFirstName} suffer from?",
              "Health impairment",
              [
                "Blind or visually impaired",
                "Permanently helpless",
                "Impaired mobility",
                "Generally impaired"
              ],
              220.0,
              "",
              Questions.childText);
        }
      }

      //answer No 154
      else if (widget.CheckCompleteQuestion ==
              "What impairment does ${Questions.childFirstName} suffer from?" &&
          widget.CheckQuestion == "Health impairment") {
        DbHelper.insatance
            .deleteWithquestion('What impairment does suffer from?');
        _insert('What impairment does suffer from?', Questions.childText, 'OK');

        //Question No 155
        return familycalculationContainer("""
<p><strong>Degree of disability of your child</strong></p>
<p>Please state here the degree of disability of your child.</p>
<p>This is abbreviated with <strong>GdB</strong> and can be found on your child's disability pass.</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Which degree of disability (GdB) does ${Questions.childFirstName} have?",
            "Degree of disability",
            220.0,
            "percentage",
            Questions.childText);
      }

      //Answer No 155
      else if (widget.CheckCompleteQuestion ==
              "Which degree of disability (GdB) does ${Questions.childFirstName} have?" &&
          widget.CheckQuestion == "Degree of disability") {
        DbHelper.insatance
            .deleteWithquestion('Which degree of disability (GdB) does?');
        _insert('Which degree of disability (GdB) does?', Questions.childText,
            'OK');

        //Question No 156
        return familydateContainer("""
<p><strong>Validity of disability pass</strong></p>
<p>Enter the date from which the disability pass of your child is valid.</p>
<p>You can find this information next to "<strong>Der Ausweis ist g&uuml;ltig ab:</strong>".</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Since when is the disability certificate valid?",
            "Valid since",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 156
      else if (widget.CheckCompleteQuestion ==
              "Since when is the disability certificate valid?" &&
          widget.CheckQuestion == "Valid since") {
        DbHelper.insatance.deleteWithquestion(
            'Since when is the disability certificate valid?');
        _insert('Since when is the disability certificate valid?',
            Questions.childText, 'OK');

        //Question No 157
        return familyyesnoContainer("""
<p><strong>Permanent validity of disability pass</strong></p>
<p>Choose "Yes" if the your child's disability pass is valid indefinitely. Otherwise click "No" and you'll be asked about the validity.</p>
<p>You can find this information <strong>at the top</strong> of the disability pass.</p>
<p>You should see in <strong>bold</strong> the word "<strong>unbefristet</strong>".</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Is the certificate valid indefinitely?",
            "Valid indefinitely",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 157
      else if (widget.CheckCompleteQuestion ==
              "Is the certificate valid indefinitely?" &&
          widget.CheckQuestion == "Valid indefinitely") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Is the certificate valid indefinitely?');
          _insert('Is the certificate valid indefinitely?', 'No', 'OK');

          //Question No 158
          return familydateContainer("""
<p><strong>Disability pass "valid until... "</strong></p>
<p>Please enter the date from which the disability pass of your child is valid.</p>
<p>You will find the information until which <strong>month and year</strong> it is valid next to "<strong>G&uuml;ltig bis Ende</strong>".</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "Until when is the disability certificate valid?",
              "Valid until",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Is the certificate valid indefinitely?');
          _insert('Is the certificate valid indefinitely?', 'skip', 'skip');

          //Question No 158
          return familydateContainer("""
<p><strong>Disability pass "valid until... "</strong></p>
<p>Please enter the date from which the disability pass of your child is valid.</p>
<p>You will find the information until which <strong>month and year</strong> it is valid next to "<strong>G&uuml;ltig bis Ende</strong>".</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "Until when is the disability certificate valid?",
              "Valid until",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Is the certificate valid indefinitely?');
          _insert('Is the certificate valid indefinitely?', 'Yes', 'OK');

          //Question No 159
          return familyyesnoContainer("""
<p><strong>50% split of disability flat-rate allowance</strong></p>
<p>Please indicate whether you want to transfer the disability flat-rate allowance equally, half each. Please select "Yes" or "No"</p>
<p>This is possible for separately assessed parents as long as you specify this in your tax return. Otherwise, the total flat-rate disability allowance will be transferred to the parent who receives the child benefit.</p>
<p>&nbsp;</p>
""",
              "",
              "Child ${Questions.childLength}",
              "Are you and the other parent splitting the disability flat-rate amount equally?",
              "Split 50%",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 158
      else if (widget.CheckCompleteQuestion ==
              "Until when is the disability certificate valid?" &&
          widget.CheckQuestion == "Valid until") {
        DbHelper.insatance.deleteWithquestion(
            'Until when is the disability certificate valid?');
        _insert('Until when is the disability certificate valid?', 'Yes', 'OK');

        //Question No 159
        return familyyesnoContainer("""
<p><strong>50% split of disability flat-rate allowance</strong></p>
<p>Please indicate whether you want to transfer the disability flat-rate allowance equally, half each. Please select "Yes" or "No"</p>
<p>This is possible for separately assessed parents as long as you specify this in your tax return. Otherwise, the total flat-rate disability allowance will be transferred to the parent who receives the child benefit.</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Are you and the other parent splitting the disability flat-rate amount equally?",
            "Split 50%",
            220.0,
            "",
            Questions.childText);
      }

      //Answer No 159
      else if (widget.CheckCompleteQuestion ==
              "Are you and the other parent splitting the disability flat-rate amount equally?" &&
          widget.CheckQuestion == "Split 50%") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Are you and the other parent splitting the disability flat-rate amount equally?');
          _insert(
              'Are you and the other parent splitting the disability flat-rate amount equally?',
              'No',
              'OK');
          print(dob.toString() + "dobbbb");

          //Question No 160
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "What share are you requesting for yourself?",
              "Your share",
              220.0,
              "percentage",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Are you and the other parent splitting the disability flat-rate amount equally?');
          _insert(
              'Are you and the other parent splitting the disability flat-rate amount equally?',
              'skip',
              'skip');

          //Question No 160
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "What share are you requesting for yourself?",
              "Your share",
              220.0,
              "percentage",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Are you and the other parent splitting the disability flat-rate amount equally?');
          _insert(
              'Are you and the other parent splitting the disability flat-rate amount equally?',
              'Yes',
              'OK');

          if (Questions.childrenLive == "With us parents") {
            //Question No 7
            return familyyesnoContainer(
                """<p><strong>Address of the other parent</strong></p>
<p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
<p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Do you know the details of the other parent?",
                "Other parent's details",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "Patchwork family") {
            //Question No 8
            return familydifferentoptionContainer(
                """<p><strong>Relationship with child</strong></p>
<p>Please specify what type of relationship you had to the child. Type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
<p><strong>BIOLOGICAL CHILD</strong></p>
<p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
<p><strong>ADOPTED CHILD</strong></p>
<p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
<p><strong>FOSTER CHILD</strong></p>
<p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
<p><strong>GRANDCHILD</strong></p>
<p>You can also specify grandchildren. But only under the conditions that you have an obligation to support the child and the child lives with you.</p>
<p><strong>STEPCHILD</strong></p>
<p>Stepchildren are treated in a similar way to grandchildren. You can deduct expenditures if the child lives in your household and you have an obligation to support them.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What relationship existed between you and the child?",
                "Relationship to child",
                [
                  "Biological child",
                  "Adopted child",
                  "Foster child",
                  "Grandchild",
                  "Stepchild"
                ],
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childrenLive == "Only with me") {
            //Question No 9
            return familycalculationContainer(
                """<p><strong>Your child's tax ID</strong></p>
<p>Please your child's tax ID number.</p>
<p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "Enter your child's Tax-ID.",
                "Tax-ID child",
                220.0,
                "tax",
                Questions.childText);
          } else if (Questions.childrenLive == "With the other parent" ||
              Questions.childrenLive == "At place of training" ||
              Questions.childrenLive == "With Step-/Grandparents" ||
              Questions.childrenLive == "Somewhere else") {
            //Question No 10
            return familycalculationContainer(
                """<p><strong>Number of places of residence of your child</strong></p>
<p>Please enter here in how many places your child lived in 2019. For this, you enter the exact number of locations.</p>
<p><strong>Important:</strong></p>
<p>If your child moved with you, you do not need to specify this here. Only relevant are the addresses and places where your child did not live together with you, for example, because your child was living with the other parent or was staying abroad.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "In how many different places has your child lived?",
                "Number of places lived",
                220.0,
                "loop",
                Questions.childText);
          }
        }
      } else if (widget.CheckCompleteQuestion ==
              "What share are you requesting for yourself?" &&
          widget.CheckQuestion == "Your share") {
        return familyyesnoContainer("""<h1>Coming Soon</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Does your children able to support themselves?",
            "Children Support",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "Does your children able to support themselves?" &&
          widget.CheckQuestion == "Children Support") {
        if (widget.CheckAnswer[0] == "No") {
          return familydateContainer("""<h1>Coming Soon</h1>""",
              "",
              "Disability Start",
              "When is the disability start?",
              "Disability Start",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          print(dob.toString() + " dobbbb");
          if (dob >= 1994 && dob <= 2005) {
            return familydifferentoptionContainer(
                """<h1>Coming Soon!</h1>""",
                "",
                "",
                "What was your child doing during these year?",
                "Child doing",
                [
                  "Attend School",
                  "Studied",
                  "Trainee",
                  "Volunteered",
                  "Was Employed",
                  "Was unemployed"
                ],
                220.0,
                "",
                "");
          } else
            return FinishCategory(
                "Family Category", "Health Category", 4, true);
        } else if (widget.CheckAnswer[0] == "skip") {
          return FinishCategory("Family Category", "Health Category", 4, true);
        }
      } else if (widget.CheckCompleteQuestion ==
              "What was your child doing during these year?" &&
          widget.CheckQuestion == "Child doing") {
        if (widget.CheckAnswer[0] == "Attend School") {
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Schools attend",
              "How many schools did he attend?",
              "Schools attend",
              220.0,
              "calculation",
              "calculation");
        } else if (widget.CheckAnswer[0] == "Studied") {
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "University attend",
              "How many university did he attend?",
              "University attend",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Trainee") {
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Training attend",
              "How many training course did he attend?",
              "Training attend",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Volunteered") {
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Volunteering",
              "How many times did he voluteered?",
              "Volunteering",
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Was Employed") {
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "",
              "What kind of work your child did?",
              "Kind of work",
              ["Regular Employed", "Mini job", "Training"],
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Was unemployed") {
          return familythreeoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "",
              "What is the reason of unemployment?",
              "Unemployed",
              [
                "Lack of apprenticeships",
                "Transitional period",
                "Registered a unemployed",
                "On vacation"
              ],
              220.0,
              "",
              "");
        }
      } else if (widget.CheckQuestion == "Unemployed") {
        return familymultipleoptionsContainer(
            """<h1>Coming soon</h1>""",
            "",
            "Child ${Questions.childLength}",
            "Have you had any of the following expenses for your child?",
            "Expenses child",
            [
              "Care costs",
              "School fees",
              "Health insurance contributions",
              "Costs due to disability",
              "None of this applies"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png"
            ],
            430.0,
            "None of this applies",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "What kind of work your child did?" &&
          widget.CheckQuestion == "Kind of work") {
        if (widget.CheckAnswer[0] == "Regular Employed") {
          return familymultipleoptionsContainer(
              """<h1>Coming soon</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Have you had any of the following expenses for your child?",
              "Expenses child",
              [
                "Care costs",
                "School fees",
                "Health insurance contributions",
                "Costs due to disability",
                "None of this applies"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              430.0,
              "None of this applies",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Mini job") {
          return familymultipleoptionsContainer(
              """<h1>Coming soon</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Have you had any of the following expenses for your child?",
              "Expenses child",
              [
                "Care costs",
                "School fees",
                "Health insurance contributions",
                "Costs due to disability",
                "None of this applies"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              430.0,
              "None of this applies",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Training") {
          return familymultipleoptionsContainer(
              """<h1>Coming soon</h1>""",
              "",
              "Child ${Questions.childLength}",
              "Have you had any of the following expenses for your child?",
              "Expenses child",
              [
                "Care costs",
                "School fees",
                "Health insurance contributions",
                "Costs due to disability",
                "None of this applies"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              430.0,
              "None of this applies",
              Questions.childText);
        }
      } else if (widget.CheckCompleteQuestion ==
              "How many schools did he attend?" &&
          widget.CheckQuestion == "Schools attend") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Name of school",
            "What is the name of school?",
            "Name of school",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "What is the name of school?" &&
          widget.CheckQuestion == "Name of school") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Time Period",
            "What is the time period of this school?",
            "Time Period",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "How many university did he attend?" &&
          widget.CheckQuestion == "University attend") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Name of University",
            "What is the name of University?",
            "Name of University",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "What is the name of University?" &&
          widget.CheckQuestion == "Name of University") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Time Period",
            "What is the time period of this University?",
            "Time Period",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "How many training course did he attend?" &&
          widget.CheckQuestion == "Training attend") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Name of Training",
            "What is the name of Training?",
            "Name of Training",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "What is the name of Training?" &&
          widget.CheckQuestion == "Training attend") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Time Period",
            "What is the time period of this Training?",
            "Time Period",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "How many times did he voluteered?" &&
          widget.CheckQuestion == "Volunteering") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Name of volunteering",
            "What is the name of Volunteering?",
            "Name of volunteering",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "What is the name of Volunteering?" &&
          widget.CheckQuestion == "Name of volunteering") {
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Time Period",
            "What is the time period of this Volunteering?",
            "Time Period",
            220.0,
            "",
            Questions.childText);
      } else if (widget.CheckQuestion == "Time Period") {
        return familymultipleoptionsContainer(
            """<p><strong>Child expenses</strong></p>
<p>Please specify whether your incurred expenses for you child in 2019.</p>
<p>You can choose which of the provided options apply to you. You can select multiple answers.</p>
<p><strong>CHILDCARE EXPENSES</strong></p>
<p>You incurred childcare costs, for example for a childminder, a babysitter for a kindergarten.</p>
<p><strong>SCHOOL FEES</strong></p>
<p>You paid school fee because your child went to a private school.</p>
<p><strong>COSTS DUE TO DISABILITY</strong></p>
<p>Your child has a disability and you had certain costs because of this. These can be for example for medication, walking aids or wheelchairs.</p>
<p><strong>HEALTH INSURANCE CONTRIBUTIONS</strong></p>
<p>If health insurance contributions were paid for the child in 2019, these can be stated here. It is also possible that the child is the policy holder. Health insurance contributions deducted from the child's salary can also be stated here in case the parents reimbursed the respective amount to the child. Note: You need to be entitled to the child allowance for this child.</p>
<p> </p>
<p> </p>""",
            "",
            "Child ${Questions.childLength}",
            "Have you had any of the following expenses for your child?",
            "Expenses child",
            [
              "Care costs",
              "School fees",
              "Health insurance contributions",
              "Costs due to disability",
              "None of this applies"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png"
            ],
            430.0,
            "None of this applies",
            Questions.childText);
      } else if (widget.CheckCompleteQuestion ==
              "When is the disability start?" &&
          widget.CheckQuestion == "Disability Start") {
        return FinishCategory("Family Category", "Health Category", 4, true);
      }

      //Answer No 160
//       else if (widget.CheckCompleteQuestion ==
//               "What share are you requesting for yourself?" &&
//           widget.CheckQuestion == "Your share") {
//         if (Questions.childrenLive == "With us parents") {
//           //Question No 7
//           return familyyesnoContainer(
//               """<p><strong>Address of the other parent</strong></p>
// <p>If you <em>know</em> the address of the other parent, then you can enter it in the next question.</p>
// <p>If you <em>don't know</em> the address, you will get the whole child allowance.</p>
// <p> </p>""",
//               "",
//               "Child ${Questions.childLength}",
//               "Do you know the details of the other parent?",
//               "Other parent's details",
//               220.0,
//               "",
//               Questions.childText);
//         } else if (Questions.childrenLive == "Patchwork family") {
//           //Question No 8
//           return familydifferentoptionContainer(
//               """<p><strong>Relationship with child</strong></p>
// <p>Please specify what type of relationship you had to the child. Type of relationship in <strong>the year 2019</strong> is what is relevant.</p>
// <p><strong>BIOLOGICAL CHILD</strong></p>
// <p>You're the biological mother or father of the child, regardless of whether the parents were married.</p>
// <p><strong>ADOPTED CHILD</strong></p>
// <p>You have officially adopted the child. Thus, the child is related you in the first degree.</p>
// <p><strong>FOSTER CHILD</strong></p>
// <p>A parent-child relationship also exists if the child is a foster child. The child must live in your household and be under your permanent supervision, care and guardianship. The biological parents may visit the child, but must not have any custodial or guardianship relationship to the child.</p>
// <p><strong>GRANDCHILD</strong></p>
// <p>You can also specify grandchildren. But only under the conditions that you have an obligation to support the child and the child lives with you.</p>
// <p><strong>STEPCHILD</strong></p>
// <p>Stepchildren are treated in a similar way to grandchildren. You can deduct expenditures if the child lives in your household and you have an obligation to support them.</p>
// <p> </p>
// <p> </p>""",
//               "",
//               "Child ${Questions.childLength}",
//               "What relationship existed between you and the child?",
//               "Relationship to child",
//               [
//                 "Biological child",
//                 "Adopted child",
//                 "Foster child",
//                 "Grandchild",
//                 "Stepchild"
//               ],
//               220.0,
//               "",
//               Questions.childText);
//         } else if (Questions.childrenLive == "Only with me") {
//           //Question No 9
//           return familycalculationContainer(
//               """<p><strong>Your child's tax ID</strong></p>
// <p>Please your child's tax ID number.</p>
// <p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
// <p> </p>""",
//               "",
//               "Child ${Questions.childLength}",
//               "Enter your child's Tax-ID.",
//               "Tax-ID child",
//               220.0,
//               "tax",
//               Questions.childText);
//         } else if (Questions.childrenLive == "skip") {
//           //Question No 9
//           return familycalculationContainer(
//               """<p><strong>Your child's tax ID</strong></p>
// <p>Please your child's tax ID number.</p>
// <p>The federal Central Tax Office automatically sends you a tax ID for your child by mail after the birth of your child. If you can no longer find is, ask for the federal Central Tax Office and the number will be sent again.</p>
// <p> </p>""",
//               "",
//               "Child ${Questions.childLength}",
//               "Enter your child's Tax-ID.",
//               "Tax-ID child",
//               220.0,
//               "tax",
//               Questions.childText);
//         } else if (Questions.childrenLive == "With the other parent" ||
//             Questions.childrenLive == "At place of training" ||
//             Questions.childrenLive == "With Step-/Grandparents" ||
//             Questions.childrenLive == "Somewhere else") {
//           //Question No 10
//           return familycalculationContainer(
//               """<p><strong>Number of places of residence of your child</strong></p>
// <p>Please enter here in how many places your child lived in 2019. For this, you enter the exact number of locations.</p>
// <p><strong>Important:</strong></p>
// <p>If your child moved with you, you do not need to specify this here. Only relevant are the addresses and places where your child did not live together with you, for example, because your child was living with the other parent or was staying abroad.</p>
// <p> </p>
// <p> </p>""",
//               "",
//               "Child ${Questions.childLength}",
//               "In how many different places has your child lived?",
//               "Number of places lived",
//               220.0,
//               "loop",
//               Questions.childText);
//         }
//       }

      // ===== Cost due to disability Ends ====== //

      //Answer no 63
      else if (widget.CheckCompleteQuestion ==
              "Which is the designated benefits office for child benefits for ${Questions.childFirstName}?" &&
          widget.CheckQuestion == "Benefits office") {
        if (widget.CheckAnswer[0] == "Other") {
          DbHelper.insatance.deleteWithquestion(
              'Which is the designated benefits office for child benefits for?');
          _insert(
              'Which is the designated benefits office for child benefits for?',
              widget.CheckAnswer[0],
              'OK');

          //Question No 161
          return familycalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "What other benefits office is responsible for your child benefits?",
              "Child benefits office",
              220.0,
              "",
              Questions.childText);
        } else {
          if ((Questions.childLength <= Questions.totalChild) &&
              (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              (Questions.familyPartnerEndSingleMove == false)) {
            print("Child Length:" + Questions.childLength.toString());
            print("Total child:" + Questions.totalChild.toString());

            Questions.familyPartnerEndSingleMove = true;
            Questions.familyYou = true;
            Questions.familyPartnerSingleMove = true;
            Questions.familyPartnerYouSingleMove = true;
            Questions.familyPartnerYouSecondMove = true;
            Questions.familyPartner = true;
            //Question No 2
            return familycalculationContainer(
                """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
                "",
                "Child ${Questions.childLength}",
                "What is your child's first name?",
                "First name child",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.familyPartnerEndSingleMove == true) {
            Questions.familyPartnerEndSingleMove = false;
            //Question No 2
            return familycalculationContainer(
                """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
                "",
                "Child ${Questions.childLength}",
                "What is your child's first name?",
                "First name child",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.childLength <= Questions.totalChild) {
            //Question No 2
            return familycalculationContainer(
                """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
                "",
                "Child ${Questions.childLength}",
                "What is your child's first name?",
                "First name child",
                220.0,
                "",
                Questions.childText);
          } else {
            //Agar Alimony Paid ka Option select hoa ha Living Situation ma
            if (Questions.alimonyPaidFamily == "Alimony paid") {
              //Question No 162
              return familymultithreeContainer(
                  """
<p><strong>Alimony payments</strong></p>
<p>Alimony can be paid both to <strong>children</strong> and to an <strong>ex-spouse.</strong></p>
<p>Choose from the answers below which apply to you for 2019. You can select multiple options.</p>
<p><strong>PENSION RIGHTS ADJUSTMENT</strong></p>
<p>Select this option if you paid a pension rights adjustment.</p>
<p><strong>Payment to avoid pension rights adjustment</strong></p>
<p>Select this option if you made a payment to avoid a pension rights adjustment. You can claim this as tax deductible.</p>
<p><strong>Alimony to an ex-spouse</strong></p>
<p>You can also write off alimony paid to your ex.</p>
<p>If you are <strong>divorced</strong> or <strong>permanently separated</strong> the lower earning ex-partner is obliged to provide <strong>financial support</strong> to the other.</p>
<p>Alimony can be written off as special expenses or an exceptional cost.</p>
<p><em>Important: Alimony paid to children is </em><strong><em>NOT</em></strong><em> tax-deductible.</em></p>
<p><em>&nbsp;</em></p>
<p><em>&nbsp;</em></p>
""",
                  "",
                  "Alimony",
                  "What kind of alimony have you paid?",
                  "Kind of alimony payments",
                  [
                    "Pension rights adjustment",
                    "Prevention of an adjustment",
                    "Alimony to ex"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png"
                  ],
                  220.0,
                  "",
                  "");
            } else {
              return FinishCategory(
                  "Family Category", "Health Category", 4, true);
            }
          }
        }
      }

      //Answer No 161
      else if (widget.CheckCompleteQuestion ==
              "What other benefits office is responsible for your child benefits?" &&
          widget.CheckQuestion == "Child benefits office") {
        if ((Questions.childLength <= Questions.totalChild) &&
            (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            (Questions.familyPartnerEndSingleMove == false &&
                Questions.familyPartnerEndSecondMove == false)) {
          print("Child Length:" + Questions.childLength.toString());
          print("Total child:" + Questions.totalChild.toString());

          Questions.familyPartnerEndSingleMove = true;
          Questions.familyPartnerEndSecondMove = true;
          Questions.familyYou = true;
          Questions.familyPartnerSingleMove = true;
          Questions.familyPartnerYouSingleMove = true;
          Questions.familyPartnerYouSecondMove = true;
          Questions.familyPartner = true;
          //Question No 2
          return familycalculationContainer(
              """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
              "",
              "Child ${Questions.childLength}",
              "What is your child's first name?",
              "First name child",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.familyPartnerEndSingleMove == true) {
          Questions.familyPartnerEndSingleMove = false;
          //Question No 2
          return familycalculationContainer(
              """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
              "",
              "Child ${Questions.childLength}",
              "What is your child's first name?",
              "First name child",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.familyPartnerEndSecondMove == true) {
          Questions.familyPartnerEndSecondMove = false;
          //Question No 2
          return familycalculationContainer(
              """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
              "",
              "Child ${Questions.childLength}",
              "What is your child's first name?",
              "First name child",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.childLength <= Questions.totalChild) {
          //Question No 2
          return familycalculationContainer(
              """<p><strong>Child's first name</strong></p>
<p>Please enter your child's first name.</p>
<p>If your child has several first names and/or middle names please enter all of these here.</p>""",
              "",
              "Child ${Questions.childLength}",
              "What is your child's first name?",
              "First name child",
              220.0,
              "",
              Questions.childText);
        } else {
          //Agar Alimony Paid ka Option select hoa ha Living Situation ma
          if (Questions.alimonyPaidFamily == "Alimony paid") {
            //Question No 162
            return familymultithreeContainer(
                """
<p><strong>Alimony payments</strong></p>
<p>Alimony can be paid both to <strong>children</strong> and to an <strong>ex-spouse.</strong></p>
<p>Choose from the answers below which apply to you for 2019. You can select multiple options.</p>
<p><strong>PENSION RIGHTS ADJUSTMENT</strong></p>
<p>Select this option if you paid a pension rights adjustment.</p>
<p><strong>Payment to avoid pension rights adjustment</strong></p>
<p>Select this option if you made a payment to avoid a pension rights adjustment. You can claim this as tax deductible.</p>
<p><strong>Alimony to an ex-spouse</strong></p>
<p>You can also write off alimony paid to your ex.</p>
<p>If you are <strong>divorced</strong> or <strong>permanently separated</strong> the lower earning ex-partner is obliged to provide <strong>financial support</strong> to the other.</p>
<p>Alimony can be written off as special expenses or an exceptional cost.</p>
<p><em>Important: Alimony paid to children is </em><strong><em>NOT</em></strong><em> tax-deductible.</em></p>
<p><em>&nbsp;</em></p>
<p><em>&nbsp;</em></p>
""",
                "",
                "Alimony",
                "What kind of alimony have you paid?",
                "Kind of alimony payments",
                [
                  "Pension rights adjustment",
                  "Prevention of an adjustment",
                  "Alimony to ex"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0,
                "",
                "");
          } else {
            return FinishCategory(
                "Family Category", "Health Category", 4, true);
          }
        }
      }

      // ====== Alimony Paid Starts (Relation) ======= //

      //Answer No 162
      else if (widget.CheckCompleteQuestion ==
              "What kind of alimony have you paid?" &&
          widget.CheckQuestion == "Kind of alimony payments") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Pension rights adjustment") {
            Questions.alimonyFamily = "Pension rights adjustment";
            //Question No 163
            return familyyesnoContainer("""

<p><strong>Alimony paid</strong></p>
<p>When you pay alimony, you can only include the payments in your tax return, if the recipient of the alimony has included this as income in their tax return.</p>
<p><strong>In order to include alimony in your tax return, the recipient must give their consent.</strong></p>
<p><strong>IMPORTANT!</strong></p>
<p>Only after this consent can you as payer of the alimony enter the expenditure in your tax return. Specify this accordingly here.</p>
<p>Choose "Yes" if the recipient has included this alimony in their tax return, otherwise click "No".</p>
<p>&nbsp;</p>

""",
                "",
                "Alimony",
                "Does the recipient of the alimony payments declare them on their tax return?",
                "Alimony taxed",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Prevention of an adjustment") {
            Questions.alimonyFamily = "Prevention of an adjustment";
            //Question No 163
            return familyyesnoContainer("""

<p><strong>Alimony paid</strong></p>
<p>When you pay alimony, you can only include the payments in your tax return, if the recipient of the alimony has included this as income in their tax return.</p>
<p><strong>In order to include alimony in your tax return, the recipient must give their consent.</strong></p>
<p><strong>IMPORTANT!</strong></p>
<p>Only after this consent can you as payer of the alimony enter the expenditure in your tax return. Specify this accordingly here.</p>
<p>Choose "Yes" if the recipient has included this alimony in their tax return, otherwise click "No".</p>
<p>&nbsp;</p>

""",
                "",
                "Alimony",
                "Does the recipient of the alimony payments declare them on their tax return?",
                "Alimony taxed",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            Questions.alimonyFamily = "Prevention of an adjustment";
            //Question No 163
            return familyyesnoContainer("""

<p><strong>Alimony paid</strong></p>
<p>When you pay alimony, you can only include the payments in your tax return, if the recipient of the alimony has included this as income in their tax return.</p>
<p><strong>In order to include alimony in your tax return, the recipient must give their consent.</strong></p>
<p><strong>IMPORTANT!</strong></p>
<p>Only after this consent can you as payer of the alimony enter the expenditure in your tax return. Specify this accordingly here.</p>
<p>Choose "Yes" if the recipient has included this alimony in their tax return, otherwise click "No".</p>
<p>&nbsp;</p>

""",
                "",
                "Alimony",
                "Does the recipient of the alimony payments declare them on their tax return?",
                "Alimony taxed",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Alimony to ex") {
            Questions.alimonyFamily = "Alimony to ex";
            //Question No 163
            return familyyesnoContainer("""

<p><strong>Alimony paid</strong></p>
<p>When you pay alimony, you can only include the payments in your tax return, if the recipient of the alimony has included this as income in their tax return.</p>
<p><strong>In order to include alimony in your tax return, the recipient must give their consent.</strong></p>
<p><strong>IMPORTANT!</strong></p>
<p>Only after this consent can you as payer of the alimony enter the expenditure in your tax return. Specify this accordingly here.</p>
<p>Choose "Yes" if the recipient has included this alimony in their tax return, otherwise click "No".</p>
<p>&nbsp;</p>

""",
                "",
                "Alimony",
                "Does the recipient of the alimony payments declare them on their tax return?",
                "Alimony taxed",
                220.0,
                "",
                "");
          }
        }
      }

      // Pension rights adjustment Starts

      //Answer No 163
      else if (widget.CheckCompleteQuestion ==
              "Does the recipient of the alimony payments declare them on their tax return?" &&
          widget.CheckQuestion == "Alimony taxed") {
        if (widget.CheckAnswer[0] == "No") {
          return FinishCategory("Family Category", "Health Category", 4, true);
        } else if (widget.CheckAnswer[0] == "skip") {
          return FinishCategory("Family Category", "Health Category", 4, true);
        } else if (widget.CheckAnswer[0] == "Yes") {
          if (Questions.alimonyFamily == "Pension rights adjustment") {
            //Question No 164
            return familycalculationContainer("""

<p><strong>Contractual pension rights adjustment</strong></p>
<p>Indicate the reason for your payment of a contractual pension rights adjustment.</p>
<p>Note that it is only your payments in 2019 that are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>A contractual pension rights adjustment means that <strong>the party obliged to pay the adjustment receives a full income</strong> must, however, pay a <strong>share</strong> of this to the <strong>party entitled to the adjustment.</strong></p>
<p>Often in a <strong>marriage contract</strong> or in a <strong>notarial agreement</strong> that compensation is excluded in the case of divorce.</p>
<p>Instead the ex partner receives a <em>compensation adjustment</em>* (such as a sum of money, indemnity, a life insurance policy).</p>
<p>Such payments are often first agreed <strong>during the divorce proceedings</strong> to settle any compensation claims.</p>

""",
                "",
                "Alimony",
                "What was the reason for payments as part of a contractual pension rights adjustment?",
                "Reason contractural adjustment",
                220.0,
                "",
                "");
          } else if (Questions.alimonyFamily == "Prevention of an adjustment") {
            //Question No 169
            return familycalculationContainer("""

<p><strong>Contractual compensation adjustment</strong></p>
<p>Please enter the total amount of your payment to avoid the pension rights adjustment. Note that this is the payment that you made in 2019.</p>
<p><strong>Your taxes</strong></p>
<p>You can write off your compensation payments from a contractual pension rights adjustment. For this, the payee must specify these payments as other income in their tax return.</p>
<ul>
<li>Please note: *</li>
</ul>
<p>For this it is required that you obtain the consent of your divorced spouse or life partner. The Appendix U must be filled out by both parties the <u>Anlage U</u> and submitted with the tax return.</p>
<p>&nbsp;</p>

""",
                "",
                "Alimony",
                "How much have you paid to prevent a pension rights adjustment?",
                "Amount paid",
                220.0,
                "",
                "");
          } else if (Questions.alimonyFamily == "Alimony to ex") {
            //Question No 170
            return familycalculationContainer("""

<p><strong>Alimony payments</strong></p>
<p>Alimony can be paid both to <strong>children</strong> and to an <strong>ex-spouse.</strong></p>
<p>Choose from the answers below which apply to you for 2019. You can select multiple options.</p>
<p><strong>PENSION RIGHTS ADJUSTMENT</strong></p>
<p>Select this option if you paid a pension rights adjustment.</p>
<p><strong>Payment to avoid pension rights adjustment</strong></p>
<p>Select this option if you made a payment to avoid a pension rights adjustment. You can claim this as tax deductible.</p>
<p><strong>Alimony to an ex-spouse</strong></p>
<p>You can also write off alimony paid to your ex.</p>
<p>If you are <strong>divorced</strong> or <strong>permanently separated</strong> the lower earning ex-partner is obliged to provide <strong>financial support</strong> to the other.</p>
<p>Alimony can be written off as special expenses or an exceptional cost.</p>
<p><em>Important: Alimony paid to children is </em><strong><em>NOT</em></strong><em> tax-deductible.</em></p>
<p><em>&nbsp;</em></p>
<p><em>&nbsp;</em></p>

""", "", "Alimony", "How much alimony have you paid?",
                "Amount alimony payments", 220.0, "calculation", "");
          }
        }
      }

      //Answer No 164
      else if (widget.CheckCompleteQuestion ==
              "What was the reason for payments as part of a contractual pension rights adjustment?" &&
          widget.CheckQuestion == "Reason contractural adjustment") {
        //Question No 165
        return familydateContainer("""
<p><strong>First-time payment</strong></p>
<p>Please specify here the **date of your first payment **. Please enter this here.</p>
<p>You need to provide the following information:</p>
<ul>
<li>the receiver of your payments</li>
<li>the type of your expenses</li>
<li>the date of the first payment</li>
</ul>
<p>&nbsp;</p>

""", "", "Alimony", "When did you make the first payment?", "First payout",
            220.0, "", "");
      }

      //Answer No 165
      else if (widget.CheckCompleteQuestion ==
              "When did you make the first payment?" &&
          widget.CheckQuestion == "First payout") {
        //Question No 166
        return familycalculationContainer("""
<p><strong>Amount of compensation payments</strong></p>
<p>Please enter the <strong>total amount</strong> of your compensation payments so that the information is complete.</p>
<p>Note that it is the amount from 2019.</p>
<p>&nbsp;</p>
""",
            "",
            "Alimony",
            "How much have you paid as part of the contractual pension rights adjustment?",
            "Amount contractual adjustment",
            220.0,
            "calculation",
            "");
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "How much have you paid as part of the contractual pension rights adjustment?" &&
          widget.CheckQuestion == "Amount contractual adjustment") {
        //Question No 167
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Alimony",
            "What is the full name of the person who received the payments under the debt settlement agreement?",
            "Recipient name",
            220.0,
            "",
            "");
      }

      //Answer No 167
      else if (widget.CheckCompleteQuestion ==
              "What is the full name of the person who received the payments under the debt settlement agreement?" &&
          widget.CheckQuestion == "Recipient name") {
        //Question No 168
        return familycalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Alimony",
            "What is the tax ID of the person who received your payments under the debt settlement agreement?",
            "Recipient tax ID",
            220.0,
            "tax",
            "");
      }

      //Answer No 168
      else if (widget.CheckCompleteQuestion ==
              "What is the tax ID of the person who received your payments under the debt settlement agreement?" &&
          widget.CheckQuestion == "Recipient tax ID") {
        return FinishCategory("Family Category", "Health Category", 4, true);
      }

      //Pension rights adjustment Ends

      //Prevention of an adjustment Starts

      //Answer No 169
      else if (widget.CheckCompleteQuestion ==
              "How much have you paid to prevent a pension rights adjustment?" &&
          widget.CheckQuestion == "Amount paid") {
        return FinishCategory("Family Category", "Health Category", 4, true);
      }

      //Prevention of an adjustment Ends

      // Alimony to ex Starts

      //Answer No 170
      else if (widget.CheckCompleteQuestion ==
              "How much alimony have you paid?" &&
          widget.CheckQuestion == "Amount alimony payments") {
        //Question No 171
        return familycalculationContainer("""
<p><strong>Alimony for health &amp; nursing care insurance</strong></p>
<p>Please state how much of your alimony paid in 2019 went to health and nursing care insurance of the recipient.</p>
<p><strong>Your taxes</strong></p>
<p>Alimony obligations can also include contributions to **health &amp; nursing care insurance **.</p>
<p>This may be the case if the alimony recipient is <strong>NOT</strong> insured themself.</p>
<p>&nbsp;</p>
""",
            "",
            "Alimony",
            "How much thereof were premiums for health and nursing care insurance?",
            "Share health- / nursing care insurance",
            220.0,
            "calculation",
            "");
      }

      //Answer No 171
      else if (widget.CheckCompleteQuestion ==
              "How much thereof were premiums for health and nursing care insurance?" &&
          widget.CheckQuestion == "Share health- / nursing care insurance") {
        //Question No 172
        return familyyesnoContainer("""
<p><strong>Rebates from health insurance</strong></p>
<p>Please state whether you received any rebates from the health &amp; nursing care insurance of the alimony recipient in 2019. Choose "Yes" or "No" accordingly.</p>
<p>These include <strong>premiums</strong>.</p>
<p>These reduce the deductible amount of health and nursing care insurance contributions.</p>
<p>&nbsp;</p>
""",
            "",
            "Alimony",
            "Have you received any reimbursements from your health or nursing care insurance?",
            "Reimbursement health / nursing care insurance",
            220.0,
            "",
            "");
      }

      //Answer No 172
      else if (widget.CheckCompleteQuestion ==
              "Have you received any reimbursements from your health or nursing care insurance?" &&
          widget.CheckQuestion ==
              "Reimbursement health / nursing care insurance") {
        if (widget.CheckAnswer[0] == "No") {
          //Question No 174
          return familycalculationContainer("""
<p><strong>Entitlement to sick pay</strong></p>
<p>Please enter the amount of your contribution to your health and nursing care insurance that entitles you to sick pay.</p>
<p>You can find this information on your <strong>certificate of insurance</strong>.</p>
<p>The contribution for entitlement to sick pay is <strong>not fully tax deductible</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Alimony",
              "What share of the premiums for health and nursing care insurance entitled you to sick pay?",
              "Share entitling to sick pay",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          //Question No 174
          return familycalculationContainer("""
<p><strong>Entitlement to sick pay</strong></p>
<p>Please enter the amount of your contribution to your health and nursing care insurance that entitles you to sick pay.</p>
<p>You can find this information on your <strong>certificate of insurance</strong>.</p>
<p>The contribution for entitlement to sick pay is <strong>not fully tax deductible</strong>.</p>
<p>&nbsp;</p>
""",
              "",
              "Alimony",
              "What share of the premiums for health and nursing care insurance entitled you to sick pay?",
              "Share entitling to sick pay",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          //Question No 173
          return familycalculationContainer("""
<p><strong>Amount of rebates</strong></p>
<p>Please state the <strong>amount received in rebates</strong> from the health &amp; nursing care insurance provider.</p>
<p>Please note we are talking about the total amount from 2019.</p>
<p>&nbsp;</p>
""", "", "Alimony", "How much have you been reimbursed?", "Refunded amount",
              220.0, "calculation", "");
        }
      }

      //Answer No 173
      else if (widget.CheckCompleteQuestion ==
              "How much have you been reimbursed?" &&
          widget.CheckQuestion == "Refunded amount") {
        //Question No 174
        return familycalculationContainer("""
<p><strong>Entitlement to sick pay</strong></p>
<p>Please enter the amount of your contribution to your health and nursing care insurance that entitles you to sick pay.</p>
<p>You can find this information on your <strong>certificate of insurance</strong>.</p>
<p>The contribution for entitlement to sick pay is <strong>not fully tax deductible</strong>.</p>
<p>&nbsp;</p>
""",
            "",
            "Alimony",
            "What share of the premiums for health and nursing care insurance entitled you to sick pay?",
            "Share entitling to sick pay",
            220.0,
            "calculation",
            "");
      }

      //Answer No 174
      else if (widget.CheckCompleteQuestion ==
              "What share of the premiums for health and nursing care insurance entitled you to sick pay?" &&
          widget.CheckQuestion == "Share entitling to sick pay") {
        //Question No 175
        return familycalculationContainer("""
<p><strong>Tax identification number of alimony recipient</strong></p>
<p>Enter here the tax identification number of the alimony recipient to continue.</p>
<p>If the tax identification number of the alimony recipient is not known to you, you need to request this information from the alimony recipient.</p>
<p>If the recipient refuses to provide this information, you can ask your <strong>designated tax office</strong> for the number.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Alimony",
            "What is the tax identification number of the person receiving the alimony payments?",
            "Tax ID of the payee",
            220.0,
            "tax",
            "");
      }

      //Answer No 175
      else if (widget.CheckCompleteQuestion ==
              "What is the tax identification number of the person receiving the alimony payments?" &&
          widget.CheckQuestion == "Tax ID of the payee") {
        return FinishCategory("Family Category", "Health Category", 4, true);
      }

      // Alimony to ex Ends

      // ====== Alimony Paid Ends (Relation) ======= //

      //Partner Extra Question Starts
      //Answer No 176
      else if (widget.CheckCompleteQuestion ==
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?" &&
          widget.CheckQuestion == "Relationship") {
        //Question No 177
        return familyyesnoContainer("""
<p><strong>Parent-child relationship</strong></p>
<p>Choose the answer "Yes", if the parent-child relationship existed for the whole of <strong>2019</strong>. Otherwise click "No".</p>
<p>A parent-child relationship includes a biological child, an adopted child or a foster child.</p>
<p><strong>Attention:</strong></p>
<p>If your child was born in 2019, the parent-child relationship <strong>didn't</strong> exist throughout the whole year.</p>
<p>&nbsp;</p>
""",
            "",
            "Child ${Questions.childLength}",
            "Did the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName} last all year?",
            "All year",
            220.0,
            "",
            "");
      }

      //Answer No 177
      else if ((widget.CheckCompleteQuestion ==
                  "Did the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName} last all year?" ||
              widget.CheckCompleteQuestion ==
                  "Did the relationship between you and ${Questions.childFirstName} last all year?") &&
          widget.CheckQuestion == "All year") {
        if (widget.CheckAnswer[0] == "No") {
          //Question No 178
          return familythreeoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "How did the relationship change during 2019?",
              "Kind of change",
              ["It started", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "skip") {
          //Question No 178
          return familythreeoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "How did the relationship change during 2019?",
              "Kind of change",
              ["It started", "It ended", "It existed temporarily"],
              220.0,
              "",
              Questions.childText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.familyPartner == true) {
            Questions.familyPartnerSingleMove = false;
            familyPartner();
            //Question No 176
            return familydifferentoptionContainer(
                """<h1>Coming Soon!</h1>""",
                "",
                "Child ${Questions.childLength}",
                "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
                "Relationship",
                [
                  "Biological child",
                  "Adopted child",
                  "Foster child",
                  "Grandchild",
                  "Stepchild",
                  "None"
                ],
                220.0,
                "",
                "");
          } else if (Questions.familyPartnerYouSingleMove == true) {
            Questions.familyPartnerYouSingleMove = false;
            //Question No 3
            return familycalculationContainer(
                """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What is ${Questions.childFirstName}'s last name?",
                "Child's last name",
                220.0,
                "",
                Questions.childText);
          } else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
            familyYouPartner();
            //Question No 3
            return familycalculationContainer(
                """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
                "",
                "Child ${Questions.childLength}",
                "What is ${Questions.childFirstName}'s last name?",
                "Child's last name",
                220.0,
                "",
                Questions.childText);
          }
        }
      }

      //Answer No 178
      else if (widget.CheckCompleteQuestion ==
              "How did the relationship change during 2019?" &&
          widget.CheckQuestion == "Kind of change") {
        if (widget.CheckAnswer[0] == "It started") {
          //Question No 179
          return familydateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "When did the childhood relationship start in 2019?",
              "Start date",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "It ended") {
          //Question No 180
          return familydateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "When did the childhood relationship end in 2019?",
              "End date",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "It existed temporarily") {
          //Question No 181
          return familydateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Child ${Questions.childLength}",
              "From when to when lastet the childhood relationship?",
              "Duration",
              220.0,
              "",
              "");
        }
      }

      //Answer No 179
      else if (widget.CheckCompleteQuestion ==
              "When did the childhood relationship start in 2019?" &&
          widget.CheckQuestion == "Start date") {
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.familyPartner == true) {
          familyPartner();
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else if (Questions.familyPartnerSingleMove == true) {
          Questions.familyPartnerSingleMove = false;
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else if (Questions.familyPartnerYouSingleMove == true) {
          Questions.familyPartnerYouSingleMove = false;
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.familyPartnerYouSecondMove == true) {
          Questions.familyPartnerYouSecondMove = false;
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          familyYouPartner();
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 180
      else if (widget.CheckCompleteQuestion ==
              "When did the childhood relationship end in 2019?" &&
          widget.CheckQuestion == "End date") {
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.familyPartner == true) {
          familyPartner();
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else if (Questions.familyPartnerSingleMove == true) {
          Questions.familyPartnerSingleMove = false;
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else if (Questions.familyPartnerYouSingleMove == true) {
          Questions.familyPartnerYouSingleMove = false;
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.familyPartnerYouSecondMove == true) {
          Questions.familyPartnerYouSecondMove = false;
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          familyYouPartner();
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        }
      }

      //Answer No 181
      else if (widget.CheckCompleteQuestion ==
              "From when to when lastet the childhood relationship?" &&
          widget.CheckQuestion == "Duration") {
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.familyPartner == true) {
          familyPartner();
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else if (Questions.familyPartnerSingleMove == true) {
          Questions.familyPartnerSingleMove = false;
          //Question No 176
          return familydifferentoptionContainer(
              """<h1>Coming Soon!</h1>""",
              "",
              "Child ${Questions.childLength}",
              "What is the relationship between ${Questions.familyYouIdentity} and ${Questions.childFirstName}?",
              "Relationship",
              [
                "Biological child",
                "Adopted child",
                "Foster child",
                "Grandchild",
                "Stepchild",
                "None"
              ],
              220.0,
              "",
              "");
        } else if (Questions.familyPartnerYouSingleMove == true) {
          Questions.familyPartnerYouSingleMove = false;
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.familyPartnerYouSecondMove == true) {
          Questions.familyPartnerYouSecondMove = false;
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        } else if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
          familyYouPartner();
          //Question No 3
          return familycalculationContainer(
              """<p><strong>Child's last name</strong></p>
<p>Please enter your child's last name.</p>
<p>Please enter this name even if it differs from your own last name.</p>
<p> </p>
<p> </p>""",
              "",
              "Child ${Questions.childLength}",
              "What is ${Questions.childFirstName}'s last name?",
              "Child's last name",
              220.0,
              "",
              Questions.childText);
        }
      }
    }
  }

  Widget familycalculationContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyCalculationContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familydateContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyDateContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familymultipleoptionsContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      List AnswerImages,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyMultipleOptionsContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 430.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familyyesnoContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyYesNoContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familythreeoptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyThreeOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 340.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familydifferentoptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyDifferentOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 420.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familyaddressContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.homeAnimatedContainer = animatedcontainer;
    return FamilyAddressContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 210.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familytwooptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyTwoOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 280.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget familymultithreeContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      List AnswerImages,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.familyAnimatedContainer = animatedcontainer;
    return FamilyMultiThreeContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 370.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  void familyPartner() {
    qu.FamilyAddAnswer("Partner", "", "", "", [], 60.0);
    Questions.familyPartner = false;

    Questions.familyYouIdentity = "your partner";
    Questions.familyYourIdentity = "your partner";
  }

  void familyYouPartner() {
    qu.FamilyAddAnswer("You & Partner", "", "", "", [], 60.0);

    Questions.familyYouIdentity = "you";
    Questions.familyYourIdentity = "your";

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
            Questions.familyAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FamilyMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.familyAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.familyAnswerShow = [];
            Questions.familyAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FamilyMainQuestions(
                  CheckCompleteQuestion: Questions
                      .familyAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.familyAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.familyAnswerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
          height: Questions.familyAnswerShow[currentIndex]['containerheight'],
          width: 450.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(width: 1.0, color: Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8))
          ),
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
                        Questions.familyAnswerShow[currentIndex]['question'],
                        style: TextStyle(
                            color: Color(0xFF003350).withOpacity(0.803),
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
                            Questions.familyAnswerShow[currentIndex]['answer']
                                [0],
                            textAlign: TextAlign.end,
                            minFontSize: 14.0,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'HelveticaBold',
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
            Questions.familyAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FamilyMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.familyAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.familyAnswerShow = [];
            Questions.familyAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FamilyMainQuestions(
                  CheckCompleteQuestion: Questions
                      .familyAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.familyAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.familyAnswerShow[currentIndex - 1]['answer'][0]
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
                          Questions.familyAnswerShow[currentIndex]['question'],
                          style: TextStyle(
                              color: Color(0xFF9bb0ba),
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
                              Questions.familyAnswerShow[currentIndex]['answer']
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
