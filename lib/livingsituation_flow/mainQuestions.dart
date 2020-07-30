//import 'package:easy_taxx/questions.dart';
import 'package:easy_taxx/income_flow/calculationcontainer.dart';
import 'package:easy_taxx/livingsituation_flow/calculationContainer.dart';
import 'package:easy_taxx/livingsituation_flow/calculationContaineremail.dart';
import 'package:easy_taxx/livingsituation_flow/termsCondition.dart';
import 'package:easy_taxx/livingsituation_flow/calculationContainerPin.dart';
import 'package:easy_taxx/livingsituation_flow/container_alimonypaid.dart';
import 'package:easy_taxx/show.dart';
import 'package:easy_taxx/livingsituation_flow/container1.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/livingsituation_flow/container2.dart';
import 'package:easy_taxx/livingsituation_flow/container3.dart';
import 'package:easy_taxx/livingsituation_flow/container4.dart';
import 'package:easy_taxx/livingsituation_flow/container5.dart';
import 'package:easy_taxx/livingsituation_flow/container6.dart';
import 'package:easy_taxx/livingsituation_flow/container7.dart';
import 'package:easy_taxx/finishcategory.dart';
import 'package:easy_taxx/livingsituation_flow/unsupportedscreen.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MaterialApp(home:HomeScreen()));

class mainQuestions extends StatefulWidget {
  String CheckQuestion;
  List CheckAnswer;

  mainQuestions({Key key, this.CheckQuestion, this.CheckAnswer})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<mainQuestions> {
  Questions qu = Questions();
  var dynamicContainer = List<Widget>();
  var dynamicContainerbig = List<Widget>();
  final dbHelper = DbHelper.insatance;

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
  int specificIndex = -1;

  Future<String> _setStringKeyFamily() async {
    final prefs = await SharedPreferences.getInstance();
    // write
    await prefs.setString('Family', 'no');
  }

  Future<String> _setStringKeyFamilyYes() async {
    final prefs = await SharedPreferences.getInstance();
    // write
    await prefs.setString('Family', 'yes');
  }

  Future<String> _setStringKey() async {
    final prefs = await SharedPreferences.getInstance();
    // write
    await prefs.setString('miniJobCheck', 'yes');
  }

  Future<String> _setStringAlimony() async {
    final prefs = await SharedPreferences.getInstance();
    // write
    await prefs.setString('Alimony', 'yes');
  }

  Future<String> _setStringKeyNo() async {
    final prefs = await SharedPreferences.getInstance();
    // write
    await prefs.setString('miniJobCheck', 'No');
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

  void Screenheight() {
    print("question length:" + Questions.answerShow.length.toString());

    for (k = l; k < Questions.answerShow.length; k++) {
      print("how manysdsdsd");
      screenHeightbig = 0.0;
      if (Questions.answerShow[k]['identity'] == "You" ||
          Questions.answerShow[k]['identity'] == "You & Partner" ||
          Questions.answerShow[k]['identity'] == "Partner") {
        screenHeight = screenHeight + 70.0;
      } else if (Questions.answerShow[k]['details'] == "") {
        screenHeight = screenHeight + 60.0;
        detail = true;
      } else {
        detailsHeight = Questions.answerShow[k]['details'];

        for (l = k; l < Questions.answerShow.length; l++) {
          if (Questions.answerShow[l]['details'] == detailsHeight) {
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
    screenHeight = screenHeight + Questions.animatedContainer;
    // screenHeight = screenHeight;
    print("Screen Height:" + screenHeight.toString());
//    print("Screen Height big:"+screenHeightbig.toString());

    detail = true;
  }

  void DynamicContainer() {
    hlength = 0;
    // print("question length:"+Questions.answerShow.length.toString());
    for (i = j; i < Questions.answerShow.length; i++) {
      print("value oif i is:" + i.toString());

      print("dat is:" + i.toString());
      //You and your and your partner identity
      if (Questions.answerShow[i]['identity'] == "You" ||
          Questions.answerShow[i]['identity'] == "You & Partner" ||
          Questions.answerShow[i]['identity'] == "Partner") {
        dynamicContainer.add(Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: Questions.answerShow[i]['containerheight'],
          width: 450.0,
          child: Text(Questions.answerShow[i]['identity'],
              style: TextStyle(fontSize: 40.0)),
        ));
      } else if (Questions.answerShow[i]['details'] == "") {
        //specificIndex++;
        dynamicContainer.add(SingleSmallContainer(currentIndex: i)
//            Container(
//              margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
//              height: Questions.answerShow[i]['containerheight'],
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
//                          child:AutoSizeText(Questions.answerShow[i]['question'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                      ),
//                      Row(children: <Widget>[
//                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Colors.lightBlue)),
//                        Container(
//                            width: 140.0,
//                            // color:Colors.blue,
//                            child:AutoSizeText(Questions.answerShow[i]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
//
//                        ),
//                        SizedBox(width: 5.0,),
//                        Icon(Icons.arrow_forward_ios, size: 12.0,
//                          color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF))
//                      ],)
//                    ],
//                  )),
//            )
            );
      }

      //data that contains long container
      else {
        detailOption = Questions.answerShow[i]['details'];
        print(detailOption);
        countLongContainer = 0;
//print("ahsjasjasksss");

        //set length of data in details that how much data comes
        for (co = i; co < Questions.answerShow.length; co++) {
          if (Questions.answerShow[co]['details'] == detailOption) {
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
          if (Questions.answerShow[j]['details'] == detailOption &&
              detail == true) {
            dynamicContainerbig.add(
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
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
                              Questions.answerShow[i]['details'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'HelveticaBold',
                                  fontSize: 15.0,
                                  color: Color(0xFF003350).withOpacity(0.803)),
                            ),
                            Row(
                              children: <Widget>[
                                //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Colors.lightBlue)),
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
          if (Questions.answerShow[j]['details'] == detailOption &&
              detail == false) {
            //specificIndex++;
            dynamicContainerbig.add(MultipleBigContainer(currentIndex: j)
//                    Container(
//                    color: Colors.white,
//                      height: 55.0,
//                      width: 450.0,
//                      child: Padding(
//                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                          child: Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              //Text(Questions.answerShow[i]['question']),
//                              Container(
//                                  width: 155.0,
//                                  //color: Colors.purple,
//                                  child:AutoSizeText(Questions.answerShow[j]['question'],style: TextStyle(color: Colors.grey),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                              ),
//                              Row(children: <Widget>[
//                                //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Colors.lightBlue)),
//                                Container(
//                                    width: 140.0,
//                                    // color:Colors.blue,
//                                    child:AutoSizeText(Questions.answerShow[j]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
//
//                                ),
//                                SizedBox(width: 5.0,),
//                                Icon(Icons.arrow_forward_ios, size: 12.0,
//                                  color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),)
//                              ],)
//                            ],
//                          ))
//                  ),

                );

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
            margin: EdgeInsets.only(bottom: 4, top: 6, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
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
                            "Living Situation",
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

        // //   leading: GestureDetector(
        // //     onTap: (){
        // //     Navigator.pushReplacementNamed(context, 'allCategoryScreen');
        // //     //  Navigator.pop(context);
        // //     },
        // //       child:Icon(Icons.arrow_back_ios,color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),size: 20.0)
        // //   ),
        // //   title: Text('Living Situation',style: TextStyle(color: Colors.black,fontSize: 14.0),),
        // //   centerTitle: true,
        // //     actions: <Widget>[
        // //       Padding(
        // //         padding: EdgeInsets.only(right: 18.0),
        // //       child:GestureDetector(
        // //         onTap: (){
        // //           print("skip");
        // //         },
        // //       child:Image(image:AssetImage("images/skip.png"),width: 23.0,height: 23.0,)
        // //       )
        // //       )
        // //  ]

        // ),
        body: SingleChildScrollView(
            reverse: true,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
              // color: Color(0xFFf2f6ff),
              // height: 667.0,
              //height:Questions.answerShow.length <3 ? MediaQuery.of(context).size.height*0.87 : (Questions.answerShow.length*60.0)+430.0,
              //height:Questions.answerShow.length <3 ? 624.0 : (Questions.answerShow.length*60.0)+430.0,
              //height: MediaQuery.of(context).size.height*0.87,

              height: MediaQuery.of(context).size.height * 0.87 >= screenHeight
                  ? MediaQuery.of(context).size.height * 0.87
                  : screenHeight,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.red,
                      child: Column(
                        children: <Widget>[
//
                          Column(
                            children: dynamicContainer,
                          ),
//

//                        Column(
//                          children: dynamicContainer.asMap()
//                              .map((i,element) =>MapEntry(i,
//                            GestureDetector(
//                              onTap: (() {
//                                setState(() {
//                                  // print("element=${element.toString()}");
//                                  // print("element=${userBoard[element]}");
//                                  print(i.toString());
//                                  print(element.toString());
//                                  print(dynamicContainer[i].toString());
//                                });
//                              }),
//                              child:dynamicContainer[i],
//                            ),
//                          ))
//                              .values.toList(),
//                        ),

                          ChangeContainer(),
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

  Widget ChangeContainer() {
    if (Questions.answerShow.length == 0) {
      //For Single 430.0
      //For Divorced 220.0
      //For Widowed 220.0
      //For Married/ civil partnership 220.0
      //For It's Complicated 220.0
      Questions.LivingCheck = 1;
      return MaritalStatus("", 430.0);
    } else if (Questions.LivingCheck == 1 || Questions.LivingCheck == 2) {
      if (widget.CheckQuestion == "Marital") {
        if (widget.CheckAnswer[0] == "Single") {
          //Partner Relation
          Questions.LivingCheck = 1;

          //for Employed 220.0
          // for Minijob (e.g. 450€ basis) 430.0
          // for studying 380.0 for container No 5
          // for training 260 for container No 6
          //for Self-employed unsupported screen 220.0
          //for Own business unsupported 220.0
          //for Forestry unsupported 220.0
          //for Retired unsupported 220.0
          //for Parental Leave 430.0
          //for Not working  430.0

          //qu.addAnswer("You","", "", [], 80.0);
          DbHelper.insatance..deleteWithquestion('Marital');
          _insert('Marital', 'Single', 'OK');
          return OccupationContainer("", 430.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          //  Questions.LivingCheck = 1;
          // return OccupationContainer("",430.0);
          DbHelper.insatance..deleteWithquestion('Marital');
          _insert('Marital', 'skip', 'skip');
          return FormallyMarried("", 430.0);
        } else if (widget.CheckAnswer[0] == "Married/ civil partnership") {
          DbHelper.insatance..deleteWithquestion('Marital');
          _insert('Marital', 'Married/ civil partnership', 'OK');
          return LivingTogether("", 220.0);
        } else if (widget.CheckAnswer[0] == "Divorced") {
          //Partner Relation
          Questions.LivingCheck = 1;
          DbHelper.insatance.deleteWithquestion('Marital');
          _insert('Marital', 'Divorced', 'OK');
          return DivorceDate("", 430.0);
        } else if (widget.CheckAnswer[0] == "Widowed") {
          //Partner Relation
          Questions.LivingCheck = 1;

          DbHelper.insatance.deleteWithquestion('Marital');
          _insert('Marital', 'Widowed', 'OK');

          return WidowedDate("", 430.0);
        } else if (widget.CheckAnswer[0] == "It's Complicated") {
          //For No 430.0
          //For yes 220.0
          DbHelper.insatance.deleteWithquestion('Marital');
          _insert('Marital', 'It\'s Complicated', 'OK');
          return FormallyMarried("", 430.0);
        }
      } else if (widget.CheckQuestion == "Payments Reason.") {
        return FirstPaymentDate("", 430.0);
      }
      // Alimony paid alimony paid
      else if (widget.CheckQuestion == "Alimony Paid.") {
        if (widget.CheckAnswer[0] == "None") {
          Questions.LivingCheck = 1;
          //qu.addAnswer("You","", "", [], 80.0);
          DbHelper.insatance..deleteWithquestion('Marital');
          _insert('Marital', 'Single', 'OK');
          return Text("");
        } else if (widget.CheckAnswer[0] == "skip") {
          //  Questions.LivingCheck = 1;
          // return OccupationContainer("",430.0);
          DbHelper.insatance.deleteWithquestion('Marital');
          _insert('Marital', 'skip', 'skip');
          return Text("");
        } else if (widget.CheckAnswer[0] == "Pension rights adjustment") {
          DbHelper.insatance..deleteWithquestion('Marital');
          _insert('Marital', 'Married/ civil partnership', 'OK');
          return PensionRightsYesNo("", 430.0);
        } else if (widget.CheckAnswer[0] == "Prevention of an adjustment") {
          //Partner Relation
          Questions.LivingCheck = 1;
          DbHelper.insatance.deleteWithquestion('Marital');
          _insert('Marital', 'Divorced', 'OK');
          return PensionRightsYesNo("", 430.0);
        } else if (widget.CheckAnswer[0] == "Alimony to ex") {
          //Partner Relation
          Questions.LivingCheck = 1;
          DbHelper.insatance.deleteWithquestion('Marital');
          _insert('Marital', 'Divorced', 'OK');
          return PensionRightsYesNo("", 430.0);
        }
      } else if (widget.CheckQuestion == "First Payment.") {
        return CalculationPaymentRight("", 430.0);
      } else if (widget.CheckQuestion == "Pension Rights Adjustments.") {
        return OccupationContainer("", 430.0);
      }

//divorce date
      else if (widget.CheckQuestion == "Date of divorce") {
        return OccupationContainer("", 430.0);
      } else if (widget.CheckQuestion == "Date of sell") {
        return ApplySources("", 430.0);
      }

      //Widowed since

      else if (widget.CheckQuestion == "Widowed since") {
        return OccupationContainer("", 430.0);
      }

      //living together tax year

      else if (widget.CheckQuestion == "Living together") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Living together');
          _insert('Living together', 'No', 'OK');
          return StartLivingPart("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Living together');
          _insert('Living together', 'Yes', 'OK');
          return GetMarried("", 220.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Living together');
          _insert('Living together', 'skip', 'skip');
          //saif
          return StartLivingPart("", 430.0);
        }
      }

      //Start living part of married/civilpartnership

      else if (widget.CheckQuestion == "Date of separation") {
        return AssessedJointly("", 430.0);
      }

      //Start living part of married/civilpartnership
      //Date of marriage

      else if (widget.CheckQuestion == "Date of marriage") {
        return AssessedJointly("", 430.0);
      }

      //It's Complicated Formally Married
      else if (widget.CheckQuestion == "Formally married") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Formally married');
          _insert('Formally married', 'No', 'OK');
          return OccupationContainer("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Formally married');
          _insert('Formally married', 'Yes', 'OK');
          return LivingTogether("", 220.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Formally married');
          _insert('Formally married', 'skip', 'skip');
          //saif
          return OccupationContainer("", 430.0);
        }
      }

      //Assesses Jointly
      else if (widget.CheckQuestion == "Joint assessment") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Joint assessment');
          _insert('Joint assessment', 'No', 'OK');
          return OccupationContainer("", 430.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Joint assessment');
          _insert('Joint assessment', 'skip', 'skip');
          //saif
          return OccupationContainer("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Joint assessment');
          _insert('Joint assessment', 'Yes', 'OK');
          //Partner's Question will be here for married/civilpartnership
          Questions.LivingCheck = 2;
          // qu.updateAnswer("You & Partner","", "", [], 60.0);
          //qu.addAnswer("You", "", "", [], 60.0);
          return OccupationContainer("", 430.0);
        }
      } else if (widget.CheckQuestion == "Occupation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Employed") {
            _setStringKeyNo();
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Employed', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            return ProfessionalCourseTraining("", 430.0);
          } else if (widget.CheckAnswer[m] == "Minijob (e.g. 450€ basis)") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Minijob (e.g. 450€ basis)', 'OK');

            // write
            setState(() {
              _setStringKey();
            });

            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "Minijob";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "Minijob";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            return IncomeSources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Studying") {
            setState(() {
              _setStringKeyNo();
            });

            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Studying', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "Studying";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "Education";

            //return ApplyStudies("",430.0);
            return EarnMoney("", 430.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'skip', 'skip');
            // _insert('Occupation', 'skip', 'OK');

            // // // For Relation in Finance
            // // Questions.occupationStudyingFinance ="skip";

            // // //For Relation in Home
            // // Questions.occupationMiniJobHome = "";

            // // //For Relation in Finance
            // // Questions.occupationMiniJobFinance = "";
            // // Questions.specialistActivityFinance = "";

            // // //For Relation to Education Enable
            // // Questions.educationCategoryEnable = "skip";

            // // //return ApplyStudies("",430.0);
            // // return EarnMoney("",430.0);

            // // For Relation in Finance
            // Questions.occupationStudyingFinance ="";

            // //For Relation in Home
            // Questions.occupationMiniJobHome = "";

            // //For Relation in Finance
            // Questions.occupationMiniJobFinance = "";
            // Questions.specialistActivityFinance = "";

            // //For Relation to Education Enable
            // Questions.educationCategoryEnable = "";

            //  return Text("");

            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            //return UnSupportedScreen();
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Training") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Training', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "Education";

            //return KindOfTraining("",430.0);
            return EarnMoney("", 430.0);
          } else if (widget.CheckAnswer[m] == "Self-employed") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Self-employed', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            //return UnSupportedScreen();
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Own business") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Own business', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            //return UnSupportedScreen();
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Forestry") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Forestry', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            //return UnSupportedScreen();
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Retired") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Retired', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            //return UnSupportedScreen();
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Parental Leave") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Parental Leave', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            return IncomeSources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Not working") {
            setState(() {
              _setStringKeyNo();
            });
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Not working', 'OK');
            // For Relation in Finance
            Questions.occupationStudyingFinance = "";

            //For Relation in Home
            Questions.occupationMiniJobHome = "";

            //For Relation in Finance
            Questions.occupationMiniJobFinance = "";
            Questions.specialistActivityFinance = "";

            //For Relation to Education Enable
            Questions.educationCategoryEnable = "";

            return IncomeSources("", 430.0);
          }
        }
      } else if (widget.CheckQuestion == "Training") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Training');
          _insert('Training', 'No', 'OK');
          //For Relation to Education Enable
          Questions.educationCategoryEnable = "";
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Training');
          _insert('Training', 'Yes', 'OK');
          //For Relation to Education Enable
          Questions.educationCategoryEnable = "Education";
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Training');
          _insert('Training', 'skip', 'skip');
          //For Relation to Education Enable
          Questions.educationCategoryEnable = "";
        }

        //for Letting and Leasing 220.0
        // for sale of property 220.0
        // for capital gain 220.0
        //for pension 220.0
        ////for Alimony here we said 430.0 but we have to check for 380.0 its better if I put 380.0
        return IncomeSources("", 430.0);
      }

      // studying and training(Earn Money)

      else if (widget.CheckQuestion == "Income from") {
        if (widget.CheckAnswer[0] == "with a minijob") {
          setState(() {
            _setStringKey();
            print("set state work in income from");
          });
        } else if (widget.CheckAnswer[0] == "No") {
          setState(() {
            _setStringKey();
            print("set state work in income from");
          });
          return IncomeSources("", 430.0);
        }

        return IncomeSources("", 430.0);
//      for(int m=0;m<widget.CheckAnswer.length;m++) {
//        if(widget.CheckAnswer[m] == "Part-time degree")
//        {
//          return IncomeSources("",430.0);
//        }
//        else if(widget.CheckAnswer[m] == "Distance learning") {
//          return IncomeSources("",430.0);
//        }
//        else if(widget.CheckAnswer[m] == "Postgraduate studies")
//        {
//          return IncomeSources("",430.0);
//        }
//        else if(widget.CheckAnswer[m] == "None")
//        {
//          return PreviousCompletedDegree("",430.0);
//        }
//
//
//      }
      }

//        else if(widget.CheckQuestion == "Type of study")
//        {
//          for(int m=0;m<widget.CheckAnswer.length;m++) {
//            if(widget.CheckAnswer[m] == "Part-time degree")
//            {
//              return IncomeSources("",430.0);
//            }
//            else if(widget.CheckAnswer[m] == "Distance learning") {
//              return IncomeSources("",430.0);
//            }
//            else if(widget.CheckAnswer[m] == "Postgraduate studies")
//            {
//              return IncomeSources("",430.0);
//            }
//            else if(widget.CheckAnswer[m] == "None")
//            {
//              return PreviousCompletedDegree("",430.0);
//            }
//
//
//          }
//        }

      //previouslydegreecompleted
      else if (widget.CheckQuestion == "Previous degree" &&
          (widget.CheckAnswer[0] == "Yes" ||
              widget.CheckAnswer[0] == "No" ||
              widget.CheckAnswer[0] == "skip")) {
        DbHelper.insatance.deleteWithquestion('Previous degree');
        _insert(
            'Previous degree', widget.CheckAnswer[0], widget.CheckAnswer[0]);
        return IncomeSources("", 430.0);
      }

      //Typeoftraining
      else if (widget.CheckQuestion == "Type of training" &&
          (widget.CheckAnswer[0] == "Dual training" ||
              widget.CheckAnswer[0] == "Professional School" ||
              widget.CheckAnswer[0] == "skip")) {
        DbHelper.insatance.deleteWithquestion('Type of training');
        _insert(
            'Type of training', widget.CheckAnswer[0], widget.CheckAnswer[0]);
        return IncomeSources("", 430.0);
      } else if (widget.CheckQuestion == "Other income") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Letting and Leasing") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Letting and Leasing', 'OK');
            //For relations with income
            Questions.alimonyReceivedIncome = "";

            //For relations with income
            Questions.salePropertyIncome = "";

            //return UnSupportedScreen();
            return Text("");
          } else if (widget.CheckAnswer[m] == "Sale of Property") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Sale of Property', 'OK');
            //For relations with income
            Questions.alimonyReceivedIncome = "";

            //For relations with income
            Questions.salePropertyIncome = "Sale of property";

            //for yes 210 and for no 380.0
            return SaleProperty("", 380.0);
          } else if (widget.CheckAnswer[m] == "Capital gains") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Capital gains', 'OK');
            //For relations with income
            Questions.alimonyReceivedIncome = "";

            //For relations with income
            Questions.salePropertyIncome = "";

            //for no 210 and for yes 430.0
            return CapitalGain("", 430.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'skip', 'skip');
            //saif
            //For relations with income
            Questions.alimonyReceivedIncome = "";

            //For relations with income
            Questions.salePropertyIncome = "";

            //return UnSupportedScreen();
            return Text("");
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'skip', 'skip');
            //saif
            //For relations with income
            Questions.alimonyReceivedIncome = "";

            //For relations with income
            Questions.salePropertyIncome = "";

            //return UnSupportedScreen();
            return ApplySources("", 220);
          } else if (widget.CheckAnswer[m] == "Pensions") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Pensions', 'OK');
            //For relations with income
            Questions.alimonyReceivedIncome = "";

            //For relations with income
            Questions.salePropertyIncome = "";

            //return UnSupportedScreen();
            return Text("");
          } else if (widget.CheckAnswer[m] == "Alimony") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Alimony', 'OK');
            //For relations with income
            Questions.alimonyReceivedIncome = "Alimony received";

            //For relations with income
            Questions.salePropertyIncome = "";

            //for Separated spouse 220.0
            // for Adult relatives 220.0
            //for child 220.0
            return ApplySources("", 220.0);
          }
        }
      }

      //for sale of property
      else if (widget.CheckQuestion == "More than one property") {
        if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('More than one property');
          _insert('More than one property', 'Yes', 'OK');
          //return UnSupportedScreen();
          return Text("");
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('More than one property');
          _insert('More than one property', 'No', 'OK');
          //for Have a disability 220.0
          //for Alimony here we said 430.0 but we have to check for 380.0 its better if I put 380.0
          //for Survivor's pension unsupported screen show 220.0
          //for None 220.0
          return ApplySources("", 220.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('More than one property');
          _insert('More than one property', 'skip', 'skip');
          //saif
          //for Have a disability 220.0
          //for Alimony here we said 430.0 but we have to check for 380.0 its better if I put 380.0
          //for Survivor's pension unsupported screen show 220.0
          //for None 220.0
          return ApplySources("", 430.0);
        }
      }

      //for Alimony check that yaha alimony check krna agar 4e ha to 6b select but shown same
      else if (widget.CheckQuestion == "Alimony recipient") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Separated spouse") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'Separated spouse', 'OK');
            return TaxReturn("", 430.0);
          } else if (widget.CheckAnswer[m] == "Adult relatives") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'Adult relatives', 'OK');
            //return UnSupportedScreen();
            return Text("");
          } else if (widget.CheckAnswer[m] == "Child") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'Child', 'OK');
            //for no 220.0
            // for yes 380.0
            return ChildTaxAllowance("", 380.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'skip', 'skip');
            //return UnSupportedScreen();
            return Text("");
          }
        }
      }
      //Child benefits
      else if (widget.CheckQuestion == "Child benefits") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'No', 'OK');
          //return UnSupportedScreen();
          return Text("");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'Yes', 'OK');

          setState(() {
            _setStringAlimony();
            print("alimony key sert to child benefits yes");
          });

          // return WhatKindOfAlimony("", 430.0);
          return TaxReturn("", 220);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'skip', 'skip');
          //return UnSupportedScreen();
          return Text("");
        }
      } else if (widget.CheckQuestion == "Alimpny Paid.") {
        if (widget.CheckAnswer[0] == "Pension rights adjustment") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'No', 'OK');
          //return UnSupportedScreen();
          return WhatKindOfAlimony("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'Yes', 'OK');

          setState(() {
            _setStringAlimony();
            print("alimony key sert to child benefits yes");
          });

          return TaxReturn("", 430.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'skip', 'skip');
          //return UnSupportedScreen();
          return Text("");
        }
      }

      //for capitalgain

      else if (widget.CheckQuestion == "German account") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('German account');
          _insert('German account', 'No', 'OK');
          return ReceiveCapitalGain("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('German account');
          _insert('German account', 'Yes', 'OK');
          //380.0 for interest in capitalgain
          // 420.for From shares
          // 430.0 for From loans check its size it has three elements
          // 220.0 For insurance contracts
          // 220.0 Old shares from funds
          //430.0 	From complex financial instruments
          return ReceiveCapitalGain("", 430.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('German account');
          _insert('German account', 'skip', 'skip');
          return ReceiveCapitalGain("", 430.0);
        }
      } else if (widget.CheckQuestion == "Type of Capital gains") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Interest") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'Interest', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "From shares") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'From shares', 'OK');
            //for dividends and Earnings  and Liquidation proceeds  and Shares in associations and foundations size is 220.0,Earnings from sale of stocks is 380.0,Shares in associations and foundations 380.0
            return IncomeShares("", 380.0);
          } else if (widget.CheckAnswer[m] == "From loans") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'From loans', 'OK');
            //for Privateloan unsupported 220.0
            //for Shareholder loan question 21  220.0
            // for Partiarisches Darlehen 220.0
            return TypeOfLoan("", 220.0);
          } else if (widget.CheckAnswer[m] == "From insurance contracts") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'From insurance contracts', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Old shares from funds") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'From insurance contracts', 'OK');
            return OldFundShares("", 220.0);
          } else if (widget.CheckAnswer[0] == "skip") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'skip', 'skip');
            //return UnSupportedScreen();
            return Text("");
          } else if (widget.CheckAnswer[m] ==
              "From complex financial instruments") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains',
                'From complex financial instruments', 'OK');
            //For Domestic Investment Funds 220.0
            //For Investment funds 220.0
            // For Option 220.0
            // For Option Premiums 220.0
            // For Derivatives 220.0
            //For Bonds 220.0
            return FinancialInstruments("", 220.0);
          }
        }
      } else if (widget.CheckQuestion == "Loan") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Private loan") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'Private loan', 'OK');
            //return UnSupportedScreen();
            return Text("");
          } else if (widget.CheckAnswer[m] == "Shareholder loan") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'Shareholder loan', 'OK');
            return Shares10Company("", 220.0);
          } else if (widget.CheckAnswer[m] == "Partiarisches Darlehen") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'Partiarisches Darlehen', 'OK');
            //return UnSupportedScreen();
            return Text("");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'skip', 'skip');
            //return UnSupportedScreen();
            return Text("");
          }
        }
      } else if (widget.CheckQuestion == "> 10% of shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('> 10% of shares');
          _insert('> 10% of shares', 'No', 'OK');
          return ApplySources("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('> 10% of shares');
          _insert('> 10% of shares', 'Yes', 'OK');
          return Text("");
          //return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('> 10% of shares');
          _insert('> 10% of shares', 'skip', 'skip');
          //return UnSupportedScreen();
          return Text("");
        }
      } else if (widget.CheckQuestion == "Certificate for old shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'No', 'OK');
          //return UnSupportedScreen();
          return Text("");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'skip', 'skip');
          //return UnSupportedScreen();
          return Text("");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'Yes', 'OK');
          return ApplySources("", 430.0);
        }
      } else if (widget.CheckQuestion == "Pension Rights.") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'No', 'OK');
          //return UnSupportedScreen();
          return OccupationContainer("", 430);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'skip', 'skip');
          //return UnSupportedScreen();
          return OccupationContainer("", 430);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'Yes', 'OK');
          return CalculationPayment("", 230.0);
        }
      } else if (widget.CheckQuestion == "Shares") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Dividends") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Dividends', 'OK');
            return KeyRole("", 220.0);
          } else if (widget.CheckAnswer[m] == "Earnings from sale of stocks") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Earnings from sale of stocks', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Liquidation proceeds") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Liquidation proceeds', 'OK');
            return KeyRole("", 220.0);
          } else if (widget.CheckAnswer[m] ==
              "Shares in associations and foundations") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Liquidation proceeds', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Silent partnerships") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Silent partnerships', 'OK');
            return Text("");
            //return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'skip', 'skip');
            return Text("");
            //return UnSupportedScreen();
          }
        }
      }

      //financial assets
      else if (widget.CheckQuestion == "Financial assests") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Domestic investment funds") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Domestic investment funds', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Foreign investment funds") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Foreign investment funds', 'OK');
            return Text("");
            //return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Options") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Options', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Option premiums") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Option premiums', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Derivatives") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Derivatives', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Bonds") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Bonds', 'OK');
            return ApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'skip', 'skip');
            return ApplySources("", 430.0);
          }
        }
      } else if (widget.CheckQuestion == "Key roles") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Key roles');
          _insert('Key roles', 'No', 'OK');
          return Shares25Company("", 220.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Key roles');
          _insert('Key roles', 'skip', 'skip');
          //skip
          return Shares25Company("", 220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Key roles');
          _insert('Key roles', 'Yes', 'OK');
          return Shares1Company("", 220.0);
        }
      } else if (widget.CheckQuestion == "> 25% of shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('> 25% of shares');
          _insert('> 25% of shares', 'No', 'OK');
          return ApplySources("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('> 25% of shares');
          _insert('> 25% of shares', 'Yes', 'OK');
          return Text("");
          //return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('> 25% of shares');
          _insert('> 25% of shares', 'skip', 'skip');
          //skip
          return Text("");
          //return UnSupportedScreen();
        }
      } else if (widget.CheckQuestion == "> 1% of shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('> 1% of shares');
          _insert('> 1% of shares', 'skip', 'skip');
          return ApplySources("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('> 1% of shares');
          _insert('> 1% of shares', 'Yes', 'OK');
          return Text("");
          //return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('> 1% of shares');
          _insert('> 1% of shares', 'skip', 'skip');
          //skip
          return Text("");
          //return UnSupportedScreen();
        }
      } else if (widget.CheckQuestion == "Further Information") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Have a disability") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'Have a disability', 'OK');
            //For relation in health
            Questions.haveDisabilityHealth = "Have a disability";

            //For relation in Family
            Questions.alimonyPaidFamily = "";

            return TaxReturn("", 220.0);
          } else if (widget.CheckAnswer[m] == "Alimony paid") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'Alimony paid', 'OK');
            //For relation in health
            Questions.haveDisabilityHealth = "";

            //For relation in Family
            Questions.alimonyPaidFamily = "Alimony paid";

            //question 8
            return PayAlimony("", 220.0);
          } else if (widget.CheckAnswer[m] == "Survivor’s pension") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'Survivor’s pension', 'OK');
            //For relation in health
            Questions.haveDisabilityHealth = "";

            //For relation in Family
            Questions.alimonyPaidFamily = "";

            //question 8
            return Text("");
            //return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'None', 'OK');
            //For relation in health
            Questions.haveDisabilityHealth = "";

            //For relation in Family
            Questions.alimonyPaidFamily = "";

            //question 8
            //for Questions. LivingCheck=1 220.0
            //for Questions. LivingCheck=2 430.0
            return TaxReturn("", 430.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'skip', 'skip');
            //saif
            //For relations with income
            Questions.alimonyReceivedIncome = "";

            //For relations with income
            Questions.salePropertyIncome = "";

            //for no 210 and for yes 430.0
            return TaxReturn("", 220.0);
          }
        }
      } else if (widget.CheckQuestion == "Email address.") {
        return CalculationPin("", 220);
      } else if (widget.CheckQuestion == "Pin.") {
        return TermsNcondition("", 220);
      } else if (widget.CheckQuestion == "Terms and condition.") {
        return FinishCategory(
            "Living Situation Category", "Income Category", 1, true);
      } else if (widget.CheckQuestion == "Disability Certificate") {
        if (widget.CheckAnswer[0] == "Yes") {
          return DisabilitySinceDate("", 220);
        } else if (widget.CheckAnswer[0] == "No") {
          return DisabilitySinceDate("", 220);
        } else if (widget.CheckAnswer[0] == "skip") {
          return DisabilitySinceDate("", 220);
        }
      } else if (widget.CheckQuestion == "Date of disability") {
        //Partner Relation
        Questions.LivingCheck = 1;
        DbHelper.insatance.deleteWithquestion('Date of disability');
        _insert('Date of disability', '12/12/2012', 'OK');
        return DisabilityIndefinite("", 430.0);
      } else if (widget.CheckQuestion == "Disability Indefinite") {
        if (widget.CheckAnswer[0] == "Yes") {
          return CalculationDisability("", 220);
        } else if (widget.CheckAnswer[0] == "No") {
          return DisabilityValidDate("", 220);
        } else if (widget.CheckAnswer[0] == "skip") {
          return DisabilityValidDate("", 220);
        }
      } else if (widget.CheckQuestion == "Date of validity") {
        //Partner Relation
        return CalculationDisability("", 220);
      } else if (widget.CheckQuestion == "Degree of disability.") {
        //Partner Relation
        Questions.LivingCheck = 1;
        DbHelper.insatance.deleteWithquestion('Date of disability');
        _insert('Date of disability', '12/12/2012', 'OK');
        return DisabilityApply("", 430.0);
      }
      if (widget.CheckQuestion == "Disability Apply") {
        if (widget.CheckAnswer[0] == "Blind") {
          return DisabilityHomeChange("", 430);
        } else if (widget.CheckAnswer[0] == "skip") {
          return DisabilityHomeChange("", 430);
        } else if (widget.CheckAnswer[0] == "Permanent Helpless") {
          return DisabilityHomeChange("", 430);
        } else if (widget.CheckAnswer[0] == "Handicapped") {
          return DisabilityHomeChange("", 430);
        } else if (widget.CheckAnswer[0] == "None of these") {
          return DisabilityHomeChange("", 430);
        }
      } else if (widget.CheckQuestion == "Disability home change") {
        if (widget.CheckAnswer[0] == "Yes") {
          return TaxReturn("", 220);
        } else if (widget.CheckAnswer[0] == "No") {
          return TaxReturn("", 220);
        } else if (widget.CheckAnswer[0] == "skip") {
          return TaxReturn("", 220);
        }
      } else if (widget.CheckQuestion == "Tax return filed" &&
          (widget.CheckAnswer[0] == "skip")) {
        DbHelper.insatance.deleteWithquestion('Tax return filed');
        _insert('Tax return filed', 'skip', 'skip');
        return HaveChildren("", 220.0);
      } else if (widget.CheckQuestion == "Tax return filed" &&
          (widget.CheckAnswer[0] == "No" || widget.CheckAnswer[0] == "Yes")) {
        DbHelper.insatance.deleteWithquestion('Tax return filed');
        _insert(
            'Tax return filed', widget.CheckAnswer[0], widget.CheckAnswer[0]);
        //saif skip
        if (Questions.LivingCheck == 1) {
          return HaveChildren("", 220.0);
        } else if (Questions.LivingCheck == 2) {
          Questions.LivingCheck = 3;
          qu.addAnswer("Partner", "", "", [], 60.0);
          //Partner's Yaha sa start hoga ab .Partner ka flow
          //Yaha size right nhi check it
          return PartnerOccupationContainer("", 220.0);
        }
      } else if (widget.CheckQuestion == "Children") {
        if (widget.CheckAnswer[0] == "No") {
          _setStringKeyFamily();
          DbHelper.insatance.deleteWithquestion('Children');
          _insert('Children', 'No', 'OK');
          //For relation with health
          Questions.childrenYesHealth = "";

          //For relation to enable family
          Questions.familyCategoryEnable = "";

          //For yes 220.0
          //For living abroad no :420
          //yaha last ma at home ka kaam bhi krna ha
          return LiveAlone("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          _setStringKeyFamilyYes();
          DbHelper.insatance.deleteWithquestion('Children');
          _insert('Children', 'Yes', 'OK');
          //For relation with health
          Questions.childrenYesHealth = "Childrenyes";

          //For relation to enable family
          Questions.familyCategoryEnable = "Family";

          //For yes 220.0
          //For living abroad no :420
          //yaha last ma at home ka kaam bhi krna ha
          return LiveAlone("", 430.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          _setStringKeyFamilyYes();
          DbHelper.insatance.deleteWithquestion('Children');
          _insert('Children', 'skip', 'skip');
          //For relation with health
          Questions.childrenYesHealth = "";

          //For relation to enable family
          Questions.familyCategoryEnable = "";

          //For yes 220.0
          //For living abroad no :420
          //yaha last ma at home ka kaam bhi krna ha
          return LiveAlone("", 430.0);
        }
      } else if (widget.CheckQuestion == "Living alone") {
        if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Living alone');
          _insert('Living alone', 'Yes', 'OK');
          return LiveAbroad("", 220.0);
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Living alone');
          _insert('Living alone', 'No', 'OK');
          return WhoLiveWith("", 220.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Living alone');
          _insert('Living alone', 'skip', 'skip');
          //saif
          return WhoLiveWith("", 220.0);
        }
      }

      //Living situation

      else if (widget.CheckQuestion == "Living situation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "With my spouse") {
            DbHelper.insatance.deleteWithquestion('Living situation');
            _insert('Living situation', 'With my spouse', 'OK');
            return LiveAbroad("", 220.0);
          } else if (widget.CheckAnswer[m] == "With my partner") {
            DbHelper.insatance.deleteWithquestion('Living situation');
            _insert('Living situation', 'With my partner', 'OK');
            //question 8
            return LiveAbroad("", 220.0);
          } else if (widget.CheckAnswer[m] == "With my children") {
            DbHelper.insatance.deleteWithquestion('Living situation');
            _insert('Living situation', 'With my children', 'OK');
            //question 8
            return LiveAbroad("", 220.0);
          } else if (widget.CheckAnswer[m] == "In a flat share") {
            DbHelper.insatance.deleteWithquestion('Living situation');
            _insert('Living situation', 'In a flat share', 'OK');
            //question 8
            return LiveAbroad("", 220.0);
          } else if (widget.CheckAnswer[m] == "With my parents") {
            DbHelper.insatance.deleteWithquestion('Living situation');
            _insert('Living situation', 'With my parents', 'OK');
            //question 8
            return LiveAbroad("", 220.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Living situation');
            _insert('Living situation', 'skip', 'skip');
            //question 8
            //saif
            return LiveAbroad("", 220.0);
          }
        }
      } else if (widget.CheckQuestion == "Living abroad") {
        return ForeignIncome("", 220.0);
      } else if (widget.CheckQuestion == "Living abroad") {
        if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Living abroad');
          _insert('Living abroad', 'Yes', 'OK');
          return Text("");
          //return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Living abroad');
          _insert('Living abroad', 'skip', 'skip');
          return Text("");
          //return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Living abroad');
          _insert('Living abroad', 'No', 'OK');
          return ForeignIncome("", 220.0);
        }
      } else if (widget.CheckQuestion == "Foreign Income") {
        if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Foreign Income');
          _insert('Foreign Income', 'Yes', 'OK');
          return Text("");
          //return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Foreign Income');
          _insert('Foreign Income', 'No', 'OK');
          return CalculationEmail("", 220);
          // return FinishCategory(
          //     "Living Situation Category", "Income Category", 1, true);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Foreign Income');
          _insert('Foreign Income', 'skip', 'skip');
          return CalculationEmail("", 220);
          //skip
          // return FinishCategory(
          //     "Living Situation Category", "Income Category", 1, true);
        }
      }
    } else if (widget.CheckQuestion == "Email address.") {
      return CalculationPin("", 220);
    }
    // ======================================== Partner's Flow Has been Started ============================================ //
    // ======================================== Partner's Flow Has been Started ============================================ //
    // ======================================== Partner's Flow Has been Started ============================================ //
    // ======================================== Partner's Flow Has been Started ============================================ //
    // ======================================== Partner's Flow Has been Started ============================================ //
    // ======================================== Partner's Flow Has been Started ============================================ //

    else if (Questions.LivingCheck == 3) {
      if (widget.CheckQuestion == "Occupation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Employed") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Employed', 'OK');
            return PartnerProfessionalCourseTraining("", 430.0);
          } else if (widget.CheckAnswer[m] == "Minijob (e.g. 450€ basis)") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Minijob (e.g. 450€ basis)', 'OK');
            return PartnerIncomeSources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Studying") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Studying', 'OK');
            //For Part-time degree 430.0
            //For Distance learning 430.0
            //For Postgraduate studies 430.0
            //For None 220.0

            //return PartnerApplyStudies("",430.0);
            return PartnerEarnMoney("", 430.0);
          } else if (widget.CheckAnswer[m] == "Training") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Training', 'OK');
            return PartnerEarnMoney("", 430.0);
            //return PartnerKindOfTraining("",430.0);
          } else if (widget.CheckAnswer[m] == "Self-employed") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Self-employed', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Own business") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Own business', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Forestry") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Forestry', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Retired") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Retired', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'skip', 'skip');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Parental Leave") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Parental Leave', 'OK');
            return PartnerIncomeSources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Not working") {
            DbHelper.insatance.deleteWithquestion('Occupation');
            _insert('Occupation', 'Not working', 'OK');
            return PartnerIncomeSources("", 430.0);
          }
        }
      } else if (widget.CheckQuestion == "Training" &&
          (widget.CheckAnswer[0] == "Yes" || widget.CheckAnswer[0] == "No")) {
        DbHelper.insatance.deleteWithquestion('Training');
        _insert('Training', widget.CheckAnswer[0], 'OK');
        //for Letting and Leasing 220.0
        // for sale of property 220.0
        // for capital gain 220.0
        //for pension 220.0
        ////for Alimony here we said 430.0 but we have to check for 380.0 its better if I put 380.0
        return PartnerIncomeSources("", 430.0);
      } else if (widget.CheckQuestion == "Training" &&
          widget.CheckAnswer[0] == "skip") {
        DbHelper.insatance.deleteWithquestion('Training');
        _insert('Training', 'skip', 'skip');
        return UnSupportedScreen();
      }

      // studying and training(Partner Earn money)
      else if (widget.CheckQuestion == "Income from") {
        return PartnerIncomeSources("", 430.0);
      }

//  else if(widget.CheckQuestion == "Type of study")
//  {
//    for(int m=0;m<widget.CheckAnswer.length;m++) {
//      if(widget.CheckAnswer[m] == "Part-time degree")
//      {
//        return PartnerIncomeSources("",430.0);
//      }
//      else if(widget.CheckAnswer[m] == "Distance learning") {
//        return PartnerIncomeSources("",430.0);
//      }
//      else if(widget.CheckAnswer[m] == "Postgraduate studies")
//      {
//        return PartnerIncomeSources("",430.0);
//      }
//      else if(widget.CheckAnswer[m] == "None")
//      {
//        return PartnerPreviousCompletedDegree("",430.0);
//      }
//
//
//    }
//  }

      //previouslydegreecompleted
      else if (widget.CheckQuestion == "Previous degree" &&
          (widget.CheckAnswer[0] == "Yes" || widget.CheckAnswer[0] == "No")) {
        DbHelper.insatance.deleteWithquestion('Previous degree');
        _insert(
            'Previous degree', widget.CheckAnswer[0], widget.CheckAnswer[0]);
        return PartnerIncomeSources("", 430.0);
      }

      //previouslydegreecompleted
      else if (widget.CheckQuestion == "Previous degree" &&
          widget.CheckAnswer[0] == "skip") {
        DbHelper.insatance.deleteWithquestion('Previous degree');
        _insert('Previous degree', 'skip', 'skip');
        return UnSupportedScreen();
      }

      //Typeoftraining
      else if (widget.CheckQuestion == "Type of training" &&
          (widget.CheckAnswer[0] == "Dual training" ||
              widget.CheckAnswer[0] == "Professional School")) {
        DbHelper.insatance.deleteWithquestion('Type of training');
        _insert(
            'Type of training', widget.CheckAnswer[0], widget.CheckAnswer[0]);
        return PartnerIncomeSources("", 430.0);
      }

      //Typeoftraining
      else if (widget.CheckQuestion == "Type of training" &&
          (widget.CheckAnswer[0] == "skip")) {
        DbHelper.insatance.deleteWithquestion('Type of training');
        _insert('Type of training', 'skip', 'skip');
        return UnSupportedScreen();
      } else if (widget.CheckQuestion == "Other income") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Letting and Leasing") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Letting and Leasing', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Sale of Property") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Sale of Property', 'OK');
            //for yes 210 and for no 380.0

            return PartnerSaleProperty("", 380.0);
          } else if (widget.CheckAnswer[m] == "Capital gains") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Capital gains', 'OK');
            //for no 210 and for yes 430.0
            return PartnerCapitalGain("", 430.0);
          } else if (widget.CheckAnswer[m] == "Pensions") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Pensions', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'skip', 'skip');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'skip', 'skip');
            return PartnerCapitalGain("", 430.0);
          } else if (widget.CheckAnswer[m] == "Alimony") {
            DbHelper.insatance.deleteWithquestion('Other income');
            _insert('Other income', 'Alimony', 'OK');
            //for Separated spouse 220.0
            // for Adult relatives 220.0
            //for child 220.0
            return ApplySources("", 220.0);
          }
        }
      }

      //for sale of property
      else if (widget.CheckQuestion == "More than one property") {
        if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('More than one property');
          _insert('More than one property', 'Yes', 'OK');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('More than one property');
          _insert('More than one property', 'skip', 'skip');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('More than one property');
          _insert('More than one property', 'No', 'OK');
          //for Have a disability 220.0
          //for Alimony here we said 430.0 but we have to check for 380.0 its better if I put 380.0
          //for Survivor's pension unsupported screen show 220.0
          //for None 220.0
          return PartnerApplySources("", 430.0);
        }
      }

      //for Alimony check that yaha alimony check krna agar 4e ha to 6b select but shown same
      else if (widget.CheckQuestion == "Alimony recipient") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Separated spouse") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'Separated spouse', 'OK');
            return TaxReturn("", 430.0);
          } else if (widget.CheckAnswer[m] == "Adult relatives") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'Adult relatives', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'skip', 'skip');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Child") {
            DbHelper.insatance.deleteWithquestion('Alimony recipient');
            _insert('Alimony recipient', 'Child', 'OK');
            //for no 220.0
            // for yes 380.0
            return PartnerChildTaxAllowance("", 380.0);
          }
        }
      }
      //Child benefits
      else if (widget.CheckQuestion == "Child benefits") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'No', 'OK');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'skip', 'skip');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Child benefits');
          _insert('Child benefits', 'Yes', 'OK');

          setState(() {
            _setStringAlimony();
            print("alimony key sert to child benefits yes");
          });

          return TaxReturn("", 220);
        }
      }

      //for capitalgain

      else if (widget.CheckQuestion == "German account") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('German account');
          _insert('German account', 'No', 'OK');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('German account');
          _insert('German account', 'skip', 'skip');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('German account');
          _insert('German account', 'Yes', 'OK');
          //380.0 for interest in capitalgain
          // 420.for From shares
          // 430.0 for From loans check its size it has three elements
          // 220.0 For insurance contracts
          // 220.0 Old shares from funds
          //430.0 	From complex financial instruments
          return PartnerReceiveCapitalGain("", 430.0);
        }
      } else if (widget.CheckQuestion == "Type of Capital gains") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Interest") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'Interest', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "From shares") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'From shares', 'OK');
            //for dividends and Earnings  and Liquidation proceeds  and Shares in associations and foundations size is 220.0,Earnings from sale of stocks is 380.0,Shares in associations and foundations 380.0
            return PartnerIncomeShares("", 380.0);
          } else if (widget.CheckAnswer[m] == "From loans") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'From loans', 'OK');
            //for Privateloan unsupported 220.0
            //for Shareholder loan question 21  220.0
            // for Partiarisches Darlehen 220.0
            return PartnerTypeOfLoan("", 220.0);
          } else if (widget.CheckAnswer[m] == "From insurance contracts") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'From insurance contracts', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Old shares from funds") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'Old shares from funds', 'OK');
            return PartnerOldFundShares("", 220.0);
          } else if (widget.CheckAnswer[m] ==
              "From complex financial instruments") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains',
                'From complex financial instruments', 'OK');
            //For Domestic Investment Funds 220.0
            //For Investment funds 220.0
            // For Option 220.0
            // For Option Premiums 220.0
            // For Derivatives 220.0
            //For Bonds 220.0
            return PartnerFinancialInstruments("", 220.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Type of Capital gains');
            _insert('Type of Capital gains', 'skip', 'skip');
            return UnSupportedScreen();
          }
        }
      } else if (widget.CheckQuestion == "Loan") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Private loan") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'Private loan', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Shareholder loan") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'Shareholder loan', 'OK');
            return PartnerShares10Company("", 220.0);
          } else if (widget.CheckAnswer[m] == "Partiarisches Darlehen") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'Partiarisches Darlehen', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Loan');
            _insert('Loan', 'skip', 'skip');
            return UnSupportedScreen();
          }
        }
      } else if (widget.CheckQuestion == "> 10% of shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('> 10% of shares');
          _insert('> 10% of shares', 'skip', 'skip');
          return PartnerApplySources("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('> 10% of shares');
          _insert('> 10% of shares', 'Yes', 'OK');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('> 10% of shares');
          _insert('> 10% of shares', 'skip', 'skip');
          return UnSupportedScreen();
        }
      } else if (widget.CheckQuestion == "Certificate for old shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'No', 'OK');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'skip', 'skip');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Certificate for old shares');
          _insert('Certificate for old shares', 'Yes', 'OK');
          return PartnerApplySources("", 430.0);
        }
      } else if (widget.CheckQuestion == "Shares") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Dividends") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Dividends', 'OK');
            return PartnerKeyRole("", 220.0);
          } else if (widget.CheckAnswer[m] == "Earnings from sale of stocks") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Earnings from sale of stocks', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Liquidation proceeds") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Liquidation proceeds', 'OK');
            return PartnerKeyRole("", 220.0);
          } else if (widget.CheckAnswer[m] ==
              "Shares in associations and foundations") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Liquidation proceeds', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Silent partnerships") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'Silent partnerships', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Shares');
            _insert('Shares', 'skip', 'skip');
            return UnSupportedScreen();
          }
        }
      }

      //financial assets
      else if (widget.CheckQuestion == "Financial assests") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Domestic investment funds") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Domestic investment funds', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Foreign investment funds") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Foreign investment funds', 'OK');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'skip', 'skip');
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "Options") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Options', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Option premiums") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Option premiums', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Derivatives") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Derivatives', 'OK');
            return PartnerApplySources("", 430.0);
          } else if (widget.CheckAnswer[m] == "Bonds") {
            DbHelper.insatance.deleteWithquestion('Financial assests');
            _insert('Financial assests', 'Derivatives', 'OK');
            return PartnerApplySources("", 430.0);
          }
        }
      } else if (widget.CheckQuestion == "Key roles") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Key roles');
          _insert('Key roles', 'No', 'OK');
          return PartnerShares25Company("", 220.0);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Key roles');
          _insert('Key roles', 'skip', 'skip');
          return PartnerShares25Company("", 220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Key roles');
          _insert('Key roles', 'Yes', 'OK');
          return PartnerShares1Company("", 220.0);
        }
      } else if (widget.CheckQuestion == "> 25% of shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('> 25% of shares');
          _insert('> 25% of shares', 'No', 'OK');
          return PartnerApplySources("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('> 25% of shares');
          _insert('> 25% of shares', 'Yes', 'OK');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('> 25% of shares');
          _insert('> 25% of shares', 'skip', 'skip');
          return UnSupportedScreen();
        }
      } else if (widget.CheckQuestion == "> 1% of shares") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('> 1% of shares');
          _insert('> 1% of shares', 'No', 'OK');
          return PartnerApplySources("", 430.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('> 1% of shares');
          _insert('> 1% of shares', 'Yes', 'OK');
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('> 1% of shares');
          _insert('> 1% of shares', 'Yes', 'OK');
          return UnSupportedScreen();
        }
      } else if (widget.CheckQuestion == "Further Information") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Have a disability") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'Have a disability', 'OK');
            return PartnerTaxReturn("", 220.0);
          } else if (widget.CheckAnswer[m] == "Alimony paid") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'Alimony paid', 'OK');
            //question 8
            return PartnerPayAlimony("", 220.0);
          } else if (widget.CheckAnswer[m] == "Survivor’s pension") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'Survivor’s pension', 'OK');
            //question 8
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'skip', 'skip');
            //question 8
            return UnSupportedScreen();
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance.deleteWithquestion('Further Information');
            _insert('Further Information', 'None', 'None');
            //question 8
            //for Questions. LivingCheck=1 220.0
            //for Questions. LivingCheck=2 430.0
            return PartnerTaxReturn("", 220.0);
          }
        }
      } else if (widget.CheckQuestion == "Tax return filed" &&
          (widget.CheckAnswer[0] == "No" || widget.CheckAnswer[0] == "Yes")) {
        DbHelper.insatance.deleteWithquestion('Tax return filed');
        _insert('Tax return filed', widget.CheckAnswer[0], 'OK');
        Questions.livcolContainer = 1;
        qu.addAnswer("You & Partner", "", "", [], 60.0);

        return PartnerHaveChildren("", 220.0);
      } else if (widget.CheckQuestion == "Tax return filed" &&
          (widget.CheckAnswer[0] == "skip")) {
        DbHelper.insatance.deleteWithquestion('Tax return filed');
        _insert(
            'Tax return filed', widget.CheckAnswer[0], widget.CheckAnswer[0]);
        //saif tax return filed

        Questions.livcolContainer = 1;
        qu.addAnswer("You & Partner", "", "", [], 60.0);

        return PartnerHaveChildren("", 220.0);
      } else if (widget.CheckQuestion == "Children" &&
          (widget.CheckAnswer[0] == "No" || widget.CheckAnswer[0] == "Yes")) {
        DbHelper.insatance.deleteWithquestion('Children');
        _insert('Children', widget.CheckAnswer[0], 'OK');
        //For relation with health(Partner)
        Questions.childrenYesHealth = "Childrenyes";

        return PartnerLiveTogetherEntireYear("", 220.0);
      } else if (widget.CheckQuestion == "Children" &&
          (widget.CheckAnswer[0] == "skip")) {
        DbHelper.insatance.deleteWithquestion('Children');
        _insert('Children', 'skip', 'skip');
        // //For relation with health(Partner)
        // Questions.childrenYesHealth = "Childrenyes";

        // return PartnerLiveTogetherEntireYear("",220.0);

        //saif
        return UnSupportedScreen();
      } else if (widget.CheckQuestion == "Together all-year" &&
          (widget.CheckAnswer[0] == "No" || widget.CheckAnswer[0] == "Yes")) {
        DbHelper.insatance.deleteWithquestion('Together all-year');
        _insert('Together all-year', widget.CheckAnswer[0], 'OK');
        return PartnerLiveAbroad("", 220.0);
      } else if (widget.CheckQuestion == "Together all-year" &&
          (widget.CheckAnswer[0] == "skip")) {
        DbHelper.insatance.deleteWithquestion('Together all-year');
        _insert(
            'Together all-year', widget.CheckAnswer[0], widget.CheckAnswer[0]);
        // //For relation with health(Partner)
        // Questions.childrenYesHealth = "Childrenyes";

        // return PartnerLiveTogetherEntireYear("",220.0);

        //saif
        return UnSupportedScreen();
      }

      //Living situation

      else if (widget.CheckQuestion == "Living abroad") {
        if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Living abroad');
          _insert('Living abroad', widget.CheckAnswer[0], "OK");
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Living abroad');
          _insert('Living abroad', "skip", "skip");
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Living abroad');
          _insert('Living abroad', "No", "OK");
          return PartnerForeignIncome("", 220.0);
        }
      } else if (widget.CheckQuestion == "Foreign Income") {
        if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('Foreign Income');
          _insert('Foreign Income', "Yes", "OK");
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Foreign Income');
          _insert('Foreign Income', "skip", "skip");
          return UnSupportedScreen();
        } else if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('Foreign Income');
          _insert('Foreign Income', "No", "OK");
          return CalculationEmail("", 220);
          // return FinishCategory(
          //     "Living Situation Category", "Income Category", 1, true);
        }
      }
    }
  }

  Widget MaritalStatus(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container1(
        Identity: identity,
        BigQuestion: "",
        Question: "What is your official marital status in Germany?",
        briefqstn: """
        <p><strong>Marital status</strong></p>
        <p>Please enter your marital status. Choose the option applicable to you from the list.</p>
        <p><strong>UNMARRIED</strong></p>
        <p>On 31.12.2019 you were</p>
        <ol>
        <li>Unmarried</li>
        <li>Still separated or divorced</li>
        <li>Widowed</li>
        </ol>
        <p><strong>MARRIED / CIVIL PARTNERSHIP</strong></p>
        <p>You were married or in a civil partnership on or before 31.12.2019, and were living with your partner. If you got married abroad, the marriage must be listed in a German marriage register. You are not legally obligated to do so, but if you don&rsquo;t the marriage won&rsquo;t be recognized in Germany.</p>
        <p><strong>Important</strong> The marriage needs to be listed in the German marriage registry</p>
        <p><strong>DIVORCED</strong></p>
        <p>You got divorced in <strong>2019</strong>.</p>
        <p><strong>WIDOWED</strong></p>
        <p>You were widowed on or before 31.12.2019.</p>
        <p><strong>IT&rsquo;S COMPLICATED</strong></p>
        <p>You were already living separately from your partner as of 31.12.2019 but you were still married.</p>
        <p>In this case we have a couple more questions about your relationship status.</p>
        """,
        QuestionOption: "Marital",
        AnswerOption: [
          "Single",
          "Married/ civil partnership",
          "Divorced",
          "Widowed",
          "It's Complicated"
        ],
        Containersize: 430.0);
  }

  Widget WhatKindOfAlimony(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return ContainerAlimony(
        Identity: identity,
        BigQuestion: "",
        Question: "What kind of Alimony did you paid?",
        briefqstn: """
        <h1>Coming Soon</h1>
        """,
        QuestionOption: "Alimony Paid.",
        AnswerOption: [
          "Pension rights adjustment",
          "Prevention of an adjustment",
          "Alimony to ex",
          "None"
        ],
        Containersize: 430.0);
  }

  Widget OccupationContainer(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: """<p><strong>Occupation</strong></p>
<p><em>Please choose how you earned your money or what you did in 2019 in Germany. You can select multiple options.</em></p>
<p><strong>EMPLOYMENT</strong></p>
<p>You were employed and paid for in the year 2019, e.g. as an employee, civil servant, soldier, mini-jobber, etc.</p>
<p><strong>MINIJOB</strong></p>
<p>You had marginal (up to 450 euros) or short-term employment. In this case, you were registered for it at the Social Insurance for Seafarers ('Knappschaft-Bahn-See').</p>
<p><strong>STUDYING</strong></p>
<p>In the year 2019 you completed your studies at a university or a technical college. Also choose this option if you studied at a distance university while working.</p>
<p><strong>TRAINING</strong></p>
<p>You completed education, training, or an apprenticeship.</p>
<p><strong>SELF-EMPLOYED</strong></p>
<p>You worked as a freelancer or were self-employed.</p>
<p><strong>OWN COMPANY</strong></p>
<p>You worked running a business and had your own company.</p>
<p><strong>FORESTRY</strong></p>
<p>Income from agriculture and forestry includes:</p>
<ul>
<li>Income from the operation of agriculture, forestry, viticulture, horticulture, nurseries</li>
<li>Income from inland waterway transport, fish farming, beekeeping</li>
<li>Income from a farm and forestry subsidiary</li>
</ul>
<p><strong>RETIRED</strong></p>
<p>If you received a retirement pension or another pension, select this option.</p>
<p><strong>PARENTAL/MATERNITY LEAVE</strong></p>
<p>If you stayed at home due to maternity or because of the birth of a child we can choose this point.</p>
<p>&nbsp;</p>
<p><strong>UNEMPLOYED</strong></p>
<p>If you did not work in the year 2019, please choose this point. For example, this may apply to the following cases:</p>
<ul>
<li>You were unemployed and received unemployment benefits.</li>
<li>You received unemployment assistance.</li>
</ul>
<p>&nbsp;</p>""",
        BigQuestion: "Personal Details",
        Question: "What were your occupations in the year 2019?",
        QuestionOption: "Occupation",
        AnswerOption: [
          "Employed",
          "Minijob (e.g. 450€ basis)",
          "Studying",
          "Training",
          "Self-employed",
          "Own business",
          "Forestry",
          "Retired",
          "Parental Leave",
          "Not working"
        ],
        AnswerImages: [
          "images/employedoption.png",
          "images/minijoboption.png",
          "images/studyingoption.png",
          "images/trainingoption.png",
          "images/selfemployed.png",
          "images/ownbusinessoption.png",
          "images/forestryoption.png",
          "images/retired.png",
          "images/parentalleaveoption.png",
          "images/notworkingoption.png"
        ],
        Containersize: 430.0);
  }

  Widget ProfessionalCourseTraining(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn:
            """<p><strong>Education: further professional training</strong></p>
<p>Select "yes" if in 2019 you attended professional training courses and wish to claim tax deductions. Otherwise answer "no".</p>
<p>Further professional training includes different educational activities that you as an employee can participate in even after completing your education.</p>
<p>This includes for example:</p>
<ul>
<li>Training courses</li>
<li>Seminars</li>
<li>Evening classes</li>
<li>Retraining</li>""",
        BigQuestion: "Personal Details",
        Question: "Did you attend any professional training courses?",
        QuestionOption: "Training",
        Containersize: 220.0);
  }

  Widget IncomeSources(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: """<p><strong>Additional income</strong></p>
<p>Choose from the options that apply to you. Select all other sources of earnings you had in the year 2019 in Germany or click "None" if none of them apply to you.</p>
<p><strong>LETTING AND LEASING</strong></p>
<p>You own a property (e.g. a condominium or a holiday home) and had income from renting or leasing the property.</p>
<p><strong>SALE OF PROPERTY</strong></p>
<p>If you sell your own property, the profit may be taxable. Choose this item if you sold a property in 2019.</p>
<p><strong>INTEREST FROM SAVINGS ACCOUNTS</strong></p>
<p>If your investment income is above the exempt amount or you have not issued an exemption order, choose this option.</p>
<p>Amount of the allowance:</p>
<ul>
<li>801 euros for unmarried people</li>
<li>1,602 euros for married people</li>
</ul>
<p>If the total amount of your investment income is below the exemption limit and you have submitted an exemption request, you do not have to do anything here.</p>
<p><strong>DIVIDENDS AND SALE OF SHARES</strong></p>
<p>The same applies here as with interest.</p>
<p><strong>INVESTMENT INCOME</strong></p>
<p>Certain capital gains must be taxed and included in your tax return. These include:</p>
<ul>
<li>Interest on loan agreements between private individuals</li>
<li>Interest on tax refunds</li>
<li>Sale of capital life insurance completed after 2005</li>
</ul>
<p><strong>RELATED PENSIONS</strong></p>
<p>Select this option if you have claimed a pension in the year 2019. These include all pension payments <strong>except survivor's pensions.</strong></p>
<p><strong>ALIMONY RECEIVED</strong></p>
<p>If you receive alimony from your ex-partner, you only need to pay tax on it if you have agreed on this with your ex-partner.</p>
<p><strong>For this you must give your consent: you need a signature on Annex U of the taxpayer's declaration.</strong></p>
<p>If this is not the case, you do not have to pay tax on the maintenance and do not choose this item here.</p>""",
        BigQuestion: "Personal Details",
        Question: "Did you have any other income sources in 2019?",
        QuestionOption: "Other income",
        AnswerOption: [
          "Letting and Leasing",
          "Sale of Property",
          "Capital gains",
          "Pensions",
          "Alimony",
          "No",
        ],
        AnswerImages: [
          "images/lettingoption.png",
          "images/salepropertyoption.png",
          "images/capitalgainoption.png",
          "images/pensionsoption.png",
          "images/alimonyoption.png",
          "images/salepropertyoption.png",
        ],
        Containersize: 430.0);
  }

  Widget SaleProperty(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "not available",
        BigQuestion: "Personal Details",
        Question: "Did you sell more than one property?",
        QuestionOption: "More than one property",
        Containersize: 220.0);
  }

  Widget ApplySources(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container4(
        Identity: identity,
        BigQuestion: "Personal Details",
        briefqstn: """<p><strong>More information</strong></p>
<p>Choose the answers that apply to you. You can choose multiple options. All information refers to the year 2019.</p>
<p><strong>DISABILITY</strong></p>
<p>Choose this option if you want to give information about your own disability. For this, you must have a certificate confirming you are severely handicapped or a notification of the severe disability.</p>
<p><strong>ALIMONY PAID</strong></p>
<p>Choose this option if you paid alimony to any person.</p>
<p><strong>The recipient of the alimony must agree that you can deduct the payments. If they have not have approved, do not choose this option.</strong></p>
<p>Consent requires the signature of the alimony recipient.</p>
<p><strong>PENSION RECEIVED AS A WIDOW OR ORPHAN</strong></p>
<p>Please select this option if you received a pension after the death of a loved one, as a widow or orphan (one or both parents).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        Question: "Did any of these applied to you during 2019?",
        QuestionOption: "Further Information",
        AnswerOption: [
          "Have a disability",
          "Alimony paid",
          "Survivor’s pension",
          "None"
        ],
        AnswerImages: [
          "images/disabilityoption.png",
          "images/alimonypaidoption.png",
          "images/survivorspension.png",
          "images/check.png"
        ],
        Containersize: 380.0);
  }

  Widget DisabilityCertificate(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """<h1>Coming Soon</h1>""",
        BigQuestion: "Personal Details",
        Question: "Do you have this disability certificate?",
        QuestionOption: "Disability Certificate",
        Containersize: 220.0);
  }

  Widget DisabilityIndefinite(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """<h1>Coming Soon</h1>""",
        BigQuestion: "Personal Details",
        Question: "Do you have this disability for indefinite time?",
        QuestionOption: "Disability Indefinite",
        Containersize: 220.0);
  }

  Widget DisabilityHomeChange(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """<h1>Coming Soon</h1>""",
        BigQuestion: "Personal Details",
        Question: "Disability home change?",
        QuestionOption: "Disability home change",
        Containersize: 220.0);
  }

  Widget DisabilitySinceDate(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question: "Since when do you have this disability?",
        QuestionOption: "Date of disability",
        Containersize: 220.0);
  }

  Widget DisabilityValidDate(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question: "This disability is valid until?",
        QuestionOption: "Date of validity",
        Containersize: 220.0);
  }

  Widget CalculationDisability(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return CalculationContainerLiving(
        briefqstn: """<h1>Coming Soon</h1>""",
        identity: "",
        bigQuestion: "Degree of disability.",
        completeQuestion: "What is the degree of disability?",
        questionOption: "Degree of disability.",
        containerSize: 430.0,
        additionalData: "calculation");
  }

  Widget CalculationEmail(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return CalculationContainerEmail(
        briefqstn: """<h1>Coming Soon</h1>""",
        identity: "",
        bigQuestion: "Email address.",
        completeQuestion:
            "Great! You have finished first category. Next step is to create profile for that we need your emai address.",
        questionOption: "Email address.",
        containerSize: 430.0,
        additionalData: "");
  }

  Widget TermsNcondition(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return TermsNCondition(
        briefqstn: """<h1>Coming Soon</h1>""",
        identity: "",
        bigQuestion: "Terms and condition.",
        completeQuestion:
            "I have read the terms & condition and the privacy policy (including the information of tax administration on data protection).",
        questionOption: "Terms and condition.",
        containerSize: 430.0,
        additionalData: "");
  }

  Widget CalculationPin(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return CalculationContainerPin(
        briefqstn: """<h1>Coming Soon</h1>""",
        identity: "",
        bigQuestion: "Pin.",
        completeQuestion: "And now, please choose a 4 digit pin.",
        questionOption: "Pin.",
        containerSize: 430.0,
        additionalData: "calculation");
  }

  Widget CalculationPaymentRight(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return CalculationContainerLiving(
        briefqstn: """<h1>Coming Soon</h1>""",
        identity: "",
        bigQuestion: "Pension Rights Adjustments.",
        completeQuestion: "How much was the pension rights adjustments?",
        questionOption: "Pension Rights Adjustments.",
        containerSize: 430.0,
        additionalData: "calculation");
  }

  Widget DisabilityApply(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container1(
        Identity: identity,
        BigQuestion: "",
        Question: "What kind of disability applied?",
        briefqstn: """ <h1>Coming Soon</h1> """,
        QuestionOption: "Disability Apply",
        AnswerOption: [
          "Blind",
          "Permanent Helpless",
          "Handicapped",
          "None of these",
        ],
        Containersize: 430.0);
  }

  Widget TaxReturn(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """<p><strong>Tax Assessment Notice received</strong></p>
<p>Please state whether you received a tax assessment notice in 2019. We are talking about a German tax return.</p>
<p>Click "yes" if you have received a tax assessment.</p>
<p>Otherwise click "no". Please also click "no" here if you have received a foreign tax assessment for example for Switzerland.</p>
<p>It is not relevant in which year you filed your tax return.</p>
<p><strong>TAX STUFF</strong></p>
<p>You can find your tax number on your tax statement. You will need to enter it later.</p>
<p>&nbsp;</p>""",
        BigQuestion: "Personal Details",
        Question: "Have you filed a tax return before?",
        QuestionOption: "Tax return filed",
        Containersize: 220.0);
  }

  Widget HaveChildren(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        BigQuestion: "",
        briefqstn: """<p><strong>Children</strong></p>
<p>All entries relate to 2019. If a child was born in 2020 then you should answer this question with &ldquo;<strong>no</strong>&rdquo;.</p>
<p>Please state whether you have children. This includes:</p>
<ul>
<li>biological children</li>
<li>adopted children</li>
<li>foster children</li>
</ul>
<p>You can also include step- and grandchildren if the child lives in the household or you are obligated to support the child.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        Question: "Do you have children?",
        QuestionOption: "Children",
        Containersize: 220.0);
  }

  Widget LiveAlone(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        BigQuestion: "",
        briefqstn: """<p><strong>Living situation</strong></p>
<p>We need this information in order to adapt the follow-up questions to your tax situation.</p>
<p>Please click <strong>yes</strong> or <strong>no</strong> accordingly.</p>
<p>If you didn't live alone, you probably lived with:</p>
<ul>
<li>a spouse</li>
<li>a partner</li>
<li>children</li>
<li>parents</li>
<li>or in a shared apartment</li>
</ul>
<p>You can specify this further in the following question.</p>
<p>&nbsp;</p>""",
        Question: "Did you live alone in 2019?",
        QuestionOption: "Living alone",
        Containersize: 220.0);
  }

  Widget LiveAbroad(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """<p><strong>FOREIGN RESIDENCY</strong></p>
<p>Answer "yes" to this question if in 2019 you moved to <strong>Germany</strong> or <strong>abroad</strong>. This means you only had a temporary residence in Germany.</p>
<p>Holidays (including for a longer period) have no bearing on your residency.</p>
<p><strong>SABBATICAL</strong></p>
<p>A sabbatical year, for example, where you travel through a foreign country for months, does not apply here.</p>""",
        BigQuestion: "",
        Question: "Did you live abroad for extended periods of time in 2019?",
        QuestionOption: "Living abroad",
        Containersize: 220.0);
  }

  Widget ForeignIncome(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """<p><strong>Foreign sources of income</strong></p>
<p>If you received foreign sources of income in 2019 that are not subject to German income tax, you have to answer this question with "yes". Otherwise click "no".</p>
<p>Examples of foreign income include:</p>
<ul>
<li>Salary from a job in a foreign country</li>
<li>Income from a freelance job conducted in a foreign country</li>
<li>Income from agriculture and forestry where the areas are cultivated in a foreign country</li>
<li>Interest, dividends, and gains from investments or deposits in foreign financial institutions</li>
</ul>
<p><strong>TAXATION</strong></p>
<p>This income is subject to the "progression clause" (Progressionsvorbehalt). This income is not taxable in itself but it does influence your personal tax rate at which your other income is taxed.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        BigQuestion: "",
        Question: "Did you have income from abroad during 2019",
        QuestionOption: "Foreign Income",
        Containersize: 220.0);
  }

  Widget CapitalGain(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """""",
        BigQuestion: "Personal Details",
        Question:
            "Did your capital gain enter a German depot or bank account only?",
        QuestionOption: "German account",
        Containersize: 220.0);
  }

  Widget ReceiveCapitalGain(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        BigQuestion: "Personal Details",
        briefqstn: """<p><strong>Type of capital gains</strong></p>
<p>Please indicate here from which sources you received capital gains.</p>
<p><strong>INTEREST INCOME FROM SAVINGS ACCOUNTS</strong></p>
<p>Choose this option if you received interest income from savings accounts such as overnight money, time deposit accounts, interest-bearing checking accounts or savings accounts.</p>
<p><strong>FROM SHARES</strong></p>
<p>Choose this option if you received income from stocks such as dividends, sales of shares, liquidation proceeds, shares in associations and foundations, or income from silent participations.</p>
<p><strong>FROM LOANS</strong></p>
<p>Choose this option if you received proceeds from loans. These can be private loan agreements, shareholder loans or loans in kind (loans to companies in proportion to the profit or turnover of the company in return).</p>
<p><strong>FROM INSURANCE CONTRACTS</strong></p>
<p>Choose this option if you had insurance benefits such as income from endowment policies.</p>
<p><strong>OLD SHARES FROM FUNDS</strong></p>
<p>Choose this point if you had shares in investment funds, in capital investment companies under the Investment Tax Act in the version applicable on 31 December 2017, or in organisms which fell within the scope of this Act for the first time on 1 January 2018 (old shares).</p>
<p><strong>FROM COMPLEX FINANCIAL INSTRUMENTS</strong></p>
<p>Choose this option if you received income from other financial instruments. These can be investment funds or derivatives.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        Question: "What kind of capital gains did you receive?",
        QuestionOption: "Type of Capital gains",
        AnswerOption: [
          "Interest",
          "From shares",
          "From loans",
          "From insurance contracts",
          "Old shares from funds",
          "From complex financial instruments"
        ],
        AnswerImages: [
          "images/interestoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/frominsuranceoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png"
        ],
        Containersize: 430.0);
  }

  Widget IncomeShares(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn:
            """<p><strong>Type of your income from stock transactions</strong></p>
<p>Please indicate what type of revenue you had from stock transactions. Click on the appropriate answer option.</p>
<p>All information refers to the year 2019.</p>
<p><strong>DIVIDENDS</strong></p>
<p>You received distributions from companies whose shares you own.</p>
<p><strong>EARNINGS FROM SALE OF STOCKS</strong></p>
<p>You sold shares in your possession and generated revenue.</p>
<p><strong>LIQUIDATION PROCEED</strong></p>
<p>You received money from the liquidation of a corporation (e.g. as a shareholder of a limited liability company).</p>
<p><strong>SHARES IN FOUNDATIONS AND ASSOCIATIONS</strong></p>
<p>You received proceeds from your shares in foundations and associations.</p>
<p><strong>SILENT PARTICIPATIONS</strong></p>
<p>You received income from silent participation. As a silent partner you invested capital in a company without appearing as an investor.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        BigQuestion: "Personal Details",
        Question: "What type of income from shares did you have?",
        QuestionOption: "Shares",
        AnswerOption: [
          "Dividends",
          "Earnings from sale of stocks",
          "Liquidation proceeds",
          "Shares in associations and foundations",
          "Silent partnerships"
        ],
        AnswerImages: [
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png"
        ],
        Containersize: 430.0);
  }

  Widget KeyRole(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        BigQuestion: "Personal Details",
        briefqstn: """<p><strong>Key position in the company</strong></p>
<p>Please indicate here whether you, in one of the companies with the investment income, have worked in a key position. Answer this question with "Yes", if that applies to you, otherwise click "No".</p>
<p><strong>THIS IS A KEY POSITION</strong></p>
<p>This means that your activity significantly influences corporate policy. To do this, you work in a capital company at a higher management level and influence the strategic direction of the company.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        Question: "Did you work in a key role for any of these companies?",
        QuestionOption: "Key roles",
        Containersize: 220.0);
  }

  Widget Shares25Company(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """""",
        BigQuestion: "Personal Details",
        Question:
            "Did you hold more than 25% of the shares of any one company?",
        QuestionOption: "> 25% of shares",
        Containersize: 220.0);
  }

  Widget Shares1Company(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: """<p><strong>Shares in a company</strong></p>
<p>Specify here whether you hold <strong>MORE</strong> than 1% of any one company's shares. Answer this question with "Yes" if that applies to you, otherwise click "No".</p>
<p>This information is important so that we can determine the correct form of taxation.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        BigQuestion: "Personal Details",
        Question: "Did you hold more than 1% of the shares of any one company?",
        QuestionOption: "> 1% of shares",
        Containersize: 220.0);
  }

  Widget TypeOfLoan(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return Container2(
        briefqstn: """<p><strong>Loans</strong></p>
<p>Please indicate here the type of loan you lent, and from which you received income (e.g. interest) in 2019.</p>
<p><strong>PRIVATE LOAN</strong></p>
<p>You lent money to a private individual, such as a friend or relative, and signed a credit agreement. If you received interest on this loan, choose this item.</p>
<p><strong>SHAREHOLDER LOAN</strong></p>
<p>You granted a loan to that company in which you hold shares.</p>
<p><strong>"PARTIARISCHES DARLEHEN"</strong></p>
<p>You granted a "Partiarisches Darlehen". With this loan you grant to a company, you receive no interest, but instead a share of the company's profits or turnover.</p>
<p>&nbsp;</p>""",
        Identity: identity,
        BigQuestion: "Personal Details",
        Question: "What type of loan did you grant?",
        QuestionOption: "Loan",
        AnswerOption: [
          "Private loan",
          "Shareholder loan",
          "Partiarisches Darlehen"
        ],
        AnswerImages: [
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png"
        ],
        Containersize: 430.0);
  }

  Widget Shares10Company(String identity, double anContainer) {
    // Questions.animatedContainer = anContainer;

    return Container3(
        Identity: identity,
        briefqstn: """""",
        BigQuestion: "Personal Details",
        Question: "Did you hold at least 10% of the shares of any one company?",
        QuestionOption: "> 10% of shares",
        Containersize: 220.0);
  }

  Widget PensionRightsYesNo(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return Container3(
        Identity: identity,
        briefqstn: """<h1>Coming Soon</h1>""",
        BigQuestion: "Pension Rights.",
        Question: "Does the recipient declare the money in tax return?",
        QuestionOption: "Pension Rights.",
        Containersize: 220.0);
  }

  Widget CalculationPayment(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return CalculationContainerLiving(
        briefqstn: """<p><strong>Sale of property: depreciation</strong></p>
<p><strong>Calculation of depreciation</strong></p>
<p>Rented real estate is depreciated linearly. This means the percent change remains the same for the whole time period. If a building (or part of building) is sold, then the depreciation amount is proportional to the time.</p>
<p>For purposes of depreciation we differentiate between new buildings, old buildings, and listed buildings.</p>
<p><strong>For new buildings completed by the end of 2005</strong>, the following applies:</p>
<ul>
<li>4 percent over the first 10 years</li>
<li>5 percent over the next 8 years</li>
<li>25 percent over the following 32 years</li>
</ul>
<p>For <strong>houses that were built from 1925 onwards</strong>, 2 percent of the acquisition costs can be written off each year for a 50 year period.</p>
<p><strong>For old buildings built before 1925,</strong> the depreciation rate is 2.5 percent over a 40 year period.</p>
<p><strong>For listed buildings</strong>, the following rates apply for the acquisition costs excluding renovations:</p>
<ul>
<li>2 percent (for houses built after 1925)</li>
<li>5 percent (for houses built before 1925)</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
        identity: "",
        bigQuestion: "Payments Reason.",
        completeQuestion: "Payments reason?",
        questionOption: "Payments Reason.",
        containerSize: 430.0,
        additionalData: "Payments Reason.");
  }

  Widget OldFundShares(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return Container3(
        Identity: identity,
        briefqstn: """<p><strong>Bank certification</strong></p>
<p>Please state here whether you have a certificate from the bank that contains all income from the old fund shares. If this is available, select "Yes", otherwise "No". The banks issue these certificates on request.</p>
<p>The income from old shares relates to shares from funds purchased by investors before 2009. These are taxable from 2018 on.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        BigQuestion: "Personal Details",
        Question:
            "Have you received a certificate from the bank listing the returns on old fund shares (Alt-Anteile von Fonds) that you purchased before 2009?",
        QuestionOption: "Certificate for old shares",
        Containersize: 220.0);
  }

  Widget FinancialInstruments(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        BigQuestion: "Personal Details",
        briefqstn: """<p><strong>Other financial assets</strong></p>
<p>Please indicate here the financial assets from which you received income in the year 2019. You can select several answers here.</p>
<p><strong>DOMESTIC INVESTMENT FUND</strong></p>
<p>Please select this item if you have received investment income from domestic mutual funds. It does not matter if they are accumulating funds that reinvest income in the fund or distributing funds where you receive the returns.</p>
<p><strong>FOREIGN INVESTMENT FUND</strong></p>
<p>Please select this item if you have received investment income from foreign capitalization mutual funds (even if they are kept in a domestic bank deposit).</p>
<p><strong>(PREMIUM) OPTIONS / OPTION PREMIUMS</strong></p>
<p>If you received income from futures (options or option premiums), then choose this. However, you only have to choose this item if the period between purchase and termination of the purchase right is one year or shorter.</p>
<p><strong>DERIVATIVES</strong></p>
<p>Derivatives are financial products whose price depends on the price of another financial product, for example a share.</p>
<p><strong>Example:</strong> With a derivative, you can bet that a particular stock is losing value. If that happens, then you win, but if you are wrong, you make a loss.</p>
<p><strong>BONDS</strong></p>
<p>You received income from bonds, for example interest or sale proceeds. Bonds are securities that give you the right to repayment and agreed upon interest.</p>
<p>&nbsp;</p>""",
        Question: "In which financial instruments have you invested?",
        QuestionOption: "Financial assests",
        AnswerOption: [
          "Domestic investment funds",
          "Foreign investment funds",
          "Options",
          "Option premiums",
          "Derivatives",
          "Bonds"
        ],
        AnswerImages: [
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png"
        ],
        Containersize: 430.0);
  }

  //iska question option likhna baqi ha
  Widget PayAlimony(String identity, double anContainer) {
    //Questions.animatedContainer = anContainer;
    return Container2(
        briefqstn: """<p><strong>Alimony recipient</strong></p>
<p><strong>SPOUSE LIVING SEPARATELY</strong></p>
<p>If you provided support to your divorced or permanently separated spouse, you can specify this here.</p>
<p><strong>The recipient of the alimony must agree that you can discontinue the alimony. If there is no approval, do not choose this option. If the recipient is in agreement, you can deduct these expenses.</strong></p>
<p>Consent is given by the signature of the recipient of the payment.</p>
<p><strong>ADULT RELATIVES</strong></p>
<p>If you paid maintenance for your parents or grandparents, click this option.</p>
<p><strong>CHILD</strong></p>
<p>If you paid child support, click this option.</p>
<p><strong>Attention</strong>: In principle, child support can only be deducted if there is no entitlement to child benefit or child allowance for them.</p>
<p>&nbsp;</p>""",
        Identity: identity,
        BigQuestion: "Personal Details",
        Question: "To whom did you pay Alimony?",
        QuestionOption: "Alimony recipient",
        AnswerOption: ["Separated spouse", "Adult relatives", "Child"],
        AnswerImages: [
          "images/spouseoption.png",
          "images/adultoption.png",
          "images/childoption.png"
        ],
        Containersize: 430.0);
  }

  Widget WhoLiveWith(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        briefqstn: """<p><strong>Living situation</strong></p>
<p>Please specify your living situation here. All information refers to the year 2019. Multiple answers are possible.</p>
<p><strong>WITH MY SPOUSE</strong></p>
<p>You and your spouse or registered partner have lived together in one household.</p>
<p><strong>WITH MY PARTNER</strong></p>
<p>You lived in a household with your friend or your girlfriend, but you were/are not married.</p>
<p><strong>WITH CHILDREN</strong></p>
<p>You and your child or children have lived together in one household.</p>
<p><strong>IN A FLAT SHARE</strong></p>
<p>You lived with other people in a shared flat.</p>
<p><strong>WITH PARENTS</strong></p>
<p>You have lived with your parents or your partner's parents in the same household.</p>
<p>&nbsp;</p>""",
        Identity: identity,
        BigQuestion: "",
        Question: "Who do you live with?",
        QuestionOption: "Living situation",
        AnswerOption: [
          "With my spouse",
          "With my partner",
          "With my children",
          "In a flat share",
          "With my parents"
        ],
        AnswerImages: [
          "images/withspouseoption.png",
          "images/withpartneroption.png",
          "images/withchildren.png",
          "images/flatshareoption.png",
          "images/withparent.png"
        ],
        Containersize: 430.0);
  }

  Widget ChildTaxAllowance(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        briefqstn: """<p><strong>Child benefits</strong></p>
<p>If this child is entitled to child benefits or child allowance, you will not be able to deduct this from your taxes.</p>
<p>Please select the appropriate answer here.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        Identity: identity,
        BigQuestion: "Personal Details",
        Question:
            "Are you or any other person entitled to receive child benefits or the child tax allowance for this child?",
        QuestionOption: "Child benefits",
        Containersize: 220.0);
  }

//  Widget ApplyStudies(String identity,double anContainer)
//  {
//    Questions.animatedContainer = anContainer;
//    return Container5(Identity:identity,BigQuestion:"Personal Details",Question:"Which of these apply to your studies?",QuestionOption:"Type of study",AnswerOption:["Part-time degree","Distance learning","Postgraduate studies","None"],Containersize:380.0);
//  }

  Widget EarnMoney(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //return Container5(Identity:identity,BigQuestion:"Personal Details",Question:"In 2019, did you earn money during any of the following?",QuestionOption:"Income from",AnswerOption:["In the course of a training","With dual studies","As a working student","With a part-time job","During an internship","with a minijob","No"],Containersize:380.0);
    return Container2(
        briefqstn: """<p><strong>Income during training/study</strong></p>
<p>Please indicate here whether you earned money during your training or studies for one of the reasons mentioned. You can select several answers here.</p>
<p><strong>YOU CAN CHOOSE FROM THE FOLLOWING OPTIONS:</strong></p>
<p><strong>Education</strong></p>
<p>Choose this option if you have done vocational training during the tax year and have received payment for it.</p>
<p><strong>Dual studies</strong></p>
<p>Choose this option if you have completed a dual course of study which includes a practical part in a company in addition to your studies at a university and you receive a training allowance for this.</p>
<p><strong>Working student</strong></p>
<p>Choose this option if you are employed as a working student in a company and are paid for it.</p>
<p><strong>Part-time job</strong></p>
<p>Choose this option if you have a paid job in addition to your education. Mini-jobs do not count here. Choose the option "Minijob" for this.</p>
<p><strong>Internship</strong></p>
<p>Choose this option if you have done a paid internship.</p>
<p><strong>Mini job</strong></p>
<p>Choose this option if you have earned money with a mini-job.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
        Identity: identity,
        BigQuestion: "Personal Details",
        Question: "In 2019, did you earn money during any of the following?",
        QuestionOption: "Income from",
        AnswerOption: [
          "In the course of a training",
          "With dual studies",
          "As a working student",
          "With a part-time job",
          "During an internship",
          "with a minijob",
          "No"
        ],
        AnswerImages: [
          "images/withspouseoption.png",
          "images/withpartneroption.png",
          "images/withchildren.png",
          "images/flatshareoption.png",
          "images/withparent.png",
          "images/withparent.png",
          "images/withparent.png"
        ],
        Containersize: 430.0);
  }

  Widget PreviousCompletedDegree(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "Have you previously completed a degree (study or training)?",
        QuestionOption: "Previous degree",
        Containersize: 220.0);
  }

  Widget KindOfTraining(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container6(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "What kind of training did you do?",
        QuestionOption: "Type of training",
        AnswerOption: ["Dual training", "Professional School"],
        Containersize: 280.0);
  }

  Widget DivorceDate(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question: "When did you get divorced?",
        QuestionOption: "Date of divorce",
        Containersize: 220.0);
  }

  Widget FirstPaymentDate(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question:
            "Enter date of the first payment of pension rights adjustment?",
        QuestionOption: "First Payment.",
        Containersize: 220.0);
  }

  Widget SaleDate(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "",
        Question: "Date of selling property?",
        QuestionOption: "Date of sell",
        Containersize: 220.0);
  }

  Widget WidowedDate(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question: "Since when have you been widowed?",
        QuestionOption: "Widowed since",
        Containersize: 220.0);
  }

  Widget LivingTogether(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question:
            "Have you been living together at any time during the tax year?",
        QuestionOption: "Living together",
        Containersize: 220.0);
  }

  Widget StartLivingPart(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question: "When did you start living apart?",
        QuestionOption: "Date of separation",
        Containersize: 220.0);
  }

  Widget GetMarried(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container7(
        briefqstn: "jhgjhgj",
        Identity: identity,
        BigQuestion: "Relationship status",
        Question: "When did you get married?",
        QuestionOption: "Date of marriage",
        Containersize: 220.0);
  }

  Widget AssessedJointly(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question: "Do you wish to be assessed jointly?",
        QuestionOption: "Joint assessment",
        Containersize: 220.0);
  }

  Widget FormallyMarried(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Relationship status",
        Question: "Are you formally married?",
        QuestionOption: "Formally married",
        Containersize: 220.0);
  }

  // ======================================== Partner's Question ===================================================================
  // ======================================== Partner's Question ===================================================================
  // ======================================== Partner's Question ===================================================================
  // ======================================== Partner's Question ===================================================================
  // ======================================== Partner's Question ===================================================================

  Widget PartnerOccupationContainer(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "What were your partner’s occupation in the year 2019?",
        QuestionOption: "Occupation",
        AnswerOption: [
          "Employed",
          "Minijob (e.g. 450€ basis)",
          "Studying",
          "Training",
          "Self-employed",
          "Own business",
          "Forestry",
          "Retired",
          "Parental Leave",
          "Not working"
        ],
        AnswerImages: [
          "images/employedoption.png",
          "images/minijoboption.png",
          "images/studyingoption.png",
          "images/trainingoption.png",
          "images/selfemployed.png",
          "images/ownbusinessoption.png",
          "images/forestryoption.png",
          "images/retired.png",
          "images/parentalleaveoption.png",
          "images/notworkingoption.png"
        ],
        Containersize: 430.0);
  }

  Widget PartnerProfessionalCourseTraining(
      String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "Did your partner attend any professional training courses?",
        QuestionOption: "Training",
        Containersize: 220.0);
  }

  Widget PartnerIncomeSources(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "Did your partner have any other income sources in 2019?",
        QuestionOption: "Other income",
        AnswerOption: [
          "Letting and Leasing",
          "Sale of Property",
          "Capital gains",
          "Pensions",
          "Alimony"
        ],
        AnswerImages: [
          "images/lettingoption.png",
          "images/salepropertyoption.png",
          "images/capitalgainoption.png",
          "images/pensionsoption.png",
          "images/alimonyoption.png"
        ],
        Containersize: 430.0);
  }

  Widget PartnerSaleProperty(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "Did your partner sell more than one property?",
        QuestionOption: "More than one property",
        Containersize: 220.0);
  }

  Widget PartnerApplySources(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container4(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "Did any of these applied to your partner during 2019?",
        QuestionOption: "Further Information",
        AnswerOption: [
          "Have a disability",
          "Alimony paid",
          "Survivor’s pension",
          "None"
        ],
        AnswerImages: [
          "images/disabilityoption.png",
          "images/alimonypaidoption.png",
          "images/survivorspension.png",
          "images/check.png"
        ],
        Containersize: 380.0);
  }

  Widget PartnerTaxReturn(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "Has your partner filed a tax return before?",
        QuestionOption: "Tax return filed",
        Containersize: 220.0);
  }

  Widget PartnerCapitalGain(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Did your partner’s capital gain enter a German depot or bank account only?",
        QuestionOption: "German account",
        Containersize: 220.0);
  }

  Widget PartnerReceiveCapitalGain(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "What kind of capital gains did your partner receive?",
        QuestionOption: "Type of Capital gains",
        AnswerOption: [
          "Interest",
          "From shares",
          "From loans",
          "From insurance contracts",
          "Old shares from funds",
          "From complex financial instruments"
        ],
        AnswerImages: [
          "images/interestoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/frominsuranceoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png"
        ],
        Containersize: 430.0);
  }

  Widget PartnerIncomeShares(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "What type of income from shares did your partner have?",
        QuestionOption: "Shares",
        AnswerOption: [
          "Dividends",
          "Earnings from sale of stocks",
          "Liquidation proceeds",
          "Shares in associations and foundations",
          "Silent partnerships"
        ],
        AnswerImages: [
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png"
        ],
        Containersize: 430.0);
  }

  Widget PartnerKeyRole(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Did your partner work in a key role for any of these companies?",
        QuestionOption: "Key roles",
        Containersize: 220.0);
  }

  Widget PartnerShares25Company(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Did your partner hold more than 25% of the shares of any one company?",
        QuestionOption: "> 25% of shares",
        Containersize: 220.0);
  }

  Widget PartnerShares1Company(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Did your partner hold more than 1% of the shares of any one company?",
        QuestionOption: "> 1% of shares",
        Containersize: 220.0);
  }

  Widget PartnerTypeOfLoan(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "What type of loan did your partner grant?",
        QuestionOption: "Loan",
        AnswerOption: [
          "Private loan",
          "Shareholder loan",
          "Partiarisches Darlehen"
        ],
        AnswerImages: [
          "images/fromsharesoption.png",
          "images/fromsharesoption.png",
          "images/fromsharesoption.png"
        ],
        Containersize: 430.0);
  }

  Widget PartnerShares10Company(String identity, double anContainer) {
    // Questions.animatedContainer = anContainer;

    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Did your partner hold at least 10% of the shares of any one company?",
        QuestionOption: "> 10% of shares",
        Containersize: 220.0);
  }

  Widget PartnerOldFundShares(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;

    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Have your partner received a certificate from the bank listing the returns on old fund shares (Alt-Anteile von Fonds) that you purchased before 2009?",
        QuestionOption: "Certificate for old shares",
        Containersize: 220.0);
  }

  Widget PartnerFinancialInstruments(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "In which financial instruments have your partner invested?",
        QuestionOption: "Financial assests",
        AnswerOption: [
          "Domestic investment funds",
          "Foreign investment funds",
          "Options",
          "Option premiums",
          "Derivatives",
          "Bonds"
        ],
        AnswerImages: [
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png",
          "images/oldsharesoption.png"
        ],
        Containersize: 430.0);
  }

  //iska question option likhna baqi ha
  Widget PartnerPayAlimony(String identity, double anContainer) {
    //Questions.animatedContainer = anContainer;
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "To whom did your partner pay Alimony?",
        QuestionOption: "Alimony recipient",
        AnswerOption: ["Separated spouse", "Adult relatives", "Child"],
        AnswerImages: [
          "images/spouseoption.png",
          "images/adultoption.png",
          "images/childoption.png"
        ],
        Containersize: 430.0);
  }

  Widget PartnerChildTaxAllowance(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Are you or your partner entitled to receive child benefits or the child tax allowance for this child",
        QuestionOption: "Child benefits",
        Containersize: 220.0);
  }

//  Widget PartnerApplyStudies(String identity,double anContainer)
//  {
//    Questions.animatedContainer = anContainer;
//    return Container5(Identity:identity,BigQuestion:"Personal Details",Question:"Which of these apply to your partner’s studies?",QuestionOption:"Type of study",AnswerOption:["Part-time degree","Distance learning","Postgraduate studies","None"],Containersize:380.0);
//  }

  Widget PartnerEarnMoney(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    //return Container5(Identity:identity,BigQuestion:"Personal Details",Question:"In 2019, did you earn money during any of the following?",QuestionOption:"Income from",AnswerOption:["In the course of a training","With dual studies","As a working student","With a part-time job","During an internship","with a minijob","No"],Containersize:380.0);
    return Container2(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "In 2019, did your partner earn money during any of the following?",
        QuestionOption: "Income from",
        AnswerOption: [
          "In the course of a training",
          "With dual studies",
          "As a working student",
          "With a part-time job",
          "During an internship",
          "with a minijob",
          "No"
        ],
        AnswerImages: [
          "images/withspouseoption.png",
          "images/withpartneroption.png",
          "images/withchildren.png",
          "images/flatshareoption.png",
          "images/withparent.png",
          "images/withparent.png",
          "images/withparent.png"
        ],
        Containersize: 430.0);
  }

  Widget PartnerPreviousCompletedDegree(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question:
            "Have your partner previously completed a degree (study or training)?",
        QuestionOption: "Previous degree",
        Containersize: 220.0);
  }

  Widget PartnerKindOfTraining(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container6(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "Personal Details",
        Question: "What kind of training did your partner do?",
        QuestionOption: "Type of training",
        AnswerOption: ["Dual training", "Professional School"],
        Containersize: 280.0);
  }

  // Widget WhatKindOfalimony(String identity, double anContainer) {
  //   Questions.animatedContainer = anContainer;
  //   return Container6(
  //       Identity: identity,
  //       briefqstn: "jhgjhgj",
  //       BigQuestion: "Personal Details",
  //       Question: "What kind of alimony have you paid?",
  //       QuestionOption: "Type of training",
  //       AnswerOption: [
  //         "Pension rights adjustment",
  //         "Pension rights adjustment"
  //       ],
  //       Containersize: 280.0);
  // }

  Widget PartnerHaveChildren(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "",
        Question: "Do either of you have children?",
        QuestionOption: "Children",
        Containersize: 220.0);
  }

  Widget PartnerLiveTogetherEntireYear(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "",
        Question: "Did the two of you live together for the entire year?",
        QuestionOption: "Together all-year",
        Containersize: 220.0);
  }

  Widget PartnerLiveAbroad(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        briefqstn: "jhgjhgj",
        BigQuestion: "",
        Question:
            "Did either of you live abroad for extended periods of time in 2019?",
        QuestionOption: "Living abroad",
        Containersize: 220.0);
  }

  Widget PartnerForeignIncome(String identity, double anContainer) {
    Questions.animatedContainer = anContainer;
    return Container3(
        Identity: identity,
        BigQuestion: "",
        briefqstn: "jhgjhgj",
        Question: "Did either of you have income from abroad during 2019?",
        QuestionOption: "Foreign Income",
        Containersize: 220.0);
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
            Questions.answerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return mainQuestions(CheckQuestion: "", CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.answerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.answerShow = [];
            Questions.answerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return mainQuestions(
                  CheckQuestion: Questions.answerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.answerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
          height: Questions.answerShow[currentIndex]['containerheight'],
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
                        Questions.answerShow[currentIndex]['question'],
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
                      //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Colors.lightBlue)),
                      Container(
                          width: 140.0,
                          // color:Colors.blue,
                          child: AutoSizeText(
                            Questions.answerShow[currentIndex]['answer'][0],
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
            Questions.answerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return mainQuestions(CheckQuestion: "", CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.answerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.answerShow = [];
            Questions.answerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return mainQuestions(
                  CheckQuestion: Questions.answerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.answerShow[currentIndex - 1]['answer'][0]
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
                          Questions.answerShow[currentIndex]['question'],
                          style: TextStyle(
                              color: Color(0xFF003350)
                                  .withOpacity(0.803)
                                  .withOpacity(0.49),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaBold'),
                          minFontSize: 14.0,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Row(
                      children: <Widget>[
                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Colors.lightBlue)),
                        Container(
                            width: 140.0,
                            // color:Colors.blue,
                            child: AutoSizeText(
                              Questions.answerShow[currentIndex]['answer'][0],
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
