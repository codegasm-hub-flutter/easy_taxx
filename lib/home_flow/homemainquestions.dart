import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finishcategory.dart';
import 'package:easy_taxx/home_flow/homeaddresscontainer.dart';
import 'package:easy_taxx/home_flow/homeyesnocontainer.dart';
import 'package:easy_taxx/home_flow/homemultitwooptioncontainer.dart';
import 'package:easy_taxx/home_flow/homemultipleoptionscontainerno.dart';
import 'package:easy_taxx/home_flow/homecalculationcontainer.dart';
import 'package:easy_taxx/home_flow/homesixoptioncontainer.dart';
import 'package:easy_taxx/home_flow/homethreeoptioncontainer.dart';
import 'package:easy_taxx/home_flow/homedatecontainer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeMainQuestions extends StatefulWidget {
  String CheckCompleteQuestion;
  String CheckQuestion;
  List CheckAnswer;

  HomeMainQuestions(
      {Key key,
      this.CheckCompleteQuestion,
      this.CheckQuestion,
      this.CheckAnswer})
      : super(key: key);

  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainQuestions> {
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
    print("question length:" + Questions.homeAnswerShow.length.toString());

    for (k = l; k < Questions.homeAnswerShow.length; k++) {
      print("how manysdsdsd");
      screenHeightbig = 0.0;
      if (Questions.homeAnswerShow[k]['identity'] == "You" ||
          Questions.homeAnswerShow[k]['identity'] == "You & Partner" ||
          Questions.homeAnswerShow[k]['identity'] == "Partner") {
        screenHeight = screenHeight + 70.0;
      } else if (Questions.homeAnswerShow[k]['details'] == "") {
        screenHeight = screenHeight + 60.0;
        detail = true;
      } else {
        detailsHeight = Questions.homeAnswerShow[k]['details'];

        for (l = k; l < Questions.homeAnswerShow.length; l++) {
          if (Questions.homeAnswerShow[l]['details'] == detailsHeight) {
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
    screenHeight = screenHeight + Questions.homeAnimatedContainer;
    // screenHeight = screenHeight;
    print("Screen Height:" + screenHeight.toString());
//    print("Screen Height big:"+screenHeightbig.toString());

    detail = true;
  }

  void DynamicContainer() {
    hlength = 0;
    // print("question length:"+Questions.answerShow.length.toString());
    for (i = j; i < Questions.homeAnswerShow.length; i++) {
      print("value oif i is:" + i.toString());

      print("dat is:" + i.toString());
      //You and your and your partner identity
      if (Questions.homeAnswerShow[i]['identity'] == "You" ||
          Questions.homeAnswerShow[i]['identity'] == "You & Partner" ||
          Questions.homeAnswerShow[i]['identity'] == "Partner") {
        dynamicContainer.add(Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: Questions.homeAnswerShow[i]['containerheight'],
          width: 450.0,
          child: Text(Questions.homeAnswerShow[i]['identity'],
              style: TextStyle(fontSize: 40.0)),
        ));
      } else if (Questions.homeAnswerShow[i]['details'] == "") {
        dynamicContainer.add(SingleSmallContainer(currentIndex: i)
//            Container(
////              margin: EdgeInsets.only(
////                  top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
////              height: Questions.homeAnswerShow[i]['containerheight'],
////              width: 450.0,
////              decoration: BoxDecoration(
////                  borderRadius: BorderRadius.circular(7.0),
////                  border: Border.all(width: 1.0, color: Color.fromARGB(0xFF, 0xE8, 0xE8, 0xE8))
////              ),
////              child: Padding(
////                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
////                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
////                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                    children: <Widget>[
////                      //Text(Questions.answerShow[i]['question']),
////                      Container(
////                          width: 155.0,
////                          //color: Colors.purple,
////                          child:AutoSizeText(Questions.homeAnswerShow[i]['question'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
////                      ),
////                      Row(children: <Widget>[
////                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
////                        Container(
////                            width: 140.0,
////                            // color:Colors.blue,
////                            child:AutoSizeText(Questions.homeAnswerShow[i]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
////
////                        ),
////                        SizedBox(width: 5.0,),
////                        Icon(Icons.arrow_forward_ios, size: 12.0,
////                            color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF))
////                      ],)
////                    ],
////                  )),
////            )
            );
      }

      //data that contains long container
      else {
        detailOption = Questions.homeAnswerShow[i]['details'];
        print(detailOption);
        countLongContainer = 0;
//print("ahsjasjasksss");

        //set length of data in details that how much data comes
        for (co = i; co < Questions.homeAnswerShow.length; co++) {
          if (Questions.homeAnswerShow[co]['details'] == detailOption) {
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
          if (Questions.homeAnswerShow[j]['details'] == detailOption &&
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
                              Questions.homeAnswerShow[i]['details'],
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
          if (Questions.homeAnswerShow[j]['details'] == detailOption &&
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
//                              child:AutoSizeText(Questions.homeAnswerShow[j]['question'],style: TextStyle(color: Colors.grey),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                          ),
//                          Row(children: <Widget>[
//                            //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                            Container(
//                                width: 140.0,
//                                // color:Colors.blue,
//                                child:AutoSizeText(Questions.homeAnswerShow[j]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
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
                            "Home",
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
        body: SingleChildScrollView(
            reverse: true,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
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
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
//
                          Column(
                            children: dynamicContainer,
                          ),
                          HomeChangeContainer(),
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

  void showDefaultSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Hello from the default snackbar'),
        action: SnackBarAction(
          label: 'Click Me',
          onPressed: () {},
        ),
      ),
    );
  }

  Widget HomeChangeContainer() {
    if (Questions.homeAnswerShow.length == 0) {
      //For You & Partner
      if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
        qu.HomeAddAnswer("You & Partner", "", "", "", [], 60.0);
        Questions.homeSecondHouseholdYou = true; //(Not repeated)
        Questions.homeSecondHouseholdPartner = true; //(Not repeated)
        //Question No 178
        return homeaddressContainer("""
<p><strong>Current address</strong></p>
<p>Please enter your current address here. This is the address where you are registered and have your primary place of residence in the moment you hand in your tax return.</p>
<p>The tax office will send your tax statement to this address.</p>
<p>&nbsp;</p>
""", "", "", "What is your current address? ", "Current address", 220.0, "",
            "");
      } else {
        //Question No 1
        return homeaddressContainer("""
<p><strong>Current address</strong></p>
<p>Please enter your current address here. This is the address where you are registered and have your primary place of residence in the moment you hand in your tax return.</p>
<p>The tax office will send your tax statement to this address.</p>
<p>&nbsp;</p>
""", "", "Home address", "What is your current address?", "Current address",
            220.0, "", "");
      }
    } else {
      //Answer No 1
      if (widget.CheckCompleteQuestion == "What is your current address?" &&
          widget.CheckQuestion == "Current address") {
        //Question No 2
        //For No 330.0
        //For yes 220.0
        DbHelper.insatance..deleteWithquestion('Current address');
        _insert('Current address', 'abc xyz 123', 'OK');
        return homeyesnoContainer("""
<p><strong>Moving house</strong></p>
<p>Please select "Yes" if your primary residence has changed in 2019. The reason for the move is not relevant at this point.</p>
<p>If you did not move, answer "No".</p>
<p>If you have acquired a second household and moved for this reason, also answer "No". This information will be dealt with elsewhere.</p>
<p>&nbsp;</p>
""", "", "Home address", "Did ${Questions.homeYouIdentity} move during 2019?",
            "Move 2019", 330.0, "", "");
      }

      //Answer No 2 and 2(Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "Did ${Questions.homeYouIdentity} move during 2019?" ||
              widget.CheckCompleteQuestion ==
                  "Did one or both of you move in 2019?") &&
          (widget.CheckQuestion == "Move 2019" ||
              widget.CheckQuestion == "Moving")) {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Move 2019');
          _insert('Move 2019', 'No', 'OK');
          //Question No 3
          //For None 430.0
          //For Utility Bill 220.0
          //For Home Owner 220.0
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Move 2019');
          _insert('Move 2019', 'skip', 'skip');
          //Question No 3
          //For None 430.0
          //For Utility Bill 220.0
          //For Home Owner 220.0
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Move 2019');
          _insert('Move 2019', 'Yes', 'ok');
          //Agar living situation ka occupation ma minijob ai to phir ya sawal ai ga wrna flow wasa hi rhega
          if (Questions.occupationMiniJobHome == "Minijob") {
            //Question No 175
            return homeyesnoContainer("""
<p><strong>Refund your moving expenses</strong></p>
<p>Please indicate whether you have been fully reimbursed for the costs associated with your move.</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Have the costs for ${Questions.homeYourIdentity} relocation been reimbursed?",
                "Costs reimbursed",
                220.0,
                "",
                "");
          } else {
            // For you&partner
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              //Question No 63(Partner)
              return homeyesnoContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Relocation",
                  "Did one or both of you move for job-related reasons?",
                  "Due to work",
                  220.0,
                  "",
                  "");
            } else {
              //Question No 63
              return homeyesnoContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Relocation",
                  "Did ${Questions.homeYouIdentity} move for job-related reasons?",
                  "Due to work",
                  220.0,
                  "",
                  "");
            }
          }
        }
      }

//============= Big Detail (Relocation Start) =========================

      //Answer No 63 and 63(Partner)
      else if ((widget.CheckCompleteQuestion ==
                  "Did ${Questions.homeYouIdentity} move for job-related reasons?" ||
              widget.CheckCompleteQuestion ==
                  "Did one or both of you move for job-related reasons?") &&
          widget.CheckQuestion == "Due to work") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Due to work');
          _insert('Due to work', 'No', 'ok');
          //Question No 64
          //For No 330.0
          //For yes 220.0
          return homeyesnoContainer("""
<p><strong>Hiring a moving company</strong></p>
<p>Please state whether you commissioned a moving company. If this applies to you, answer "Yes". Otherwise click "No".</p>
<p>Note that you cannot deduct cash payments. You must have paid the invoice from the moving company in 2019.</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} hire a moving company?",
              "Moving company",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Due to work');
          _insert('Due to work', 'skip', 'skip');
          //saif
          //Question No 64
          //For No 330.0
          //For yes 220.0
          return homeyesnoContainer("""
<p><strong>Hiring a moving company</strong></p>
<p>Please state whether you commissioned a moving company. If this applies to you, answer "Yes". Otherwise click "No".</p>
<p>Note that you cannot deduct cash payments. You must have paid the invoice from the moving company in 2019.</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} hire a moving company?",
              "Moving company",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Due to work');
          _insert('Due to work', 'Yes', 'OK');
          //Question No 65

          return homecalculationContainer("""
<p><strong>Number of moves</strong></p>
<p>Please enter how many times you moved for work related reasons in 2019.</p>
<p><em>Moving to a second household in addition to your primary residence is not relevant at this point. This is dealt with later.</em></p>
<p><strong>A WORK RELATED MOVE OCCURS IN THE FOLLOWING CASES:</strong></p>
<ul>
<li>By moving you save at least an hour in travel time.</li>
<li>You are moved for a new job in another city.</li>
<li>Your employer has relocated.</li>
<li>You were moved to another site. This can be within the same city if the move considerably shortened your distance to work. If you reduced the distance from 20 to 2 km, for instance, you would be able to deduct this.</li>
<li>You use a company apartment. This is the case, for example, as a janitor, if you need to occupy the apartment of the employer. Here, distance plays no role.</li>
<li>You moved out of your company apartment.</li>
<li>You have ended "double housekeeping"and moved completely to your place of work.</li>
</ul>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "How often did ${Questions.homeYouIdentity} move for job-related reasons in 2019?",
              "Number of moves",
              330.0,
              "calculation",
              "");
        }
      }

      //Answer No 64
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} hire a moving company?" &&
          widget.CheckQuestion == "Moving company") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Moving company');
          _insert('Moving company', 'No', 'OK');
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Moving company');
          _insert('Moving company', 'skip', 'skip');
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Moving company');
          _insert('Moving company', 'Yes', 'OK');
          //Question No 66
          return homecalculationContainer("""
<p><strong>Cost for moving company</strong></p>
<p>Please enter here the total costs for the moving company.</p>
<p>Note that you cannot deduct cash payments. You must have paid the invoice from the moving company in 2019.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""", "", "Relocation", "How much was the moving company?",
              "Amount moving company", 330.0, "calculation", "");
        }
      }

      //Answer No 66
      else if (widget.CheckCompleteQuestion ==
              "How much was the moving company?" &&
          widget.CheckQuestion == "Amount moving company") {
        DbHelper.insatance..deleteWithquestion('Amount moving company');
        _insert('Amount moving company', '12', 'OK');
        //Question No 3
        return homemultitwooptionContainer(
            """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
            "",
            "Household services",
            "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
            "Utility bill, 'WEG' statement",
            ["Utility Bill", "Home owner statement ('WEG')", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            430.0,
            "None",
            "");
      }

      //Answer No 65

      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.homeYouIdentity} move for job-related reasons in 2019?" &&
          widget.CheckQuestion == "Number of moves") {
        //Question No 67

        return homeyesnoContainer("""
<p><strong>Refund your moving expenses</strong></p>
<p>Please indicate whether you have been fully reimbursed for the costs associated with your move.</p>
<p>&nbsp;</p>
""",
            "",
            "Relocation",
            "Have the costs for ${Questions.homeYourIdentity} relocation been reimbursed?",
            "Costs reimbursed",
            220.0,
            "",
            "");
      }

      //Answer No 67

      else if (widget.CheckCompleteQuestion ==
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?" &&
          widget.CheckQuestion == "Reason of relocation") {
        if (widget.CheckAnswer[0] == "Started a new job") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation', 'Started a new job', 'OK');
          //Question No 68
          //For No 220.0
          //For yes 430.0
          return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
              "Lump sum",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] ==
            "Moved in or out of a second household") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation',
              'Moved in or out of a second household', 'OK');
          if (Questions.relocationLength <= Questions.totalRelocation) {
            //Question No 67
//             return homesixoptioncontainer(
//                 """
// <p><strong>Reason for relocation</strong></p>
// <p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
// <p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
// <p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
// <p><strong>STARTED A NEW JOB</strong></p>
// <p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
// <p><strong>EMPLOYER MOVED</strong></p>
// <p>The employer has relocated its location or place of business.</p>
// <p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
// <p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
// <p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
// <p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
// <p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
// <p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
// <p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
// <ul>
// <li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
// <li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
// <li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
// </ul>
// <p><strong>Important!</strong></p>
// <p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//                 "",
//                 "Relocation",
//                 "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
//                 "Reason of relocation",
//                 [
//                   "Started a new job",
//                   "Moved in or out of a second household",
//                   "Saving 1 hour per day",
//                   "Employer moved",
//                   "Transferred to other employer’s location",
//                   "At employer’s request",
//                   "Moving in or out of company flat",
//                   "Other provable occupational reasons",
//                   "None of them"
//                 ],
//                 220.0,
//                 "",
//                 Questions.relocationText);

            return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
                "Lump sum",
                220.0,
                "",
                Questions.relocationText);
          } else {
            //Question No 3
//             return homemultitwooptionContainer(
//                 """
// <p><strong>Type of annual statement</strong></p>
// <p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
// <p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
// <p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
// <ul>
// <li>maintenance &amp; replacement of meter</li>
// <li>clearing gutters</li>
// <li>gardening</li>
// <li>winter service</li>
// <li>maintenance work for heating &amp; water supply</li>
// </ul>
// <p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
// <p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
// <p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
// <p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
// <p>&nbsp;</p>
// """,
//                 "",
//                 "Household services",
//                 "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
//                 "Utility bill, 'WEG' statement",
//                 ["Utility Bill", "Home owner statement ('WEG')", "None"],
//                 [
//                   "images/disabilityoption.png",
//                   "images/alimonypaidoption.png",
//                   "images/survivorspension.png"
//                 ],
//                 430.0,
//                 "None",
//                 "");

            return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
                "Lump sum",
                220.0,
                "",
                Questions.relocationText);
          }
        } else if (widget.CheckAnswer[0] == "Saving 1 hour per day") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation', 'Saving 1 hour per day', 'OK');

          //Question No 68
          //For No 220.0
          //For yes 430.0
          return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
              "Lump sum",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "Employer moved") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation', 'Employer moved', 'OK');
//Question No 68
          //For No 220.0
          //For yes 430.0
          return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
              "Lump sum",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] ==
            "Transferred to other employer’s location") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation',
              'Transferred to other employer’s location', 'OK');
//Question No 68
          //For No 220.0
          //For yes 430.0
          return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
              "Lump sum",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "At employer’s request") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation',
              'Transferred to other employer’s location', 'OK');
//Question No 68
          //For No 220.0
          //For yes 430.0
          return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
              "Lump sum",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] ==
            "Moving in or out of company flat") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert(
              'Reason of relocation', 'Moving in or out of company flat', 'OK');
//Question No 68
          //For No 220.0
          //For yes 430.0
          return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
              "Lump sum",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] ==
            "Other provable occupational reasons") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation', 'Other provable occupational reasons',
              'OK');
//Question No 68
          //For No 220.0
          //For yes 430.0
          return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
              "Lump sum",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "None of them") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation', 'None of them', 'OK');
          if (Questions.relocationLength <= Questions.totalRelocation) {
            //Question No 67
//             return homesixoptioncontainer(
//                 """
// <p><strong>Reason for relocation</strong></p>
// <p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
// <p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
// <p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
// <p><strong>STARTED A NEW JOB</strong></p>
// <p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
// <p><strong>EMPLOYER MOVED</strong></p>
// <p>The employer has relocated its location or place of business.</p>
// <p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
// <p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
// <p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
// <p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
// <p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
// <p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
// <p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
// <ul>
// <li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
// <li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
// <li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
// </ul>
// <p><strong>Important!</strong></p>
// <p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//                 "",
//                 "Relocation",
//                 "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
//                 "Reason of relocation",
//                 [
//                   "Started a new job",
//                   "Moved in or out of a second household",
//                   "Saving 1 hour per day",
//                   "Employer moved",
//                   "Transferred to other employer’s location",
//                   "At employer’s request",
//                   "Moving in or out of company flat",
//                   "Other provable occupational reasons",
//                   "None of them"
//                 ],
//                 220.0,
//                 "",
//                 Questions.relocationText);

            return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
                "Lump sum",
                220.0,
                "",
                Questions.relocationText);
          } else {
            //Question No 3
//             return homemultitwooptionContainer(
//                 """
// <p><strong>Type of annual statement</strong></p>
// <p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
// <p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
// <p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
// <ul>
// <li>maintenance &amp; replacement of meter</li>
// <li>clearing gutters</li>
// <li>gardening</li>
// <li>winter service</li>
// <li>maintenance work for heating &amp; water supply</li>
// </ul>
// <p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
// <p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
// <p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
// <p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//                 "",
//                 "Household services",
//                 "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
//                 "Utility bill, 'WEG' statement",
//                 ["Utility Bill", "Home owner statement ('WEG')", "None"],
//                 [
//                   "images/disabilityoption.png",
//                   "images/alimonypaidoption.png",
//                   "images/survivorspension.png"
//                 ],
//                 430.0,
//                 "None",
//                 "");

            return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
                "Lump sum",
                220.0,
                "",
                Questions.relocationText);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Reason of relocation');
          _insert('Reason of relocation', 'skip', 'skip');
          if (Questions.relocationLength <= Questions.totalRelocation) {
            //Question No 67
//             return homesixoptioncontainer(
//                 """
// <p><strong>Reason for relocation</strong></p>
// <p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
// <p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
// <p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
// <p><strong>STARTED A NEW JOB</strong></p>
// <p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
// <p><strong>EMPLOYER MOVED</strong></p>
// <p>The employer has relocated its location or place of business.</p>
// <p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
// <p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
// <p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
// <p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
// <p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
// <p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
// <p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
// <ul>
// <li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
// <li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
// <li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
// </ul>
// <p><strong>Important!</strong></p>
// <p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//                 "",
//                 "Relocation",
//                 "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
//                 "Reason of relocation",
//                 [
//                   "Started a new job",
//                   "Moved in or out of a second household",
//                   "Saving 1 hour per day",
//                   "Employer moved",
//                   "Transferred to other employer’s location",
//                   "At employer’s request",
//                   "Moving in or out of company flat",
//                   "Other provable occupational reasons",
//                   "None of them"
//                 ],
//                 220.0,
//                 "",
//                 Questions.relocationText);

            return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
                "Lump sum",
                220.0,
                "",
                Questions.relocationText);
          } else {
            //Question No 3
//             return homemultitwooptionContainer(
//                 """
// <p><strong>Type of annual statement</strong></p>
// <p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
// <p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
// <p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
// <ul>
// <li>maintenance &amp; replacement of meter</li>
// <li>clearing gutters</li>
// <li>gardening</li>
// <li>winter service</li>
// <li>maintenance work for heating &amp; water supply</li>
// </ul>
// <p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
// <p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
// <p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
// <p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//                 "",
//                 "Household services",
//                 "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
//                 "Utility bill, 'WEG' statement",
//                 ["Utility Bill", "Home owner statement ('WEG')", "None"],
//                 [
//                   "images/disabilityoption.png",
//                   "images/alimonypaidoption.png",
//                   "images/survivorspension.png"
//                 ],
//                 430.0,
//                 "None",
//                 "");

            return homeyesnoContainer("""
<p><strong>Other moving expenses</strong></p>
<p>Anyone who moves because of the work can claim the lump sum instead of the actual expenses for other costs.</p>
<p>These other costs include, for example:</p>
<ul>
<li>Advertisements for housing search in newspapers and other media</li>
<li>Cosmetic repairs for the old dwelling, if there is a contractual obligation</li>
<li>Fees for identity card, car, telephone and internet connection</li>
<li>Electrical work in the new apartment</li>
<li>Installation and assembly of electrical appliances and kitchen equipment</li>
<li>Tips and rations for removal helpers</li>
<li>Changing curtains and mounting roller blinds</li>
<li>Installing lamps</li>
<li>Costs for changes to be able to use previously used appliances in the new apartment (e.g. stove or dishwasher)</li>
</ul>
<p><strong>Tip:</strong> If the actual expenses for these other costs are higher, they can be considered. You can simply answer with "No". We will then ask for the actual costs. However, these have to be verifiable (with invoices, etc.).</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?",
                "Lump sum",
                220.0,
                "",
                Questions.relocationText);
          }
        }
      }

      //Answer No 68
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} want to make use of the lump sum for so called other moving expenses?" &&
          widget.CheckQuestion == "Lump sum") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Lump sum');
          _insert('Lump sum', 'No', 'OK');
          //Question No 69
          //For No 430.0
          //For yes 220.0
          return homeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} have any miscellaneous moving expenses?",
              "Miscellaneous moving expenses",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Lump sum');
          _insert('Lump sum', 'skip', 'skip');
          //Question No 69
          //For No 430.0
          //For yes 220.0
          return homeyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Relocation",
              "Did ${Questions.homeYouIdentity} have any miscellaneous moving expenses?",
              "Miscellaneous moving expenses",
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Lump sum');
          _insert('Lump sum', 'Yes', 'OK');
          //Question No 70
          //For None 420
          //For rest of 220.0
          return homemultipleoptionsContainerNo(
              """
<p><strong>Your move</strong></p>
<p>Please specify how you moved house. Choose the answer that applies to you. You can select several answers.</p>
<p>If, for example you drove some of your furniture yourself to the new apartment but commissioned a moving company to transport the rest, choose "Own car" and "Moving company".</p>
<p><strong>Own car</strong></p>
<p>You used your own car to move.</p>
<p><strong>Rental car</strong></p>
<p>You rented a car and transported your furniture from the old to the new apartment.</p>
<p><strong>Moving company</strong></p>
<p>You commissioned a moving company to help you with the move.</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "How did ${Questions.homeYouIdentity} move?",
              "Relocation",
              ["Own car", "Rental car", "Moving company", "By plane", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.relocationText);
        }
      }

      //Answer No 69
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} have any miscellaneous moving expenses?" &&
          widget.CheckQuestion == "Miscellaneous moving expenses") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion('Miscellaneous moving expenses');
          _insert('Miscellaneous moving expenses', 'No', 'OK');
          //Question No 70
          return homemultipleoptionsContainerNo(
              """
<p><strong>Your move</strong></p>
<p>Please specify how you moved house. Choose the answer that applies to you. You can select several answers.</p>
<p>If, for example you drove some of your furniture yourself to the new apartment but commissioned a moving company to transport the rest, choose "Own car" and "Moving company".</p>
<p><strong>Own car</strong></p>
<p>You used your own car to move.</p>
<p><strong>Rental car</strong></p>
<p>You rented a car and transported your furniture from the old to the new apartment.</p>
<p><strong>Moving company</strong></p>
<p>You commissioned a moving company to help you with the move.</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "How did ${Questions.homeYouIdentity} move?",
              "Relocation",
              ["Own car", "Rental car", "Moving company", "By plane", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion('Miscellaneous moving expenses');
          _insert('Miscellaneous moving expenses', 'skip', 'skip');
          //Question No 70
          return homemultipleoptionsContainerNo(
              """
<p><strong>Your move</strong></p>
<p>Please specify how you moved house. Choose the answer that applies to you. You can select several answers.</p>
<p>If, for example you drove some of your furniture yourself to the new apartment but commissioned a moving company to transport the rest, choose "Own car" and "Moving company".</p>
<p><strong>Own car</strong></p>
<p>You used your own car to move.</p>
<p><strong>Rental car</strong></p>
<p>You rented a car and transported your furniture from the old to the new apartment.</p>
<p><strong>Moving company</strong></p>
<p>You commissioned a moving company to help you with the move.</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "How did ${Questions.homeYouIdentity} move?",
              "Relocation",
              ["Own car", "Rental car", "Moving company", "By plane", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion('Miscellaneous moving expenses');
          _insert('Miscellaneous moving expenses', 'Yes', 'OK');
          //Question No 71
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Relocation",
              "How much did ${Questions.homeYouIdentity} spent on miscellaneous moving expenses?",
              "Actual costs",
              430.0,
              "calculation",
              Questions.relocationText);
        }
      }

      //Answer No 71
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spent on miscellaneous moving expenses?" &&
          widget.CheckQuestion == "Actual costs") {
        //Question No 70
        return homemultipleoptionsContainerNo(
            """
<p><strong>Your move</strong></p>
<p>Please specify how you moved house. Choose the answer that applies to you. You can select several answers.</p>
<p>If, for example you drove some of your furniture yourself to the new apartment but commissioned a moving company to transport the rest, choose "Own car" and "Moving company".</p>
<p><strong>Own car</strong></p>
<p>You used your own car to move.</p>
<p><strong>Rental car</strong></p>
<p>You rented a car and transported your furniture from the old to the new apartment.</p>
<p><strong>Moving company</strong></p>
<p>You commissioned a moving company to help you with the move.</p>
<p>&nbsp;</p>
""",
            "",
            "Relocation",
            "How did ${Questions.homeYouIdentity} move?",
            "Relocation",
            ["Own car", "Rental car", "Moving company", "By plane", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.relocationText);
      }

      //Answer no 70

      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.homeYouIdentity} move?" &&
          widget.CheckQuestion == "Relocation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Own car") {
            DbHelper.insatance..deleteWithquestion('How did you move?');
            _insert('How did you move?', 'Own car', 'OK');
            //Question No 72
            //Ya container from to sa change hoga
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Relocation",
                "We want to calculate the distance. From where to where did ${Questions.homeYouIdentity} go by car?",
                "Distance by car",
                430.0,
                "",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "Rental car") {
            DbHelper.insatance..deleteWithquestion('How did you move?');
            _insert('How did you move?', 'Rental car', 'OK');
//Question No 73
            return homecalculationContainer("""
<p><strong>MOVE WITH RENTAL CAR</strong></p>
<p>If you rented a car or a truck for your move, enter the total costs here.</p>
<p>You can enter all of the costs including the rental price and for fuel.</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "How much did ${Questions.homeYouIdentity} spend on the rental car?",
                "Amount",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "Moving company") {
            DbHelper.insatance..deleteWithquestion('How did you move?');
            _insert('How did you move?', 'Moving company', 'OK');
//Question No 74
            return homecalculationContainer("""
<p><strong>Cost for moving company</strong></p>
<p>If you hired a moving company, please enter here the total costs here.</p>
<p>You can enter the total invoice amount.</p>
<p>Please note you may have to provide proof of these costs to the tax office.</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "How much did ${Questions.homeYouIdentity} spend on the moving company?",
                "Amount",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "By plane") {
            DbHelper.insatance..deleteWithquestion('How did you move?');
            _insert('How did you move?', 'By plane', 'OK');
//Question No 75
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Relocation",
                "How much did ${Questions.homeYouIdentity} spent on the plane?",
                "Costs for plane",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance..deleteWithquestion('How did you move?');
            _insert('How did you move?', 'None', 'OK');
//Question No 76
            return homemultipleoptionsContainerNo(
                """
<p><strong>Moving costs</strong></p>
<p>Indicate here if you had any further costs related to moving in the year 2019. You can choose from the given that apply to you.</p>
<p><strong>BROKER FEE</strong></p>
<p>If you used a broker to find a flat, you can specify the total cost.</p>
<p>If a broker helps you to find a home (when buying a property), you <strong>cannot deduct</strong> these costs, even if the relocation is work related. In this case, the private reasons weigh more heavily than the professional ones.</p>
<p><strong>TRAVEL COSTS FOR APARTMENT VIEWINGS</strong></p>
<p>If you have traveled to another city for apartment viewings, state the total cost for the round trip. If you cannot state the exact cost, use the flat rate of 30 cents per kilometer.</p>
<p><strong>DOUBLE RENT PAYMENTS</strong></p>
<p>If you have to pay rent for both your old and the new apartment because of the notice period of the old apartment, you can deduct the double rent payments.</p>
<p><strong>Which rent is deductible?</strong> If you still live in the old apartment, but have already rented the new one, you should enter the <strong>rent payments for the new apartment.</strong></p>
<p>If you already live in the new apartment, you can deduct rent payments including utility costs for the old one. This is valid from the day of moving out from the old apartment until the end of the tenancy.</p>
<p><strong>TRANSPORTATION DAMAGE</strong></p>
<p>If items have been damaged during transportation you can enter the repair costs here.</p>
<p><strong>PRIVATE TUTORING</strong></p>
<p>If children are also involved in the move, you can deduct their tutoring lessons if they have to catch up on learning content due to the change of school.</p>
<p><strong>ADDITIONAL COSTS</strong></p>
<p>If other costs have arisen, you can enter them here.</p>
<p>For example:</p>
<ul>
<li>Costs for packaging material (moving boxes, clothes crates etc.)</li>
<li>Free parking signs</li>
<li>Administration frees</li>
<li>Tips for moving helpers</li>
<li>Lump sum for a cooking stove up to 230 Euro</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} have any other costs due to the move?",
                "Costs",
                [
                  "Broker’s fee",
                  "Travel to apartment viewings",
                  "Double rent",
                  "Damages during transport",
                  "Private tutoring",
                  "Other expenses",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                220.0,
                "No",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance..deleteWithquestion('How did you move?');
            _insert('How did you move?', 'skip', 'skip');
//Question No 76
            return homemultipleoptionsContainerNo(
                """
<p><strong>Moving costs</strong></p>
<p>Indicate here if you had any further costs related to moving in the year 2019. You can choose from the given that apply to you.</p>
<p><strong>BROKER FEE</strong></p>
<p>If you used a broker to find a flat, you can specify the total cost.</p>
<p>If a broker helps you to find a home (when buying a property), you <strong>cannot deduct</strong> these costs, even if the relocation is work related. In this case, the private reasons weigh more heavily than the professional ones.</p>
<p><strong>TRAVEL COSTS FOR APARTMENT VIEWINGS</strong></p>
<p>If you have traveled to another city for apartment viewings, state the total cost for the round trip. If you cannot state the exact cost, use the flat rate of 30 cents per kilometer.</p>
<p><strong>DOUBLE RENT PAYMENTS</strong></p>
<p>If you have to pay rent for both your old and the new apartment because of the notice period of the old apartment, you can deduct the double rent payments.</p>
<p><strong>Which rent is deductible?</strong> If you still live in the old apartment, but have already rented the new one, you should enter the <strong>rent payments for the new apartment.</strong></p>
<p>If you already live in the new apartment, you can deduct rent payments including utility costs for the old one. This is valid from the day of moving out from the old apartment until the end of the tenancy.</p>
<p><strong>TRANSPORTATION DAMAGE</strong></p>
<p>If items have been damaged during transportation you can enter the repair costs here.</p>
<p><strong>PRIVATE TUTORING</strong></p>
<p>If children are also involved in the move, you can deduct their tutoring lessons if they have to catch up on learning content due to the change of school.</p>
<p><strong>ADDITIONAL COSTS</strong></p>
<p>If other costs have arisen, you can enter them here.</p>
<p>For example:</p>
<ul>
<li>Costs for packaging material (moving boxes, clothes crates etc.)</li>
<li>Free parking signs</li>
<li>Administration frees</li>
<li>Tips for moving helpers</li>
<li>Lump sum for a cooking stove up to 230 Euro</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Did ${Questions.homeYouIdentity} have any other costs due to the move?",
                "Costs",
                [
                  "Broker’s fee",
                  "Travel to apartment viewings",
                  "Double rent",
                  "Damages during transport",
                  "Private tutoring",
                  "Other expenses",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                220.0,
                "No",
                Questions.relocationText);
          }
        }
      }

      //Answer No 72
      else if (widget.CheckCompleteQuestion ==
              "We want to calculate the distance. From where to where did ${Questions.homeYouIdentity} go by car?" &&
          widget.CheckQuestion == "Distance by car") {
        //Question No 76
        return homemultipleoptionsContainerNo(
            """
<p><strong>Moving costs</strong></p>
<p>Indicate here if you had any further costs related to moving in the year 2019. You can choose from the given that apply to you.</p>
<p><strong>BROKER FEE</strong></p>
<p>If you used a broker to find a flat, you can specify the total cost.</p>
<p>If a broker helps you to find a home (when buying a property), you <strong>cannot deduct</strong> these costs, even if the relocation is work related. In this case, the private reasons weigh more heavily than the professional ones.</p>
<p><strong>TRAVEL COSTS FOR APARTMENT VIEWINGS</strong></p>
<p>If you have traveled to another city for apartment viewings, state the total cost for the round trip. If you cannot state the exact cost, use the flat rate of 30 cents per kilometer.</p>
<p><strong>DOUBLE RENT PAYMENTS</strong></p>
<p>If you have to pay rent for both your old and the new apartment because of the notice period of the old apartment, you can deduct the double rent payments.</p>
<p><strong>Which rent is deductible?</strong> If you still live in the old apartment, but have already rented the new one, you should enter the <strong>rent payments for the new apartment.</strong></p>
<p>If you already live in the new apartment, you can deduct rent payments including utility costs for the old one. This is valid from the day of moving out from the old apartment until the end of the tenancy.</p>
<p><strong>TRANSPORTATION DAMAGE</strong></p>
<p>If items have been damaged during transportation you can enter the repair costs here.</p>
<p><strong>PRIVATE TUTORING</strong></p>
<p>If children are also involved in the move, you can deduct their tutoring lessons if they have to catch up on learning content due to the change of school.</p>
<p><strong>ADDITIONAL COSTS</strong></p>
<p>If other costs have arisen, you can enter them here.</p>
<p>For example:</p>
<ul>
<li>Costs for packaging material (moving boxes, clothes crates etc.)</li>
<li>Free parking signs</li>
<li>Administration frees</li>
<li>Tips for moving helpers</li>
<li>Lump sum for a cooking stove up to 230 Euro</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Relocation",
            "Did ${Questions.homeYouIdentity} have any other costs due to the move?",
            "Costs",
            [
              "Broker’s fee",
              "Travel to apartment viewings",
              "Double rent",
              "Damages during transport",
              "Private tutoring",
              "Other expenses",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.relocationText);
      }

      //Answer No 73
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the rental car?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 76
        return homemultipleoptionsContainerNo(
            """
<p><strong>Moving costs</strong></p>
<p>Indicate here if you had any further costs related to moving in the year 2019. You can choose from the given that apply to you.</p>
<p><strong>BROKER FEE</strong></p>
<p>If you used a broker to find a flat, you can specify the total cost.</p>
<p>If a broker helps you to find a home (when buying a property), you <strong>cannot deduct</strong> these costs, even if the relocation is work related. In this case, the private reasons weigh more heavily than the professional ones.</p>
<p><strong>TRAVEL COSTS FOR APARTMENT VIEWINGS</strong></p>
<p>If you have traveled to another city for apartment viewings, state the total cost for the round trip. If you cannot state the exact cost, use the flat rate of 30 cents per kilometer.</p>
<p><strong>DOUBLE RENT PAYMENTS</strong></p>
<p>If you have to pay rent for both your old and the new apartment because of the notice period of the old apartment, you can deduct the double rent payments.</p>
<p><strong>Which rent is deductible?</strong> If you still live in the old apartment, but have already rented the new one, you should enter the <strong>rent payments for the new apartment.</strong></p>
<p>If you already live in the new apartment, you can deduct rent payments including utility costs for the old one. This is valid from the day of moving out from the old apartment until the end of the tenancy.</p>
<p><strong>TRANSPORTATION DAMAGE</strong></p>
<p>If items have been damaged during transportation you can enter the repair costs here.</p>
<p><strong>PRIVATE TUTORING</strong></p>
<p>If children are also involved in the move, you can deduct their tutoring lessons if they have to catch up on learning content due to the change of school.</p>
<p><strong>ADDITIONAL COSTS</strong></p>
<p>If other costs have arisen, you can enter them here.</p>
<p>For example:</p>
<ul>
<li>Costs for packaging material (moving boxes, clothes crates etc.)</li>
<li>Free parking signs</li>
<li>Administration frees</li>
<li>Tips for moving helpers</li>
<li>Lump sum for a cooking stove up to 230 Euro</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Relocation",
            "Did ${Questions.homeYouIdentity} have any other costs due to the move?",
            "Costs",
            [
              "Broker’s fee",
              "Travel to apartment viewings",
              "Double rent",
              "Damages during transport",
              "Private tutoring",
              "Other expenses",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.relocationText);
      }

      //Answer No 74
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the moving company?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 76
        return homemultipleoptionsContainerNo(
            """
<p><strong>Moving costs</strong></p>
<p>Indicate here if you had any further costs related to moving in the year 2019. You can choose from the given that apply to you.</p>
<p><strong>BROKER FEE</strong></p>
<p>If you used a broker to find a flat, you can specify the total cost.</p>
<p>If a broker helps you to find a home (when buying a property), you <strong>cannot deduct</strong> these costs, even if the relocation is work related. In this case, the private reasons weigh more heavily than the professional ones.</p>
<p><strong>TRAVEL COSTS FOR APARTMENT VIEWINGS</strong></p>
<p>If you have traveled to another city for apartment viewings, state the total cost for the round trip. If you cannot state the exact cost, use the flat rate of 30 cents per kilometer.</p>
<p><strong>DOUBLE RENT PAYMENTS</strong></p>
<p>If you have to pay rent for both your old and the new apartment because of the notice period of the old apartment, you can deduct the double rent payments.</p>
<p><strong>Which rent is deductible?</strong> If you still live in the old apartment, but have already rented the new one, you should enter the <strong>rent payments for the new apartment.</strong></p>
<p>If you already live in the new apartment, you can deduct rent payments including utility costs for the old one. This is valid from the day of moving out from the old apartment until the end of the tenancy.</p>
<p><strong>TRANSPORTATION DAMAGE</strong></p>
<p>If items have been damaged during transportation you can enter the repair costs here.</p>
<p><strong>PRIVATE TUTORING</strong></p>
<p>If children are also involved in the move, you can deduct their tutoring lessons if they have to catch up on learning content due to the change of school.</p>
<p><strong>ADDITIONAL COSTS</strong></p>
<p>If other costs have arisen, you can enter them here.</p>
<p>For example:</p>
<ul>
<li>Costs for packaging material (moving boxes, clothes crates etc.)</li>
<li>Free parking signs</li>
<li>Administration frees</li>
<li>Tips for moving helpers</li>
<li>Lump sum for a cooking stove up to 230 Euro</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Relocation",
            "Did ${Questions.homeYouIdentity} have any other costs due to the move?",
            "Costs",
            [
              "Broker’s fee",
              "Travel to apartment viewings",
              "Double rent",
              "Damages during transport",
              "Private tutoring",
              "Other expenses",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.relocationText);
      }

      //Answer No 75
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spent on the plane?" &&
          widget.CheckQuestion == "Costs for plane") {
        //Question No 76
        return homemultipleoptionsContainerNo(
            """
<p><strong>Moving costs</strong></p>
<p>Indicate here if you had any further costs related to moving in the year 2019. You can choose from the given that apply to you.</p>
<p><strong>BROKER FEE</strong></p>
<p>If you used a broker to find a flat, you can specify the total cost.</p>
<p>If a broker helps you to find a home (when buying a property), you <strong>cannot deduct</strong> these costs, even if the relocation is work related. In this case, the private reasons weigh more heavily than the professional ones.</p>
<p><strong>TRAVEL COSTS FOR APARTMENT VIEWINGS</strong></p>
<p>If you have traveled to another city for apartment viewings, state the total cost for the round trip. If you cannot state the exact cost, use the flat rate of 30 cents per kilometer.</p>
<p><strong>DOUBLE RENT PAYMENTS</strong></p>
<p>If you have to pay rent for both your old and the new apartment because of the notice period of the old apartment, you can deduct the double rent payments.</p>
<p><strong>Which rent is deductible?</strong> If you still live in the old apartment, but have already rented the new one, you should enter the <strong>rent payments for the new apartment.</strong></p>
<p>If you already live in the new apartment, you can deduct rent payments including utility costs for the old one. This is valid from the day of moving out from the old apartment until the end of the tenancy.</p>
<p><strong>TRANSPORTATION DAMAGE</strong></p>
<p>If items have been damaged during transportation you can enter the repair costs here.</p>
<p><strong>PRIVATE TUTORING</strong></p>
<p>If children are also involved in the move, you can deduct their tutoring lessons if they have to catch up on learning content due to the change of school.</p>
<p><strong>ADDITIONAL COSTS</strong></p>
<p>If other costs have arisen, you can enter them here.</p>
<p>For example:</p>
<ul>
<li>Costs for packaging material (moving boxes, clothes crates etc.)</li>
<li>Free parking signs</li>
<li>Administration frees</li>
<li>Tips for moving helpers</li>
<li>Lump sum for a cooking stove up to 230 Euro</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Relocation",
            "Did ${Questions.homeYouIdentity} have any other costs due to the move?",
            "Costs",
            [
              "Broker’s fee",
              "Travel to apartment viewings",
              "Double rent",
              "Damages during transport",
              "Private tutoring",
              "Other expenses",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.relocationText);
      }

      //Answer No 76
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} have any other costs due to the move?" &&
          widget.CheckQuestion == "Costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Broker’s fee") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you have any other costs due to the move?');
            _insert('Did you have any other costs due to the move?',
                'Broker’s fee', 'OK');
            //Question No 77
            return homecalculationContainer("""
<p><strong>Broker costs</strong></p>
<p>If you used a broker to help look for an apartment, enter the total costs here.</p>
<p><em>Please enter the total amount spent on a broker in 2019.</em></p>
<p><strong>Warning for purchase of property:</strong></p>
<p>If you used a broker or estate agent to purchase a property, you <strong>cannot deduct</strong> the costs for a work related move.</p>
<p>In this case the private reasons take precedent over the professional.</p>
<p>&nbsp;</p>
""", "", "Relocation", "How much was the broker’s fee?", "Broker", 430.0,
                "calculation", Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "Travel to apartment viewings") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you have any other costs due to the move?');
            _insert('Did you have any other costs due to the move?',
                'Travel to apartment viewings', 'OK');
//Question No 78
            return homecalculationContainer("""
<p><strong>Apartment viewings</strong></p>
<p>Please enter the costs for apartment viewings. Remember, only costs from 2019 are relevant.</p>
<p>If you traveled to another city or town because of a flat viewing, then you can write off the journey costs for the trip there and back. If you don't know the exact costs, you can use the commuting allowance of 30 cents per kilometer.</p>
<p><strong>Other costs include:</strong></p>
<ul>
<li>overnight costs</li>
<li>telephone and postal costs</li>
</ul>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "How much were ${Questions.homeYourIdentity} travel costs for apartment viewings?",
                "Apartment viewings",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "Double rent") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you have any other costs due to the move?');
            _insert('Did you have any other costs due to the move?',
                'Double rent', 'OK');

//Question No 79
            return homecalculationContainer("""
<p><strong>Double rent</strong></p>
<p>Please enter the amount you spent on double rent. Only expenses from 2019 are relevant.</p>
<p><strong>WHICH RENT IS DEDUCTIBLE?</strong></p>
<p>If you still live in the old apartment but already pay rent for the new one, then you enter the <strong>rent payments for the new apartment.</strong></p>
<p>If you already live in the new apartment, you can deduct both rent and utilities costs from the old apartment. This applies from the day you moved out of the old apartment to the end of the rental contract.</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "How much did ${Questions.homeYouIdentity} pay in rent for the unused apartment?",
                "Double rent payments",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "Damages during transport") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you have any other costs due to the move?');
            _insert('Did you have any other costs due to the move?',
                'Damages during transport', 'OK');
//Question No 80
            return homecalculationContainer("""
<p><strong>Transport damage</strong></p>
<p>Enter here the total amount of damage caused while moving house in 2019.</p>
<p>If something broke during the move, you can enter the related expenditure here:</p>
<ul>
<li>repair costs</li>
<li>replacement cost for damaged or lost items</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "How much were the damages due to transport?",
                "Damages during transport",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "Private tutoring") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you have any other costs due to the move?');
            _insert('Did you have any other costs due to the move?',
                'Private tutoring', 'OK');
//Question No 81
            return homecalculationContainer("""
<p><strong>Tutoring</strong></p>
<p>If your children requite tutoring as a result of the move, the costs are tax deductible up to a maximum amount.</p>
<p>You don't have to worry about the maximum amount. We calculate this automatically.</p>
<p><em>Enter your total cost. Please only costs from 2019 are relevant.</em></p>
<p><em>&nbsp;</em></p>
""",
                "",
                "Relocation",
                "How much did ${Questions.homeYouIdentity} spend on tutoring due to change of school?",
                "Private tutoring",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "Other expenses") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you have any other costs due to the move?');
            _insert('Did you have any other costs due to the move?',
                'Other expenses', 'OK');
//Question No 82
            return homecalculationContainer("""
<p><strong>Additional moving expenses</strong></p>
<p>Please enter the amount of additional costs you had due to moving. Remember, only costs from 2019 are relevant.</p>
<p>For example:</p>
<ul>
<li>costs for moving boxes etc.</li>
<li>fees for parking signs</li>
<li>fees for registration</li>
<li>tips for movers</li>
<li>lump sum for a cooking stove up to 230 Euro.</li>
</ul>
<p><strong>Own receipt</strong></p>
<p>The tax office may ask to see proof. If you do not have any you can create you create your own. Write the name and address of the recipient of the payment, the type, price and date of the expense, and sign this.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Relocation",
                "Please enter any other costs ${Questions.homeYouIdentity} had due to relocation?",
                "Other costs",
                430.0,
                "calculation",
                Questions.relocationText);
          } else if (widget.CheckAnswer[m] == "No" ||
              widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you have any other costs due to the move?');
            _insert('Did you have any other costs due to the move?',
                widget.CheckAnswer[m], widget.CheckAnswer[m]);
            if (Questions.relocationLength <= Questions.totalRelocation) {
              //Question No 67
              return homesixoptioncontainer(
                  """
<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                  "",
                  "Relocation",
                  "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
                  "Reason of relocation",
                  [
                    "Started a new job",
                    "Moved in or out of a second household",
                    "Saving 1 hour per day",
                    "Employer moved",
                    "Transferred to other employer’s location",
                    "At employer’s request",
                    "Moving in or out of company flat",
                    "Other provable occupational reasons",
                    "None of them"
                  ],
                  220.0,
                  "",
                  Questions.relocationText);
            } else {
              //Question No 3
              return homemultitwooptionContainer(
                  """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
                  "Utility bill, 'WEG' statement",
                  ["Utility Bill", "Home owner statement ('WEG')", "None"],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png"
                  ],
                  430.0,
                  "None",
                  "");
            }
          }
        }
      }

      //Answer No 77
      else if (widget.CheckCompleteQuestion ==
              "How much was the broker’s fee?" &&
          widget.CheckQuestion == "Broker") {
        if (Questions.relocationLength <= Questions.totalRelocation) {
          //Question No 67
          return homesixoptioncontainer(
              """
<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
              "Reason of relocation",
              [
                "Started a new job",
                "Moved in or out of a second household",
                "Saving 1 hour per day",
                "Employer moved",
                "Transferred to other employer’s location",
                "At employer’s request",
                "Moving in or out of company flat",
                "Other provable occupational reasons",
                "None of them"
              ],
              220.0,
              "",
              Questions.relocationText);
        } else {
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        }
      }

      //Answer No 78
      else if (widget.CheckCompleteQuestion ==
              "How much were ${Questions.homeYourIdentity} travel costs for apartment viewings?" &&
          widget.CheckQuestion == "Apartment viewings") {
        if (Questions.relocationLength <= Questions.totalRelocation) {
          //Question No 67
          return homesixoptioncontainer(
              """
<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
              "Reason of relocation",
              [
                "Started a new job",
                "Moved in or out of a second household",
                "Saving 1 hour per day",
                "Employer moved",
                "Transferred to other employer’s location",
                "At employer’s request",
                "Moving in or out of company flat",
                "Other provable occupational reasons",
                "None of them"
              ],
              220.0,
              "",
              Questions.relocationText);
        } else {
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        }
      }

      //Answer No 79
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} pay in rent for the unused apartment?" &&
          widget.CheckQuestion == "Double rent payments") {
        if (Questions.relocationLength <= Questions.totalRelocation) {
          //Question No 67
          return homesixoptioncontainer(
              """
<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
              "Reason of relocation",
              [
                "Started a new job",
                "Moved in or out of a second household",
                "Saving 1 hour per day",
                "Employer moved",
                "Transferred to other employer’s location",
                "At employer’s request",
                "Moving in or out of company flat",
                "Other provable occupational reasons",
                "None of them"
              ],
              220.0,
              "",
              Questions.relocationText);
        } else {
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        }
      }

      //Answer No 80
      else if (widget.CheckCompleteQuestion ==
              "How much were the damages due to transport?" &&
          widget.CheckQuestion == "Damages during transport") {
        if (Questions.relocationLength <= Questions.totalRelocation) {
          //Question No 67
          return homesixoptioncontainer(
              """
<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
              "Reason of relocation",
              [
                "Started a new job",
                "Moved in or out of a second household",
                "Saving 1 hour per day",
                "Employer moved",
                "Transferred to other employer’s location",
                "At employer’s request",
                "Moving in or out of company flat",
                "Other provable occupational reasons",
                "None of them"
              ],
              220.0,
              "",
              Questions.relocationText);
        } else {
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        }
      }

      //Answer No 81
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on tutoring due to change of school?" &&
          widget.CheckQuestion == "Private tutoring") {
        if (Questions.relocationLength <= Questions.totalRelocation) {
          //Question No 67
          return homesixoptioncontainer(
              """
<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
              "Reason of relocation",
              [
                "Started a new job",
                "Moved in or out of a second household",
                "Saving 1 hour per day",
                "Employer moved",
                "Transferred to other employer’s location",
                "At employer’s request",
                "Moving in or out of company flat",
                "Other provable occupational reasons",
                "None of them"
              ],
              220.0,
              "",
              Questions.relocationText);
        } else {
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        }
      }

      //Answer No 82
      else if (widget.CheckCompleteQuestion ==
              "Please enter any other costs ${Questions.homeYouIdentity} had due to relocation?" &&
          widget.CheckQuestion == "Other costs") {
        if (Questions.relocationLength <= Questions.totalRelocation) {
          //Question No 67
          return homesixoptioncontainer(
              """
<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Relocation",
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
              "Reason of relocation",
              [
                "Started a new job",
                "Moved in or out of a second household",
                "Saving 1 hour per day",
                "Employer moved",
                "Transferred to other employer’s location",
                "At employer’s request",
                "Moving in or out of company flat",
                "Other provable occupational reasons",
                "None of them"
              ],
              220.0,
              "",
              Questions.relocationText);
        } else {
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        }
      }

      //============= Big Detail (Relocation End) =========================

      //============= Big Detail (House Hold Services Start) =========================

      //Answer No 3
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?" &&
          widget.CheckQuestion == "Utility bill, 'WEG' statement") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Utility Bill") {
            DbHelper.insatance
              ..deleteWithquestion('Utility bill, \'WEG\' statement');
            _insert('Utility bill, \'WEG\' statement', 'Utility Bill', 'OK');
            //Question No 5
            return homeyesnoContainer("""
<p><strong>Annual utilities statements</strong></p>
<p>Please select whether you want to enter multiple annual utilities statements. In this case click "Yes", otherwise choose "No". This could be the case if you relocated and have utilities statements for various apartments.</p>
<p><strong>IMPORTANT</strong></p>
<p>You can enter all annual utilities statements that you have received. If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return.</p>
<p><strong>CURRENT ANNUAL UTILITIES STATEMENT</strong></p>
<p>If you still don't have your utilities statement for 2019 it's not a problem. You can write it off in the year you receive it. If, for example, you only receive it in August 2020, then you can enter this in next year's tax return.</p>
<p><strong>NOTE ON SECOND HOUSEHOLD</strong></p>
<p>We'll deal with utilities costs for your second household in another section. You DON'T have to enter them here.</p>
<p>Often individual costs are not correctly listed in the annual utilities statement. In this case you are entitled to a free cost overview according to &sect; 35 a of the Income Tax Act. Ask your landlord for this.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Would ${Questions.homeYouIdentity} like to enter more than one utility bill?",
                "More bills",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Home owner statement ('WEG')") {
            DbHelper.insatance
              ..deleteWithquestion('Utility bill, \'WEG\' statement');
            _insert('Utility bill, \'WEG\' statement',
                'Home owner statement (\'WEG\')', 'OK');
            //Question No 17
            return homeyesnoContainer("""
<p><strong>Several annual costs statements from owners' association</strong></p>
<p>Please choose whether you had more than one annual cost statement from an owners' assocation that you want to write off.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Would ${Questions.homeYouIdentity} like to enter more than one 'WEG' statement?",
                "More than one",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance
              ..deleteWithquestion('Utility bill, \'WEG\' statement');
            _insert('Utility bill, \'WEG\' statement', 'None', 'OK');
            //Question No 9
            //For No 220.0
            //For nursing care 220.0
            //For rest 330.0
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion('Utility bill, \'WEG\' statement');
            _insert('Utility bill, \'WEG\' statement', 'skip', 'skip');
            //Question No 9
            //For No 220.0
            //For nursing care 220.0
            //For rest 330.0
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer no 5
      else if (widget.CheckCompleteQuestion ==
              "Would ${Questions.homeYouIdentity} like to enter more than one utility bill?" &&
          widget.CheckQuestion == "More bills") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('More bills');
          _insert('More bills', 'No', 'OK');
          //Question No 6
          //For No 430.0
          //For Yes 220.0
          return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?",
              "Certificate",
              430.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('More bills');
          _insert('More bills', 'Yes', 'OK');
          //Question No 7
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How many utility statements would ${Questions.homeYouIdentity} like to enter?",
              "Number of bills",
              430.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('More bills');
          _insert('More bills', 'skip', 'skip');
          //Question No 7
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How many utility statements would ${Questions.homeYouIdentity} like to enter?",
              "Number of bills",
              430.0,
              "calculation",
              "");
        }
      }

      //Answer No 7
      else if (widget.CheckCompleteQuestion ==
              "How many utility statements would ${Questions.homeYouIdentity} like to enter?" &&
          widget.CheckQuestion == "Number of bills") {
        //Question No 58
        //For No 430.0
        //For Yes 220.0

        //Multiple data
        return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
            "",
            "Household services",
            "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
            "Certificate ${Questions.utilityBillLength}",
            430.0,
            "",
            "STATEMENT ${Questions.utilityBillLength}");
      }

//Multiple Single
      else if ((widget.CheckCompleteQuestion ==
                  "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?" ||
              widget.CheckCompleteQuestion ==
                  "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?") &&
          (widget.CheckQuestion == "Certificate" ||
              widget.CheckQuestion ==
                  "Certificate ${Questions.utilityBillLength}")) {
        if (widget.CheckCompleteQuestion ==
            "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?") {
          //Answer No 6
          //Single Data
          if (widget.CheckAnswer[0] == "No") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?');
            _insert(
                'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?',
                'No',
                'OK');
            //Question No 8
            //For No services 420
            //For Rest 220.0
            return homemultipleoptionsContainerNo(
                """
<p><strong>Type of services</strong></p>
<p>Here you can specify which of the so-called household services and craftsman services are included in your utility bill. Kindly note that only certain types of costs are deductible.</p>
<p>Therefore, besides the type of costs within the list you can pay attention to the following deductible items:</p>
<ul>
<li>Gutter cleaning</li>
<li>Maintenance &amp; replacement of meter</li>
<li>Janitorial activities</li>
<li>Maintenance work on heating &amp; water supply</li>
<li>Maintenance of the elevator</li>
</ul>
<p>Although the work was commissioned by the landlord, it has been paid by the tenants and is therefore deductible for you. In this regard kindly note that only the labour costs are deductible. Costs for material are not deductible.</p>
<p><strong>CURRENT UTILITY BILL</strong></p>
<p>In case the utility bill of 2019 is not yet available, this is no problem. It can be entered in the tax return for the year in which it is available. If it does not arrive until August 2020, the statement can be entered in the next tax return.</p>
<p>If the statement of 2018 is available now, then it can be entered in the current tax return.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Which of the following services are included in ${Questions.homeYourIdentity} utility bill?",
                "Services",
                [
                  "Cleaning / pest control",
                  "Gardening",
                  "Facility manager",
                  "Maintenance / repair",
                  "Chimney sweeper",
                  "Winter service",
                  "Other services",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No services",
                "");
          } else if (widget.CheckAnswer[0] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?');
            _insert(
                'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?',
                'skip',
                'skip');
            //Question No 8
            //For No services 420
            //For Rest 220.0
            return homemultipleoptionsContainerNo(
                """
<p><strong>Type of services</strong></p>
<p>Here you can specify which of the so-called household services and craftsman services are included in your utility bill. Kindly note that only certain types of costs are deductible.</p>
<p>Therefore, besides the type of costs within the list you can pay attention to the following deductible items:</p>
<ul>
<li>Gutter cleaning</li>
<li>Maintenance &amp; replacement of meter</li>
<li>Janitorial activities</li>
<li>Maintenance work on heating &amp; water supply</li>
<li>Maintenance of the elevator</li>
</ul>
<p>Although the work was commissioned by the landlord, it has been paid by the tenants and is therefore deductible for you. In this regard kindly note that only the labour costs are deductible. Costs for material are not deductible.</p>
<p><strong>CURRENT UTILITY BILL</strong></p>
<p>In case the utility bill of 2019 is not yet available, this is no problem. It can be entered in the tax return for the year in which it is available. If it does not arrive until August 2020, the statement can be entered in the next tax return.</p>
<p>If the statement of 2018 is available now, then it can be entered in the current tax return.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Which of the following services are included in ${Questions.homeYourIdentity} utility bill?",
                "Services",
                [
                  "Cleaning / pest control",
                  "Gardening",
                  "Facility manager",
                  "Maintenance / repair",
                  "Chimney sweeper",
                  "Winter service",
                  "Other services",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No services",
                "");
          } else if (widget.CheckAnswer[0] == "Yes") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?');
            _insert(
                'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?',
                'Yes',
                'OK');
            //Question No 179

            return homecalculationContainer("""
<p><strong>Utilities and operating costs</strong></p>
<p>Please enter the amount of utilities and operating costs you had. Add up all of the amounts and enter the total.</p>
<p>Check your last annual utilities statement for these deductible costs:</p>
<ul>
<li>gardening</li>
<li>cleaning</li>
<li>caretaker duties</li>
<li>chimney cleaning</li>
<li>maintenance of elevator</li>
</ul>
<p>These works are contracted by the landlord but paid for by you and the other tenants. You can deduct the labor costs. Material costs are not deductible.</p>
<p>Here it can be stated how much was paid by you in total according to the certificate issued by the landlord for the so-called household services and craftsman services, as far as they relate to your flat.</p>
<p>Therefore, pay attention to the proportion that is attributable to your flat. This is mostly listed in the far right column under "Your share".</p>
<p>Although the work was commissioned by the landlord, it was paid for by the tenants and is therefore deductible for you.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "What was the bill amount for services or craftsmen on ${Questions.homeYourIdentity} utilities statement (excluding heating, electricity, insurances etc.)?",
                "Amount utilities",
                430.0,
                "calculation",
                "");
          }
        }
        //answer No 58

//Multiple Data
        else if (widget.CheckCompleteQuestion ==
            "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?") {
          if (widget.CheckAnswer[0] == "No") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?');
            _insert(
                'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?',
                'No',
                'OK');
            //Question No 59
            //For No services 420
            //For Rest 220.0

            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Household services",
                "Which of the following services are included in ${Questions.homeYourIdentity} utility bill no. ${Questions.utilityBillLength}?",
                "Services ${Questions.utilityBillLength}",
                [
                  "Cleaning / pest control",
                  "Gardening",
                  "Facility manager",
                  "Maintenance / repair",
                  "Chimney sweeper",
                  "Winter service",
                  "Other services",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No services",
                "STATEMENT ${Questions.utilityBillLength}");
          } else if (widget.CheckAnswer[0] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?');
            _insert(
                'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?',
                'skip',
                'skip');
            //Question No 59
            //For No services 420
            //For Rest 220.0

            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Household services",
                "Which of the following services are included in ${Questions.homeYourIdentity} utility bill no. ${Questions.utilityBillLength}?",
                "Services ${Questions.utilityBillLength}",
                [
                  "Cleaning / pest control",
                  "Gardening",
                  "Facility manager",
                  "Maintenance / repair",
                  "Chimney sweeper",
                  "Winter service",
                  "Other services",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No services",
                "STATEMENT ${Questions.utilityBillLength}");
          } else if (widget.CheckAnswer[0] == "Yes") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?');
            _insert(
                'receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.)?',
                'Yes',
                'OK');
            //Question No 179

            return homecalculationContainer("""
<p><strong>Utilities and operating costs</strong></p>
<p>Please enter the amount of utilities and operating costs you had. Add up all of the amounts and enter the total.</p>
<p>Check your last annual utilities statement for these deductible costs:</p>
<ul>
<li>gardening</li>
<li>cleaning</li>
<li>caretaker duties</li>
<li>chimney cleaning</li>
<li>maintenance of elevator</li>
</ul>
<p>These works are contracted by the landlord but paid for by you and the other tenants. You can deduct the labor costs. Material costs are not deductible.</p>
<p>Here it can be stated how much was paid by you in total according to the certificate issued by the landlord for the so-called household services and craftsman services, as far as they relate to your flat.</p>
<p>Therefore, pay attention to the proportion that is attributable to your flat. This is mostly listed in the far right column under "Your share".</p>
<p>Although the work was commissioned by the landlord, it was paid for by the tenants and is therefore deductible for you.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "What was the bill amount for services or craftsmen on ${Questions.homeYourIdentity} utilities statement (excluding heating, electricity, insurances etc.)?",
                "Amount for ${Questions.utilityBillLength}",
                430.0,
                "calculation",
                "STATEMENT ${Questions.utilityBillLength}");
          }
        }
      }

      //Answer No 179
      else if (widget.CheckCompleteQuestion ==
              "What was the bill amount for services or craftsmen on ${Questions.homeYourIdentity} utilities statement (excluding heating, electricity, insurances etc.)?" &&
          (widget.CheckQuestion == "Amount utilities" ||
              widget.CheckQuestion ==
                  "Amount for ${Questions.utilityBillLength - 1}")) {
        //Single Option
        if (widget.CheckQuestion == "Amount utilities") {
          //Question No 9
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 8

      else if ((widget.CheckCompleteQuestion ==
                  "Which of the following services are included in ${Questions.homeYourIdentity} utility bill?" ||
              widget.CheckCompleteQuestion ==
                  "Which of the following services are included in ${Questions.homeYourIdentity} utility bill no. ${Questions.utilityBillLength}?") &&
          (widget.CheckQuestion == "Services" ||
              widget.CheckQuestion ==
                  "Services ${Questions.utilityBillLength}")) {
        //For Single
        //Answer No 8
        if (widget.CheckCompleteQuestion ==
            "Which of the following services are included in ${Questions.homeYourIdentity} utility bill?") {
          for (int m = 0; m < widget.CheckAnswer.length; m++) {
            if (widget.CheckAnswer[m] == "Cleaning / pest control") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'Cleaning / pest control',
                  'OK');
              //Question No 10
              return homecalculationContainer("""
<p><strong>Share cleaning/pest control</strong></p>
<p>Here you can state the amount that was paid for cleaning and/or pest control according to the utilities statement which relates to your flat. In case the statement includes several positions for cleaning or pest control you need to sum up these positions and enter the sum.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for cleaning / pest control relating to ${Questions.homeYourIdentity} flat?",
                  "Share cleaning/pest control",
                  430.0,
                  "calculation",
                  "");
            } else if (widget.CheckAnswer[m] == "Gardening") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'Gardening',
                  'OK');
              //Question No 11
              return homecalculationContainer("""
<p><strong>Share gardening</strong></p>
<p>Here you can state the amount that was paid for gardening according to the utilities statement which relates to your flat. In case the statement includes several positions for gardening you need to sum up these positions and enter the sum.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for gardening relating to ${Questions.homeYourIdentity} flat?",
                  "Share gardening",
                  430.0,
                  "calculation",
                  "");
            } else if (widget.CheckAnswer[m] == "Facility manager") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'Facility manager',
                  'OK');
              //Question No 12
              return homecalculationContainer("""
<p><strong>Share janitorial services</strong></p>
<p>Here you can state the amount that was paid for janitorial services according to the utilities statement which relates to your flat. In case the statement includes several positions for janitorial services you need to sum up these positions and enter the sum.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for janitorial services relating to ${Questions.homeYourIdentity} flat?",
                  "Share janitorial service",
                  430.0,
                  "calculation",
                  "");
            } else if (widget.CheckAnswer[m] == "Maintenance / repair") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'Maintenance / repair',
                  'OK');
              //Question No 13
              return homecalculationContainer("""
<p><strong>Share maintenance/repair</strong></p>
<p>Here you can state the amount that was paid for maintenance/repair according to the utilities statement which relates to your flat. In case the statement includes several positions for maintenance/repair you need to sum up these positions and enter the sum.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for maintenance / repair relating to ${Questions.homeYourIdentity} flat?",
                  "Share maintenance/repair",
                  430.0,
                  "calculation",
                  "");
            } else if (widget.CheckAnswer[m] == "Chimney sweeper") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'Chimney sweeper',
                  'OK');
              //Question No 14
              return homecalculationContainer("""
<p><strong>Share chimney sweeper</strong></p>
<p>Here you can state the amount that was paid for the chimney sweeper according to the utilities statement which relates to your flat. In case the statement includes several positions for chimney sweepers you need to sum up these positions and enter the sum.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for chimney sweeper relating to ${Questions.homeYourIdentity} flat?",
                  "Share chimney sweeper",
                  430.0,
                  "calculation",
                  "");
            } else if (widget.CheckAnswer[m] == "Winter service") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'Winter service',
                  'OK');
              //Question No 15
              return homecalculationContainer("""
<p><strong>Share winter services</strong></p>
<p>Here you can state the amount that was paid for winter services according to the utilities statement which relates to your flat. In case the statement includes several positions for winter services you need to sum up these positions and enter the sum.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for winter services relating to ${Questions.homeYourIdentity} flat?",
                  "Share winter services",
                  430.0,
                  "calculation",
                  "");
            } else if (widget.CheckAnswer[m] == "Other services") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'Other services',
                  'OK');
              //Question No 16
              return homecalculationContainer("""
<p><strong>Share other costs</strong></p>
<p>Here you can state the amount that was paid for other services according to the utilities statement which relates to your flat. In case the statement includes several positions for other services you need to sum up these positions and enter the sum.</p>
<p><strong>Important</strong> The following costs can not be included here: heating, electricity, taxes, insurances, material costs, cold/sewage costs.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
""", """
<p><strong>Share other costs</strong></p>
<p>Here you can state the amount that was paid for other services according to the utilities statement which relates to your flat. In case the statement includes several positions for other services you need to sum up these positions and enter the sum.</p>
<p><strong>Important</strong> The following costs can not be included here: heating, electricity, taxes, insurances, material costs, cold/sewage costs.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
""",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for other services from utility bill no. relating to ${Questions.homeYourIdentity} flat (excluding heating, electricity, insurances etc.)?",
                  "Share other services",
                  430.0,
                  "calculation",
                  "");
            } else if (widget.CheckAnswer[m] == "No") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'No services',
                  'OK');
              //Question No 9
              return homemultipleoptionsContainerNo(
                  """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                  "Made use of",
                  [
                    "Cleaning",
                    "Winter service",
                    "Gardening",
                    "Nursing care",
                    "Pet Care",
                    "Craftsmen",
                    "Chimney sweep",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  "");
            } else if (widget.CheckAnswer[m] == "skip") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill?');
              _insert(
                  'Which of the following services are included in you utility bill?',
                  'skip',
                  'skip');
              //Question No 9
              return homemultipleoptionsContainerNo(
                  """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                  "Made use of",
                  [
                    "Cleaning",
                    "Winter service",
                    "Gardening",
                    "Nursing care",
                    "Pet Care",
                    "Craftsmen",
                    "Chimney sweep",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  "");
            }
          }
        }

        //For Multiple
        //Answer No 59
        else if (widget.CheckCompleteQuestion ==
            "Which of the following services are included in ${Questions.homeYourIdentity} utility bill no. ${Questions.utilityBillLength}?") {
          for (int m = 0; m < widget.CheckAnswer.length; m++) {
            if (widget.CheckAnswer[m] == "Cleaning / pest control") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'Cleaning / pest control',
                  'OK');
              //Question No 10
              return homecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for cleaning / pest control from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat?",
                  "Share cleaning/pest control ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "Gardening") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'Gardening',
                  'OK');
              //Question No 11
              return homecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for gardening from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat?",
                  "Share gardening ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "Facility manager") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'Facility manager',
                  'OK');
              //Question No 12
              return homecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for janitorial services from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat?",
                  "Share janitorial service ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "Maintenance / repair") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'Maintenance / repairr',
                  'OK');
              //Question No 13
              return homecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for maintenance / repair from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat?",
                  "Share maintenance/repair ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "Chimney sweeper") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'Chimney sweeper',
                  'OK');
              //Question No 14
              return homecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for chimney sweeper from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat?",
                  "Share chimney sweeper ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "Winter service") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'Winter service',
                  'OK');
              //Question No 15
              return homecalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for winter services from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat?",
                  "Share winter services ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "Other services") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'Other services',
                  'OK');
              //Question No 16
              return homecalculationContainer("""
<p><strong>Share other costs</strong></p>
<p>Here you can state the amount that was paid for other services according to the utilities statement which relates to your flat. In case the statement includes several positions for other services you need to sum up these positions and enter the sum.</p>
<p><strong>Important</strong> The following costs can not be included here: heating, electricity, taxes, insurances, material costs, cold/sewage costs.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for other services from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat (excluding heating, electricity, insurances etc.)?",
                  "Share other services ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "skip") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'skip',
                  'skip');
              //Question No 16
              return homecalculationContainer("""
<p><strong>Share other costs</strong></p>
<p>Here you can state the amount that was paid for other services according to the utilities statement which relates to your flat. In case the statement includes several positions for other services you need to sum up these positions and enter the sum.</p>
<p><strong>Important</strong> The following costs can not be included here: heating, electricity, taxes, insurances, material costs, cold/sewage costs.</p>
<p>Make sure to only state the amount that relates to the flat you lived in. This is shown under "Your share".</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                  "",
                  "Household services",
                  "How much is ${Questions.homeYourIdentity} share for other services from utility bill no. ${Questions.utilityBillLength} relating to ${Questions.homeYourIdentity} flat (excluding heating, electricity, insurances etc.)?",
                  "Share other services ${Questions.utilityBillLength}",
                  430.0,
                  "calculation",
                  "STATEMENT ${Questions.utilityBillLength}");
            } else if (widget.CheckAnswer[m] == "No") {
              DbHelper.insatance
                ..deleteWithquestion(
                    'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?');
              _insert(
                  'Which of the following services are included in you utility bill no. ${Questions.utilityBillLength}?',
                  'No services',
                  'OK');
              int noServiceQuestion = Questions.utilityBillLength + 1;
              if (noServiceQuestion <= Questions.totalUtilityBill) {
                //Question No 58
                return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                    "",
                    "Household services",
                    "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${noServiceQuestion}?",
                    "Certificate ${noServiceQuestion}",
                    430.0,
                    "",
                    "STATEMENT ${noServiceQuestion}");
              }

              //Single Option
              else {
                //Question No 9
                return homemultipleoptionsContainerNo(
                    """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>""",
                    "",
                    "Household services",
                    "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                    "Made use of",
                    [
                      "Cleaning",
                      "Winter service",
                      "Gardening",
                      "Nursing care",
                      "Pet Care",
                      "Craftsmen",
                      "Chimney sweep",
                      "No"
                    ],
                    [
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png",
                      "images/disabilityoption.png",
                      "images/alimonypaidoption.png",
                      "images/survivorspension.png",
                      "images/check.png"
                    ],
                    220.0,
                    "No",
                    "");
              }
            }
          }
        }
      }

      // ========= Services Utility Bill Start ============ //

      //Answer No 10
      else if ((widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for cleaning / pest control relating to ${Questions.homeYourIdentity} flat?" ||
              widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for cleaning / pest control from utility bill no. ${Questions.utilityBillLength - 1} relating to ${Questions.homeYourIdentity} flat?") &&
          (widget.CheckQuestion == "Share cleaning/pest control" ||
              widget.CheckQuestion ==
                  "Share cleaning/pest control ${Questions.utilityBillLength - 1}")) {
        //Question No 9
        //Single Option
        if (widget.CheckCompleteQuestion ==
            "How much is ${Questions.homeYourIdentity} share for cleaning / pest control relating to ${Questions.homeYourIdentity} flat?") {
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 11
      else if ((widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for gardening relating to ${Questions.homeYourIdentity} flat?" ||
              widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for gardening from utility bill no. ${Questions.utilityBillLength - 1} relating to ${Questions.homeYourIdentity} flat?") &&
          (widget.CheckQuestion == "Share gardening" ||
              widget.CheckQuestion ==
                  "Share gardening ${Questions.utilityBillLength - 1}")) {
        //Question No 9
        //Single Option
        print("gussa ha");
        if (widget.CheckCompleteQuestion ==
            "How much is ${Questions.homeYourIdentity} share for gardening relating to ${Questions.homeYourIdentity} flat?") {
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 12
      else if ((widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for janitorial services relating to ${Questions.homeYourIdentity} flat?" ||
              widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for janitorial services from utility bill no. ${Questions.utilityBillLength - 1} relating to ${Questions.homeYourIdentity} flat?") &&
          (widget.CheckQuestion == "Share janitorial service" ||
              widget.CheckQuestion ==
                  "Share janitorial service ${Questions.utilityBillLength - 1}")) {
        //Question No 9
        //Single Option
        print("gussa ha");
        if (widget.CheckCompleteQuestion ==
            "How much is ${Questions.homeYourIdentity} share for janitorial services relating to ${Questions.homeYourIdentity} flat?") {
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 13
      else if ((widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for maintenance / repair relating to ${Questions.homeYourIdentity} flat?" ||
              widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for maintenance / repair from utility bill no. ${Questions.utilityBillLength - 1} relating to ${Questions.homeYourIdentity} flat?") &&
          (widget.CheckQuestion == "Share maintenance/repair" ||
              widget.CheckQuestion ==
                  "Share maintenance/repair ${Questions.utilityBillLength - 1}")) {
        //Question No 9
        //Single Option
        print("gussa ha");
        if (widget.CheckCompleteQuestion ==
            "How much is ${Questions.homeYourIdentity} share for maintenance / repair relating to ${Questions.homeYourIdentity} flat?") {
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 14
      else if ((widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for chimney sweeper relating to ${Questions.homeYourIdentity} flat?" ||
              widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for chimney sweeper from utility bill no. ${Questions.utilityBillLength - 1} relating to ${Questions.homeYourIdentity} flat?") &&
          (widget.CheckQuestion == "Share chimney sweeper" ||
              widget.CheckQuestion ==
                  "Share chimney sweeper ${Questions.utilityBillLength - 1}")) {
        //Question No 9
        //Single Option
        print("gussa ha");
        if (widget.CheckCompleteQuestion ==
            "How much is ${Questions.homeYourIdentity} share for chimney sweeper relating to ${Questions.homeYourIdentity} flat?") {
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 15
      else if ((widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for winter services relating to ${Questions.homeYourIdentity} flat?" ||
              widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for winter services from utility bill no. ${Questions.utilityBillLength - 1} relating to ${Questions.homeYourIdentity} flat?") &&
          (widget.CheckQuestion == "Share winter services" ||
              widget.CheckQuestion ==
                  "Share winter services ${Questions.utilityBillLength - 1}")) {
        //Question No 9
        //Single Option
        print("gussa ha");
        if (widget.CheckCompleteQuestion ==
            "How much is ${Questions.homeYourIdentity} share for winter services relating to ${Questions.homeYourIdentity} flat?") {
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 16
      else if ((widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for other services from utility bill no. relating to ${Questions.homeYourIdentity} flat (excluding heating, electricity, insurances etc.)?" ||
              widget.CheckCompleteQuestion ==
                  "How much is ${Questions.homeYourIdentity} share for other services from utility bill no. ${Questions.utilityBillLength - 1} relating to ${Questions.homeYourIdentity} flat (excluding heating, electricity, insurances etc.)?") &&
          (widget.CheckQuestion == "Share other services" ||
              widget.CheckQuestion ==
                  "Share other services ${Questions.utilityBillLength - 1}")) {
        //Question No 9
        //Single Option
        print("gussa ha");
        if (widget.CheckCompleteQuestion ==
            "How much is ${Questions.homeYourIdentity} share for other services from utility bill no. relating to ${Questions.homeYourIdentity} flat (excluding heating, electricity, insurances etc.)?") {
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.utilityBillLength <= Questions.totalUtilityBill) {
            //Question No 58
            return homeyesnoContainer("""
<p><strong>Certificate of household services and/or craftsman services</strong></p>
<p>Indicate here whether a separate certificate has been issued by the landlord for so-called household-related services or craftsman services.</p>
<p>These costs are included in the service charge statement. However, only certain types of costs can be deducted. Often material costs and wages are also not separately registered on the operating cost account. For this reason one has requirement on a free certificate after ? 35a EStG. Therefore the landlord should be asked to issue a separate list to the developed costs, so that these can be seized correctly in the tax return.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} receive a separate certificate that only includes the sum for household services and/or craftsman services according to §35a EStG(excluding heating, electricity, insurances etc.) for utility bill no. ${Questions.utilityBillLength}?",
                "Certificate ${Questions.utilityBillLength}",
                430.0,
                "",
                "STATEMENT ${Questions.utilityBillLength}");
          }

          //Single Option
          else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      // ========= Services Utility Bill End ============ //

      //Answer No 17
      else if (widget.CheckCompleteQuestion ==
              "Would ${Questions.homeYouIdentity} like to enter more than one 'WEG' statement?" &&
          widget.CheckQuestion == "More than one") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Would you like to enter more than one \'WEG\' statement?');
          _insert('Would you like to enter more than one \'WEG\' statement?',
              'No', 'OK');
          //Question No 18
          return homecalculationContainer("""
<p><strong>Amount of annual cost statement from owners' association</strong></p>
<p>Please enter the amount you paid according to the annual cost statement for the owners' association ('Wohnungseigent&uuml;mergemeinschaft-Abrechnung' or 'WEG-Abrechnung') in 2019.</p>
<p>Check your statement for these deductible costs:</p>
<ul>
<li>gardening</li>
<li>cleaning</li>
<li>caretaker duties</li>
<li>chimney cleaning</li>
<li>maintenance of elevator</li>
</ul>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown.</p>
<p>&nbsp;</p>

""",
              "",
              "Household services",
              "How much was invoiced for utility services on ${Questions.homeYourIdentity} 'WEG' bill?",
              "Amount",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Would you like to enter more than one \'WEG\' statement?');
          _insert('Would you like to enter more than one \'WEG\' statement?',
              'skip', 'skip');
          //Question No 18
          return homecalculationContainer("""
<p><strong>Amount of annual cost statement from owners' association</strong></p>
<p>Please enter the amount you paid according to the annual cost statement for the owners' association ('Wohnungseigent&uuml;mergemeinschaft-Abrechnung' or 'WEG-Abrechnung') in 2019.</p>
<p>Check your statement for these deductible costs:</p>
<ul>
<li>gardening</li>
<li>cleaning</li>
<li>caretaker duties</li>
<li>chimney cleaning</li>
<li>maintenance of elevator</li>
</ul>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown.</p>
<p>&nbsp;</p>

""",
              "",
              "Household services",
              "How much was invoiced for utility services on ${Questions.homeYourIdentity} 'WEG' bill?",
              "Amount",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Would you like to enter more than one \'WEG\' statement?');
          _insert('Would you like to enter more than one \'WEG\' statement?',
              'Yes', 'OK');
          //Question No 19
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How many 'WEG' statements would ${Questions.homeYouIdentity} like to enter?",
              "Number of 'WEG' statements",
              220.0,
              "calculation",
              "");
        }
      }

      //Answer No 19
      else if (widget.CheckCompleteQuestion ==
              "How many 'WEG' statements would ${Questions.homeYouIdentity} like to enter?" &&
          widget.CheckQuestion == "Number of 'WEG' statements") {
        //Question No 18
        return homecalculationContainer("""
<p><strong>Amount of annual cost statement from owners' association</strong></p>
<p>Please enter the amount you paid according to the annual cost statement for the owners' association ('Wohnungseigent&uuml;mergemeinschaft-Abrechnung' or 'WEG-Abrechnung') in 2019.</p>
<p>Check your statement for these deductible costs:</p>
<ul>
<li>gardening</li>
<li>cleaning</li>
<li>caretaker duties</li>
<li>chimney cleaning</li>
<li>maintenance of elevator</li>
</ul>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Household services",
            "How much was invoiced for utility services on ${Questions.homeYourIdentity} 'WEG' bill?",
            "'WEG' ${Questions.WEGLength}",
            220.0,
            "calculation",
            "WEG BILL ${Questions.WEGLength}");
      }

      //Answer No 18

      else if (widget.CheckCompleteQuestion ==
              "How much was invoiced for utility services on ${Questions.homeYourIdentity} 'WEG' bill?" &&
          (widget.CheckQuestion == "Amount" ||
              widget.CheckQuestion == "'WEG' ${Questions.WEGLength - 1}")) {
        //Single Option
        if (widget.CheckQuestion == "Amount") {
          //Question No 9
          return homemultipleoptionsContainerNo(
              """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
              "Made use of",
              [
                "Cleaning",
                "Winter service",
                "Gardening",
                "Nursing care",
                "Pet Care",
                "Craftsmen",
                "Chimney sweep",
                "No"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              "");
        }

        //Multiple Option
        else {
          if (Questions.WEGLength <= Questions.totalWEG) {
            //Question No 18
            return homecalculationContainer("""
<p><strong>Amount of annual cost statement from owners' association</strong></p>
<p>Please enter the amount you paid according to the annual cost statement for the owners' association ('Wohnungseigent&uuml;mergemeinschaft-Abrechnung' or 'WEG-Abrechnung') in 2019.</p>
<p>Check your statement for these deductible costs:</p>
<ul>
<li>gardening</li>
<li>cleaning</li>
<li>caretaker duties</li>
<li>chimney cleaning</li>
<li>maintenance of elevator</li>
</ul>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "How much was invoiced for utility services on ${Questions.homeYourIdentity} 'WEG' bill?",
                "'WEG' ${Questions.WEGLength}",
                220.0,
                "calculation",
                "WEG BILL ${Questions.WEGLength}");
          } else {
            //Question No 9
            return homemultipleoptionsContainerNo(
                """
<p><strong>Household services and craftsmen</strong></p>
<p>Please indicate here which of the listed household services you ordered in the year 2019. This normally applies with a home of one's own (e.g. chimney sweeper, gardener etc.). If you live in a rented flat and, in addition to the services from the utility bill, you independently ordered services (e.g. cleaner), these can be specified here. You can select several answers.</p>
<p>Please note:</p>
<ul>
<li>You cannot deduct payments made in cash.</li>
<li>You need an invoice and have to pay by bank transfer.</li>
<li>You can only deduct costs that you paid <strong>in 2019</strong>.</li>
<li>The date of payment is what counts, not the date of invoicing.</li>
</ul>
<p><strong>SERVICES</strong></p>
<p>If you hired a <strong>company or a self-employed person</strong> for work that would normally be done by members of your household, you can enter the costs here. The same applies to work completed by craftsmen in your apartment or your house.</p>
<p>A list of tax-exempt and non-exempt household and craft services can be found [in this document] (https://taxfix.de/wp-content/uploads/2017/05/beispiele_haushaltsnah_handwerker.pdf)</p>
<p><strong>ONLY LABOR COSTS</strong></p>
<p>Labor and material costs must be shown separately on the invoice, because only the labor and travel costs are tax deductible. The material costs are not deductible.</p>
<p><strong>HOUSEHOLD SERVICES</strong></p>
<p><strong>CLEANING</strong></p>
<p>These include e.g. the cleaning of the apartment, the windows and also carpet cleaning.</p>
<p><strong>WINTER SERVICE</strong></p>
<p>The winter service takes over the clearing and spreading gravel on the roads. You can deduct the costs for this.</p>
<p><strong>GARDENING</strong></p>
<p>Gardening includes tree care, cutting hedges and mowing lawns within your property.</p>
<p><strong>NURSING BENEFITS</strong></p>
<p>This includes care and support services. For example, if you pay a carer, because you need their help.</p>
<p><strong>PET CARE</strong></p>
<p>Deductible expenses include animal liability insurance, the hairdresser (if they cut the hair in your household) as well as the care costs (feeding, grooming, cleaning, running and playing).</p>
<p><strong>CRAFTSMEN</strong></p>
<p>You can deduct many craftsmanship services. These include, for example:</p>
<ul>
<li>Drainpipe cleaning</li>
<li>Sanitation</li>
<li>Gutter cleaning</li>
<li>Legionella inspection</li>
<li>Water damage restoration</li>
</ul>
<p><strong>CHIMNEY SWEEPER</strong></p>
<p>All services of the chimney sweep are deductible in full. These include e.g. sweeping, repairs, maintenance and measurement / verification work.</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?",
                "Made use of",
                [
                  "Cleaning",
                  "Winter service",
                  "Gardening",
                  "Nursing care",
                  "Pet Care",
                  "Craftsmen",
                  "Chimney sweep",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                "");
          }
        }
      }

      //Answer No 9
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} order any of the following work or services for ${Questions.homeYourIdentity} household?" &&
          widget.CheckQuestion == "Made use of") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Cleaning") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'Cleaning',
                'OK');
            //Question No 21

            return homemultitwooptionContainer(
                """
<p><strong>Completion of services</strong></p>
<p>Please select who you contracted to complete services in 2019. Both answers are possible.</p>
<p><strong>Select "service provider"</strong> if you contracted an independent service provider or agency.</p>
<p><strong>Select "employee"</strong> if the service was carried out by someone registered for social insurance and employed by you. Also select this option if you employed household help in the form or marginal employment (mini job). In this case you will receive a written statement from the mini job office. If the employee relationship is does not confirm with these standards and you pay the household help on a different basis, the costs are not deductible.</p>
<p><strong>REQUIREMENTS:</strong></p>
<ul>
<li>Cash payments are not deductible.</li>
<li>Only payments made in 2019 are deductible.</li>
<li>Based on time invoice was paid.</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "Who provided the cleaning service?",
                "Provided by",
                ["Service company", "Employee"],
                ["images/disabilityoption.png", "images/alimonypaidoption.png"],
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Winter service") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'Winter service',
                'OK');
            //Question No 26
            return homemultitwooptionContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Household services",
                "Who provided the winter service?",
                "Provided by",
                ["Service company", "Employee"],
                ["images/disabilityoption.png", "images/alimonypaidoption.png"],
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Gardening") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'Gardening',
                'OK');
            //Question No 30
            return homemultitwooptionContainer(
                """
<p><strong>Gardening provider</strong></p>
<p>Please select who you contracted to complete gardening services in 2019. It's possible to select both answers.</p>
<p><strong>Select "service company"</strong> if you contracted an independent service provider or agency.</p>
<p><strong>Select "employee"</strong> if the service was carried out by someone registered for social insurance and employed by you. Also select this option if you employed household help in the form or marginal employment (mini job). In this case you will receive a written statement from the mini job office. If the employee relationship is does not confirm with these standards and you pay the household help on a different basis, the costs are not deductible.</p>
<p><strong>REQUIREMENTS:</strong></p>
<ul>
<li>Cash payments are not deductible.</li>
<li>Only payments made in 2019 are deductible.</li>
<li>Based on time invoice was paid.</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "Who provided ${Questions.homeYouIdentity} with the gardening service?",
                "Provider",
                ["Service company", "Employee"],
                ["images/disabilityoption.png", "images/alimonypaidoption.png"],
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Nursing care") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'Gardening',
                'OK');
            //Question No 34
            return homecalculationContainer("""
<p><strong>Care costs</strong></p>
<p>Please enter the total spent on care costs in 2019.</p>
<p>A person in need of care can be one of the following:</p>
<ul>
<li>yourself</li>
<li>a member of your household</li>
<li>someone outside your household (e.g. mother or father)</li>
<li>The care must have taken place in the household of either the person in need or of the carer.*</li>
</ul>
<p>Costs that are directly related to care are deductible:</p>
<ul>
<li>personal hygiene</li>
<li>nutrition</li>
<li>mobility</li>
<li>care</li>
</ul>
<p><strong>IN NEED OF CARE</strong></p>
<p>A proof of being in need of care is not necessary. If, however, a person is designated as being in need of care, then you have to deduct the amount paid by the health insurer.</p>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "How much did ${Questions.homeYouIdentity} spend on nursing care?",
                "Household help nursing care",
                220.0,
                "calculation",
                "");
          } else if (widget.CheckAnswer[m] == "Pet Care") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'Pet Care',
                'OK');
            //Question No 35
            return homemultitwooptionContainer(
                """
<p><strong>Completion of services</strong></p>
<p>Please select who you contracted to complete services in 2019. Both answers are possible.</p>
<p><strong>Select "service provider"</strong> if you contracted an independent service provider or agency.</p>
<p><strong>Select "employee"</strong> if the service was carried out by someone registered for social insurance and employed by you. Also select this option if you employed household help in the form or marginal employment (mini job). In this case you will receive a written statement from the mini job office. If the employee relationship is does not confirm with these standards and you pay the household help on a different basis, the costs are not deductible.</p>
<p><strong>REQUIREMENTS:</strong></p>
<ul>
<li>Cash payments are not deductible.</li>
<li>Only payments made in 2019 are deductible.</li>
<li>Based on time invoice was paid.</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "Who provided the pet care service?",
                "Provided by",
                ["Service company", "Employee"],
                ["images/disabilityoption.png", "images/alimonypaidoption.png"],
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Craftsmen") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'Craftsmen',
                'OK');
            //Question No 39
            //For No 430.0
            //For Yes 220.0
            return homeyesnoContainer("""
<p><strong>Several building / trade services</strong></p>
<p>Please state whether you had costs for several building and service contracts in <strong>2019</strong></p>
<p>You can use the number of invoices you have paid as orientation.</p>
<p><em>Later, we will ask you to choose between different construction services.</em></p>
<p>Please note:</p>
<ul>
<li>Cash payments are not deductible</li>
<li>You need and invoice and to have paid by bank transfer</li>
<li>Only costs that have been paid in 2019 are deductible.</li>
<li>The date of payment is important, not the date of the invoice.</li>
<li>Costs for renovation, repair and home improvement are deductible</li>
<li>Contract must not have been carried out by a registered construction company.</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "Would ${Questions.homeYouIdentity} like to enter several craftsmen services?",
                "More than one",
                430.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Chimney sweep") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'Chimney sweep',
                'OK');
            //Question No 43
            return homecalculationContainer("""
<p><strong>Chimney sweeping</strong></p>
<p>Please enter the total amount spent on chimney cleaning in 2019.</p>
<p>Chimney cleaning costs are completely tax deductible. Dividing the invoice into sweeping, cleaning, measuring and inspection is no longer necessary.</p>
<p><strong>YOUR TAXES</strong></p>
<p>If the tax office still insists on dividing the bill you can object to this and refer to a decision from the federal finance court (06.11.2014, case number.: VI R 1/13). This states that the inspection of the functionality of a system (such as a chimney) also belongs to the tax exempt trade services.</p>

""",
                "",
                "Household services",
                "How much did ${Questions.homeYouIdentity} spend on the chimney sweep?",
                "Costs chimney sweep",
                220.0,
                "calculation",
                "");
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'No',
                'OK');
            // For partner we have to add You
            if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
              qu.HomeAddAnswer("You", "", "", "", [], 60.0);
            }

            //Question No 98
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Did you order any of the following work or services for you household?');
            _insert(
                'Did you order any of the following work or services for you household?',
                'skip',
                'skip');
            qu.HomeAddAnswer("You", "", "", "", [], 60.0);
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          }
        }
      }

      //Answer No 21

      else if (widget.CheckCompleteQuestion ==
              "Who provided the cleaning service?" &&
          widget.CheckQuestion == "Provided by") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Service company") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the cleaning service?');
            _insert(
                'Who provided the cleaning service?', 'Service company', 'OK');
            //Question No 22
            return homecalculationContainer("""
<p><strong>Cleaning costs</strong></p>
<p>Please enter the total amount you spent on cleaning costs in 2019.</p>
<p>You can write off cleaning costs as household services. Enter the total amount for 2019. These costs include the following:</p>
<ul>
<li>Cleaning of home</li>
<li>Cleaning carpets or similar</li>
<li>Costs of window cleaning</li>
<li>Cleaning of staircases and other common areas</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>

""", "", "Household services", "How much was the cleaning?",
                "Costs cleaning company", 220.0, "calculation", "");
          } else if (widget.CheckAnswer[m] == "Employee") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the cleaning service?');
            _insert('Who provided the cleaning service?', 'Employee', 'OK');
            //Question No 23
            return homeyesnoContainer("""
<p><strong>Mini job</strong></p>
<p>Please state whether hired the household help in the form of marginal employment (mini job).</p>
<p>If you did employ household help in the form of a mini job, this job must be registered with the mini job office.</p>
<p>At the end of the year, 'Deutsche Rentenversicherung Knappschaft - Bahn - See (KBS)' (German pension for marginal employment) will send you a certificate which need as proof of your costs.</p>
<p>'KBS' is a network of statutory pension, supplementary pension, health and nursing care insurance, and has its own medical network. It offers comprehensive medical and social security to its members.</p>
<p>All marginal employment is managed through the mini job office under the umbrella of KBS.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "Were the cleaning services provided as part of a marginal employment (mini-job)?",
                "Cleaning: mini job",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "Employee") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the cleaning service?');
            _insert('Who provided the cleaning service?', 'Employee', 'OK');
            //Question No 23
            return homeyesnoContainer("""
<p><strong>Mini job</strong></p>
<p>Please state whether hired the household help in the form of marginal employment (mini job).</p>
<p>If you did employ household help in the form of a mini job, this job must be registered with the mini job office.</p>
<p>At the end of the year, 'Deutsche Rentenversicherung Knappschaft - Bahn - See (KBS)' (German pension for marginal employment) will send you a certificate which need as proof of your costs.</p>
<p>'KBS' is a network of statutory pension, supplementary pension, health and nursing care insurance, and has its own medical network. It offers comprehensive medical and social security to its members.</p>
<p>All marginal employment is managed through the mini job office under the umbrella of KBS.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "Were the cleaning services provided as part of a marginal employment (mini-job)?",
                "Cleaning: mini job",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the cleaning service?');
            _insert('Who provided the cleaning service?', 'skip', 'skip');
            //Question No 23
            return homeyesnoContainer("""
<p><strong>Mini job</strong></p>
<p>Please state whether hired the household help in the form of marginal employment (mini job).</p>
<p>If you did employ household help in the form of a mini job, this job must be registered with the mini job office.</p>
<p>At the end of the year, 'Deutsche Rentenversicherung Knappschaft - Bahn - See (KBS)' (German pension for marginal employment) will send you a certificate which need as proof of your costs.</p>
<p>'KBS' is a network of statutory pension, supplementary pension, health and nursing care insurance, and has its own medical network. It offers comprehensive medical and social security to its members.</p>
<p>All marginal employment is managed through the mini job office under the umbrella of KBS.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Household services",
                "Were the cleaning services provided as part of a marginal employment (mini-job)?",
                "Cleaning: mini job",
                220.0,
                "",
                "");
          }
        }
      }

      //Answer No 22
      else if (widget.CheckCompleteQuestion == "How much was the cleaning?" &&
          widget.CheckQuestion == "Costs cleaning company") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 23
      else if (widget.CheckCompleteQuestion ==
              "Were the cleaning services provided as part of a marginal employment (mini-job)?" &&
          widget.CheckQuestion == "Cleaning: mini job") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Were the cleaning services provided as part of a marginal employment (mini-job)?');
          _insert(
              'Were the cleaning services provided as part of a marginal employment (mini-job)?',
              'No',
              'OK');
          //Question 24
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the household help for the cleaning service?",
              "Household help cleaning",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Were the cleaning services provided as part of a marginal employment (mini-job)?');
          _insert(
              'Were the cleaning services provided as part of a marginal employment (mini-job)?',
              'skip',
              'skip');
          //Question 24
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the household help for the cleaning service?",
              "Household help cleaning",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Were the cleaning services provided as part of a marginal employment (mini-job)?');
          _insert(
              'Were the cleaning services provided as part of a marginal employment (mini-job)?',
              'Yes',
              'OK');
          //Question No 25
          return homecalculationContainer("""
<p><strong>Cleaning costs: employed cleaning services</strong></p>
<p>Please enter the total amount you spent on cleaning services in 2019, specifically when you had a employment relationship with with the cleaner.</p>
<p>You can write off cleaning service costs as household services. Enter the total amount.</p>
<p>These costs include for the cleaning of the:</p>
<ul>
<li>Home</li>
<li>Carpets or similar</li>
<li>Window</li>
<li>Staircases and other common areas</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} spend on (employed) cleaning services?",
              "Cleaning services (employed)",
              220.0,
              "calculation",
              "");
        }
      }

      //Answer No 24
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} pay the household help for the cleaning service?" &&
          widget.CheckQuestion == "Household help cleaning") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 25
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on (employed) cleaning services?" &&
          widget.CheckQuestion == "Cleaning services (employed)") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 26

      else if (widget.CheckCompleteQuestion ==
              "Who provided the winter service?" &&
          widget.CheckQuestion == "Provided by") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Service company") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the winter service?');
            _insert(
                'Who provided the winter service?', 'Service company', 'OK');
            //Question No 27
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Household services",
                "How much was the winter service?",
                "Amount table",
                220.0,
                "calculation",
                "");
          } else if (widget.CheckAnswer[m] == "Employee") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the winter service?');
            _insert('Who provided the winter service?', 'Employee', 'OK');
            //Question No 28
            return homeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Household services",
                "Were the winter service provided as part of marginal employment (mini-job)?",
                "Winter service: Mini job",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the winter service?');
            _insert('Who provided the winter service?', 'skip', 'OK');
            //Question No 28
            return homeyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Household services",
                "Were the winter service provided as part of marginal employment (mini-job)?",
                "Winter service: Mini job",
                220.0,
                "",
                "");
          }
        }
      }

      //Answer No 27
      else if (widget.CheckCompleteQuestion ==
              "How much was the winter service?" &&
          widget.CheckQuestion == "Amount table") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 28
      else if (widget.CheckCompleteQuestion ==
              "Were the winter service provided as part of marginal employment (mini-job)?" &&
          widget.CheckQuestion == "Winter service: Mini job") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion('Who provided the winter service?');
          _insert('Who provided the winter service?', 'No', 'OK');
          //Question No 29
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who provided the service?",
              "Amount",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion('Who provided the winter service?');
          _insert('Who provided the winter service?', 'skip', 'skip');
          //Question No 29
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who provided the service?",
              "Amount",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion('Who provided the winter service?');
          _insert('Who provided the winter service?', 'Yes', 'OK');
          //Question No 29
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who provided the service?",
              "Amount",
              220.0,
              "calculation",
              "");
        }
      }

      //Answer No 29
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} pay the person who provided the service?" &&
          (widget.CheckQuestion == "Amount" ||
              widget.CheckQuestion == "Household help winter service" ||
              widget.CheckQuestion == "skip")) {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

//Answer No 30
      else if (widget.CheckCompleteQuestion ==
              "Who provided ${Questions.homeYouIdentity} with the gardening service?" &&
          widget.CheckQuestion == "Provider") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Service company") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Who provided ${Questions.homeYouIdentity} with the gardening service?');
            _insert(
                'Who provided ${Questions.homeYouIdentity} with the gardening service?',
                'Service company',
                'OK');
            //Question No 31
            return homecalculationContainer("""
<p><strong>Gardening</strong></p>
<p>Please enter the total amount you spent on gardening in 2019.</p>
<p>Deductible costs include the following:</p>
<ul>
<li>mowing lawn</li>
<li>trimming hedges</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
""", "", "Household services", "How much was the gardening?",
                "Gardening company", 220.0, "calculation", "");
          } else if (widget.CheckAnswer[m] == "Employee") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Who provided ${Questions.homeYouIdentity} with the gardening service?');
            _insert(
                'Who provided ${Questions.homeYouIdentity} with the gardening service?',
                'Employee',
                'OK');
            //Question No 32
            return homeyesnoContainer("""
<p><strong>Mini job</strong></p>
<p>Please state whether hired the household help for gardening in the form of marginal employment (mini job).</p>
<p>If you did employ household help in the form of a mini job, this job must be registered with the mini job office.</p>
<p>At the end of the year, 'Deutsche Rentenversicherung Knappschaft - Bahn - See (KBS)' (German pension for marginal employment) will send you a certificate which need as proof of your costs.</p>
<p>'KBS' is a network of statutory pension, supplementary pension, health and nursing care insurance, and has its own medical network. It offers comprehensive medical and social security to its members.</p>
<p>All marginal employment is managed through the mini job office under the umbrella of KBS.</p>
""",
                "",
                "Household services",
                "Was the gardening provided as part of marginal employment (mini-job)?",
                "Gardening: mini job",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'Who provided ${Questions.homeYouIdentity} with the gardening service?');
            _insert(
                'Who provided ${Questions.homeYouIdentity} with the gardening service?',
                'skip',
                'skip');
            //Question No 32
            return homeyesnoContainer("""
<p><strong>Mini job</strong></p>
<p>Please state whether hired the household help for gardening in the form of marginal employment (mini job).</p>
<p>If you did employ household help in the form of a mini job, this job must be registered with the mini job office.</p>
<p>At the end of the year, 'Deutsche Rentenversicherung Knappschaft - Bahn - See (KBS)' (German pension for marginal employment) will send you a certificate which need as proof of your costs.</p>
<p>'KBS' is a network of statutory pension, supplementary pension, health and nursing care insurance, and has its own medical network. It offers comprehensive medical and social security to its members.</p>
<p>All marginal employment is managed through the mini job office under the umbrella of KBS.</p>
""",
                "",
                "Household services",
                "Was the gardening provided as part of marginal employment (mini-job)?",
                "Gardening: mini job",
                220.0,
                "",
                "");
          }
        }
      }

      //Answer No 31
      else if (widget.CheckCompleteQuestion == "How much was the gardening?" &&
          widget.CheckQuestion == "Gardening company") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 32
      else if (widget.CheckCompleteQuestion ==
              "Was the gardening provided as part of marginal employment (mini-job)?" &&
          widget.CheckQuestion == "Gardening: mini job") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Who provided ${Questions.homeYouIdentity} with the gardening service?');
          _insert(
              'Who provided ${Questions.homeYouIdentity} with the gardening service?',
              'No',
              'OK');
          //Question No 33
          return homecalculationContainer("""
<p><strong>Gardening</strong></p>
<p>Please enter the total amount you spent on gardening in 2019.</p>
<p>Deductible costs include the following:</p>
<ul>
<li>mowing lawn</li>
<li>trimming hedges</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who did the gardening?",
              "Household help gardening",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Who provided ${Questions.homeYouIdentity} with the gardening service?');
          _insert(
              'Who provided ${Questions.homeYouIdentity} with the gardening service?',
              'skip',
              'skip');
          //Question No 33
          return homecalculationContainer("""
<p><strong>Gardening</strong></p>
<p>Please enter the total amount you spent on gardening in 2019.</p>
<p>Deductible costs include the following:</p>
<ul>
<li>mowing lawn</li>
<li>trimming hedges</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who did the gardening?",
              "Household help gardening",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          //Question No 33
          return homecalculationContainer("""
<p><strong>Gardening</strong></p>
<p>Please enter the total amount you spent on gardening in 2019.</p>
<p>Deductible costs include the following:</p>
<ul>
<li>mowing lawn</li>
<li>trimming hedges</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who did the gardening?",
              "Amount",
              220.0,
              "calculation",
              "");
        }
      }

      //Answer No 33
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} pay the person who did the gardening?" &&
          (widget.CheckQuestion == "Household help gardening" ||
              widget.CheckQuestion == "Amount")) {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 34
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on nursing care?" &&
          widget.CheckQuestion == "Household help nursing care") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 35
      else if (widget.CheckCompleteQuestion ==
              "Who provided the pet care service?" &&
          widget.CheckQuestion == "Provided by") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Service company") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the pet care service?');
            _insert(
                'Who provided the pet care service?', 'Service company', 'OK');
            //Question No 36
            return homecalculationContainer("""
<p><strong>Pet care</strong></p>
<p>Please enter the total amount you spent on pet care in 2019.</p>
<p>These costs include the following:</p>
<ul>
<li>pet boarding / sitting when on vacation</li>
<li>feeding</li>
<li>walking / entertaining the pet</li>
<li>fur care</li>
<li>pet haircuts when carried out at home</li>
</ul>
<p><strong>NOT DEDUCTIBLE:</strong></p>
<ul>
<li>Veterinary costs</li>
<li>Dog license fee</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs such as for feed are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "How much did ${Questions.homeYouIdentity} pay the service company for the pet care?",
                "Pet care",
                220.0,
                "calculation",
                "");
          } else if (widget.CheckAnswer[m] == "Employee") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the pet care service?');
            _insert('Who provided the pet care service?', 'Employee', 'OK');
            //Question No 37
            return homeyesnoContainer("""
<p><strong>Mini job</strong></p>
<p>Please state whether hired the household help for pet care in the form of marginal employment (mini job).</p>
<p>If you did employ household help in the form of a mini job, this job must be registered with the mini job office.</p>
<p>At the end of the year, 'Deutsche Rentenversicherung Knappschaft - Bahn - See (KBS)' (German pension for marginal employment) will send you a certificate which need as proof of your costs.</p>
<p>'KBS' is a network of statutory pension, supplementary pension, health and nursing care insurance, and has its own medical network. It offers comprehensive medical and social security to its members.</p>
<p>All marginal employment is managed through the mini job office under the umbrella of KBS.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Was the pet care provided as part of a marginal employment(mini-job)?",
                "Petcare: mini job",
                220.0,
                "",
                "");
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion('Who provided the pet care service?');
            _insert('Who provided the pet care service?', 'skip', 'skip');
            //Question No 37
            return homeyesnoContainer("""
<p><strong>Mini job</strong></p>
<p>Please state whether hired the household help for pet care in the form of marginal employment (mini job).</p>
<p>If you did employ household help in the form of a mini job, this job must be registered with the mini job office.</p>
<p>At the end of the year, 'Deutsche Rentenversicherung Knappschaft - Bahn - See (KBS)' (German pension for marginal employment) will send you a certificate which need as proof of your costs.</p>
<p>'KBS' is a network of statutory pension, supplementary pension, health and nursing care insurance, and has its own medical network. It offers comprehensive medical and social security to its members.</p>
<p>All marginal employment is managed through the mini job office under the umbrella of KBS.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
                "",
                "Household services",
                "Was the pet care provided as part of a marginal employment(mini-job)?",
                "Petcare: mini job",
                220.0,
                "",
                "");
          }
        }
      }

      //Answer No 36
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} pay the service company for the pet care?" &&
          widget.CheckQuestion == "Pet care") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 37

      else if (widget.CheckCompleteQuestion ==
              "Was the pet care provided as part of a marginal employment(mini-job)?" &&
          widget.CheckQuestion == "Petcare: mini job") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Was the pet care provided as part of a marginal employment(mini-job)?');
          _insert(
              'Was the pet care provided as part of a marginal employment(mini-job)?',
              'No',
              'OK');
          //Question No 38
          return homecalculationContainer("""
<p><strong>Pet care</strong></p>
<p>Please enter the total amount you spent on pet care in 2019.</p>
<p>These costs include the following:</p>
<ul>
<li>pet boarding / sitting when on vacation</li>
<li>feeding</li>
<li>walking / entertaining the pet</li>
<li>fur care</li>
<li>pet haircuts when carried out at home</li>
</ul>
<p><strong>NOT DEDUCTIBLE:</strong></p>
<ul>
<li>Veterinary costs</li>
<li>Dog license fee</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs such as for feed are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who took care of ${Questions.homeYourIdentity} pet?",
              "Amount pet care",
              220.0,
              "calculation",
              "");
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Was the pet care provided as part of a marginal employment(mini-job)?');
          _insert(
              'Was the pet care provided as part of a marginal employment(mini-job)?',
              'skip',
              'skip');
          //Question No 38
          return homecalculationContainer("""
<p><strong>Pet care</strong></p>
<p>Please enter the total amount you spent on pet care in 2019.</p>
<p>These costs include the following:</p>
<ul>
<li>pet boarding / sitting when on vacation</li>
<li>feeding</li>
<li>walking / entertaining the pet</li>
<li>fur care</li>
<li>pet haircuts when carried out at home</li>
</ul>
<p><strong>NOT DEDUCTIBLE:</strong></p>
<ul>
<li>Veterinary costs</li>
<li>Dog license fee</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs such as for feed are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay the person who took care of ${Questions.homeYourIdentity} pet?",
              "Amount pet care",
              220.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Was the pet care provided as part of a marginal employment(mini-job)?');
          _insert(
              'Was the pet care provided as part of a marginal employment(mini-job)?',
              'Yes',
              'OK');
          //Question No 40
          return homecalculationContainer("""
<p><strong>Pet care</strong></p>
<p>Please enter the total amount you spent on pet care in 2019.</p>
<p>These costs include the following:</p>
<ul>
<li>pet boarding / sitting when on vacation</li>
<li>feeding</li>
<li>walking / entertaining the pet</li>
<li>fur care</li>
<li>pet haircuts when carried out at home</li>
</ul>
<p><strong>NOT DEDUCTIBLE:</strong></p>
<ul>
<li>Veterinary costs</li>
<li>Dog license fee</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs such as for feed are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} pay ${Questions.homeYourIdentity} household help for taking care of ${Questions.homeYourIdentity} pet?",
              "Household help pet care",
              220.0,
              "calculation",
              "");
        }
      }

      //Answer No 38
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} pay the person who took care of ${Questions.homeYourIdentity} pet?" &&
          widget.CheckQuestion == "Amount pet care") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 40
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} pay ${Questions.homeYourIdentity} household help for taking care of ${Questions.homeYourIdentity} pet?" &&
          widget.CheckQuestion == "Household help pet care") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 39

      else if (widget.CheckCompleteQuestion ==
              "Would ${Questions.homeYouIdentity} like to enter several craftsmen services?" &&
          widget.CheckQuestion == "More than one") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Would ${Questions.homeYouIdentity} like to enter several craftsmen services?');
          _insert(
              'Would ${Questions.homeYouIdentity} like to enter several craftsmen services?',
              'No',
              'OK');
          //Question 41

          return homesixoptioncontainer(
              """
<p><strong>Building works</strong></p>
<p>Choose the type of work that was carried out.</p>
<p><strong>IMPORTANT!</strong></p>
<p>We will ask about each service that you choose. If several works or services were carried out, you can deduct these in the following section.</p>
<p>The following requirements need to be met for building works:</p>
<ul>
<li>You contracted the work as a private individual</li>
<li>The works took place in your apartment / house / property</li>
<li>Costs for renovation, repair and home improvement are deductible</li>
<li>The invoice must have been paid by bank transfer. Cash payments are not deductible</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Invoice must have been paid for in 2019. Date of invoice is not relevant.</li>
<li>Contract must not have been carried out by a registered construction company</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/14</u></p>
<p><u>&nbsp;</u></p>
<p><u>&nbsp;</u></p>
""",
              "",
              "Household services",
              "What kind of work did the craftsmen do?",
              "Training",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              "");
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Would ${Questions.homeYouIdentity} like to enter several craftsmen services?');
          _insert(
              'Would ${Questions.homeYouIdentity} like to enter several craftsmen services?',
              'skip',
              'skip');
          //Question 41

          return homesixoptioncontainer(
              """
<p><strong>Building works</strong></p>
<p>Choose the type of work that was carried out.</p>
<p><strong>IMPORTANT!</strong></p>
<p>We will ask about each service that you choose. If several works or services were carried out, you can deduct these in the following section.</p>
<p>The following requirements need to be met for building works:</p>
<ul>
<li>You contracted the work as a private individual</li>
<li>The works took place in your apartment / house / property</li>
<li>Costs for renovation, repair and home improvement are deductible</li>
<li>The invoice must have been paid by bank transfer. Cash payments are not deductible</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Invoice must have been paid for in 2019. Date of invoice is not relevant.</li>
<li>Contract must not have been carried out by a registered construction company</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/14</u></p>
<p><u>&nbsp;</u></p>
<p><u>&nbsp;</u></p>
""",
              "",
              "Household services",
              "What kind of work did the craftsmen do?",
              "Training",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Would ${Questions.homeYouIdentity} like to enter several craftsmen services?');
          _insert(
              'Would ${Questions.homeYouIdentity} like to enter several craftsmen services?',
              'Yes',
              'OK');
          //Question No 49
          return homecalculationContainer("""
<p><strong>Several building / trade services</strong></p>
<p>Please state whether you had costs for several building and service contracts in <strong>2019</strong></p>
<p>You can use the number of invoices you have paid as orientation.</p>
<p><em>Later, we will ask you to choose between different construction services.</em></p>
<p>Please note:</p>
<ul>
<li>Cash payments are not deductible</li>
<li>You need and invoice and to have paid by bank transfer</li>
<li>Only costs that have been paid in 2019 are deductible.</li>
<li>The date of payment is important, not the date of the invoice.</li>
<li>Costs for renovation, repair and home improvement are deductible</li>
<li>Contract must not have been carried out by a registered construction company.</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How many services by craftsmen would ${Questions.homeYouIdentity} like to enter?",
              "Craftsmen services",
              220.0,
              "calculation",
              "");
        }
      }

      //Answer No 43
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the chimney sweep?" &&
          widget.CheckQuestion == "Costs chimney sweep") {
        // For partner we have to add You and second household use to insert only one you
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.homeSecondHouseholdYou == true) {
          Questions.homeSecondHouseholdYou = false;
          qu.HomeAddAnswer("You", "", "", "", [], 60.0);
        }

        //Question No 98
        return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
            "Second household",
            220.0,
            "",
            "");
      }

      //Answer No 49
      else if (widget.CheckCompleteQuestion ==
              "How many services by craftsmen would ${Questions.homeYouIdentity} like to enter?" &&
          widget.CheckQuestion == "Craftsmen services") {
        //Question No 50
        return homesixoptioncontainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Household services",
            "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?",
            "Craftsman service ${Questions.craftsmenLength}",
            [
              "Maintenance",
              "Repairs",
              "Paintwork",
              "Modernisations",
              "Extension work",
              "Plumbing"
            ],
            220.0,
            "",
            Questions.craftsmenText);
      }

      //Answer No 41
      else if ((widget.CheckCompleteQuestion ==
                  "What kind of work did the craftsmen do?" ||
              widget.CheckCompleteQuestion ==
                  "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?") &&
          (widget.CheckQuestion == "Training" ||
              widget.CheckQuestion ==
                  "Craftsman service ${Questions.craftsmenLength}")) {
        if (widget.CheckAnswer[0] == "Maintenance") {
          DbHelper.insatance
            ..deleteWithquestion('What kind of work did the craftsmen do?');
          _insert(
              'What kind of work did the craftsmen do?', 'Maintenance', 'OK');
          //Question No 42
          return homecalculationContainer("""
<p><strong>Maintenance works</strong></p>
<p>Please enter the total amount spent on maintenance works in 2019.</p>
<ul>
<li>The works took place in your apartment / house / property</li>
<li>The invoice must have been paid by bank transfer. Cash payments are not deductible</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Must have been paid for in 2019</li>
</ul>
<p><strong>DEDUCTIBLE COSTS INCLUDE THE FOLLOWING:</strong></p>
<ul>
<li>legionella inspection</li>
<li>technical inspection (elevator)</li>
<li>inspection of lightning</li>
<li>leakage tests of waste pipes</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/14</u></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much have ${Questions.homeYouIdentity} spent on maintenance?",
              "Amount maintenance",
              220.0,
              "calculation",
              Questions.craftsmenText);
        } else if (widget.CheckAnswer[0] == "Repairs") {
          DbHelper.insatance
            ..deleteWithquestion('What kind of work did the craftsmen do?');
          _insert('What kind of work did the craftsmen do?', 'Repairs', 'OK');
          //Question No 44
          return homecalculationContainer("""
<p><strong>Repair works</strong></p>
<p>Please enter the total amount spent on maintenance works in 2019.</p>
<ul>
<li>You contracted the work as a private individual</li>
<li>The works took place in your apartment / house / property</li>
<li>The invoice must have been paid by bank transfer. Cash payments are not deductible</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Invoice must have been paid for in 2019. Date of invoice is not relevant.</li>
<li>Contract must not have been carried out by a registered construction company</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/1</u></p>
<p><u>&nbsp;</u></p>
<p><u>&nbsp;</u></p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} spend on repairs?",
              "Amount repairs",
              220.0,
              "calculation",
              Questions.craftsmenText);
        } else if (widget.CheckAnswer[0] == "Paintwork") {
          DbHelper.insatance
            ..deleteWithquestion('What kind of work did the craftsmen do?');
          _insert('What kind of work did the craftsmen do?', 'Paintwork', 'OK');
          //Question No 45
          return homecalculationContainer("""
<p><strong>Painting and decorating</strong></p>
<p>Please enter the total amount spent on painting and decorating in 2019.</p>
<ul>
<li>The works took place in your apartment / house / property</li>
<li>The works carried out on existing building, not a new construction</li>
<li>The invoice must have been paid by bank transfer. Cash payments are not deductible</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Must have been paid for in 2019</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/14</u></p>
<p><u>&nbsp;</u></p>
<p><u>&nbsp;</u></p>

""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} spend on paintwork?",
              "Amount paintwork",
              220.0,
              "calculation",
              Questions.craftsmenText);
        } else if (widget.CheckAnswer[0] == "Modernisations") {
          DbHelper.insatance
            ..deleteWithquestion('What kind of work did the craftsmen do?');
          _insert('What kind of work did the craftsmen do?', 'Modernisations',
              'OK');
          //Question No 46
          return homecalculationContainer("""
<p><strong>Modernisation works</strong></p>
<p>Please enter the total amount spent on modernisation works in 2019.</p>
<ul>
<li>The works took place in your apartment / house / property</li>
<li>Contract must not have been carried out by a registered construction company</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Invoice must have been paid for in 2019. Date of invoice is not relevant.</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/14</u></p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} spend on modernisation?",
              "Costs modernisation",
              220.0,
              "calculation",
              Questions.craftsmenText);
        } else if (widget.CheckAnswer[0] == "Extension work") {
          DbHelper.insatance
            ..deleteWithquestion('What kind of work did the craftsmen do?');
          _insert('What kind of work did the craftsmen do?', 'Extension work',
              'OK');
          //Question No 47

          return homecalculationContainer("""
<p><strong>Extension works</strong></p>
<ul>
<li>Please enter the total amount spent on extension works in 2019.</li>
<li>The works involve your apartment / house / property</li>
<li>The invoice must have been paid by bank transfer. Cash payments are not deductible</li>
<li>Works involve an existing building, not a new construction</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Must have been paid for in 2019</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/14</u></p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} spend on extension work?",
              "Amount extension work",
              220.0,
              "calculation",
              Questions.craftsmenText);
        } else if (widget.CheckAnswer[0] == "Plumbing") {
          DbHelper.insatance
            ..deleteWithquestion('What kind of work did the craftsmen do?');
          _insert('What kind of work did the craftsmen do?', 'Plumbing', 'OK');
          //Question No 48
          return homecalculationContainer("""
<p><strong>Supply works</strong></p>
<ul>
<li>Please enter the total amount spent on supply works in 2019.</li>
<li>The works took place in your apartment / house / property</li>
<li>The invoice must have been paid by bank transfer. Cash payments are not deductible</li>
<li>Only personnel and journey costs, no material costs</li>
<li>Must have been paid for in 2019</li>
</ul>
<p><strong>DEDUCTIBLE COSTS INCLUDE THE FOLLOWING:</strong></p>
<ul>
<li>leakage tests of waste pipes</li>
<li>connection costs to drain system and power supply</li>
</ul>
<p><strong>LABOR COSTS ON INVOICE</strong></p>
<p>If the labor costs are not separately identified on the invoice, ask for a new one. Labor and material costs must be shown separately.</p>
<p>You are legally entitled to this type of invoice. This was ruled by the district court of M&uuml;hlheim in July 2015: <u>Az.: 12 C 1124/14</u></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "How much did ${Questions.homeYouIdentity} spend on supply works?",
              "Amount supply works",
              220.0,
              "calculation",
              Questions.craftsmenText);
        }
      }

      //Answer No 42
      else if (widget.CheckCompleteQuestion ==
              "How much have ${Questions.homeYouIdentity} spent on maintenance?" &&
          widget.CheckQuestion == "Amount maintenance") {
        if (Questions.craftsmenLength <= Questions.totalCraftsmen &&
            Questions.craftsmenLength > 0) {
          //Question No 50
          return homesixoptioncontainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?",
              "Craftsman service ${Questions.craftsmenLength}",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              Questions.craftsmenText);
        } else {
          // For partner we have to add You and second household use to insert only one you
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homeSecondHouseholdYou == true) {
            Questions.homeSecondHouseholdYou = false;
            qu.HomeAddAnswer("You", "", "", "", [], 60.0);
          }

          //Question No 98
          return homeyesnoContainer("""

<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
              "Second household",
              220.0,
              "",
              "");
        }
      }

      //Answer No 44
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on repairs?" &&
          widget.CheckQuestion == "Amount repairs") {
        if (Questions.craftsmenLength <= Questions.totalCraftsmen &&
            Questions.craftsmenLength > 0) {
          //Question No 50
          return homesixoptioncontainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?",
              "Craftsman service ${Questions.craftsmenLength}",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              Questions.craftsmenText);
        } else {
          // For partner we have to add You and second household use to insert only one you
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homeSecondHouseholdYou == true) {
            Questions.homeSecondHouseholdYou = false;
            qu.HomeAddAnswer("You", "", "", "", [], 60.0);
          }

          //Question No 98
          return homeyesnoContainer("""

<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
              "Second household",
              220.0,
              "",
              "");
        }
      }

      //Answer No 45
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on paintwork?" &&
          widget.CheckQuestion == "Amount paintwork") {
        if (Questions.craftsmenLength <= Questions.totalCraftsmen &&
            Questions.craftsmenLength > 0) {
          //Question No 50
          return homesixoptioncontainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?",
              "Craftsman service ${Questions.craftsmenLength}",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              Questions.craftsmenText);
        } else {
          // For partner we have to add You and second household use to insert only one you
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homeSecondHouseholdYou == true) {
            Questions.homeSecondHouseholdYou = false;
            qu.HomeAddAnswer("You", "", "", "", [], 60.0);
          }

          //Question No 98
          return homeyesnoContainer("""

<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
              "Second household",
              220.0,
              "",
              "");
        }
      }

      //Answer No 46
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on modernisation?" &&
          widget.CheckQuestion == "Costs modernisation") {
        if (Questions.craftsmenLength <= Questions.totalCraftsmen &&
            Questions.craftsmenLength > 0) {
          //Question No 50
          return homesixoptioncontainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?",
              "Craftsman service ${Questions.craftsmenLength}",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              Questions.craftsmenText);
        } else {
          // For partner we have to add You and second household use to insert only one you
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homeSecondHouseholdYou == true) {
            Questions.homeSecondHouseholdYou = false;
            qu.HomeAddAnswer("You", "", "", "", [], 60.0);
          }

          //Question No 98
          return homeyesnoContainer("""

<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
              "Second household",
              220.0,
              "",
              "");
        }
      }

      //Answer No 47
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on extension work?" &&
          widget.CheckQuestion == "Amount extension work") {
        if (Questions.craftsmenLength <= Questions.totalCraftsmen &&
            Questions.craftsmenLength > 0) {
          //Question No 50
          return homesixoptioncontainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?",
              "Craftsman service ${Questions.craftsmenLength}",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              Questions.craftsmenText);
        } else {
          // For partner we have to add You and second household use to insert only one you
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homeSecondHouseholdYou == true) {
            Questions.homeSecondHouseholdYou = false;
            qu.HomeAddAnswer("You", "", "", "", [], 60.0);
          }

          //Question No 98
          return homeyesnoContainer("""

<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
              "Second household",
              220.0,
              "",
              "");
        }
      }

      //Answer No 48
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on supply works?" &&
          widget.CheckQuestion == "Amount supply works") {
        if (Questions.craftsmenLength <= Questions.totalCraftsmen &&
            Questions.craftsmenLength > 0) {
          //Question No 50
          return homesixoptioncontainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Household services",
              "What kind of services were done by craftsmen no. ${Questions.craftsmenLength}?",
              "Craftsman service ${Questions.craftsmenLength}",
              [
                "Maintenance",
                "Repairs",
                "Paintwork",
                "Modernisations",
                "Extension work",
                "Plumbing"
              ],
              220.0,
              "",
              Questions.craftsmenText);
        } else {
          // For partner we have to add You and second household use to insert only one you
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homeSecondHouseholdYou == true) {
            Questions.homeSecondHouseholdYou = false;
            qu.HomeAddAnswer("You", "", "", "", [], 60.0);
          }

          //Question No 98
          return homeyesnoContainer("""

<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
              "Second household",
              220.0,
              "",
              "");
        }
      }

      //============= Big Detail (House Hold Services End)  =========================

      //============= Big Detail (Home Start) =========================

      //Answer No 98(Partner)
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?" &&
          widget.CheckQuestion == "Second household") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Did ${Questions.homeYouIdentity} have a second household due to work in 2019?');
          _insert(
              'Did ${Questions.homeYouIdentity} have a second household due to work in 2019?',
              'No',
              'OK');
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Did ${Questions.homeYouIdentity} have a second household due to work in 2019?');
          _insert(
              'Did ${Questions.homeYouIdentity} have a second household due to work in 2019?',
              'Yes',
              'OK');
          //Question No 99
          return homeyesnoContainer("""

<p><strong>First and second household</strong></p>
<p>You need to be able to prove that you cover at least 10 percent of the running costs of the first household. You can include invoices for electricity, rent, water, food etc.</p>
<p>Only then can you claim the expenses from your second household as tax deductible from the tax office.</p>
<p>Trainees that live for free with their parents cannot therefore claim a second household at the place of training.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Did ${Questions.homeYouIdentity} bear at least 10% of ${Questions.homeYourIdentity} first household's costs?",
              "10% of costs",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Did ${Questions.homeYouIdentity} have a second household due to work in 2019?');
          _insert(
              'Did ${Questions.homeYouIdentity} have a second household due to work in 2019?',
              'skip',
              'OK');
          //Question No 99
          return FinishCategory("Home Category", "Work Category", 3, true);
        }
      }

      //Answer No 99
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} bear at least 10% of ${Questions.homeYourIdentity} first household's costs?" &&
          widget.CheckQuestion == "10% of costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('bear at least 10% of');
          _insert('bear at least 10% of', 'No', 'OK');
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('bear at least 10% of');
          _insert('bear at least 10% of', 'skip', 'skip');
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('bear at least 10% of');
          _insert('bear at least 10% of', 'Yes', 'OK');
          //Question No 100
          //For No 330.0
          //For yes 220.0
          return homeyesnoContainer("""

<p><strong>Multiple second homes</strong></p>
<p>Please state whether you had multiple second homes. If this applies to you, then choose "Yes", otherwise click "No".</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "${Questions.homeYouIdentity} have stated ${Questions.homeYouIdentity} have a second household. Did ${Questions.homeYouIdentity} have more than one second household?",
              "Multiple second households",
              220.0,
              "",
              "");
        }
      }

      //Answer No 100

      else if (widget.CheckCompleteQuestion ==
              "${Questions.homeYouIdentity} have stated ${Questions.homeYouIdentity} have a second household. Did ${Questions.homeYouIdentity} have more than one second household?" &&
          widget.CheckQuestion == "Multiple second households") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('bear at least 10% of');
          _insert('bear at least 10% of', 'No', 'OK');
          //Question No 101

          return homethreeoptioncontainer(
              """

<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('bear at least 10% of');
          _insert('bear at least 10% of', 'skip', 'skip');
          //Question No 101

          return homethreeoptioncontainer(
              """

<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('bear at least 10% of');
          _insert('bear at least 10% of', 'Yes', 'OK');
          //Question No 102
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "How many second households would ${Questions.homeYouIdentity} like to enter?",
              "Quantity",
              220.0,
              "calculation",
              "");
        }
      }

      //Answer No 102
      else if (widget.CheckCompleteQuestion ==
              "How many second households would ${Questions.homeYouIdentity} like to enter?" &&
          widget.CheckQuestion == "Quantity") {
        //Question No 101
        return homethreeoptioncontainer(
            """

<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What is living situation in ${Questions.homeYourIdentity} second household?",
            "Living there",
            ["Rented apartment", "Own home", "With friends or family"],
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 101

      else if (widget.CheckCompleteQuestion ==
              "What is living situation in ${Questions.homeYourIdentity} second household?" &&
          widget.CheckQuestion == "Living there") {
        if (widget.CheckAnswer[0] == "Rented apartment") {
          DbHelper.insatance
            ..deleteWithquestion(
                'What is living situation in second household?');
          _insert('What is living situation in second household?',
              'Rented apartment', 'OK');
          //Question No 103
          return homeaddressContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "What is the address of ${Questions.homeYourIdentity} second household?",
              "Address second household",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Own home") {
          DbHelper.insatance
            ..deleteWithquestion(
                'What is living situation in second household?');
          _insert('What is living situation in second household?', 'Own home',
              'OK');
//Question No 103
          return homeaddressContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "What is the address of ${Questions.homeYourIdentity} second household?",
              "Address second household",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "With friends or family") {
          DbHelper.insatance
            ..deleteWithquestion(
                'What is living situation in second household?');
          _insert('What is living situation in second household?',
              'With friends or family', 'OK');
          //Question No 103
          return homeaddressContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "What is the address of ${Questions.homeYourIdentity} second household?",
              "Address second household",
              220.0,
              "",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 103
      else if (widget.CheckCompleteQuestion ==
              "What is the address of ${Questions.homeYourIdentity} second household?" &&
          widget.CheckQuestion == "Address second household") {
        //Question No 104
        return homedateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Home",
            "When did ${Questions.homeYouIdentity} move into ${Questions.homeYourIdentity} second household?",
            "Moving to",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 104
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} move into ${Questions.homeYourIdentity} second household?" &&
          widget.CheckQuestion == "Moving to") {
        //Question No 105
        //For No 220.0
        //For Yes 430.0
        return homeyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Home",
            "Were ${Questions.homeYouIdentity} still living there by the end of year?",
            "Living end of 2019",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 105

      else if (widget.CheckCompleteQuestion ==
              "Were ${Questions.homeYouIdentity} still living there by the end of year?" &&
          widget.CheckQuestion == "Living end of 2019") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion('still living there by the end of year?');
          _insert('still living there by the end of year?', 'No', 'OK');
          //Question No 106
          return homedateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "When did ${Questions.homeYouIdentity} move out of ${Questions.homeYourIdentity} second household?",
              "Moved out on",
              430.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion('still living there by the end of year?');
          _insert('still living there by the end of year?', 'skip', 'skip');
          //Question No 106
          return homedateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "When did ${Questions.homeYouIdentity} move out of ${Questions.homeYourIdentity} second household?",
              "Moved out on",
              430.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion('still living there by the end of year?');
          _insert('still living there by the end of year?', 'Yes', 'OK');
          //Question No 107
          return homesixoptioncontainer(
              """

<p><strong>Second household</strong></p>
<p>Choose the reason for your second household from the options below.</p>
<p><strong>Important!</strong></p>
<p>If you have a second household for <strong>work related reasons</strong>, the costs are tax deductible.</p>
<p>The second household must be a maximum of half the distance to your primary place of work compared with your primary residence.</p>
<p>Your primary base must still be your primary residence. The following points apply to this:</p>
<ul>
<li>Your second apartment is not bigger than your primary residence.</li>
<li>If your employment away from home is temporary, the tax office will recognize the costs more easily.</li>
<li>If you are married, your primary base is where your partner and family live.</li>
<li>You regularly travel home and spend most of your free time at your primary residence.</li>
</ul>
<p>If these conditions are met, you can include many costs as income-relate expenses in your tax return.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Why did ${Questions.homeYouIdentity} have a second household?",
              "Reason for double housekeeping",
              [
                "Transfer to another location",
                "Change of employer",
                "New workplace",
                "Shorter commute",
                "Private reasons"
              ],
              220.0,
              "",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 106
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} move out of ${Questions.homeYourIdentity} second household?" &&
          widget.CheckQuestion == "Moved out on") {
        //Question No 107
        return homesixoptioncontainer(
            """

<p><strong>Second household</strong></p>
<p>Choose the reason for your second household from the options below.</p>
<p><strong>Important!</strong></p>
<p>If you have a second household for <strong>work related reasons</strong>, the costs are tax deductible.</p>
<p>The second household must be a maximum of half the distance to your primary place of work compared with your primary residence.</p>
<p>Your primary base must still be your primary residence. The following points apply to this:</p>
<ul>
<li>Your second apartment is not bigger than your primary residence.</li>
<li>If your employment away from home is temporary, the tax office will recognize the costs more easily.</li>
<li>If you are married, your primary base is where your partner and family live.</li>
<li>You regularly travel home and spend most of your free time at your primary residence.</li>
</ul>
<p>If these conditions are met, you can include many costs as income-relate expenses in your tax return.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Why did ${Questions.homeYouIdentity} have a second household?",
            "Reason for double housekeeping",
            [
              "Transfer to another location",
              "Change of employer",
              "New workplace",
              "Shorter commute",
              "Private reasons"
            ],
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 107
      else if (widget.CheckCompleteQuestion ==
              "Why did ${Questions.homeYouIdentity} have a second household?" &&
          widget.CheckQuestion == "Reason for double housekeeping") {
        if (widget.CheckAnswer[0] == "Transfer to another location") {
          DbHelper.insatance
            ..deleteWithquestion('Reason for double housekeeping');
          _insert('Reason for double housekeeping',
              'Transfer to another location', 'OK');
          //Question No 108
          return homeyesnoContainer("""

<p><strong>External activity before</strong></p>
<p>Answer "Yes" to this question if you had an external activity at this place before.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Have ${Questions.homeYouIdentity} had an external activity at this place before?",
              "External activity before",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Change of employer") {
          DbHelper.insatance
            ..deleteWithquestion('Reason for double housekeeping');
          _insert('Reason for double housekeeping', 'Change of employer', 'OK');
          //Question No 108
          return homeyesnoContainer("""

<p><strong>External activity before</strong></p>
<p>Answer "Yes" to this question if you had an external activity at this place before.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Have ${Questions.homeYouIdentity} had an external activity at this place before?",
              "External activity before",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "New workplace") {
          DbHelper.insatance
            ..deleteWithquestion('Reason for double housekeeping');
          _insert('Reason for double housekeeping', 'New workplace', 'OK');
          //Question No 108
          return homeyesnoContainer("""

<p><strong>External activity before</strong></p>
<p>Answer "Yes" to this question if you had an external activity at this place before.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Have ${Questions.homeYouIdentity} had an external activity at this place before?",
              "External activity before",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Shorter commute") {
          DbHelper.insatance
            ..deleteWithquestion('Reason for double housekeeping');
          _insert('Reason for double housekeeping', 'Shorter commute', 'OK');
          //Question No 108
          return homeyesnoContainer("""

<p><strong>External activity before</strong></p>
<p>Answer "Yes" to this question if you had an external activity at this place before.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Have ${Questions.homeYouIdentity} had an external activity at this place before?",
              "External activity before",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Private reasons") {
          DbHelper.insatance
            ..deleteWithquestion('Reason for double housekeeping');
          _insert('Reason for double housekeeping', 'Private reasons', 'OK');
          if ((Questions.secondHouseHoldLength <=
                  Questions.totalSecondHouseHold) &&
              Questions.secondHouseHoldLength > 0) {
            return homethreeoptioncontainer(
                """

<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "What is living situation in ${Questions.homeYourIdentity} second household?",
                "Living there",
                ["Rented apartment", "Own home", "With friends or family"],
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else {
            // For Partner
            if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
                Questions.homePartner == true) {
              homePartner();
              //Question No 98(Partner)
              return homeyesnoContainer("""

<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""", "", "Home", "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                  "Second household", 220.0, "", "");
            } else {
              return FinishCategory("Home Category", "Work Category", 3, true);
            }
          }
        }
      }

      //Answer No 108
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.homeYouIdentity} had an external activity at this place before?" &&
          widget.CheckQuestion == "External activity before") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'had an external activity at this place before?');
          _insert('had an external activity at this place before?', 'No', 'OK');
          //Question No 109
          return homeyesnoContainer("""

<p><strong>Current main residence</strong></p>
<p>Here you need to indicate whether you already lived in your current residence in the year 2019 or whether you moved in the meantime.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Is the address of ${Questions.homeYourIdentity} main residence in 2019 equal to ${Questions.homeYourIdentity} current address?",
              "Current address main residence",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'had an external activity at this place before?');
          _insert(
              'had an external activity at this place before?', 'skip', 'skip');
          //Question No 109
          return homeyesnoContainer("""

<p><strong>Current main residence</strong></p>
<p>Here you need to indicate whether you already lived in your current residence in the year 2019 or whether you moved in the meantime.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Is the address of ${Questions.homeYourIdentity} main residence in 2019 equal to ${Questions.homeYourIdentity} current address?",
              "Current address main residence",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'had an external activity at this place before?');
          _insert(
              'had an external activity at this place before?', 'Yes', 'OK');
          //Question No 109
          return homeyesnoContainer("""

<p><strong>Current main residence</strong></p>
<p>Here you need to indicate whether you already lived in your current residence in the year 2019 or whether you moved in the meantime.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Is the address of ${Questions.homeYourIdentity} main residence in 2019 equal to ${Questions.homeYourIdentity} current address?",
              "Current address main residence",
              220.0,
              "",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 109
      else if (widget.CheckCompleteQuestion ==
              "Is the address of ${Questions.homeYourIdentity} main residence in 2019 equal to ${Questions.homeYourIdentity} current address?" &&
          widget.CheckQuestion == "Current address main residence") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion('Current address is main residence');
          _insert('Current address is main residence', 'No', 'OK');
          //Question No 110
          return homeaddressContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "What is the address of ${Questions.homeYourIdentity} main residence in 2019?",
              "Main residence 2019",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion('Current address is main residence');
          _insert('Current address is main residence', 'skip', 'skip');
          //Question No 110
          return homeaddressContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "What is the address of ${Questions.homeYourIdentity} main residence in 2019?",
              "Main residence 2019",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion('Current address is main residence');
          _insert('Current address is main residence', 'Yes', 'OK');
          //Question No 111
          return homedateContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "Since when do ${Questions.homeYouIdentity} have ${Questions.homeYourIdentity} primary residence at this address?",
              "Primary residence since",
              430.0,
              "",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 110
      else if (widget.CheckCompleteQuestion ==
              "What is the address of ${Questions.homeYourIdentity} main residence in 2019?" &&
          widget.CheckQuestion == "Main residence 2019") {
        //Question No 111
        return homedateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Home",
            "Since when do ${Questions.homeYouIdentity} have ${Questions.homeYourIdentity} primary residence at this address?",
            "Primary residence since",
            430.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 111
      else if (widget.CheckCompleteQuestion ==
              "Since when do ${Questions.homeYouIdentity} have ${Questions.homeYourIdentity} primary residence at this address?" &&
          widget.CheckQuestion == "Primary residence since") {
        //Question No 112
        return homemultipleoptionsContainerNo(
            """

<p><strong>Means of transportation: commuting</strong></p>
<p>Select from the options below the mode of transportation you used to travel between both of your apartments.</p>
<p>You can choose several answers.</p>
<p><strong>CAR</strong></p>
<p>You used you own car to travel between your households.</p>
<p><strong>BUS AND TRAIN</strong></p>
<p>You used public transportation such as buses and trains to commute.</p>
<p><strong>PLANE</strong></p>
<p>You traveled by plane.</p>
<p><strong>CAR SHARING</strong></p>
<p>You used car sharing to travel between apartments.</p>
<p><strong>COMPANY CAR</strong></p>
<p>You commuted using the company car.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You traveled by motorcycle.</p>
<p><strong>SHARED COMPANY TRANSPORT</strong></p>
<p>You used shared company transport.</p>
<p><strong>FREE SHARED COMPANY TRANSPORT</strong></p>
<p>You traveled between households using free shared company transport.</p>
<p><strong>FERRY</strong></p>
<p>You traveled by ferry.</p>
<p>--------------</p>
<ol>
<li>Q) How many times did you travel between your first and second household?</li>
</ol>
<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "How did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} households?",
            "Mode of transport",
            [
              "Car",
              "Bus and train",
              "Airplane",
              "Car sharing",
              "Company car",
              "Motorcycle",
              "Collective transport",
              "Free company transport",
              "Ferry"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      // ======== Travel Between Household Start ========
      //Answer No 112
      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} households?" &&
          widget.CheckQuestion == "Mode of transport") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Car") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Car', 'OK');
            //Question No 113
            Questions.modeOfTransport = "Car";
            //Agar ya car ka liya agaya to phir multiple option ma baqi kisi ka liya nhi aiga
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'skip', 'skip');
            //Question No 113
            Questions.modeOfTransport = "car";
            //Agar ya car ka liya agaya to phir multiple option ma baqi kisi ka liya nhi aiga
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Bus and train") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Bus and train', 'OK');
            //Question No 113
            Questions.modeOfTransport = "Bus and train";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Airplane") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Airplane', 'OK');
            //Question No 113
            Questions.modeOfTransport = "Airplane";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Car sharing") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Car sharing', 'OK');
            //Question No 113
            Questions.modeOfTransport = "Car sharing";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Company car") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Company car', 'OK');
            //Question New
            Questions.modeOfTransport = "Company car";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How often did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "No. regular drives",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Motorcycle") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Motorcycle', 'OK');
            //Question 113
            Questions.modeOfTransport = "Motorcycle";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Collective transport") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Collective transport', 'OK');
            //Question 113
            Questions.modeOfTransport = "Collective transport";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Free company transport") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Free company transport', 'OK');
            //Question New
            Questions.modeOfTransport = "Free company transport";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How often did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "No. regular drives",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Ferry") {
            DbHelper.insatance..deleteWithquestion('Mode of transport');
            _insert('Mode of transport', 'Ferry', 'OK');
            //Question 113
            Questions.modeOfTransport = "Ferry";
            return homecalculationContainer("""

<p><strong>Journeys home</strong></p>
<p>Please enter the total number of journeys you made while maintaining two households. Please note only journeys from 2019 are relevant.</p>
<p>A journey includes the trip there and the trip back. So if you commuted every weekend in June, July, and August 2019, that would be 13 journeys. Enter the corresponding number of journeys here.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?",
                "Number of journeys",
                220.0,
                "",
                Questions.secondHouseHoldText);
          }
        }
      }

      //Answer No 113

      else if (widget.CheckCompleteQuestion ==
              "How many times did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?" &&
          widget.CheckQuestion == "Number of journeys") {
        if (Questions.modeOfTransport == "Car") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'Car', 'OK');
          //Yaha sa container change hoga is tara ka
          //Question No 114
          return homecalculationContainer("""

<p><strong>Distance of journeys home: motorcycle</strong></p>
<p>Enter the route you used for to get home in 2019. Enter the respective addresses here.</p>
<p>You can deduct travel expenses for journeys home to see your family. This means you can travel once a week from your second home to your primary residence.</p>
<p>You can write off 30 cents per kilometer for the route between your households.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Where was the start and end point of ${Questions.homeYourIdentity} car journey?",
              "By car",
              430.0,
              "",
              Questions.secondHouseHoldText);
        } else if (Questions.modeOfTransport == "skip") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'skip', 'skip');
          //Yaha sa container change hoga is tara ka
          //Question No 114
          return homecalculationContainer("""

<p><strong>Distance of journeys home: motorcycle</strong></p>
<p>Enter the route you used for to get home in 2019. Enter the respective addresses here.</p>
<p>You can deduct travel expenses for journeys home to see your family. This means you can travel once a week from your second home to your primary residence.</p>
<p>You can write off 30 cents per kilometer for the route between your households.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Where was the start and end point of ${Questions.homeYourIdentity} car journey?",
              "By car",
              430.0,
              "",
              Questions.secondHouseHoldText);
        } else if (Questions.modeOfTransport == "Bus and train") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'Bus and train', 'OK');
//Yaha sa container change hoga is tara ka
          //Question No 115
          return homecalculationContainer("""

<p><strong>Distance of journeys home: bus &amp; train</strong></p>
<p>Enter the route you used for to get home in 2019. Enter the respective addresses you traveled between here.</p>
<p>You can deduct travel expenses for journeys home to see your family. This means you can travel once a week from your second home to your primary residence.</p>
<p>You can write off 30 cents per kilometer for the route between your households or the actual costs of the tickets with public transport.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Where was the start and end point of ${Questions.homeYourIdentity} journey by train or bus?",
              "By train or bus",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (Questions.modeOfTransport == "Airplane") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'Airplane', 'OK');
          //Question No 125
          return homecalculationContainer("""

<p><strong>Journeys home by plane</strong></p>
<p>If you travel by plane for your weekly journey home to see your family, you can only deduct the actual airfare. The commuting allowance does not apply here.</p>
<p>Accordingly, enter how much your airline tickets cost. Remember, only expenses from 2019 are relevant.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "How much did ${Questions.homeYouIdentity} spend on flight tickets?",
              "Flight costs",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (Questions.modeOfTransport == "Car sharing") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'Car sharing', 'OK');
          //Yaha sa container change hoga is tara ka
          //Question No 116

//           return homecalculationContainer("""

// <p><strong>Distance of journeys home: car sharing</strong></p>
// <p>Enter the route you used for to get home in 2019. Enter the respective addresses here.</p>
// <p>You can deduct travel expenses for journeys home to see your family. This means you can travel once a week from your second home to your primary residence.</p>
// <p>You can write off 30 cents per kilometer for the route between your households or the actual costs.</p>
// <p>&nbsp;</p>
// <p>&nbsp;</p>
// """,
//               "",
//               "Home",
//               "How much did ${Questions.homeYouIdentity} spend on flight tickets?",
//               "Flight costs",
//               220.0,
//               "",
//               Questions.secondHouseHoldText);

          return homecalculationContainer("""

<p><strong>Distance of journeys home: motorcycle</strong></p>
<p>Enter the route you used for to get home in 2019. Enter the respective addresses here.</p>
<p>You can deduct travel expenses for journeys home to see your family. This means you can travel once a week from your second home to your primary residence.</p>
<p>You can write off 30 cents per kilometer for the route between your households.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Where was the start and end point of ${Questions.homeYourIdentity} car journey?",
              "By car sharing",
              430.0,
              "",
              Questions.secondHouseHoldText);
        } else if (Questions.modeOfTransport == "Motorcycle") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'Motorcycle', 'OK');
          //Yaha sa container change hoga is tara ka
          //Question No 117
          return homecalculationContainer("""

<p><strong>Distance of journeys home: motorcycle</strong></p>
<p>Enter the route you used for to get home in 2019. Enter the respective addresses here.</p>
<p>You can deduct travel expenses for journeys home to see your family. This means you can travel once a week from your second home to your primary residence.</p>
<p>You can write off 30 cents per kilometer for the route between your households.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Please enter the route ${Questions.homeYouIdentity} traveled by motorcycle?",
              "By motorcycle",
              430.0,
              "",
              Questions.secondHouseHoldText);
        } else if (Questions.modeOfTransport == "Collective transport") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'Collective transport', 'OK');
          //Yaha sa container change hoga is tara ka
          //Question No 118
          return homecalculationContainer("""

<p><strong>Distance of journeys home: company transport</strong></p>
<p>Enter the route you used for to get home in 2019. Enter the respective addresses here.</p>
<p>You can deduct travel expenses for journeys home to see your family. This means you can travel once a week from your second home to your primary residence.</p>
<p>You can write off 30 cents per kilometer for the route between your households or the actual costs.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "Where was the start and end point of ${Questions.homeYourIdentity} journey via company transport?",
              "Company transport",
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else if (Questions.modeOfTransport == "Ferry") {
          DbHelper.insatance..deleteWithquestion('Number of journeys');
          _insert('Number of journeys', 'Ferry', 'OK');
          //Question No 126
          return homecalculationContainer("""

<p><strong>Ferry journeys</strong></p>
<p>If you travel by ferry for your weekly journey home to see your family, you can only deduct the actual costs. The commuting allowance does not apply here.</p>
<p>Accordingly, enter how much your ferry tickets cost. Remember, only expenses from 2019 are relevant.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "How much did ${Questions.homeYouIdentity} spend on ferry tickets?",
              "Ferry costs",
              430.0,
              "",
              Questions.secondHouseHoldText);
        }
      } else if (widget.CheckCompleteQuestion ==
              "Do you have any cost for car sharing?" &&
          widget.CheckQuestion == "Car Sharing Cost") {
        if (widget.CheckAnswer[0] == "Yes") {
          return homecalculationContainer("""

<p><strong>Journeys home by car sharing</strong></p>
<p>Please state whether the costs we calculated cover your expenses. If they do, confirm with "Yes", otherwise click "No".</p>
<p>If the actual costs of your journey home are higher than the commuting allowance, you can deduct these instead.</p>
<p><strong>Please note you may have to provide proof of these costs.</strong></p>
<p><strong>&nbsp;</strong></p>

""",
              "",
              "Home",
              "How much did ${Questions.homeYouIdentity} spend on car sharing?",
              "Costs car sharing",
              430.0,
              "calculation",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "No") {
          return homecalculationContainer("""

<p><strong>Journeys home by car sharing</strong></p>
<p>Please state whether the costs we calculated cover your expenses. If they do, confirm with "Yes", otherwise click "No".</p>
<p>If the actual costs of your journey home are higher than the commuting allowance, you can deduct these instead.</p>
<p><strong>Please note you may have to provide proof of these costs.</strong></p>
<p><strong>&nbsp;</strong></p>

""",
              "",
              "Home",
              "How much did ${Questions.homeYouIdentity} spend on car sharing?",
              "Costs car sharing",
              430.0,
              "calculation",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 114

      else if (widget.CheckCompleteQuestion ==
              "Where was the start and end point of ${Questions.homeYourIdentity} car journey?" &&
          widget.CheckQuestion == "By car sharing") {
        //Question No 127
        return homeyesnoContainer("""

<p><strong>Journeys home by public transport</strong></p>
<p>Please state whether the costs we calculated cover your expenses. If they do, confirm with "Yes", otherwise click "No".</p>
<p>You can deduct the actual costs for journeys home to see your family by public transport - with proof.</p>
<p>This is worth it if the actual costs are higher than the commuting allowance.</p>

""", "", "Home", "Do you have any cost for car sharing?", "Car Sharing Cost",
            220.0, "", Questions.secondHouseHoldText);
      } else if (widget.CheckCompleteQuestion ==
              "Where was the start and end point of ${Questions.homeYourIdentity} car journey?" &&
          widget.CheckQuestion == "By car") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of moving cost did you have for your second household?",
            "Costs second house",
            [
              "Rental Car",
              "Public transport",
              "Moving company",
              "Flight tickets",
              "No"
            ],
            [
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png",
              "images/check.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      } else if (widget.CheckCompleteQuestion ==
              "What kind of moving cost did you have for your second household?" &&
          widget.CheckQuestion == "Costs second house") {
        //Question No 127
        if (widget.CheckAnswer[0] == "Rental Car") {
          return homecalculationContainer("""<h1>Coming Soon</h1>""",
              "",
              "Rental Car Cost?",
              "How much was the rental car cost?",
              "Rental Car Cost?",
              330.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Public transport") {
          return homecalculationContainer("""<h1>Coming Soon</h1>""",
              "",
              "Rental Car Cost?",
              "How much was the Public transport cost?",
              "Rental Car Cost?",
              330.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Moving company") {
          return homecalculationContainer("""<h1>Coming Soon</h1>""",
              "",
              "Rental Car Cost?",
              "How much was the Moving company cost?",
              "Rental Car Cost?",
              330.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "Flight tickets") {
          return homecalculationContainer("""<h1>Coming Soon</h1>""",
              "",
              "Rental Car Cost?",
              "How much was the Flight tickets cost?",
              "Rental Car Cost?",
              330.0,
              "calculation",
              "");
        } else if (widget.CheckAnswer[0] == "No") {
          return homemultipleoptionsContainerNo(
              """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
              "Costs second home",
              [
                "Rent",
                "Additional property expenses",
                "Furnishing",
                "Parking space",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.secondHouseHoldText);
        }
      } else if (widget.CheckQuestion == "Rental Car Cost?") {
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      //Answer No 115
      else if (widget.CheckCompleteQuestion ==
              "Where was the start and end point of ${Questions.homeYourIdentity} journey by train or bus?" &&
          widget.CheckQuestion == "By train or bus") {
        //Question No 119
        //For No 430.0
        //For Yes 220.0
        return homeyesnoContainer("""

<p><strong>Journeys home by public transport</strong></p>
<p>Please state whether the costs we calculated cover your expenses. If they do, confirm with "Yes", otherwise click "No".</p>
<p>You can deduct the actual costs for journeys home to see your family by public transport - with proof.</p>
<p>This is worth it if the actual costs are higher than the commuting allowance.</p>

""",
            "",
            "Home",
            "We have calculated an amount of €4.80 as travelling expenses. Were ${Questions.homeYourIdentity} actual costs for public transport higher than this?",
            "Higher costs",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 119
      else if (widget.CheckCompleteQuestion ==
              "We have calculated an amount of €4.80 as travelling expenses. Were ${Questions.homeYourIdentity} actual costs for public transport higher than this?" &&
          widget.CheckQuestion == "Higher costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'No',
              'OK');
          //Question No 127
          return homemultipleoptionsContainerNo(
              """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
              "Costs second home",
              [
                "Rent",
                "Additional property expenses",
                "Furnishing",
                "Parking space",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.secondHouseHoldText);
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'skip',
              'OK');
          //Question No 127
          return homemultipleoptionsContainerNo(
              """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
              "Costs second home",
              [
                "Rent",
                "Additional property expenses",
                "Furnishing",
                "Parking space",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'Yes',
              'OK');
          //Question No 120
          return homecalculationContainer("""

<p><strong>Journeys home by public transport</strong></p>
<p>Please enter how much you spent on journeys by bus and train in 2019.</p>
<p>You can deduct the actual costs for journeys home to see your family by public transport - with proof (tickets etc.).</p>
<p>This is worth it if the actual costs are higher than the commuting allowance.</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "How much did ${Questions.homeYouIdentity} spend on public transport?",
              "Costs bus / train",
              220.0,
              "calculation",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 120
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on public transport?" &&
          widget.CheckQuestion == "Costs bus / train") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      //Answer No 125
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on flight tickets?" &&
          widget.CheckQuestion == "Flight costs") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      //Answer No 116
      else if (widget.CheckCompleteQuestion ==
              "Where was the start and end point of ${Questions.homeYourIdentity} journey via car sharing?" &&
          widget.CheckQuestion == "Car sharing") {
        //Question No 121
        //For No 430.0
        //For Yes 220.0
        return homeyesnoContainer("""

<p><strong>Journeys home by car sharing</strong></p>
<p>Please state whether the costs we calculated cover your expenses. If they do, confirm with "Yes", otherwise click "No".</p>
<p>If the actual costs of your journey home are higher than the commuting allowance, you can deduct these instead.</p>
<p><strong>Please note you may have to provide proof of these costs.</strong></p>
<p><strong>&nbsp;</strong></p>

""",
            "",
            "Home",
            "We have calculated an amount of €4.80 as travelling expenses. Were ${Questions.homeYourIdentity} actual costs for car sharing higher than this?",
            "Higher costs",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 121

      else if (widget.CheckCompleteQuestion ==
              "We have calculated an amount of €4.80 as travelling expenses. Were ${Questions.homeYourIdentity} actual costs for car sharing higher than this?" &&
          widget.CheckQuestion == "Higher costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'No',
              'OK');
          //Question No 127
          return homemultipleoptionsContainerNo(
              """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
              "Costs second home",
              [
                "Rent",
                "Additional property expenses",
                "Furnishing",
                "Parking space",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'skip',
              'OK');
          //Question No 127
          return homemultipleoptionsContainerNo(
              """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
              "Costs second home",
              [
                "Rent",
                "Additional property expenses",
                "Furnishing",
                "Parking space",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'Yes',
              'OK');
          //Question No 122
          return homecalculationContainer("""

<p><strong>Journeys home by car sharing</strong></p>
<p>Please state whether the costs we calculated cover your expenses. If they do, confirm with "Yes", otherwise click "No".</p>
<p>If the actual costs of your journey home are higher than the commuting allowance, you can deduct these instead.</p>
<p><strong>Please note you may have to provide proof of these costs.</strong></p>
<p><strong>&nbsp;</strong></p>

""",
              "",
              "Home",
              "How much did ${Questions.homeYouIdentity} spend on car sharing?",
              "Costs car sharing",
              430.0,
              "calculation",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 122

      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on car sharing?" &&
          widget.CheckQuestion == "Costs car sharing") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      //Answer New
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.homeYouIdentity} travel between ${Questions.homeYourIdentity} first and second household?" &&
          widget.CheckQuestion == "No. regular drives") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      //Answer No 117
      else if (widget.CheckCompleteQuestion ==
              "Please enter the route ${Questions.homeYouIdentity} traveled by motorcycle?" &&
          widget.CheckQuestion == "By motorcycle") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      //Answer No 118
      else if (widget.CheckCompleteQuestion ==
              "Where was the start and end point of ${Questions.homeYourIdentity} journey via company transport?" &&
          widget.CheckQuestion == "Company transport") {
        //Question No 123
        //For No 430.0
        //For Yes 220.0
        return homeyesnoContainer("""

<p><strong>Journeys home by car sharing</strong></p>
<p>Please state whether the costs we calculated cover your expenses. If they do, confirm with "Yes", otherwise click "No".</p>
<p>If the actual costs of your journey home are higher than the commuting allowance, you can deduct these instead.</p>
<p><strong>Please note you may have to provide proof of these costs.</strong></p>
<p><strong>&nbsp;</strong></p>

""",
            "",
            "Home",
            "We have calculated an amount of €4.80 as travelling expenses. Were ${Questions.homeYourIdentity} actual costs for company transport higher than this?",
            "Costs company transport",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 123
      else if (widget.CheckCompleteQuestion ==
              "We have calculated an amount of €4.80 as travelling expenses. Were ${Questions.homeYourIdentity} actual costs for company transport higher than this?" &&
          widget.CheckQuestion == "Costs company transport") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'No',
              'OK');
          //Question No 127
          return homemultipleoptionsContainerNo(
              """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
              "Costs second home",
              [
                "Rent",
                "Additional property expenses",
                "Furnishing",
                "Parking space",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'skip',
              'skip');
          //Question No 127
          return homemultipleoptionsContainerNo(
              """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
              "Costs second home",
              [
                "Rent",
                "Additional property expenses",
                "Furnishing",
                "Parking space",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png"
              ],
              220.0,
              "None",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'We have calculated an amount of €4.80 as travelling expenses');
          _insert(
              'We have calculated an amount of €4.80 as travelling expenses',
              'Yes',
              'OK');
          //Question No 124
          return homecalculationContainer("""

<p><strong>Journeys home by company transport</strong></p>
<p>Please enter the actual costs of your journeys by company transport. Remember only costs from 2019 are relevant.</p>
<p>If the actual costs of your journey home are higher than the commuting allowance, you can deduct these instead.</p>
<p><strong>Please note you may have to provide proof of these costs.</strong></p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "How much did ${Questions.homeYouIdentity} spend on company transport?",
              "Costs company transport",
              220.0,
              "calculation",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 124
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on company transport?" &&
          widget.CheckQuestion == "Costs company transport") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      //Answer No 126
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on ferry tickets?" &&
          widget.CheckQuestion == "Ferry costs") {
        //Question No 127
        return homemultipleoptionsContainerNo(
            """

<p><strong>Living costs</strong></p>
<p>Choose from the options which of the following expenses you had. The good news is you can choose multiple options.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You can deduct up to 1,000 euros a month in living costs.</p>
<p>This includes:</p>
<ul>
<li>rent</li>
<li>utilities</li>
<li>necessary furnishing and appliances</li>
<li>parking space</li>
</ul>
<p><strong>OTHER COSTS INCLUDE:</strong></p>
<ul>
<li>cleaning costs (staircase, basement etc.)</li>
<li>waste disposal and chimney cleaning</li>
<li>TV license fee</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?",
            "Costs second home",
            [
              "Rent",
              "Additional property expenses",
              "Furnishing",
              "Parking space",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "None",
            Questions.secondHouseHoldText);
      }

      // ====== Travel Between Household End ======

      // ====== Costs Second Home Starts ======

      //Answer No 127
      else if (widget.CheckCompleteQuestion ==
              "What kind of costs did ${Questions.homeYouIdentity} have for ${Questions.homeYourIdentity} second home?" &&
          widget.CheckQuestion == "Costs second home") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Rent") {
            DbHelper.insatance..deleteWithquestion('Costs second home');
            _insert('Costs second home', 'Rent', 'OK');
            //Question No 128
            return homecalculationContainer("""

<p><strong>Rent costs</strong></p>
<p>If you have a second household for work related reasons, then the living costs are tax deductible.</p>
<p>Please enter the "annual rent costs" for your second household in 2019.</p>
<p>&nbsp;</p>

""", "", "Home", "How much was annual basic rent?", "Basic rent", 430.0,
                "calculation", Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Additional property expenses") {
            DbHelper.insatance..deleteWithquestion('Costs second home');
            _insert('Costs second home', 'Additional property expenses', 'OK');
            //Question No 129
            return homecalculationContainer("""

<p><strong>Ancillary costs</strong></p>
<p>If you have a second household for work related reasons, you can deduct the accommodation costs. This includes utilities.</p>
<p>Please tell us the <strong>total amount of ancillary costs</strong> you had for you second household in 2019.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "What were ${Questions.homeYourIdentity} ancillary costs?",
                "Ancillary costs",
                430.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Furnishing") {
            DbHelper.insatance..deleteWithquestion('Costs second home');
            _insert('Costs second home', 'Furnishing', 'OK');
            //Question No 131
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 488 EUR on any piece of furniture or household appliance?",
                ">488 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Desk",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelf",
                  "Other furniture",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Parking space") {
            DbHelper.insatance..deleteWithquestion('Costs second home');
            _insert('Costs second home', 'Parking space', 'OK');
            //Question No 130
            return homecalculationContainer("""

<p><strong>Parking fees</strong></p>
<p>Did you have parking costs for instance for a parking space at your second home?</p>
<p>Please enter the resulting costs for your parking space or similar here. Remember, only costs from 2019 are relevant.</p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on ${Questions.homeYourIdentity} parking space?",
                "Parking space",
                430.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance..deleteWithquestion('Costs second home');
            _insert('Costs second home', 'None', 'OK');
            //Question No 167
            return homemultipleoptionsContainerNo(
                """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
                "Type of costs",
                [
                  "Dry cleaning costs",
                  "Broadcasting fee",
                  "Second residence tax",
                  "Trips to flat viewings",
                  "Broker’s fee",
                  "Other costs",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                220.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance..deleteWithquestion('Costs second home');
            _insert('Costs second home', 'skip', 'skip');
            //Question No 167
            return homemultipleoptionsContainerNo(
                """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
                "Type of costs",
                [
                  "Dry cleaning costs",
                  "Broadcasting fee",
                  "Second residence tax",
                  "Trips to flat viewings",
                  "Broker’s fee",
                  "Other costs",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                220.0,
                "No",
                Questions.secondHouseHoldText);
          }
        }
      }

      //Answer No 128
      else if (widget.CheckCompleteQuestion ==
              "How much was annual basic rent?" &&
          widget.CheckQuestion == "Basic rent") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //Answer No 129
      else if (widget.CheckCompleteQuestion ==
              "What were ${Questions.homeYourIdentity} ancillary costs?" &&
          widget.CheckQuestion == "Ancillary costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //Answer No 130
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on ${Questions.homeYourIdentity} parking space?" &&
          widget.CheckQuestion == "Parking space") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //====== more than 488 start ====== //
      //Answer No 131
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} spend more than 488 EUR on any piece of furniture or household appliance?" &&
          widget.CheckQuestion == ">488 EUR") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Dryer") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Dryer', 'OK');

            Questions.Appliance = "Dryer";
            //Question No 132
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: dryer</strong></p>
<p>Please enter how much you spent on the dryer. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p><em>&nbsp;</em></p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the dryer?",
                "Amount: dryer",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Refrigerator") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Refrigerator', 'OK');

            Questions.Appliance = "Refrigerator";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Microwave") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Microwave', 'OK');

            Questions.Appliance = "Microwave";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Computer") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Computer', 'OK');

            Questions.Appliance = "Computer";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Computer accessory") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Computer accessory', 'OK');

            Questions.Appliance = "Computer accessory";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "TV") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'TV', 'OK');

            Questions.Appliance = "TV";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Dishwasher") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Dishwasher', 'OK');

            Questions.Appliance = "Dishwasher";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Washing Machine") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Washing Machine', 'OK');

            Questions.Appliance = "Washing Machine";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Bed") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Bed', 'OK');

            Questions.Appliance = "Bed";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Desk") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Desk', 'OK');

            Questions.Appliance = "Desk";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Kitchen") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Kitchen', 'OK');

            Questions.Appliance = "Kitchen";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Wardrobe") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Wardrobe', 'OK');

            Questions.Appliance = "Wardrobe";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Sofa") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Sofa', 'OK');

            Questions.Appliance = "Sofa";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Shelf") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Shelf', 'OK');

            Questions.Appliance = "Shelf";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Other furniture") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Other furniture', 'OK');

            Questions.Appliance = "Other furniture";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'No', 'OK');

            Questions.Appliance = "No";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'skip', 'skip');

            Questions.Appliance = "skip";
            //Question No 132
            return homemultipleoptionsContainerNo(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
                ">952 EUR",
                [
                  "Dryer",
                  "Refrigerator",
                  "Microwave",
                  "Computer",
                  "Computer accessory",
                  "TV",
                  "Dishwasher",
                  "Washing Machine",
                  "Bed",
                  "Table",
                  "Kitchen",
                  "Wardrobe",
                  "Sofa",
                  "Shelves",
                  "Other",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                430.0,
                "No",
                Questions.secondHouseHoldText);
          }
        }
      }

      //====== more than 488 end ====== //

      //====== more than 952 start ====== //

      //Answer No 132
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?" &&
          widget.CheckQuestion == ">952 EUR") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Dryer") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Dryer', 'OK');
            //Question No 133
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: dryer</strong></p>
<p>Please enter how much you spent on the dryer. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p><em>&nbsp;</em></p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} Spend on the dryer?",
                "Amount: dryer",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Refrigerator") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Refrigerator', 'OK');
            //Question No 135
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: refrigerator</strong></p>
<p>Please enter how much you spent on the refrigerator. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the refrigerator?",
                "Amount refrigerator",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Microwave") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Microwave', 'OK');
            //Question No 137
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: microwave</strong></p>
<p>Please enter how much you spent on the microwave. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the microwave?",
                "Amount: microwave",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Computer") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Computer', 'OK');
            //Question No 139
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: computer</strong></p>
<p>Please enter how much you spent on the computer. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the computer?",
                "Amount: computer",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Computer accessory") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Computer accessory', 'OK');
            //Question No 141
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the computer accessory?",
                "Amount: computer accessory",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "TV") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'TV', 'OK');
            //Question No 143
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: television</strong></p>
<p>Please enter how much you spent on the television. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the TV?",
                "Amount: TV",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Dishwasher") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Dishwasher', 'OK');
            //Question No 145
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: dishwasher</strong></p>
<p>Please enter how much you spent on the dishwasher. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the dishwasher?",
                "Amount: dishwasher",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Washing Machine") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Washing Machine', 'OK');
            //Question No 147
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: washing machine</strong></p>
<p>Please enter how much you spent on the washing machine. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the washing machine?",
                "Amount: washing machine",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Bed") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Bed', 'OK');
            //Question No 149
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: bed</strong></p>
<p>Please enter how much you spent on the bed. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the bed?",
                "Amount: bed",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Table") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Table', 'OK');
            //Question No 151
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: table</strong></p>
<p>Please enter how much you spent on the table. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the table?",
                "Amount: table",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Kitchen") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Kitchen', 'OK');
            //Question No 153
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: kitchen</strong></p>
<p>Please enter how much you spent on the kitchen. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the kitchen?",
                "Amount: kitchen",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Wardrobe") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Wardrobe', 'OK');
            //Question No 155
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: wardrobe</strong></p>
<p>Please enter how much you spent on the wardrobe. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the wardrobe?",
                "Amount: wardrobe",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Sofa") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Sofa', 'OK');
            //Question No 157
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: sofa</strong></p>
<p>Please enter how much you spent on the sofa. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the sofa?",
                "Amount: sofa",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Shelves") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Shelves', 'OK');
            //Question No 159
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: shelf</strong></p>
<p>Please enter how much you spent on the shelf. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the shelf?",
                "Amount: shelf",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Other") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'Other', 'OK');
//Question No 161

            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: other fixture</strong></p>
<p>Please enter the type of fixture you bought. Remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p><em>Items like kitchen appliances, beds, tables, and chairs are necessary to maintain a basic standard or living. Items like oriental tapestries and aquariums are not necessary.</em></p>
<p>&nbsp;</p>

""", "", "Home", "Which other fixtures did ${Questions.homeYouIdentity} buy?",
                "Other fixture", 220.0, "", Questions.secondHouseHoldText);
          } else if (Questions.Appliance == "skip") {
            DbHelper.insatance..deleteWithquestion('>488 EUR');
            _insert('>488 EUR', 'skip', 'skip');
            //Question No 167
            return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: other fixture</strong></p>
<p>Please enter the type of fixture you bought. Remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p><em>Items like kitchen appliances, beds, tables, and chairs are necessary to maintain a basic standard or living. Items like oriental tapestries and aquariums are not necessary.</em></p>
<p>&nbsp;</p>

""", "", "Home", "Which other fixtures did ${Questions.homeYouIdentity} buy?",
                "Other fixture", 220.0, "", Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "No") {
            if (Questions.Appliance == "Dryer") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Dryer', 'OK');
              //Question No 133
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: dryer</strong></p>
<p>Please enter how much you spent on the dryer. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p><em>&nbsp;</em></p>
""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the dryer?",
                  "Amount: dryer",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Refrigerator") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Refrigerator', 'OK');
              //Question No 135
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: refrigerator</strong></p>
<p>Please enter how much you spent on the refrigerator. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the refrigerator?",
                  "Amount refrigerator",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Microwave") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Microwave', 'OK');
              //Question No 137
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: microwave</strong></p>
<p>Please enter how much you spent on the microwave. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the microwave?",
                  "Amount: microwave",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Computer") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Computer', 'OK');
              //Question No 139
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: computer</strong></p>
<p>Please enter how much you spent on the computer. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the computer?",
                  "Amount: computer",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Computer accessory") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Computer accessory', 'OK');
              //Question No 141
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: computer accessory</strong></p>
<p>Please enter how much you spent on the computer accessory. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the computer accessory?",
                  "Amount: computer accessory",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "TV") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'TV', 'OK');
              //Question No 143
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: television</strong></p>
<p>Please enter how much you spent on the television. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the TV?",
                  "Amount: TV",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Dishwasher") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Dishwasher', 'OK');
              //Question No 145
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: dishwasher</strong></p>
<p>Please enter how much you spent on the dishwasher. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the dishwasher?",
                  "Amount: dishwasher",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Washing Machine") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Washing Machine', 'OK');
              //Question No 147
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: washing machine</strong></p>
<p>Please enter how much you spent on the washing machine. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the washing machine?",
                  "Amount: washing machine",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Bed") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Bed', 'OK');
              //Question No 149
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: bed</strong></p>
<p>Please enter how much you spent on the bed. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the bed?",
                  "Amount: bed",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Desk") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Desk', 'OK');
              //Question No 151
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: table</strong></p>
<p>Please enter how much you spent on the table. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the table?",
                  "Amount: table",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Kitchen") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Kitchen', 'OK');
              //Question No 153
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: kitchen</strong></p>
<p>Please enter how much you spent on the kitchen. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the kitchen?",
                  "Amount: kitchen",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Wardrobe") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Wardrobe', 'OK');
              //Question No 155
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: wardrobe</strong></p>
<p>Please enter how much you spent on the wardrobe. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the wardrobe?",
                  "Amount: wardrobe",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Sofa") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Sofa', 'OK');
              //Question No 157
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: sofa</strong></p>
<p>Please enter how much you spent on the sofa. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the sofa?",
                  "Amount: sofa",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Shelf") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Shelf', 'OK');
              //Question No 159
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: shelf</strong></p>
<p>Please enter how much you spent on the shelf. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "How much did ${Questions.homeYouIdentity} spend on the shelf?",
                  "Amount: shelf",
                  220.0,
                  "calculation",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "Other furniture") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'Other furniture', 'OK');
              //Question No 161
              return homecalculationContainer("""

<p><strong>Appliances and furnishings in second household: other fixture</strong></p>
<p>Please enter the type of fixture you bought. Remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p><em>Items like kitchen appliances, beds, tables, and chairs are necessary to maintain a basic standard or living. Items like oriental tapestries and aquariums are not necessary.</em></p>
<p>&nbsp;</p>

""", "", "Home", "Which other fixtures did ${Questions.homeYouIdentity} buy?",
                  "Other fixture", 220.0, "", Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "No") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'No', 'OK');
              //Question No 167
              return homemultipleoptionsContainerNo(
                  """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
                  "Type of costs",
                  [
                    "Dry cleaning costs",
                    "Broadcasting fee",
                    "Second residence tax",
                    "Trips to flat viewings",
                    "Broker’s fee",
                    "Other costs",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/disabilityoption.png",
                    "images/disabilityoption.png",
                    "images/disabilityoption.png"
                  ],
                  220.0,
                  "No",
                  Questions.secondHouseHoldText);
            } else if (Questions.Appliance == "skip") {
              DbHelper.insatance..deleteWithquestion('>488 EUR');
              _insert('>488 EUR', 'skip', 'OK');
              //Question No 167
              return homemultipleoptionsContainerNo(
                  """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
                  "",
                  "Home",
                  "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
                  "Type of costs",
                  [
                    "Dry cleaning costs",
                    "Broadcasting fee",
                    "Second residence tax",
                    "Trips to flat viewings",
                    "Broker’s fee",
                    "Other costs",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/disabilityoption.png",
                    "images/disabilityoption.png",
                    "images/disabilityoption.png"
                  ],
                  220.0,
                  "No",
                  Questions.secondHouseHoldText);
            }
          }
        }
      }

      //Dryer Starts

      //Answer No 133
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the dryer?" &&
          widget.CheckQuestion == "Amount: dryer") {
//Question No 134
        return homedateContainer("""

<p><strong>Purchase date: dryer</strong></p>
<p>Please enter when you bought the dryer.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT<strong>) 2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the Dryer?",
            "Date: dryer", 220.0, "", Questions.secondHouseHoldText);
      } else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the Dryer?" &&
          widget.CheckQuestion == "Date: dryer") {
//Question No 134
        return homemultipleoptionsContainerNo(
            "<h1>Coming Soon!</h1>",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} spend more than 952 EUR on any appliance or piece of furniture?",
            ">952 EUR",
            [
              "Dryer",
              "Refrigerator",
              "Microwave",
              "Computer",
              "Computer accessory",
              "TV",
              "Dishwasher",
              "Washing Machine",
              "Bed",
              "Table",
              "Kitchen",
              "Wardrobe",
              "Sofa",
              "Shelves",
              "Other",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            430.0,
            "No",
            Questions.secondHouseHoldText);
      } else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} Spend on the dryer?" &&
          widget.CheckQuestion == "Amount: dryer") {
//Question No 134
        return homedateContainer("""

<p><strong>Purchase date: dryer</strong></p>
<p>Please enter when you bought the dryer.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT<strong>) 2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the dryer?",
            "Date: dryer", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 134
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the dryer?" &&
          widget.CheckQuestion == "Date: dryer") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //Dryer Ends

      //Refrigerator Starts

      //Answer No 135
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the refrigerator?" &&
          widget.CheckQuestion == "Amount refrigerator") {
//Question No 136
        return homedateContainer("""

<p><strong>Purchase date: refrigerator</strong></p>
<p>Please enter when you bought the refrigerator.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the refrigerator?",
            "Date: refrigerator", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 136
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the refrigerator?" &&
          widget.CheckQuestion == "Date: refrigerator") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //Refrigerator Ends

      //Microwave Starts

      //Answer No 137
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the microwave?" &&
          widget.CheckQuestion == "Amount: microwave") {
//Question No 138
        return homedateContainer("""

<p><strong>Purchase date: microwave</strong></p>
<p>Please enter when you bought the microwave.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the microwave?",
            "Date: microwave", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 138
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the microwave?" &&
          widget.CheckQuestion == "Date: microwave") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //Microwave Ends

      //Computer Starts

      //Answer No 141
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the computer accessory?" &&
          widget.CheckQuestion == "Amount: computer accessory") {
//Question No 142
        return homedateContainer("""

<p><strong>Purchase date: computer accessory</strong></p>
<p>Please enter when you bought the computer accessory.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "When did ${Questions.homeYouIdentity} buy the computer accessory?",
            "Date: computer accessory",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 142
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the computer accessory?" &&
          widget.CheckQuestion == "Date: computer accessory") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //Computer Ends

      //Computer accessory Starts

      //Answer No 139
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the computer?" &&
          widget.CheckQuestion == "Amount: computer") {
//Question No 140
        return homedateContainer("""

<p><strong>Purchase date: computer</strong></p>
<p>Please enter when you bought the computer.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the computer?",
            "Date: computer", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 140
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the computer?" &&
          widget.CheckQuestion == "Date: computer") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //Computer accessory Ends

      //TV Starts

      //Answer No 143
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the TV?" &&
          widget.CheckQuestion == "Amount: TV") {
//Question No 144
        return homedateContainer("""

<p><strong>Purchase date: television</strong></p>
<p>Please enter when you bought the television.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the TV?",
            "Date: TV", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 144
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the TV?" &&
          widget.CheckQuestion == "Date: TV") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //TV Ends

      //dishwasher Starts

      //Answer No 145
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the dishwasher?" &&
          widget.CheckQuestion == "Amount: dishwasher") {
//Question No 146
        return homedateContainer("""

<p><strong>Purchase date: dishwasher</strong></p>
<p>Please enter when you bought the dishwasher.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the dishwasher?",
            "Date: dishwasher", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 146
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the dishwasher?" &&
          widget.CheckQuestion == "Date: dishwasher") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //dishwasher Ends

      //washing machine Starts

      //Answer No 147
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the washing machine?" &&
          widget.CheckQuestion == "Amount: washing machine") {
//Question No 148
        return homedateContainer("""

<p><strong>Purchase date: washing machine</strong></p>
<p>Please enter when you bought the washing machine.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "When did ${Questions.homeYouIdentity} buy the washing machine?",
            "Date: washing machine",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 148
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the washing machine?" &&
          widget.CheckQuestion == "Date: washing machine") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //washing machine Ends

      //bed Starts

      //Answer No 149
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the bed?" &&
          widget.CheckQuestion == "Amount: bed") {
//Question No 150
        return homedateContainer("""

<p><strong>Purchase date: bed</strong></p>
<p>Please enter when you bought the bed.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the bed?",
            "Date: bed", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 150
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the bed?" &&
          widget.CheckQuestion == "Date: bed") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //bed Ends

//table Starts

      //Answer No 151
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the table?" &&
          widget.CheckQuestion == "Amount: table") {
//Question No 152
        return homedateContainer("""

<p><strong>Purchase date: table</strong></p>
<p>Please enter when you bought the table.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the table?",
            "Date: table", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 152
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the table?" &&
          widget.CheckQuestion == "Date: table") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //table Ends

      //kitchen Starts

      //Answer No 153
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the kitchen?" &&
          widget.CheckQuestion == "Amount: kitchen") {
//Question No 154

        return homedateContainer("""

<p><strong>Purchase date: kitchen</strong></p>
<p>Please enter when you bought the kitchen.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the kitchen?",
            "Date: kitchen", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 154
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the kitchen?" &&
          widget.CheckQuestion == "Date: kitchen") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //kitchen Ends

      //wardrobe Starts

      //Answer No 155
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the wardrobe?" &&
          widget.CheckQuestion == "Amount: wardrobe") {
//Question No 156
        return homedateContainer("""

<p><strong>Purchase date: wardrobe</strong></p>
<p>Please enter when you bought the wardrobe.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the wardrobe?",
            "Date: wardrobe", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 156
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the wardrobe?" &&
          widget.CheckQuestion == "Date: wardrobe") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //wardrobe Ends

      //sofa Starts

      //Answer No 157
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the sofa?" &&
          widget.CheckQuestion == "Amount: sofa") {
//Question No 158
        return homedateContainer("""

<p><strong>Purchase date: sofa</strong></p>
<p>Please enter when you bought the sofa.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the sofa?",
            "Date: sofa", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 158
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the sofa?" &&
          widget.CheckQuestion == "Date: sofa") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //sofa Ends

      //shelf Starts

      //Answer No 159
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the shelf?" &&
          widget.CheckQuestion == "Amount: shelf") {
//Question No 160
        return homedateContainer("""

<p><strong>Purchase date: shelf</strong></p>
<p>Please enter when you bought the shelf.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before: </strong>488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>

""", "", "Home", "When did ${Questions.homeYouIdentity} buy the shelf?",
            "Date: shelf", 220.0, "", Questions.secondHouseHoldText);
      }

      //Answer No 161
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the shelf?" &&
          widget.CheckQuestion == "Date: shelf") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //shelf Ends

//other fixture Starts

      //Answer No 161
      else if (widget.CheckCompleteQuestion ==
              "Which other fixtures did ${Questions.homeYouIdentity} buy?" &&
          widget.CheckQuestion == "Other fixture") {
//Question No 162
        return homedateContainer("""

<p><strong>Appliances and furnishings in second household: other fixture</strong></p>
<p>Please enter how much you spent on the fixture. Please remember that only expenses from 2019 are relevant.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than: <strong>2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after:</strong> 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
""",
            "",
            "Home",
            "How much did ${Questions.homeYouIdentity} spend on the ${Questions.otherFixture}?",
            "Amount: other",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 162
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.homeYouIdentity} spend on the ${Questions.otherFixture}?" &&
          widget.CheckQuestion == "Amount: other") {
//Question No 163
        return homedateContainer("""

<p><strong>Purchase date: other fixture</strong></p>
<p>Please enter when you bought the fixture.</p>
<p>For second households, the cost of necessary appliances and furnishings is tax deductible. "Necessary" means that you need it in order to maintain a basic standard of living.</p>
<p>Appliances and furnishings must be depreciated over several years if they cost more than<strong>: 2017 and before:</strong> 488 EUR (410 EUR without VAT) <strong>2018 and after</strong>: 952 EUR (800 EUR without VAT)</p>
<p><em>The depreciation amount will be calculated automatically - no action is necessary on your part.</em></p>
<p>&nbsp;</p>
""",
            "",
            "Home",
            "When did ${Questions.homeYouIdentity} buy the ${Questions.otherFixture}?",
            "Date: other",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 163
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.homeYouIdentity} buy the ${Questions.otherFixture}?" &&
          widget.CheckQuestion == "Date: other") {
//        //Question No 166
//        return homecalculationContainer("","Home","What other furnishing costs did ${Questions.homeYouIdentity} have?","Furnishing costs",430.0,"calculation","");
        //Question No 164
        return homeyesnoContainer("""

<p><strong>Appliances and furnishings in second household: depreciation of furniture</strong></p>
<p>We recommend a depreciation period of 10 years.</p>
<p>If this does not seem right, you can choose your own time period. Click, "No". If you agree with our suggestion, then click on the Button.</p>
<p>You can find a list of the usual depreciation ties in the depreciation tables <u>AfA-Tabellen des Bundesfinanzministeriums</u></p>
<p>Appliances and furnishings that cost more than 488 euros (410 euros without VAT) must be depreciated over several years.</p>
<p><em>The depreciation amount will be calculated automatically, you don&rsquo;t have to do anything.</em></p>
<p><em>&nbsp;</em></p>
<p><em>&nbsp;</em></p>

""",
            "",
            "Home",
            "We appreciate ${Questions.homeYouIdentity} depreciate the ${Questions.otherFixture} over a period of 10 years. Do ${Questions.homeYouIdentity} agree?",
            "Usual depreciation",
            220.0,
            "",
            Questions.secondHouseHoldText);
      }

      //Answer No 164

      else if (widget.CheckCompleteQuestion ==
              "We appreciate ${Questions.homeYouIdentity} depreciate the ${Questions.otherFixture} over a period of 10 years. Do ${Questions.homeYouIdentity} agree?" &&
          widget.CheckQuestion == "Usual depreciation") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Usual depreciation');
          _insert('Usual depreciation', 'No', 'OK');
          //Question No 165
          return homecalculationContainer("""
<p><strong>Depreciation period</strong></p>
<p>Please state here over how many years you want to depreciate the object.</p>
<p>If you want to depreciate the object over a shorter period of time, you have to justify this well to the tax office.</p>
<p>We recommend using the predetermined usual service life as the depreciation period.</p>
<p>You can find the usual depreciation periods in the [depreciation tables of the Federal Ministry of finance](http://www.bundesfinanzministerium.de/Content/DE/Standardartikel/Themen/Steuern/Weitere_Steuerthemen/Betriebspruefung/AfA-Tabellen/2000-12-15- AfA-103.PDF? __blob = publicationFile &amp; v = 3)</p>
<p><em>The amount of depreciation is calculated automatically, you don't have to do anything.</em></p>
<p><em>&nbsp;</em></p>

""",
              "",
              "Home",
              "How many years are ${Questions.homeYouIdentity} going to use the ${Questions.otherFixture} for?",
              "Correct depreciation",
              430.0,
              "",
              Questions.secondHouseHoldText);
        }

        if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Usual depreciation');
          _insert('Usual depreciation', 'skip', 'skip');
          //Question No 165
          return homecalculationContainer("""
<p><strong>Depreciation period</strong></p>
<p>Please state here over how many years you want to depreciate the object.</p>
<p>If you want to depreciate the object over a shorter period of time, you have to justify this well to the tax office.</p>
<p>We recommend using the predetermined usual service life as the depreciation period.</p>
<p>You can find the usual depreciation periods in the [depreciation tables of the Federal Ministry of finance](http://www.bundesfinanzministerium.de/Content/DE/Standardartikel/Themen/Steuern/Weitere_Steuerthemen/Betriebspruefung/AfA-Tabellen/2000-12-15- AfA-103.PDF? __blob = publicationFile &amp; v = 3)</p>
<p><em>The amount of depreciation is calculated automatically, you don't have to do anything.</em></p>
<p><em>&nbsp;</em></p>

""",
              "",
              "Home",
              "How many years are ${Questions.homeYouIdentity} going to use the ${Questions.otherFixture} for?",
              "Correct depreciation",
              430.0,
              "",
              Questions.secondHouseHoldText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Usual depreciation');
          _insert('Usual depreciation', 'Yes', 'OK');
          //Question No 166
          return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Home",
              "What other furnishing costs did ${Questions.homeYouIdentity} have?",
              "Furnishing costs",
              430.0,
              "calculation",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 165
      else if (widget.CheckCompleteQuestion ==
              "How many years are ${Questions.homeYouIdentity} going to use the ${Questions.otherFixture} for?" &&
          widget.CheckQuestion == "Correct depreciation") {
        //Question No 166
        return homecalculationContainer("""

<p><strong>Additional costs for furnishings and appliances</strong></p>
<p>Did you have additional costs for furnishings or objects that did not fit in any category so far or that we have forgotten in 2019? Now you have the option to enter these.</p>
<p>Only <strong>necessary</strong> furnishings and appliances are tax deductible.</p>
<p>Items like a kitchen appliance, a bed, a table and chairs are necessary to maintain a basic standard or living.</p>
<p>An oriental tapestry or aquarium are not.</p>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "What other furnishing costs did ${Questions.homeYouIdentity} have?",
            "Furnishing costs",
            430.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

      //Answer No 166
      else if (widget.CheckCompleteQuestion ==
              "What other furnishing costs did ${Questions.homeYouIdentity} have?" &&
          widget.CheckQuestion == "Furnishing costs") {
        //Question No 167
        return homemultipleoptionsContainerNo(
            """

<p><strong>Additional costs</strong></p>
<p>Did you have further costs in 2019?</p>
<p><em>You can specify these here and deduct them. You can select several options.</em></p>
<p><strong>CLEANING COSTS</strong></p>
<p>If you hired someone to clean your second home, you can specify this here.</p>
<p><strong>BROADCASTING FEE</strong></p>
<p>You can also deduct your broadcasting / TV license fee contribution for your second home.</p>
<p><strong>SECOND HOME TAX</strong></p>
<p>Some cities require you to pay a second home tax. If this is the case for you, specify this here.</p>
<p><strong>JOURNEY FOR APARTMENT VIEWING</strong></p>
<p>You can deduct the journey costs for apartment viewings here.</p>
<p><strong>Brokerage fee</strong></p>
<p>You used a broker or estate agent? You can enter the costs here.</p>
<p><strong>Other expenses</strong></p>
<ul>
<li>Paint and decorating costs</li>
<li>Renovations</li>
</ul>
<p>&nbsp;</p>

""",
            "",
            "Home",
            "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?",
            "Type of costs",
            [
              "Dry cleaning costs",
              "Broadcasting fee",
              "Second residence tax",
              "Trips to flat viewings",
              "Broker’s fee",
              "Other costs",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png"
            ],
            220.0,
            "No",
            Questions.secondHouseHoldText);
      }

      //other fixture Ends

      //====== more than 952 end ====== //

      //Double housekeeping start
      //Answer No 167
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} have any other costs due to double housekeeping?" &&
          widget.CheckQuestion == "Type of costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Dry cleaning costs") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert('have any other costs due to double housekeeping?',
                'Dry cleaning costs', 'OK');
            //Question No 168
            return homecalculationContainer("""


<p><strong>Cleaning costs</strong></p>
<p>Please enter the total amount you spent on cleaning costs in 2019.</p>
<p>You can write off cleaning costs as household services. Enter the total amount for 2019. These costs include the following:</p>
<ul>
<li>Cleaning of home</li>
<li>Cleaning carpets or similar</li>
<li>Costs of window cleaning</li>
<li>Cleaning of staircases and other common areas</li>
</ul>
<p><strong>IMPORTANT:</strong></p>
<ul>
<li>Pay by bank transfer</li>
<li>Cash payments are not deductible</li>
<li>Personnel costs are deductible, material costs are not</li>
<li>Payment must have been made in 2019</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p>



""", "", "Home", "How much was the cleaning?", "Cleaning costs", 220.0,
                "calculation", Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Broadcasting fee") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert('have any other costs due to double housekeeping?',
                'Broadcasting fee', 'OK');
            //Question No 169
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on the broadcasting license fee?",
                "Costs broadcasting fee",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Second residence tax") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert('have any other costs due to double housekeeping?',
                'Second residence tax', 'OK');
            //Question No 170
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "How much did ${Questions.homeYouIdentity} spend on taxes for ${Questions.homeYourIdentity} second household?",
                "Second home tax",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Trips to flat viewings") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert('have any other costs due to double housekeeping?',
                'Trips to flat viewings', 'OK');
            //Question No 171
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "How much have ${Questions.homeYouIdentity} spent on journeys to apartment viewings?",
                "Apartment viewings",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Broker’s fee") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert('have any other costs due to double housekeeping?',
                'Broker’s fee', 'OK');
            //Question No 172
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "How much was the brokerage fee?",
                "Broker's fee",
                220.0,
                "calculation",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "Other costs") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert('have any other costs due to double housekeeping?',
                'Other costs', 'OK');
            //Question No 173
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "What type of other costs did ${Questions.homeYouIdentity} had?",
                "Kind of costs",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert('have any other costs due to double housekeeping?', 'skip',
                'OK');
            //Question No 173
            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "What type of other costs did ${Questions.homeYouIdentity} had?",
                "Kind of costs",
                220.0,
                "",
                Questions.secondHouseHoldText);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance
              ..deleteWithquestion(
                  'have any other costs due to double housekeeping?');
            _insert(
                'have any other costs due to double housekeeping?', 'No', 'OK');

            return homecalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Home",
                "How many stays do you have at your second house in a week?",
                "Stays in a week",
                220.0,
                "",
                Questions.secondHouseHoldText);

//             if ((Questions.secondHouseHoldLength <=
//                     Questions.totalSecondHouseHold) &&
//                 Questions.secondHouseHoldLength > 0) {
//               return homethreeoptioncontainer(
//                   """

// <p><strong>Housing situation</strong></p>
// <p>Please specify your living situation. Select the answer that applies to you.</p>
// <p><strong>RENTED APARTMENT</strong></p>
// <p>You're living there in an apartment that you rent.</p>
// <p><strong>OWN APARTMENT</strong></p>
// <p>You live in an apartment which you bought.</p>
// <p><strong>WITH FRIENDS AND FAMILY</strong></p>
// <p>You're living with friends and family.</p>
// <p>&nbsp;</p>

// """,
//                   "",
//                   "Home",
//                   "What is living situation in ${Questions.homeYourIdentity} second household?",
//                   "Living there",
//                   ["Rented apartment", "Own home", "With friends or family"],
//                   220.0,
//                   "",
//                   Questions.secondHouseHoldText);
// //             } else {
// //               // For Partner
// //               if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
// //                   Questions.homePartner == true) {
// //                 homePartner();
// //                 //Question No 98(Partner)
// //                 return homeyesnoContainer("""

// // <p><strong>Second household</strong></p>
// // <p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
// // <p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
// // <p>The center of your life should still be at your primary residence. Please consider the following:</p>
// // <ul>
// // <li>The second household should not be bigger than your main residence.</li>
// // <li>The costs will be mostly accepted if it is a short-term job.</li>
// // <li>When your married your primary residence will be the place of your spouse's residence.</li>
// // <li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
// // <li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
// // </ul>
// // <p>&nbsp;</p>

// // """, "", "Home", "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
// //                     "Second household", 220.0, "", "");
// //               } else {
// //                 return FinishCategory(
// //                     "Home Category", "Work Category", 3, true);
// //               }
// //             }
          }
        }
      } else if (widget.CheckCompleteQuestion ==
              "How many stays do you have at your second house in a week?" &&
          widget.CheckQuestion == "Stays in a week") {
        return homethreeoptioncontainer(
            """<h1>Coming Soon</h1>""",
            "",
            "Home",
            "Did you receive free meals?",
            "Complimentary Meals",
            ["Breakfast", "Lunch", "Dinner"],
            220.0,
            "",
            Questions.secondHouseHoldText);
      } else if (widget.CheckCompleteQuestion ==
              "Did you receive free meals?" &&
          widget.CheckQuestion == "Complimentary Meals") {
        if (widget.CheckAnswer[0] == "Breakfast") {
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "How many breakfast you received?",
              "Breakfast",
              220.0,
              "",
              'calculation');
        } else if (widget.CheckAnswer[0] == "Lunch") {
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "How many lunch you received?",
              "lunch",
              220.0,
              "",
              'calculation');
        } else if (widget.CheckAnswer[0] == "Dinner") {
          return homecalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home",
              "How many Dinner you received?",
              "Dinner",
              220.0,
              "",
              'calculation');
        }
      } else if (widget.CheckQuestion == "Breakfast" ||
          widget.CheckQuestion == "lunch" ||
          widget.CheckQuestion == "Dinner") {
        return FinishCategory("Home Category", "Work Category", 3, true);
      }

      //Answer No 168
      else if (widget.CheckCompleteQuestion == "How much was the cleaning?" &&
          widget.CheckQuestion == "Cleaning costs") {
        if ((Questions.secondHouseHoldLength <=
                Questions.totalSecondHouseHold) &&
            Questions.secondHouseHoldLength > 0) {
          return homethreeoptioncontainer(
              """


<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else {
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        }
      }

      //Answer No 169
      else if ((widget.CheckCompleteQuestion ==
                  "How much did ${Questions.homeYouIdentity} spend on the broadcasting license fee?" ||
              widget.CheckCompleteQuestion ==
                  "How much did you spend on the broadcasting license fee?") &&
          widget.CheckQuestion == "Costs broadcasting fee") {
        if ((Questions.secondHouseHoldLength <=
                Questions.totalSecondHouseHold) &&
            Questions.secondHouseHoldLength > 0) {
          return homethreeoptioncontainer(
              """


<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else {
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else if (Questions.homeSecondHouseholdPartner == true) {
            Questions.homeSecondHouseholdPartner = false;
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        }
      }

      //Answer No 170
      else if ((widget.CheckCompleteQuestion ==
                  "How much did ${Questions.homeYouIdentity} spend on taxes for ${Questions.homeYourIdentity} second household?" ||
              widget.CheckCompleteQuestion ==
                  "How much did you spend on taxes for your second household?") &&
          widget.CheckQuestion == "Second home tax") {
        if ((Questions.secondHouseHoldLength <=
                Questions.totalSecondHouseHold) &&
            Questions.secondHouseHoldLength > 0) {
          return homethreeoptioncontainer(
              """


<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else {
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else if (Questions.homeSecondHouseholdPartner == true) {
            Questions.homeSecondHouseholdPartner = false;
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        }
      }

      //Answer No 171
      else if ((widget.CheckCompleteQuestion ==
                  "How much have ${Questions.homeYouIdentity} spent on journeys to apartment viewings?" ||
              widget.CheckCompleteQuestion ==
                  "How much have you spent on journeys to apartment viewings?") &&
          widget.CheckQuestion == "Apartment viewings") {
        if ((Questions.secondHouseHoldLength <=
                Questions.totalSecondHouseHold) &&
            Questions.secondHouseHoldLength > 0) {
          return homethreeoptioncontainer(
              """


<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else {
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else if (Questions.homeSecondHouseholdPartner == true) {
            Questions.homeSecondHouseholdPartner = false;
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        }
      }

      //Answer No 172
      else if (widget.CheckCompleteQuestion ==
              "How much was the brokerage fee?" &&
          widget.CheckQuestion == "Broker's fee") {
        if ((Questions.secondHouseHoldLength <=
                Questions.totalSecondHouseHold) &&
            Questions.secondHouseHoldLength > 0) {
          return homethreeoptioncontainer(
              """


<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else {
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else if (Questions.homeSecondHouseholdPartner == true) {
            Questions.homeSecondHouseholdPartner = false;
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        }
      }

      //Answer No 173
      else if (widget.CheckCompleteQuestion ==
              "What type of other costs did ${Questions.homeYouIdentity} had?" &&
          widget.CheckQuestion == "Kind of costs") {
        //Question No 174
        return homecalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Home",
            "How much did ${Questions.homeYouIdentity} spend on that?",
            "Amount other",
            220.0,
            "calculation",
            Questions.secondHouseHoldText);
      }

//Answer No 174
      else if ((widget.CheckCompleteQuestion ==
                  "How much did ${Questions.homeYouIdentity} spend on that?" ||
              widget.CheckCompleteQuestion ==
                  "How much did you spend on that?") &&
          widget.CheckQuestion == "Amount other") {
        if ((Questions.secondHouseHoldLength <=
                Questions.totalSecondHouseHold) &&
            Questions.secondHouseHoldLength > 0) {
          return homethreeoptioncontainer(
              """


<p><strong>Housing situation</strong></p>
<p>Please specify your living situation. Select the answer that applies to you.</p>
<p><strong>RENTED APARTMENT</strong></p>
<p>You're living there in an apartment that you rent.</p>
<p><strong>OWN APARTMENT</strong></p>
<p>You live in an apartment which you bought.</p>
<p><strong>WITH FRIENDS AND FAMILY</strong></p>
<p>You're living with friends and family.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
              "",
              "Home",
              "What is living situation in ${Questions.homeYourIdentity} second household?",
              "Living there",
              ["Rented apartment", "Own home", "With friends or family"],
              220.0,
              "",
              Questions.secondHouseHoldText);
        } else {
          // For Partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.homePartner == true) {
            homePartner();
            //Question No 98(Partner)
            return homeyesnoContainer(""" """,
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else if (Questions.homeSecondHouseholdPartner == true) {
            Questions.homeSecondHouseholdPartner = false;
            //Question No 98(Partner)
            return homeyesnoContainer("""
<p><strong>Second household</strong></p>
<p>Please state whether you had a second household in 2019 due to work (you can also have a second household due to your training or study).</p>
<p>The second household should be near your work. Therefore, half of the distance from your primary residence at a max.</p>
<p>The center of your life should still be at your primary residence. Please consider the following:</p>
<ul>
<li>The second household should not be bigger than your main residence.</li>
<li>The costs will be mostly accepted if it is a short-term job.</li>
<li>When your married your primary residence will be the place of your spouse's residence.</li>
<li>You should go to your main residence on a regular basis and spent your free time preferably there.</li>
<li>You should contribute to the running costs of the primary residence of at least 10%. Furthermore, you should be able to verify this.</li>
</ul>
<p>&nbsp;</p>

""",
                "",
                "Home",
                "Did ${Questions.homeYouIdentity} have a second household due to work in 2019?",
                "Second household",
                220.0,
                "",
                "");
          } else {
            return FinishCategory("Home Category", "Work Category", 3, true);
          }
        }
      }

      //Double housekeeping end

      // ====== Costs Second Home Ends ======

      //============= Big Detail (Home End) =========================

      //Minijob Relocation (Relation) Starts

      //Answer No 175
      else if (widget.CheckCompleteQuestion ==
              "Have the costs for ${Questions.homeYourIdentity} relocation been reimbursed?" &&
          widget.CheckQuestion == "Costs reimbursed") {
        //Question No 176
        if (widget.CheckAnswer[0] == "No") {
          return homesixoptioncontainer(
              """

<p><strong>Reason for relocation</strong></p>
<p>In the case of an occupational relocation, the reason can be chosen from the following. If the move was made for private reasons and there are no professional reasons, none of these reasons apply. In this case we will ask separately for the deductible costs.</p>
<p><strong>SAVING 1 HOUR DRIVING TIME PER DAY</strong></p>
<p>The move saved at least one hour of travel time per day. The round trip can be added together. Intermediate journeys (e.g. for lunch) cannot be considered. In case of spouses, the times cannot be added together.</p>
<p><strong>STARTED A NEW JOB</strong></p>
<p>Professionally induced are the expenditures that arise from the start of the job (e.g. a job change to get ahead better in his profession). This also applies to first-time employments.</p>
<p><strong>EMPLOYER MOVED</strong></p>
<p>The employer has relocated its location or place of business.</p>
<p><strong>TRANSFERRED TO ANOTHER LOCATION OF THE EMPLOYER</strong></p>
<p>This can also be within the same city if the commute to work is considerably shortened by the move. If the distance is reduced from 20 to two kilometres, you might have good chances.</p>
<p><strong>IN THE INTEREST OF THE EMPLOYER</strong></p>
<p>Here the employer has a predominantly self-interest. The employer demands, for example, that one should move one's place of residence due to the place of work. In this case a written instruction by the employer or similar should be able to be submitted.</p>
<p><strong>MOVING IN OR OUT OF COMPANY FLAT</strong></p>
<p>This is the case, for example, as a caretaker when you have to move into an employer's apartment. The distance does not matter.</p>
<p>##Other verifiable professional reason The aforementioned reasons do not apply, but there is still a professionally induced move. It should be possible to prove the professional cause. There are, for example, various individual case decisions:</p>
<ul>
<li>A change of the family dwelling within a large city can be occupationally caused (shortening of the way to work around only 9 km), if the way between dwelling and work place must be put back several times daily at the request of the employer (BFH judgement of 10.9.82, BStBl II 83, 16).</li>
<li>After the move, the workplace can be reached more easily by public transport or on foot (FG Rheinland-Pfalz, 21.6.95, EFG 95, 1048).</li>
<li>For the tax recognition of relocation costs, it may also be sufficient that the journey to the place of work is essentially eased by the relocation. This is the case, for example, if traffic conditions are much better after the move (FG Rheinland-Pfalz 25.1.95, EFG 95, 515).</li>
</ul>
<p><strong>Important!</strong></p>
<p>The relocation costs in connection with a double household are not to be recorded here. We will ask for them elsewhere.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

""",
              "",
              "Relocation",
              "What is the reason for ${Questions.homeYourIdentity} relocation No. ${Questions.relocationLength}?",
              "Reason of relocation",
              [
                "Started a new job",
                "Moved in or out of a second household",
                "Saving 1 hour per day",
                "Employer moved",
                "Transferred to other employer’s location",
                "At employer’s request",
                "Moving in or out of company flat",
                "Other provable occupational reasons",
                "None of them"
              ],
              220.0,
              "",
              Questions.relocationText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        }
      }

      //Answer No 176
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.homeYouIdentity} hire a moving company? " &&
          widget.CheckQuestion == "Moving company") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance..deleteWithquestion('Moving company');
          _insert('Moving company', 'No', 'OK');
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance..deleteWithquestion('Moving company');
          _insert('Moving company', 'skip', 'OK');
          //Question No 3
          return homemultitwooptionContainer(
              """
<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
""",
              "",
              "Household services",
              "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
              "Utility bill, 'WEG' statement",
              ["Utility Bill", "Home owner statement ('WEG')", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              430.0,
              "None",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance..deleteWithquestion('Moving company');
          _insert('Moving company', 'Yes', 'OK');
          //Question No 177
          return homecalculationContainer("""


<p><strong>Cost for moving company</strong></p>
<p>Please enter here the total costs for the moving company.</p>
<p>Note that you cannot deduct cash payments. You must have paid the invoice from the moving company in 2019.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
              "",
              "Relocation",
              "How much was the moving company? ",
              "Amount moving company",
              220.0,
              "calculation",
              Questions.secondHouseHoldText);
        }
      }

      //Answer No 177
      else if (widget.CheckCompleteQuestion ==
              "How much was the moving company? " &&
          widget.CheckQuestion == "Amount moving company") {
        //Question No 3
        return homemultitwooptionContainer(
            """


<p><strong>Type of annual statement</strong></p>
<p>Please choose which type of annual invoice you received. This should be the last invoice you received and have not yet written off from your taxes.</p>
<p><strong>ANNUAL UTILITIES STATEMENT</strong></p>
<p>As a tenant you can deduct some of the utilities costs for household services such as craftsmen and the following:</p>
<ul>
<li>maintenance &amp; replacement of meter</li>
<li>clearing gutters</li>
<li>gardening</li>
<li>winter service</li>
<li>maintenance work for heating &amp; water supply</li>
</ul>
<p>Check your last annual utilities statement to see what costs you had and which you can deduct.</p>
<p>If you only recently received the annual utilities statement for 2018, then you can enter this in your tax return. You can also enter several annual utilities statements.</p>
<p><strong>ANNUAL COST STATEMENT OF OWNERS' ASSOCIATION</strong></p>
<p>This is an overview of all income and expenses of the owners' association for a calendar year. The amount owed by each owner is calculated and shown. The expenses are deductible.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>



""",
            "",
            "Household services",
            "Did ${Questions.homeYouIdentity} receive any of the following bills for ${Questions.homeYourIdentity} home?",
            "Utility bill, 'WEG' statement",
            ["Utility Bill", "Home owner statement ('WEG')", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            430.0,
            "None",
            "");
      }

      //Minijob Relocation (Relation) Ends

      //Partner Answer And Questions Starts

      //Answer No 178
      else if (widget.CheckCompleteQuestion ==
              "What is your current address? " &&
          widget.CheckQuestion == "Current address") {
        //yaha add dosri file ma hoa

        //Question No 179
        return homeyesnoContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Home address",
            "Does your partner live somewhere else?",
            "Partner somewhere else",
            220.0,
            "",
            "");
      }

      //Answer No 179
      else if (widget.CheckCompleteQuestion ==
              "Does your partner live somewhere else?" &&
          widget.CheckQuestion == "Partner somewhere else") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion('Does your partner live somewhere else?');
          _insert('Does your partner live somewhere else?', 'No', 'OK');
          //Question No 2(Partner)
          //For No 330.0
          //For yes 220.0
          return homeyesnoContainer("<h1>Coming Soon!</h1>", "", "",
              "Did one or both of you move in 2019?", "Moving", 330.0, "", "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion('Does your partner live somewhere else?');
          _insert('Does your partner live somewhere else?', 'skip', 'skip');
          //Question No 2(Partner)
          //For No 330.0
          //For yes 220.0
          return homeyesnoContainer("<h1>Coming Soon!</h1>", "", "",
              "Did one or both of you move in 2019?", "Moving", 330.0, "", "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion('Does your partner live somewhere else?');
          _insert('Does your partner live somewhere else?', 'Yes', 'OK');
          //Question No 180
          return homeaddressContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Home address",
              "What is your partner's current address?",
              "Current partner's address",
              220.0,
              "",
              "");
        }
      }

      //Answer No 180
      else if (widget.CheckCompleteQuestion ==
              "What is your partner's current address?" &&
          widget.CheckQuestion == "Current partner's address") {
        //Question No 2(Partner)
        //For No 330.0
        //For yes 220.0
        return homeyesnoContainer("<h1>Coming Soon!</h1>", "", "",
            "Did one or both of you move in 2019?", "Moving", 330.0, "", "");
      }

      //Partner Answer And Questions Ends

    }
  }

  Widget homeaddressContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeAddressContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget homeyesnoContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeYesNoContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget homemultitwooptionContainer(
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
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeMultiTwoOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 330.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget homemultipleoptionsContainerNo(
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
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeMultipleOptionsContainerNo(
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

  Widget homecalculationContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeCalculationContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget homesixoptioncontainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeSixOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 430.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget homethreeoptioncontainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeThreeOptionContainer(
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

  Widget homedateContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.homeAnimatedContainer = animatedcontainer;
    return HomeDateContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  void homePartner() {
    qu.HomeAddAnswer("Partner", "", "", "", [], 60.0);
    Questions.homePartner = false;

    Questions.homeYouIdentity = "your partner";
    Questions.homeYourIdentity = "your partner";

    Questions.modeOfTransport = "";
    Questions.Appliance = "";
    Questions.otherFixture = "";
    Questions.totalSecondHouseHold = 0;
    Questions.secondHouseHoldLength = 0;
    Questions.secondHouseHoldText = "";
  }

  void homeYouPartner() {
    qu.HomeAddAnswer("You & Partner", "", "", "", [], 60.0);

    Questions.homeYouIdentity = "you";
    Questions.homeYourIdentity = "your";

    Questions.utilityBillLength = 0;
    Questions.totalUtilityBill = 0;
    Questions.WEGLength = 0;
    Questions.totalWEG = 0;
    Questions.totalRelocation = 0;
    Questions.relocationLength = 0;
    Questions.relocationText = "";
    Questions.totalCraftsmen = 0;
    Questions.craftsmenLength = 0;
    Questions.craftsmenText = "";
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
            Questions.homeAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.homeAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.homeAnswerShow = [];
            Questions.homeAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeMainQuestions(
                  CheckCompleteQuestion: Questions
                      .homeAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.homeAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.homeAnswerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
          height: Questions.homeAnswerShow[currentIndex]['containerheight'],
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
                        Questions.homeAnswerShow[currentIndex]['question'],
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
                            Questions.homeAnswerShow[currentIndex]['answer'][0],
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
            Questions.homeAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.homeAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.homeAnswerShow = [];
            Questions.homeAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeMainQuestions(
                  CheckCompleteQuestion: Questions
                      .homeAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.homeAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.homeAnswerShow[currentIndex - 1]['answer'][0]
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
                          Questions.homeAnswerShow[currentIndex]['question'],
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
                              Questions.homeAnswerShow[currentIndex]['answer']
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
