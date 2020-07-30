import 'package:easy_taxx/livingsituation_flow/container1.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/finishcategory.dart';
import 'package:easy_taxx/education_flow/educationyesnocontainer.dart';
import 'package:easy_taxx/education_flow/educationcalculationcontainer.dart';
import 'package:easy_taxx/education_flow/educationdifferentoptioncontainer.dart';
import 'package:easy_taxx/education_flow/educationmultipleoptionscontainer.dart';
import 'package:easy_taxx/education_flow/educationtwooptioncontainer.dart';
import 'package:easy_taxx/education_flow/educationmultithreecontainer.dart';
import 'package:easy_taxx/education_flow/educationdatecontainer.dart';
import 'package:easy_taxx/education_flow/educationmultitwocontainer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationMainQuestions extends StatefulWidget {
  String CheckCompleteQuestion;
  String CheckQuestion;
  List CheckAnswer;
  bool isdone;

  EducationMainQuestions(
      {Key key,
      this.CheckCompleteQuestion,
      this.CheckQuestion,
      this.CheckAnswer})
      : super(key: key);

  @override
  _EducationMainQuestionsState createState() => _EducationMainQuestionsState();
}

class _EducationMainQuestionsState extends State<EducationMainQuestions> {
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
  String checkFamily = "";

  Future<String> _getStringFamily() async {
    final prefs = await SharedPreferences.getInstance();
    // read
    final String myString = prefs.getString('Family') ?? '';
    if (myString == 'no') {
      setState(() {
        checkFamily = "Family Category";
      });
    } else {
      setState(() {
        checkFamily = "Education Category";
      });
    }

    print(myString);
    print(checkFamily);
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
    _getStringFamily();
    //timer();
    Screenheight();
    DynamicContainer();
  }

  void Screenheight() {
    print("question length:" + Questions.educationAnswerShow.length.toString());

    for (k = l; k < Questions.educationAnswerShow.length; k++) {
      print("how manysdsdsd");
      screenHeightbig = 0.0;
      if (Questions.educationAnswerShow[k]['identity'] == "You" ||
          Questions.educationAnswerShow[k]['identity'] == "You & Partner" ||
          Questions.educationAnswerShow[k]['identity'] == "Partner") {
        screenHeight = screenHeight + 70.0;
      } else if (Questions.educationAnswerShow[k]['details'] == "") {
        screenHeight = screenHeight + 60.0;
        detail = true;
      } else {
        detailsHeight = Questions.educationAnswerShow[k]['details'];

        for (l = k; l < Questions.educationAnswerShow.length; l++) {
          if (Questions.educationAnswerShow[l]['details'] == detailsHeight) {
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
    screenHeight = screenHeight + Questions.educationAnimatedContainer;
    // screenHeight = screenHeight;
    print("Screen Height:" + screenHeight.toString());
//    print("Screen Height big:"+screenHeightbig.toString());

    detail = true;
  }

  void DynamicContainer() {
    hlength = 0;
    // print("question length:"+Questions.answerShow.length.toString());
    for (i = j; i < Questions.educationAnswerShow.length; i++) {
      print("value oif i is:" + i.toString());

      print("dat is:" + i.toString());
      //You and your and your partner identity
      if (Questions.educationAnswerShow[i]['identity'] == "You" ||
          Questions.educationAnswerShow[i]['identity'] == "You & Partner" ||
          Questions.educationAnswerShow[i]['identity'] == "Partner") {
        dynamicContainer.add(Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: Questions.educationAnswerShow[i]['containerheight'],
          width: 450.0,
          child: Text(Questions.educationAnswerShow[i]['identity'],
              style: TextStyle(fontSize: 40.0)),
        ));
      } else if (Questions.educationAnswerShow[i]['details'] == "") {
        dynamicContainer.add(SingleSmallContainer(currentIndex: i));
      }

      //data that contains long container
      else {
        detailOption = Questions.educationAnswerShow[i]['details'];
        print(detailOption);
        countLongContainer = 0;
//print("ahsjasjasksss");

        //set length of data in details that how much data comes
        for (co = i; co < Questions.educationAnswerShow.length; co++) {
          if (Questions.educationAnswerShow[co]['details'] == detailOption) {
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
          if (Questions.educationAnswerShow[j]['details'] == detailOption &&
              detail == true) {
            dynamicContainerbig.add(
              Container(
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
                            Questions.educationAnswerShow[i]['details'],
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
            );

            dynamicContainerbig.add(Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  height: 1.0,
                  color: Colors.grey[200],
                )));
            //so that details data not come again and again
            detail = false;
          }
          // after details data
          if (Questions.educationAnswerShow[j]['details'] == detailOption &&
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
//                            width: 155.0,
//                          //color: Colors.purple,
//                          child:AutoSizeText(Questions.educationAnswerShow[j]['question'],style: TextStyle(color: Colors.grey),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                          ),
//                          Row(children: <Widget>[
//                            //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Colors.lightBlue)),
//                            Container(
//                              width: 140.0,
//                           // color:Colors.blue,
//                            child:AutoSizeText(Questions.educationAnswerShow[j]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
//
//                            ),
//                            SizedBox(width: 5.0,),
//                            Icon(Icons.arrow_forward_ios, size: 12.0,
//                              color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),)
//                          ],)
//                        ],
//                      ))),

                );

            dynamicContainerbig.add(Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  height: j == countLongContainer - 1 ? 0.0 : 1.0,
                  color: Colors.grey[200],
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
                            "Education",
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
                          EducationChangeContainer(),
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

  Widget EducationChangeContainer() {
    if (Questions.educationAnswerShow.length == 0) {
      if (Questions.LivingCheck == 2 || Questions.LivingCheck == 3) {
        qu.EducationAddAnswer("You", "", "", "", [], 60.0);
      }

      //Question No 1
      return educationyesnoContainer("""
<p><strong>Graduated before 2019</strong></p>
<p>Please indicate here whether you have already completed a vocational or academic degree before the year 2019. The length of the training must have been at least 12 months for full-time training and was concluded through a final examination.</p>
<p> </p>


""",
          "",
          "Education",
          "Did ${Questions.educationYouIdentity} complete any degrees or professional qualifications before 2019?",
          "Degree before 2019",
          220.0,
          "",
          "");
    } else {
      //Answer No 1
      if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} complete any degrees or professional qualifications before 2019?" &&
          widget.CheckQuestion == "Degree before 2019") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did complete any degrees or professional qualifications before 2019?');
          _insert(
              'Did complete any degrees or professional qualifications before 2019?',
              'No',
              'OK');

          //Question No 2
          return educationyesnoContainer("""
<p><strong>First degree</strong></p>
<p>Please indicate if you have completed your first degree in the year 2019. The degree counts as a qualification if you have successfully completed vocational training or courses of study that had a minimum duration of 12 months and was concluded through a final examination.</p>
<p>If you do not remember the date of your degree, please check your diploma.</p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} first degree/professional qualification in 2019?",
              "Degree 2019",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did complete any degrees or professional qualifications before 2019?');
          _insert(
              'Did complete any degrees or professional qualifications before 2019?',
              'skip',
              'skip');

          //Question No 2
          return educationyesnoContainer("""
<p><strong>First degree</strong></p>
<p>Please indicate if you have completed your first degree in the year 2019. The degree counts as a qualification if you have successfully completed vocational training or courses of study that had a minimum duration of 12 months and was concluded through a final examination.</p>
<p>If you do not remember the date of your degree, please check your diploma.</p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} first degree/professional qualification in 2019?",
              "Degree 2019",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did complete any degrees or professional qualifications before 2019?');
          _insert(
              'Did complete any degrees or professional qualifications before 2019?',
              'Yes',
              'OK');

          //Question No 3
          return educationyesnoContainer("""
<p><strong>Number of training courses</strong></p>
<p>We need to know whether you attended more than one training course in 2019.</p>
<p>Training courses include, for example:</p>
<ul>
<li>Part-time degree</li>
<li>Distance learning</li>
<li>Master's degree</li>
<li>Further professional training</li>
<li>Training courses at work</li>
</ul>
<p>You will get the chance to deduct expenses in the questions that follow.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} participate in more than one training in 2019?",
              "Multiple training courses",
              220.0,
              "",
              "");
        }
      }

      //Answer No 2
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} first degree/professional qualification in 2019?" &&
          widget.CheckQuestion == "Degree 2019") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did complete first degree/professional qualification in 2019?');
          _insert(
              'Did complete first degree/professional qualification in 2019?',
              'No',
              'OK');
          //Question No 3
          //For No 430.0
          //For Yes 220.0
          return educationyesnoContainer("""
<p><strong>Number of training courses</strong></p>
<p>We need to know whether you attended more than one training course in 2019.</p>
<p>Training courses include, for example:</p>
<ul>
<li>Part-time degree</li>
<li>Distance learning</li>
<li>Master's degree</li>
<li>Further professional training</li>
<li>Training courses at work</li>
</ul>
<p>You will get the chance to deduct expenses in the questions that follow.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} participate in more than one training in 2019?",
              "Multiple training courses",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did complete first degree/professional qualification in 2019?');
          _insert(
              'Did complete first degree/professional qualification in 2019?',
              'skip',
              'skip');

          //Question No 3
          //For No 430.0
          //For Yes 220.0
          return educationyesnoContainer("""
<p><strong>Number of training courses</strong></p>
<p>We need to know whether you attended more than one training course in 2019.</p>
<p>Training courses include, for example:</p>
<ul>
<li>Part-time degree</li>
<li>Distance learning</li>
<li>Master's degree</li>
<li>Further professional training</li>
<li>Training courses at work</li>
</ul>
<p>You will get the chance to deduct expenses in the questions that follow.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} participate in more than one training in 2019?",
              "Multiple training courses",
              220.0,
              "",
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did complete first degree/professional qualification in 2019?');
          _insert(
              'Did complete first degree/professional qualification in 2019?',
              'Yes',
              'OK');
          //Question no 3
          return educationyesnoContainer("""
<p><strong>Number of training courses</strong></p>
<p>We need to know whether you attended more than one training course in 2019.</p>
<p>Training courses include, for example:</p>
<ul>
<li>Part-time degree</li>
<li>Distance learning</li>
<li>Master's degree</li>
<li>Further professional training</li>
<li>Training courses at work</li>
</ul>
<p>You will get the chance to deduct expenses in the questions that follow.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} participate in more than one training in 2019?",
              "Multiple training courses",
              220.0,
              "",
              "");
        }
      }

      //Answer No 3

      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} participate in more than one training in 2019?" &&
          widget.CheckQuestion == "Multiple training courses") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did participate in more than one training in 2019?');
          _insert(
              'Did participate in more than one training in 2019?', 'No', 'OK');

          //Question No 5
          return educationdifferentoptionContainer(
              """
<p><strong>Type of training</strong></p>
<p>Please indicate here the type of training or study.</p>
<p><strong>DUAL STUDIES - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A UNIVERSITY OR COLLEGE AND LEARNED THE PRACTICAL PART IN A COMPANY.</strong></p>
<p><strong>VOCATIONAL TRAINING (AT VOCATIONAL SCHOOL AND IN THE COMPANY) - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A VOCATIONAL SCHOOL AND LEARNED THE PRACTICAL PART IN THE COMPANY WHERE YOU WERE TRAINED.</strong></p>
<p><strong>PART-TIME TRAINING (E.G. DISTANCE LEARNING) - YOU HAVE BEEN ENROLLED AS A STUDENT AT A DISTANCE UNIVERSITY IN ADDITION TO YOUR PROFESSIONAL ACTIVITIES.</strong></p>
<p><strong>FULL-TIME STUDIES - YOU HAVE STUDIED AS A FULL-TIME STUDENT AT A UNIVERSITY OR COLLEGE.</strong></p>
<p><strong>SCHOOL-BASED APPRENTICESHIP - YOU HAVE ATTENDED A TECHNICAL COLLEGE, NOT A UNIVERSITY, FULL-TIME FOR YOUR EDUCATION.</strong></p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?",
              "Kind of training",
              [
                "Dual studies (job and university)",
                "Vocational training (job and school)",
                "Besides job (e.g. distance learning)",
                "Full time study (university only)",
                "School training",
                "None of the above"
              ],
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did participate in more than one training in 2019?');
          _insert('Did participate in more than one training in 2019?', 'skip',
              'skip');

          //Question No 5
          return educationdifferentoptionContainer(
              """
<p><strong>Type of training</strong></p>
<p>Please indicate here the type of training or study.</p>
<p><strong>DUAL STUDIES - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A UNIVERSITY OR COLLEGE AND LEARNED THE PRACTICAL PART IN A COMPANY.</strong></p>
<p><strong>VOCATIONAL TRAINING (AT VOCATIONAL SCHOOL AND IN THE COMPANY) - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A VOCATIONAL SCHOOL AND LEARNED THE PRACTICAL PART IN THE COMPANY WHERE YOU WERE TRAINED.</strong></p>
<p><strong>PART-TIME TRAINING (E.G. DISTANCE LEARNING) - YOU HAVE BEEN ENROLLED AS A STUDENT AT A DISTANCE UNIVERSITY IN ADDITION TO YOUR PROFESSIONAL ACTIVITIES.</strong></p>
<p><strong>FULL-TIME STUDIES - YOU HAVE STUDIED AS A FULL-TIME STUDENT AT A UNIVERSITY OR COLLEGE.</strong></p>
<p><strong>SCHOOL-BASED APPRENTICESHIP - YOU HAVE ATTENDED A TECHNICAL COLLEGE, NOT A UNIVERSITY, FULL-TIME FOR YOUR EDUCATION.</strong></p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?",
              "Kind of training",
              [
                "Dual studies (job and university)",
                "Vocational training (job and school)",
                "Besides job (e.g. distance learning)",
                "Full time study (university only)",
                "School training",
                "None of the above"
              ],
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did participate in more than one training in 2019?');
          _insert('Did participate in more than one training in 2019?', 'Yes',
              'OK');

          //Question No 4
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How many different trainings did ${Questions.educationYouIdentity} participate in during 2019?",
              "Number of training courses",
              430.0,
              "",
              "");
        }
      }

      //Answer No 4
      else if (widget.CheckCompleteQuestion ==
              "How many different trainings did ${Questions.educationYouIdentity} participate in during 2019?" &&
          widget.CheckQuestion == "Number of training courses") {
        //Question No 5

        //For Dual 430.0
        //For Vocational 430.0
        //For rest 220.0
        return educationdifferentoptionContainer(
            """
<p><strong>Type of training</strong></p>
<p>Please indicate here the type of training or study.</p>
<p><strong>DUAL STUDIES - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A UNIVERSITY OR COLLEGE AND LEARNED THE PRACTICAL PART IN A COMPANY.</strong></p>
<p><strong>VOCATIONAL TRAINING (AT VOCATIONAL SCHOOL AND IN THE COMPANY) - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A VOCATIONAL SCHOOL AND LEARNED THE PRACTICAL PART IN THE COMPANY WHERE YOU WERE TRAINED.</strong></p>
<p><strong>PART-TIME TRAINING (E.G. DISTANCE LEARNING) - YOU HAVE BEEN ENROLLED AS A STUDENT AT A DISTANCE UNIVERSITY IN ADDITION TO YOUR PROFESSIONAL ACTIVITIES.</strong></p>
<p><strong>FULL-TIME STUDIES - YOU HAVE STUDIED AS A FULL-TIME STUDENT AT A UNIVERSITY OR COLLEGE.</strong></p>
<p><strong>SCHOOL-BASED APPRENTICESHIP - YOU HAVE ATTENDED A TECHNICAL COLLEGE, NOT A UNIVERSITY, FULL-TIME FOR YOUR EDUCATION.</strong></p>
<p> </p>
<p> </p>

""",
            "",
            "Education",
            "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?",
            "Kind of training",
            [
              "Dual studies (job and university)",
              "Vocational training (job and school)",
              "Besides job (e.g. distance learning)",
              "Full time study (university only)",
              "School training",
              "None of the above"
            ],
            220.0,
            "",
            Questions.trainingText);
      }

//Yaha sa multiple sawal start hoga abhi single ka liya kaam kiya ha
      //Answer No 5
      else if (widget.CheckCompleteQuestion ==
              "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?" &&
          widget.CheckQuestion == "Kind of training") {
        if (widget.CheckAnswer[0] == "Dual studies (job and university)") {
          DbHelper.insatance
              .deleteWithquestion('Which best applies to training?');
          _insert('Which best applies to training?',
              'Dual studies (job and university)', 'OK');
          //Question No 7
          //For None of these 210.0
          //For Travel Costs 430.0
          //For Tuition Fees 220.0
          //For Course material 220.0
          //For Interest on student loan 220.0
          //For Applications 220.0
          //For Student association 220.0
          //For Language course 220.0
          //For University admission lawsuit 220.0
          //For Other costs 220.0
          return educationmultipleoptionsContainer(
              """
<p><strong>Education costs</strong></p>
<p>Choose from the given answers which one best applies to you. You can select several answers here. Note: all costs must have been actually paid by you. Costs that have been reimbursed to you, tax-free, by your employer or a third party (e.g. employment agency) and that you do not have to pay back, cannot be listed here.</p>
<p><strong>FEES</strong></p>
<p>This includes all course, tuition, semester, monthly and tuition fees that have been incurred during your training and further education.</p>
<p><strong>COURSE MATERIAL</strong></p>
<p>These are reference books and magazines that you had to buy for your education and training.</p>
<p><strong>TRAVEL EXPENSES</strong></p>
<p>If you have travelled beyond normal commuting for further education, training courses, learning groups, and courses etc., you can indicate those costs.</p>
<p><strong>EDUCATIONAL LOAN</strong></p>
<p>Indicate the interest you’ve had to pay on any education loan(s) to finance your education and training.</p>
<p><strong>APPLICATIONS FOR FURTHER EDUCATION</strong></p>
<p>If you have applied for further education, training or studies you can state here what you spent on postage, paper, printing, passport photos, etc.</p>
<p><strong>STUDENT ASSOCIATION</strong></p>
<p>If you are a member of a student fraternity or alumni association and pay membership fees you can claim it for tax purposes here.</p>
<p><strong>LANGUAGE COURSE</strong></p>
<p>If you had to attend a language course as a prerequisite for your job or training or if you had to prove mastery of a language by receiving certification, you can indicate the costs here.</p>
<p><strong>OFFICE SUPPLIES</strong></p>
<p>Paper, pens, hole punches, files... for all the materials you need during your education, you can list your costs here.</p>
<p><strong>UNIVERSITY ADMISSION LAWSUIT</strong></p>
<p>If you had to take legal action to ensure your place in a university, you can now claim legal fees and court costs to offset your taxes.</p>
<p><strong>ITEMS FOR EDUCATION</strong></p>
<p>If you bought items for your education, training or studies then you can enter these expenses here. Examples of this include computers, furniture or other similar items.</p>
<p> </p>

""",
              "",
              "Education",
              "What education costs did ${Questions.educationYouIdentity} have?",
              "Type of costs",
              [
                "Travel costs",
                "Tuition fees",
                "Items for education (e.g. computer, office furniture etc.)",
                "Course material",
                "Office supplies",
                "Interest on student loan",
                "Applications",
                "Student association",
                "Language course",
                "University admission lawsuit",
                "Other costs",
                "None of these"
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
                "images/alimonypaidoption.png"
              ],
              220.0,
              "None of these",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] ==
            "Vocational training (job and school)") {
          DbHelper.insatance
              .deleteWithquestion('Which best applies to training?');
          _insert('Which best applies to training?',
              'Vocational training (job and school)', 'OK');
          //Question No 7
          return educationmultipleoptionsContainer(
              """
<p><strong>Education costs</strong></p>
<p>Choose from the given answers which one best applies to you. You can select several answers here. Note: all costs must have been actually paid by you. Costs that have been reimbursed to you, tax-free, by your employer or a third party (e.g. employment agency) and that you do not have to pay back, cannot be listed here.</p>
<p><strong>FEES</strong></p>
<p>This includes all course, tuition, semester, monthly and tuition fees that have been incurred during your training and further education.</p>
<p><strong>COURSE MATERIAL</strong></p>
<p>These are reference books and magazines that you had to buy for your education and training.</p>
<p><strong>TRAVEL EXPENSES</strong></p>
<p>If you have travelled beyond normal commuting for further education, training courses, learning groups, and courses etc., you can indicate those costs.</p>
<p><strong>EDUCATIONAL LOAN</strong></p>
<p>Indicate the interest you’ve had to pay on any education loan(s) to finance your education and training.</p>
<p><strong>APPLICATIONS FOR FURTHER EDUCATION</strong></p>
<p>If you have applied for further education, training or studies you can state here what you spent on postage, paper, printing, passport photos, etc.</p>
<p><strong>STUDENT ASSOCIATION</strong></p>
<p>If you are a member of a student fraternity or alumni association and pay membership fees you can claim it for tax purposes here.</p>
<p><strong>LANGUAGE COURSE</strong></p>
<p>If you had to attend a language course as a prerequisite for your job or training or if you had to prove mastery of a language by receiving certification, you can indicate the costs here.</p>
<p><strong>OFFICE SUPPLIES</strong></p>
<p>Paper, pens, hole punches, files... for all the materials you need during your education, you can list your costs here.</p>
<p><strong>UNIVERSITY ADMISSION LAWSUIT</strong></p>
<p>If you had to take legal action to ensure your place in a university, you can now claim legal fees and court costs to offset your taxes.</p>
<p><strong>ITEMS FOR EDUCATION</strong></p>
<p>If you bought items for your education, training or studies then you can enter these expenses here. Examples of this include computers, furniture or other similar items.</p>
<p> </p>

""",
              "",
              "Education",
              "What education costs did ${Questions.educationYouIdentity} have?",
              "Type of costs",
              [
                "Travel costs",
                "Tuition fees",
                "Items for education (e.g. computer, office furniture etc.)",
                "Course material",
                "Office supplies",
                "Interest on student loan",
                "Applications",
                "Student association",
                "Language course",
                "University admission lawsuit",
                "Other costs",
                "None of these"
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
                "images/alimonypaidoption.png"
              ],
              220.0,
              "None of these",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] ==
            "Besides job (e.g. distance learning)") {
          DbHelper.insatance
              .deleteWithquestion('Which best applies to training?');
          _insert('Which best applies to training?',
              'Besides job (e.g. distance learning)', 'OK');

          //Question No 6
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What is the degree that ${Questions.educationYouIdentity} are currently pursuing called?",
              "Degree",
              430.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] ==
            "Full time study (university only)") {
          DbHelper.insatance
              .deleteWithquestion('Which best applies to training?');
          _insert('Which best applies to training?',
              'Full time study (university only)', 'OK');

          //Question No 6
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What is the degree that ${Questions.educationYouIdentity} are currently pursuing called?",
              "Degree",
              430.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "School training") {
          DbHelper.insatance
              .deleteWithquestion('Which best applies to training?');
          _insert('Which best applies to training?', 'School training', 'OK');

          //Question No 6
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What is the degree that ${Questions.educationYouIdentity} are currently pursuing called?",
              "Degree",
              430.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "None of the above") {
          DbHelper.insatance
              .deleteWithquestion('Which best applies to training?');
          _insert('Which best applies to training?', 'None of the above', 'OK');

          //Question No 6
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What is the degree that ${Questions.educationYouIdentity} are currently pursuing called?",
              "Degree",
              430.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Which best applies to training?');
          _insert('Which best applies to training?', 'skip', 'skip');

          //Question No 6
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What is the degree that ${Questions.educationYouIdentity} are currently pursuing called?",
              "Degree",
              430.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 6
      else if (widget.CheckCompleteQuestion ==
              "What is the degree that ${Questions.educationYouIdentity} are currently pursuing called?" &&
          widget.CheckQuestion == "Degree") {
        DbHelper.insatance.deleteWithquestion(
            'What is the degree that are currently pursuing called?');
        _insert('What is the degree that are currently pursuing called?',
            'Degree', 'OK');

        //Question No 7
        //For None of these 210.0
        //For Travel Costs 430.0
        //For Tuition Fees 220.0
        //For Course material 220.0
        //For Interest on student loan 220.0
        //For Applications 220.0
        //For Student association 220.0
        //For Language course 220.0
        //For University admission lawsuit 220.0
        //For Other costs 220.0
        return educationmultipleoptionsContainer(
            """

<p><strong>Education costs</strong></p>
<p>Choose from the given answers which one best applies to you. You can select several answers here. Note: all costs must have been actually paid by you. Costs that have been reimbursed to you, tax-free, by your employer or a third party (e.g. employment agency) and that you do not have to pay back, cannot be listed here.</p>
<p><strong>FEES</strong></p>
<p>This includes all course, tuition, semester, monthly and tuition fees that have been incurred during your training and further education.</p>
<p><strong>COURSE MATERIAL</strong></p>
<p>These are reference books and magazines that you had to buy for your education and training.</p>
<p><strong>TRAVEL EXPENSES</strong></p>
<p>If you have travelled beyond normal commuting for further education, training courses, learning groups, and courses etc., you can indicate those costs.</p>
<p><strong>EDUCATIONAL LOAN</strong></p>
<p>Indicate the interest you’ve had to pay on any education loan(s) to finance your education and training.</p>
<p><strong>APPLICATIONS FOR FURTHER EDUCATION</strong></p>
<p>If you have applied for further education, training or studies you can state here what you spent on postage, paper, printing, passport photos, etc.</p>
<p><strong>STUDENT ASSOCIATION</strong></p>
<p>If you are a member of a student fraternity or alumni association and pay membership fees you can claim it for tax purposes here.</p>
<p><strong>LANGUAGE COURSE</strong></p>
<p>If you had to attend a language course as a prerequisite for your job or training or if you had to prove mastery of a language by receiving certification, you can indicate the costs here.</p>
<p><strong>OFFICE SUPPLIES</strong></p>
<p>Paper, pens, hole punches, files... for all the materials you need during your education, you can list your costs here.</p>
<p><strong>UNIVERSITY ADMISSION LAWSUIT</strong></p>
<p>If you had to take legal action to ensure your place in a university, you can now claim legal fees and court costs to offset your taxes.</p>
<p><strong>ITEMS FOR EDUCATION</strong></p>
<p>If you bought items for your education, training or studies then you can enter these expenses here. Examples of this include computers, furniture or other similar items.</p>
<p> </p>
""",
            "",
            "Education",
            "What education costs did ${Questions.educationYouIdentity} have?",
            "Type of costs",
            [
              "Travel costs",
              "Tuition fees",
              "Items for education (e.g. computer, office furniture etc.)",
              "Course material",
              "Office supplies",
              "Interest on student loan",
              "Applications",
              "Student association",
              "Language course",
              "University admission lawsuit",
              "Other costs",
              "None of these"
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
              "images/alimonypaidoption.png"
            ],
            220.0,
            "None of these",
            Questions.trainingText);
      } else if (widget.CheckCompleteQuestion ==
              "What is the degree that ${Questions.educationYouIdentity} are currently pursuing called?" &&
          widget.CheckQuestion == "skip") {
        //Question No 7
        //For None of these 210.0
        //For Travel Costs 430.0
        //For Tuition Fees 220.0
        //For Course material 220.0
        //For Interest on student loan 220.0
        //For Applications 220.0
        //For Student association 220.0
        //For Language course 220.0
        //For University admission lawsuit 220.0
        //For Other costs 220.0
        return educationmultipleoptionsContainer(
            """

<p><strong>Education costs</strong></p>
<p>Choose from the given answers which one best applies to you. You can select several answers here. Note: all costs must have been actually paid by you. Costs that have been reimbursed to you, tax-free, by your employer or a third party (e.g. employment agency) and that you do not have to pay back, cannot be listed here.</p>
<p><strong>FEES</strong></p>
<p>This includes all course, tuition, semester, monthly and tuition fees that have been incurred during your training and further education.</p>
<p><strong>COURSE MATERIAL</strong></p>
<p>These are reference books and magazines that you had to buy for your education and training.</p>
<p><strong>TRAVEL EXPENSES</strong></p>
<p>If you have travelled beyond normal commuting for further education, training courses, learning groups, and courses etc., you can indicate those costs.</p>
<p><strong>EDUCATIONAL LOAN</strong></p>
<p>Indicate the interest you’ve had to pay on any education loan(s) to finance your education and training.</p>
<p><strong>APPLICATIONS FOR FURTHER EDUCATION</strong></p>
<p>If you have applied for further education, training or studies you can state here what you spent on postage, paper, printing, passport photos, etc.</p>
<p><strong>STUDENT ASSOCIATION</strong></p>
<p>If you are a member of a student fraternity or alumni association and pay membership fees you can claim it for tax purposes here.</p>
<p><strong>LANGUAGE COURSE</strong></p>
<p>If you had to attend a language course as a prerequisite for your job or training or if you had to prove mastery of a language by receiving certification, you can indicate the costs here.</p>
<p><strong>OFFICE SUPPLIES</strong></p>
<p>Paper, pens, hole punches, files... for all the materials you need during your education, you can list your costs here.</p>
<p><strong>UNIVERSITY ADMISSION LAWSUIT</strong></p>
<p>If you had to take legal action to ensure your place in a university, you can now claim legal fees and court costs to offset your taxes.</p>
<p><strong>ITEMS FOR EDUCATION</strong></p>
<p>If you bought items for your education, training or studies then you can enter these expenses here. Examples of this include computers, furniture or other similar items.</p>
<p> </p>
""",
            "",
            "Education",
            "What education costs did ${Questions.educationYouIdentity} have?",
            "Type of costs",
            [
              "Travel costs",
              "Tuition fees",
              "Items for education (e.g. computer, office furniture etc.)",
              "Course material",
              "Office supplies",
              "Interest on student loan",
              "Applications",
              "Student association",
              "Language course",
              "University admission lawsuit",
              "Other costs",
              "None of these"
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
              "images/alimonypaidoption.png"
            ],
            220.0,
            "None of these",
            Questions.trainingText);
      }

      //Answer No 7

      else if (widget.CheckCompleteQuestion ==
              "What education costs did ${Questions.educationYouIdentity} have?" &&
          widget.CheckQuestion == "Type of costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Travel costs") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'Travel costs', 'OK');

            //Question No 8
            return educationmultipleoptionsContainer(
                """

<p><strong>Education costs</strong></p>
<p>Choose from the given answers which one best applies to you. You can select several answers here. Note: all costs must have been actually paid by you. Costs that have been reimbursed to you, tax-free, by your employer or a third party (e.g. employment agency) and that you do not have to pay back, cannot be listed here.</p>
<p><strong>FEES</strong></p>
<p>This includes all course, tuition, semester, monthly and tuition fees that have been incurred during your training and further education.</p>
<p><strong>COURSE MATERIAL</strong></p>
<p>These are reference books and magazines that you had to buy for your education and training.</p>
<p><strong>TRAVEL EXPENSES</strong></p>
<p>If you have travelled beyond normal commuting for further education, training courses, learning groups, and courses etc., you can indicate those costs.</p>
<p><strong>EDUCATIONAL LOAN</strong></p>
<p>Indicate the interest you’ve had to pay on any education loan(s) to finance your education and training.</p>
<p><strong>APPLICATIONS FOR FURTHER EDUCATION</strong></p>
<p>If you have applied for further education, training or studies you can state here what you spent on postage, paper, printing, passport photos, etc.</p>
<p><strong>STUDENT ASSOCIATION</strong></p>
<p>If you are a member of a student fraternity or alumni association and pay membership fees you can claim it for tax purposes here.</p>
<p><strong>LANGUAGE COURSE</strong></p>
<p>If you had to attend a language course as a prerequisite for your job or training or if you had to prove mastery of a language by receiving certification, you can indicate the costs here.</p>
<p><strong>OFFICE SUPPLIES</strong></p>
<p>Paper, pens, hole punches, files... for all the materials you need during your education, you can list your costs here.</p>
<p><strong>UNIVERSITY ADMISSION LAWSUIT</strong></p>
<p>If you had to take legal action to ensure your place in a university, you can now claim legal fees and court costs to offset your taxes.</p>
<p><strong>ITEMS FOR EDUCATION</strong></p>
<p>If you bought items for your education, training or studies then you can enter these expenses here. Examples of this include computers, furniture or other similar items.</p>
<p> </p>
""",
                "",
                "Education",
                "What kind of trips did ${Questions.educationYouIdentity} take?",
                "Kind of trips",
                [
                  "School/University",
                  "Library outside campus",
                  "Learning community",
                  "Unpaid internship",
                  "Excursion",
                  "Semester abroad"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Tuition fees") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'Tuition fees', 'OK');

            //Question No 9
            return educationcalculationContainer("""

<p><strong>Education costs</strong></p>
<p>Choose from the given answers which one best applies to you. You can select several answers here. Note: all costs must have been actually paid by you. Costs that have been reimbursed to you, tax-free, by your employer or a third party (e.g. employment agency) and that you do not have to pay back, cannot be listed here.</p>
<p><strong>FEES</strong></p>
<p>This includes all course, tuition, semester, monthly and tuition fees that have been incurred during your training and further education.</p>
<p><strong>COURSE MATERIAL</strong></p>
<p>These are reference books and magazines that you had to buy for your education and training.</p>
<p><strong>TRAVEL EXPENSES</strong></p>
<p>If you have travelled beyond normal commuting for further education, training courses, learning groups, and courses etc., you can indicate those costs.</p>
<p><strong>EDUCATIONAL LOAN</strong></p>
<p>Indicate the interest you’ve had to pay on any education loan(s) to finance your education and training.</p>
<p><strong>APPLICATIONS FOR FURTHER EDUCATION</strong></p>
<p>If you have applied for further education, training or studies you can state here what you spent on postage, paper, printing, passport photos, etc.</p>
<p><strong>STUDENT ASSOCIATION</strong></p>
<p>If you are a member of a student fraternity or alumni association and pay membership fees you can claim it for tax purposes here.</p>
<p><strong>LANGUAGE COURSE</strong></p>
<p>If you had to attend a language course as a prerequisite for your job or training or if you had to prove mastery of a language by receiving certification, you can indicate the costs here.</p>
<p><strong>OFFICE SUPPLIES</strong></p>
<p>Paper, pens, hole punches, files... for all the materials you need during your education, you can list your costs here.</p>
<p><strong>UNIVERSITY ADMISSION LAWSUIT</strong></p>
<p>If you had to take legal action to ensure your place in a university, you can now claim legal fees and court costs to offset your taxes.</p>
<p><strong>ITEMS FOR EDUCATION</strong></p>
<p>If you bought items for your education, training or studies then you can enter these expenses here. Examples of this include computers, furniture or other similar items.</p>
<p> </p>
""",
                "",
                "Education",
                "How much were ${Questions.educationYourIdentity} course fees?",
                "Course fees",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] ==
              "Items for education (e.g. computer, office furniture etc.)") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert(
                'What education costs did have?',
                'Items for education (e.g. computer, office furniture etc.)',
                'OK');

            //Question No 99
            //For None of these 320.0
            //For rest 220.0
            return educationmultipleoptionsContainer(
                """
<p><strong>Work equipment</strong></p>
<p>Select from the given answer options those items that were purchased in the year 2019 for education or training. You can select several answers here.</p>
<ul>
<li><strong>Office furniture</strong> - A new or used office chair, desk or shelf was purchased.</li>
<li><strong>Computer/laptop -</strong> A new or used computer / laptop was purchased.</li>
<li><strong>Computer accessories</strong> - These include a printer, keyboard or software.</li>
<li><strong>Tools </strong>- A tool was purchased specifically for the work.</li>
<li><strong>Other</strong> - Click here if the purchased item is not on the list.</li>
</ul>
<p> </p>
<p> </p>


""",
                "",
                "Education",
                "What kind of items did ${Questions.educationYouIdentity} buy in 2019 for training no. ${Questions.trainingLength}?",
                "Item",
                [
                  "Office furniture",
                  "Computer/laptop",
                  "Computer accessories",
                  "Tools",
                  "Other",
                  "None of these"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/disabilityoption.png"
                ],
                220.0,
                "None of these",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Course material") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'Course material', 'OK');

            //Question No 12
            return educationcalculationContainer("""

<p><strong>Expenses for course material</strong></p>
<p>Add the costs you had for course material in 2019 and enter the total here.</p>
<p>You can deduct the following course material, for example:</p>
<ul>
<li>Specialist literature</li>
<li>Scientific journals</li>
<li>Course books</li>
<li>Learning aids</li>
<li>Teaching material</li>
</ul>
<p>If you haven't kept the receipts for proof you can still deduct the standard amount of 80 euros.</p>
<p> </p>
""",
                "",
                "Education",
                "How much have ${Questions.educationYouIdentity} spent on course materials?",
                "Course materials",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Office supplies") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'Office supplies', 'OK');

            //Question No 13
            return educationcalculationContainer("""

<p><strong>Expenses for course material</strong></p>
<p>Add the costs you had for course material in 2019 and enter the total here.</p>
<p>You can deduct the following course material, for example:</p>
<ul>
<li>Specialist literature</li>
<li>Scientific journals</li>
<li>Course books</li>
<li>Learning aids</li>
<li>Teaching material</li>
</ul>
<p>If you haven't kept the receipts for proof you can still deduct the standard amount of 80 euros.</p>
<p> </p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on office supplies?",
                "Office supplies",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Interest on student loan") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?',
                'Interest on student loan', 'OK');

            //Question no 14
            return educationyesnoContainer("""
<p><strong>Costs of student loan</strong></p>
<p>Did you take out a student loan to help finance your education or training and had to repay it in 2019? Then select "yes" if you wish to deduct the interest payments you paid on installments. Otherwise answer "no".</p>
<p>Student loans include:</p>
<ul>
<li>Traditional installment loan (e.g. 'KfW' student loan)</li>
<li>Bridge or short-term loan</li>
<li>Tuition fee loan</li>
<li>Education funds</li>
</ul>
<p> </p>
""",
                "",
                "Education",
                "Did ${Questions.educationYouIdentity} take out a loan to finance the training?",
                "Student loan",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Applications") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'Applications', 'OK');

            //Question no 16
            return educationcalculationContainer("""
<p><strong>Expenses for applications</strong></p>
<p>You can deduct application costs for professional training courses or university courses.</p>
<p>Deductible costs include:</p>
<ul>
<li>Application portfolios</li>
<li>Cv design</li>
<li>Cost of printing</li>
<li>Photos</li>
<li>Paper</li>
<li>Envelopes</li>
<li>Postage</li>
</ul>
<p>Add up your costs and enter the total here. Keep in mind that only expenses from 2019 are relevant.</p>
<p> </p>
<p> </p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on training applications?",
                "Training application expenses",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Student association") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert(
                'What education costs did have?', 'Student association', 'OK');

            //Question no 17
            return educationcalculationContainer("""
<p><strong>Membership fees for student associations</strong></p>
<p>State the amount you paid for membership fees if you were a member of a student association in 2019.</p>
<p>Student associations include:</p>
<ul>
<li>Alumni societies</li>
<li>Fraternities</li>
<li>Other student societies</li>
</ul>
<p> </p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on student associations?",
                "Student organization",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Language course") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'Language course', 'OK');

            //Question no 18
            return educationcalculationContainer("""
<p><strong>Costs for language courses</strong></p>
<p>State the costs you had due to language courses here. Remember, we are talking about 2019.</p>
<p>You can enter costs for the following:</p>
<ul>
<li>Language certificates</li>
<li>Language courses</li>
<li>Exams (for example TOEFL)</li>
</ul>
<p>In order to be tax deductible it is <strong>required</strong> that the language exams were completed on career related grounds.</p>
<p> </p>
<p> </p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on language courses?",
                "Language courses",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "University admission lawsuit") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?',
                'University admission lawsuit', 'OK');

            //Question no 19
            return educationcalculationContainer("""
<p><strong>Costs for university admission lawsuit</strong></p>
<p>Add up the costs you had for a university admission lawsuit in 2019 and enter the total.</p>
<p>This includes all <strong>attorney and court fees</strong> you had due to the lawsuit.</p>
<p>The cost may vary depending on the applicable proceedings and are regulated by law. In principle the cost depends on the amount determined as payable by the responsible administrative courts.</p>
<p> </p>
""",
                "",
                "Education",
                "How much were ${Questions.educationYourIdentity} legal costs for ${Questions.educationYourIdentity} university admission lawsuit?",
                "University admission lawsuit",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Other costs") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'Other costs', 'OK');

            //Question no 20
            return educationcalculationContainer("""
<p><strong>Other costs</strong></p>
<p>Here you can state if you had any other costs for your education. Kindly note that costs for work equipment, such as computers or the like, are requested separately. Therefore, please do not include them here.</p>
<p> </p>
""",
                "",
                "Education",
                "What kind of costs did ${Questions.educationYouIdentity} have?",
                "Kind of costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'skip', 'skip');

            return FinishCategory("Education Category", checkFamily, 4, true);
          } else if (widget.CheckAnswer[m] == "None of these") {
            DbHelper.insatance
                .deleteWithquestion('What education costs did have?');
            _insert('What education costs did have?', 'None of these', 'OK');

            //    Yaha multiple hoga dobara
            if (Questions.trainingLength <= Questions.totalTraining) {
              //Question No 5
              return educationdifferentoptionContainer(
                  """
<p><strong>Type of training</strong></p>
<p>Please indicate here the type of training or study.</p>
<p><strong>DUAL STUDIES - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A UNIVERSITY OR COLLEGE AND LEARNED THE PRACTICAL PART IN A COMPANY.</strong></p>
<p><strong>VOCATIONAL TRAINING (AT VOCATIONAL SCHOOL AND IN THE COMPANY) - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A VOCATIONAL SCHOOL AND LEARNED THE PRACTICAL PART IN THE COMPANY WHERE YOU WERE TRAINED.</strong></p>
<p><strong>PART-TIME TRAINING (E.G. DISTANCE LEARNING) - YOU HAVE BEEN ENROLLED AS A STUDENT AT A DISTANCE UNIVERSITY IN ADDITION TO YOUR PROFESSIONAL ACTIVITIES.</strong></p>
<p><strong>FULL-TIME STUDIES - YOU HAVE STUDIED AS A FULL-TIME STUDENT AT A UNIVERSITY OR COLLEGE.</strong></p>
<p><strong>SCHOOL-BASED APPRENTICESHIP - YOU HAVE ATTENDED A TECHNICAL COLLEGE, NOT A UNIVERSITY, FULL-TIME FOR YOUR EDUCATION.</strong></p>
<p> </p>
<p> </p>


""",
                  "",
                  "Education",
                  "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?",
                  "Kind of training",
                  [
                    "Dual studies (job and university)",
                    "Vocational training (job and school)",
                    "Besides job (e.g. distance learning)",
                    "Full time study (university only)",
                    "School training",
                    "None of the above"
                  ],
                  220.0,
                  "",
                  Questions.trainingText);
            } else {
              //For Partner Relation
              if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
                  Questions.educationPartner == true) {
                educationPartner();
                //Question No 1
                return educationyesnoContainer("""
<p><strong>Graduated before 2019</strong></p>
<p>Please indicate here whether you have already completed a vocational or academic degree before the year 2019. The length of the training must have been at least 12 months for full-time training and was concluded through a final examination.</p>
<p> </p>
""",
                    "",
                    "Education",
                    "Did ${Questions.educationYouIdentity} complete any degrees or professional qualifications before 2019?",
                    "Degree before 2019",
                    220.0,
                    "",
                    "");
              } else {
                return FinishCategory(checkFamily, checkFamily, 4, true);
              }
            }
          }
        }
      }

      // ====== Tuition Fees Start ====== //
      //Answer No 9
      else if (widget.CheckCompleteQuestion ==
              "How much were ${Questions.educationYourIdentity} course fees?" &&
          widget.CheckQuestion == "Course fees") {
//Question No 10
        //For No 210.0
        //For Yes 220.0
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }
// ====== Tuition Fees End ====== //

      //====== Course material Start ====== //
      //Answer No 12
      else if (widget.CheckCompleteQuestion ==
              "How much have ${Questions.educationYouIdentity} spent on course materials?" &&
          widget.CheckQuestion == "Course materials") {
        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== Course material End ====== //

      //====== Office Supplies Start ====== //
      //Answer No 13
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on office supplies?" &&
          widget.CheckQuestion == "Office supplies") {
        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== Office Supplies End ====== //

      //====== Interest on student loan Start ====== //
      //Answer No 14
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} take out a loan to finance the training?" &&
          widget.CheckQuestion == "Student loan") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did take out a loan to finance the training?');
          _insert('Did take out a loan to finance the training?', 'No', 'OK');

//Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did take out a loan to finance the training?');
          _insert(
              'Did take out a loan to finance the training?', 'skip', 'skip');

//Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did take out a loan to finance the training?');
          _insert('Did take out a loan to finance the training?', 'Yes', 'OK');

          //Question No 15
          return educationcalculationContainer("""

<p><strong>Interest on student loan</strong></p>
<p>Interest paid on a student loan is tax deductible.</p>
<p>Please enter the total amount of interest you paid in 2019.</p>
<p>You can find all the necessary information in your loan agreement.</p>
<p> </p>

""",
              "",
              "Education",
              "How much interest did ${Questions.educationYouIdentity} pay?",
              "Amount interest",
              220.0,
              "calculation",
              Questions.trainingText);
        }
      }

      //Answer No 15
      else if (widget.CheckCompleteQuestion ==
              "How much interest did ${Questions.educationYouIdentity} pay?" &&
          widget.CheckQuestion == "Amount interest") {
        DbHelper.insatance.deleteWithquestion('How much interest did pay?');
        _insert('How much interest did pay?', Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== Interest on student loan End ====== //

      //====== Applications Start ====== //
      //Answer No 16
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on training applications?" &&
          widget.CheckQuestion == "Training application expenses") {
        DbHelper.insatance.deleteWithquestion('Training application expenses');
        _insert('Training application expenses', Questions.trainingText, 'OK');
        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== Applications End ====== //

      //====== Student association Start ====== //
      //Answer No 17
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on student associations?" &&
          widget.CheckQuestion == "Student organization") {
        DbHelper.insatance
            .deleteWithquestion('How much did spend on student associations?');
        _insert('How much did spend on student associations?',
            Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== Student association End ====== //

      //====== Language course Start ====== //
      //Answer No 18
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on language courses?" &&
          widget.CheckQuestion == "Language courses") {
        DbHelper.insatance
            .deleteWithquestion('How much did spend on language courses?');
        _insert('How much did spend on language courses?',
            Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== Language course End ====== //

      //====== University admission lawsuit Start ====== //
      //Answer No 19
      else if (widget.CheckCompleteQuestion ==
              "How much were ${Questions.educationYourIdentity} legal costs for ${Questions.educationYourIdentity} university admission lawsuit?" &&
          widget.CheckQuestion == "University admission lawsuit") {
        DbHelper.insatance.deleteWithquestion(
            'How much were legal costs for university admission lawsuit?');
        _insert('How much were legal costs for university admission lawsuit?',
            Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== University admission lawsuit End ====== //

      //====== Other costs Start ====== //
      //Answer No 20
      else if (widget.CheckCompleteQuestion ==
              "What kind of costs did ${Questions.educationYouIdentity} have?" &&
          widget.CheckQuestion == "Kind of costs") {
        DbHelper.insatance.deleteWithquestion('What kind of costs did have?');
        _insert('What kind of costs did have?', Questions.trainingText, 'OK');

        //Question No 21
        return educationcalculationContainer("""

<p><strong>Expenses for applications</strong></p>
<p>You can deduct application costs for professional training courses or university courses.</p>
<p>Deductible costs include:</p>
<ul>
<li>Application portfolios</li>
<li>Cv design</li>
<li>Cost of printing</li>
<li>Photos</li>
<li>Paper</li>
<li>Envelopes</li>
<li>Postage</li>
</ul>
<p>Add up your costs and enter the total here. Keep in mind that only expenses from 2019 are relevant.</p>
<p> </p>
<p> </p>

""",
            "",
            "Education",
            "How much did ${Questions.educationYouIdentity} spend on ${Questions.educationOtherCosts}?",
            "Other costs",
            220.0,
            "calculation",
            Questions.trainingText);
      }

      //Answer No 21
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on ${Questions.educationOtherCosts}?" &&
          widget.CheckQuestion == "Other costs") {
        DbHelper.insatance.deleteWithquestion('How much did spend on?');
        _insert('How much did spend on?', Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //====== Other costs End ====== //

      // ====== Travel Costs Start ======

      //Answer No 8
      else if (widget.CheckCompleteQuestion ==
              "What kind of trips did ${Questions.educationYouIdentity} take?" &&
          widget.CheckQuestion == "Kind of trips") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "School/University") {
            DbHelper.insatance
                .deleteWithquestion('What kind of trips did take?');
            _insert('What kind of trips did take?', 'School/University', 'OK');

            //Question No 22
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How many different routes to school/university did ${Questions.educationYouIdentity} use?",
                "Number of routes",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Library outside campus") {
            DbHelper.insatance
                .deleteWithquestion('What kind of trips did take?');
            _insert(
                'What kind of trips did take?', 'Library outside campus', 'OK');

//Question No 28
            return educationcalculationContainer("""

p><strong>Number of routes</strong></p>
<p>Here you can specify how many different routes have been used to go to libraries outside the campus during the year 2019.</p>
<p>E.g. if you went to two or more different libraries during the year 2019, a corresponding number of routes was used. If a more convenient route was temporarily used due to a construction site, this also increases the number of routes. A relocation or a different start address could also change the route and therefor increase the number of routes.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How many different routes did ${Questions.educationYouIdentity} use to travel to libraries outside ${Questions.educationYourIdentity} campus?",
                "Number of routes",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Learning community") {
            DbHelper.insatance
                .deleteWithquestion('What kind of trips did take?');
            _insert('What kind of trips did take?', 'Learning community', 'OK');

//Question No 37
            return educationcalculationContainer("""
<p><strong>Number of routes</strong></p>
<p>Here you can specify how many different routes have been used to go to learning communities during the year 2019.</p>
<p>E.g. if you went to different places to meet your learning community during the year 2019 a corresponding number of routes was used. A relocation or a different start address could also change the route and therefor increase the number of routes.</p>

""",
                "",
                "Education",
                "How many different routes did ${Questions.educationYouIdentity} use for travels to learning communities?",
                "Number of routes",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Unpaid internship") {
            DbHelper.insatance
                .deleteWithquestion('What kind of trips did take?');
            _insert('What kind of trips did take?', 'Unpaid internship', 'OK');

//Question No 46
            return educationcalculationContainer("""
<p><strong>Number of unpaid internships</strong></p>
<p>Please enter here how many different unpaid internships you participated in 2019.</p>
<p> </p>

""",
                "",
                "Education",
                "How many unpaid internships did ${Questions.educationYouIdentity} participate in?",
                "Number of internships",
                280.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Excursion") {
            DbHelper.insatance
                .deleteWithquestion('What kind of trips did take?');
            _insert('What kind of trips did take?', 'Excursion', 'OK');

//Question No 67
            return educationcalculationContainer("""
<p><strong>Number of excursions</strong></p>
<p>Please enter here to how many different excursions you went to in 2019.</p>
<p> </p>

""",
                "",
                "Education",
                "To how many excursions did ${Questions.educationYouIdentity} go?",
                "Number of excursions",
                280.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Semester abroad") {
            DbHelper.insatance
                .deleteWithquestion('What kind of trips did take?');
            _insert('What kind of trips did take?', 'Semester abroad', 'OK');

//Question No 83
            return educationcalculationContainer("""
<p><strong>Number of semesters abroad</strong></p>
<p>Please enter here how many different semesters abroad you had in 2019.</p>

""",
                "",
                "Education",
                "To how many semester abroad did ${Questions.educationYouIdentity} go?",
                "Number of semester abroad",
                280.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
                .deleteWithquestion('What kind of trips did take?');
            _insert('What kind of trips did take?', 'skip', 'skip');

//Question No 83
            return educationcalculationContainer("""

p><strong>Number of routes</strong></p>
<p>Here you can specify how many different routes have been used to go to libraries outside the campus during the year 2019.</p>
<p>E.g. if you went to two or more different libraries during the year 2019, a corresponding number of routes was used. If a more convenient route was temporarily used due to a construction site, this also increases the number of routes. A relocation or a different start address could also change the route and therefor increase the number of routes.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How many different routes did ${Questions.educationYouIdentity} use to travel to libraries outside ${Questions.educationYourIdentity} campus?",
                "Number of routes",
                220.0,
                "",
                Questions.trainingText);
          }
        }
      }

      // ====== School/University Starts ======= //
      //Answer No 22
      else if (widget.CheckCompleteQuestion ==
              "How many different routes to school/university did ${Questions.educationYouIdentity} use?" &&
          widget.CheckQuestion == "Number of routes") {
        DbHelper.insatance.deleteWithquestion(
            'How many different routes to school/university did use?');
        _insert('How many different routes to school/university did use?',
            Questions.schoolRouteText, 'OK');

        //Ya container baad ma change hoga
        //Question No 23
        return educationcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
            "Distance route no. ${Questions.schoolRouteLength}",
            220.0,
            "",
            Questions.schoolRouteText);
      }

      //Answer No 23
      else if (widget.CheckCompleteQuestion ==
              "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?" &&
          widget.CheckQuestion ==
              "Distance route no. ${Questions.schoolRouteLength}") {
        DbHelper.insatance
            .deleteWithquestion('From where to where did go on route?');
        _insert('From where to where did go on route?',
            Questions.schoolRouteText, 'OK');

        //Question No 24
        return educationcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "How often did ${Questions.educationYouIdentity} use this route in 2019?",
            "Number of drives",
            430.0,
            "",
            Questions.schoolRouteText);
      }

      //Answer No 24
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} use this route in 2019?" &&
          widget.CheckQuestion == "Number of drives") {
        DbHelper.insatance
            .deleteWithquestion('How often did use this route in 2019?');
        _insert('How often did use this route in 2019?',
            Questions.schoolRouteText, 'OK');

        //Question No 25
        return educationmultipleoptionsContainer(
            """
<p><strong>Mode of transport</strong></p>
<p>Please indicate which means of transport you used to get to your training.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went in your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get to your training. This includes taxis.</p>
<p><strong>AIRPLANE</strong></p>
<p>You hopped on a flight. Deduct your flight tickets here.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>ON FOOT</strong></p>
<p>You went to your training on foot.</p>
<p> </p>

""",
            "",
            "Education",
            "How did ${Questions.educationYouIdentity} get there?",
            "Means of transport",
            ["By car", "By public transport", "Bicycle", "on foot"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "",
            Questions.schoolRouteText);
      }

      //Answer No 25
      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.educationYouIdentity} get there?" &&
          widget.CheckQuestion == "Means of transport") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "By car") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'By car', 'OK');

            if (Questions.schoolRouteLength <= Questions.totalSchoolRoute) {
              //Ya container baad ma change hoga
              //Question No 23
              return educationcalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
                  "Distance route no. ${Questions.schoolRouteLength}",
                  220.0,
                  "",
                  Questions.schoolRouteText);
            } else {
              //Question No 10
              return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                  "",
                  "Education",
                  "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                  "Reimbursement of costs",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "By public transport") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'By public transport', 'OK');

            //Question No 26
            return educationyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "Were ${Questions.educationYourIdentity} travel expenses for route no. ${Questions.schoolRouteLength} higher than €1.00?",
                "Higher expenses",
                220.0,
                "",
                Questions.schoolRouteText);
          } else if (widget.CheckAnswer[m] == "Bicycle") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'Bicycle', 'OK');

            if (Questions.schoolRouteLength <= Questions.totalSchoolRoute) {
              //Ya container baad ma change hoga
              //Question No 23
              return educationcalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
                  "Distance route no. ${Questions.schoolRouteLength}",
                  220.0,
                  "",
                  Questions.schoolRouteText);
            } else {
              //Question No 10
              return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                  "",
                  "Education",
                  "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                  "Reimbursement of costs",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "on foot") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'on foot', 'OK');

            if (Questions.schoolRouteLength <= Questions.totalSchoolRoute) {
              //Ya container baad ma change hoga
              //Question No 23
              return educationcalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
                  "Distance route no. ${Questions.schoolRouteLength}",
                  220.0,
                  "",
                  Questions.schoolRouteText);
            } else {
              //Question No 10
              return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                  "",
                  "Education",
                  "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                  "Reimbursement of costs",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('How did get there?');
            _insert('How did get there?', 'skip', 'OK');

            //saif
            if (Questions.schoolRouteLength <= Questions.totalSchoolRoute) {
              //Ya container baad ma change hoga
              //Question No 23
              return educationcalculationContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
                  "Distance route no. ${Questions.schoolRouteLength}",
                  220.0,
                  "",
                  Questions.schoolRouteText);
            } else {
              //Question No 10
              return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                  "",
                  "Education",
                  "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                  "Reimbursement of costs",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 26
      else if (widget.CheckCompleteQuestion ==
              "Were ${Questions.educationYourIdentity} travel expenses for route no. ${Questions.schoolRouteLength} higher than €1.00?" &&
          widget.CheckQuestion == "Higher expenses") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Were travel expenses for route higher than €1.00?');
          _insert(
              'Were travel expenses for route higher than €1.00?', 'No', 'OK');

          if (Questions.schoolRouteLength <= Questions.totalSchoolRoute) {
            //Ya container baad ma change hoga
            //Question No 23
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
                "Distance route no. ${Questions.schoolRouteLength}",
                220.0,
                "",
                Questions.schoolRouteText);
          } else {
            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          }
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Were travel expenses for route higher than €1.00?');
          _insert('Were travel expenses for route higher than €1.00?', 'skip',
              'skip');

          if (Questions.schoolRouteLength <= Questions.totalSchoolRoute) {
            //Ya container baad ma change hoga
            //Question No 23
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
                "Distance route no. ${Questions.schoolRouteLength}",
                220.0,
                "",
                Questions.schoolRouteText);
          } else {
            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Were travel expenses for route higher than €1.00?');
          _insert(
              'Were travel expenses for route higher than €1.00?', 'Yes', 'OK');

          //Question No 27
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much have ${Questions.educationYouIdentity} spent on travels to training?",
              "Travel costs",
              220.0,
              "calculation",
              Questions.schoolRouteText);
        }
      }

      //Answer No 27
      else if (widget.CheckCompleteQuestion ==
              "How much have ${Questions.educationYouIdentity} spent on travels to training?" &&
          widget.CheckQuestion == "Travel costs") {
        if (Questions.schoolRouteLength <= Questions.totalSchoolRoute) {
          //Ya container baad ma change hoga
          //Question No 23
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "From where to where did ${Questions.educationYouIdentity} go on ${Questions.educationYourIdentity} route no. ${Questions.schoolRouteLength}?",
              "Distance route no. ${Questions.schoolRouteLength}",
              220.0,
              "",
              Questions.schoolRouteText);
        } else {
          //Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      // ====== School/University Ends ======= //

// ====== Library outside campus Starts ====== //

//Answer No 28
      else if (widget.CheckCompleteQuestion ==
              "How many different routes did ${Questions.educationYouIdentity} use to travel to libraries outside ${Questions.educationYourIdentity} campus?" &&
          widget.CheckQuestion == "Number of routes") {
        DbHelper.insatance.deleteWithquestion(
            'How many different routes did use to travel to libraries outside campus?');
        _insert(
            'How many different routes did use to travel to libraries outside campus?',
            Questions.libraryRouteText,
            'OK');

        //Question No 29
        return educationmultipleoptionsContainer(
            """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the library.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the library by foot.</p>
<p> </p>
<p> </p>

""",
            "",
            "Education",
            "What route did ${Questions.educationYouIdentity} use to get to the library no. ${Questions.libraryRouteLength}?",
            "Transportation",
            [
              "By car",
              "By public transport",
              "By motorcycle",
              "By bike",
              "By foot"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png"
            ],
            220.0,
            "",
            Questions.libraryRouteText);
      }

//Answer No 29
      else if (widget.CheckCompleteQuestion ==
              "What route did ${Questions.educationYouIdentity} use to get to the library no. ${Questions.libraryRouteLength}?" &&
          widget.CheckQuestion == "Transportation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "By car") {
            DbHelper.insatance.deleteWithquestion(
                'What route did use to get to the library?');
            _insert(
                'What route did use to get to the library?', 'By car', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 30
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "What were the start and end locations for ${Questions.educationYourIdentity} route to the library ${Questions.libraryRouteLength}?",
                "Distance",
                220.0,
                "",
                Questions.libraryRouteText);
          } else if (widget.CheckAnswer[m] == "By public transport") {
            DbHelper.insatance.deleteWithquestion(
                'What route did use to get to the library?');
            _insert('What route did use to get to the library?',
                'By public transport', 'OK');

            //Question No 36
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total for using this route in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total?",
                "Actual costs",
                220.0,
                "calculation",
                Questions.libraryRouteText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'What route did use to get to the library?');
            _insert('What route did use to get to the library?', 'skip', 'OK');

            //skip
            //Question No 36
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total for using this route in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total?",
                "Actual costs",
                220.0,
                "calculation",
                Questions.libraryRouteText);
          } else if (widget.CheckAnswer[m] == "By motorcycle") {
            DbHelper.insatance.deleteWithquestion(
                'What route did use to get to the library?');
            _insert('What route did use to get to the library?',
                'By motorcycle', 'OK');

            //Question No 30
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "What were the start and end locations for ${Questions.educationYourIdentity} route to the library ${Questions.libraryRouteLength}?",
                "Distance",
                220.0,
                "",
                Questions.libraryRouteText);
          } else if (widget.CheckAnswer[m] == "By bike") {
            DbHelper.insatance.deleteWithquestion(
                'What route did use to get to the library?');
            _insert(
                'What route did use to get to the library?', 'By bike', 'OK');

            if (Questions.libraryRouteLength <= Questions.totalLibraryRoute) {
              //Question No 29
              return educationmultipleoptionsContainer(
                  """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the library.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the library by foot.</p>
<p> </p>
<p> </p>

""",
                  "",
                  "Education",
                  "What route did ${Questions.educationYouIdentity} use to get to the library no. ${Questions.libraryRouteLength}?",
                  "Transportation",
                  [
                    "By car",
                    "By public transport",
                    "By motorcycle",
                    "By bike",
                    "By foot"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "",
                  Questions.libraryRouteText);
            } else {
              //Question No 32
              return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>


""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours when going to a library?",
                  "More than 8 hours",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "By foot") {
            DbHelper.insatance.deleteWithquestion(
                'What route did use to get to the library?');
            _insert(
                'What route did use to get to the library?', 'By foot', 'OK');

            if (Questions.libraryRouteLength <= Questions.totalLibraryRoute) {
              //Question No 29
              return educationmultipleoptionsContainer(
                  """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the library.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the library by foot.</p>
<p> </p>
<p> </p>

""",
                  "",
                  "Education",
                  "What route did ${Questions.educationYouIdentity} use to get to the library no. ${Questions.libraryRouteLength}?",
                  "Transportation",
                  [
                    "By car",
                    "By public transport",
                    "By motorcycle",
                    "By bike",
                    "By foot"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "",
                  Questions.libraryRouteText);
            } else {
              //Question No 32
              return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>


""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours when going to a library?",
                  "More than 8 hours",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 30
      else if (widget.CheckCompleteQuestion ==
              "What were the start and end locations for ${Questions.educationYourIdentity} route to the library ${Questions.libraryRouteLength}?" &&
          widget.CheckQuestion == "Distance") {
        DbHelper.insatance.deleteWithquestion(
            'What were the start and end locations for route to the library');
        _insert(
            'What were the start and end locations for route to the library',
            Questions.libraryRouteText,
            'OK');

        //Question No 31
        return educationcalculationContainer("""
<p><strong>Number of trips</strong></p>
<p>Please enter here how often you used this route to go to the library in 2019.</p>
<p>Kindly note that the app will already consider the round trip in case it is applicable.</p>
<p> </p>
""",
            "",
            "Education",
            "How often did ${Questions.educationYouIdentity} use the route no. ${Questions.libraryRouteLength} to the library?",
            "Number of drives",
            220.0,
            "",
            Questions.libraryRouteText);
      }

      //Answer No 31

      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} use the route no. ${Questions.libraryRouteLength - 1} to the library?" &&
          widget.CheckQuestion == "Number of drives") {
        DbHelper.insatance
            .deleteWithquestion('How often did use the route to the library?');
        _insert('How often did use the route to the library?',
            Questions.libraryRouteText, 'OK');

        if (Questions.libraryRouteLength <= Questions.totalLibraryRoute) {
          //Question No 29
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the library.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the library by foot.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "What route did ${Questions.educationYouIdentity} use to get to the library no. ${Questions.libraryRouteLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "",
              Questions.libraryRouteText);
        } else {
          //Question No 32
          return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>


""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours when going to a library?",
              "More than 8 hours",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 32
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours when going to a library?" &&
          widget.CheckQuestion == "More than 8 hours") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have been away from home and campus for more than 8 hours when going to a library?');
          _insert(
              'Have been away from home and campus for more than 8 hours when going to a library?',
              'No',
              'OK');

          //Question No 33
          return educationyesnoContainer("""
<p><strong>Additional travel costs</strong></p>
<p>In case you had any additional costs due to traveling in 2019 this can be stated here.</p>
<p>Additional costs could be:</p>
<ul>
<li>Baggage fees</li>
<li>Professional phone calls</li>
<li>Tolls</li>
<li>Parking fees</li>
<li>Further expenses e.g. petrol cost, visa fees, cost of passport photos or charges for using your credit card abroad</li>
</ul>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} have additional costs due to traveling to libraries, e.g. parking?",
              "Additional costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have been away from home and campus for more than 8 hours when going to a library?');
          _insert(
              'Have been away from home and campus for more than 8 hours when going to a library?',
              'skip',
              'skip');

          //Question No 33
          return educationyesnoContainer("""
<p><strong>Additional travel costs</strong></p>
<p>In case you had any additional costs due to traveling in 2019 this can be stated here.</p>
<p>Additional costs could be:</p>
<ul>
<li>Baggage fees</li>
<li>Professional phone calls</li>
<li>Tolls</li>
<li>Parking fees</li>
<li>Further expenses e.g. petrol cost, visa fees, cost of passport photos or charges for using your credit card abroad</li>
</ul>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} have additional costs due to traveling to libraries, e.g. parking?",
              "Additional costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have been away from home and campus for more than 8 hours when going to a library?');
          _insert(
              'Have been away from home and campus for more than 8 hours when going to a library?',
              'Yes',
              'OK');

          //Question No 34
          return educationcalculationContainer("""
<p><strong>Days with more than 8 hours</strong></p>
<p>Here you can state on how many days you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>


""",
              "",
              "Education",
              "How many days have ${Questions.educationYouIdentity} been away for more than 8 hours when going to a library?",
              "Days at library",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 33
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} have additional costs due to traveling to libraries, e.g. parking?" &&
          widget.CheckQuestion == "Additional costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did have additional costs due to traveling to libraries, e.g. parking?');
          _insert(
              'Did have additional costs due to traveling to libraries, e.g. parking?',
              'No',
              'OK');

          //Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did have additional costs due to traveling to libraries, e.g. parking?');
          _insert(
              'Did have additional costs due to traveling to libraries, e.g. parking?',
              'skip',
              'skip');

          //Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did have additional costs due to traveling to libraries, e.g. parking?');
          _insert(
              'Did have additional costs due to traveling to libraries, e.g. parking?',
              'Yes',
              'OK');

          //Question No 35
          return educationcalculationContainer("""
<p><strong>Total additional costs</strong></p>
<p>Add up your actual costs from 2019 and enter the total here.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>


""",
              "",
              "Education",
              "How much additional costs did ${Questions.educationYouIdentity} have in total due to trips to libraries?",
              "Total additional costs",
              220.0,
              "",
              Questions.trainingText);

          return educationcalculationContainer("""
<p><strong>Days with more than 8 hours</strong></p>
<p>Here you can state on how many days you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>


""",
              "",
              "Education",
              "How many days have ${Questions.educationYouIdentity} been away for more than 8 hours when going to a library?",
              "Days at library",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 34
      else if (widget.CheckCompleteQuestion ==
              "How many days have ${Questions.educationYouIdentity} been away for more than 8 hours when going to a library?" &&
          widget.CheckQuestion == "Days at library") {
        DbHelper.insatance.deleteWithquestion(
            'How many days have been away for more than 8 hours when going to a library?');
        _insert(
            'How many days have been away for more than 8 hours when going to a library?',
            Questions.trainingText,
            'OK');

        //Question No 33
        return educationyesnoContainer("""
<p><strong>Additional travel costs</strong></p>
<p>In case you had any additional costs due to traveling in 2019 this can be stated here.</p>
<p>Additional costs could be:</p>
<ul>
<li>Baggage fees</li>
<li>Professional phone calls</li>
<li>Tolls</li>
<li>Parking fees</li>
<li>Further expenses e.g. petrol cost, visa fees, cost of passport photos or charges for using your credit card abroad</li>
</ul>
<p> </p>


""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} have additional costs due to traveling to libraries, e.g. parking?",
            "Additional costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 35
      else if (widget.CheckCompleteQuestion ==
              "How much additional costs did ${Questions.educationYouIdentity} have in total due to trips to libraries?" &&
          widget.CheckQuestion == "Total additional costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much additional costs did have in total due to trips to libraries?');
        _insert(
            'How much additional costs did have in total due to trips to libraries?',
            Questions.trainingText,
            'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 36
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend in total?" &&
          widget.CheckQuestion == "Actual costs") {
        DbHelper.insatance.deleteWithquestion('How much did spend in total?');
        _insert('How much did spend in total?', Questions.trainingText, 'OK');

        if (Questions.libraryRouteLength <= Questions.totalLibraryRoute) {
          //Question No 29
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the library.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the library by foot.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "What route did ${Questions.educationYouIdentity} use to get to the library no. ${Questions.libraryRouteLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "",
              Questions.libraryRouteText);
        } else {
          //Question No 32
          return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>


""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours when going to a library?",
              "More than 8 hours",
              220.0,
              "",
              Questions.trainingText);
        }
      }

// ====== Library outside campus Ends ====== //

      // ====== Learning Community Starts ====== //

      //Answer No 37
      else if (widget.CheckCompleteQuestion ==
              "How many different routes did ${Questions.educationYouIdentity} use for travels to learning communities?" &&
          widget.CheckQuestion == "Number of routes") {
        DbHelper.insatance.deleteWithquestion(
            'How many different routes did use for travels to learning communities?');
        _insert(
            'How many different routes did use for travels to learning communities?',
            Questions.trainingText,
            'OK');

        //Question No 38
        //For car 220.0
        //For public transport 220.0
        //For Motorcycle 220.0
        //For bike 430.0
        //For foot 430.0
        return educationmultipleoptionsContainer(
            """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the learning community.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This also includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>ON FOOT</strong></p>
<p>You went to the learning community by foot.</p>
<p>--------------</p>
<ol>
<li>Q) How often did you use the route no.1? [learning community]</li>
</ol>
<p><strong>Number of trips</strong></p>
<p>Please enter here how often you used this route to got to the learning community in 2019.</p>
<p>Kindly note that the app will already consider the round trip in case it is applicable.</p>
<p> </p>


""",
            "",
            "Education",
            "How did ${Questions.educationYouIdentity} go to the learning community on route no. ${Questions.learningRouteLength}?",
            "Transportation",
            [
              "By car",
              "By public transport",
              "By motorcycle",
              "By bike",
              "By foot"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/check.png"
            ],
            220.0,
            "",
            Questions.learningRouteText);
      }

      //Answer No 38
      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.educationYouIdentity} go to the learning community on route no. ${Questions.learningRouteLength}?" &&
          widget.CheckQuestion == "Transportation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "By car") {
            DbHelper.insatance.deleteWithquestion(
                'How did go to the learning community on route?');
            _insert('How did go to the learning community on route?', 'By car',
                'OK');

            //Ya container baad ma jaka change hoga
            //Question No 39
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go on route no. ${Questions.learningRouteLength}?",
                "Distance",
                220.0,
                "",
                Questions.learningRouteText);
          } else if (widget.CheckAnswer[m] == "By public transport") {
            DbHelper.insatance.deleteWithquestion(
                'How did go to the learning community on route?');
            _insert('How did go to the learning community on route?',
                'By public transport', 'OK');

//Question No 45
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total for using this route in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for the route no. ${Questions.learningRouteLength}?",
                "Actual costs",
                220.0,
                "",
                Questions.learningRouteText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'How did go to the learning community on route?');
            _insert('How did go to the learning community on route?', 'skip',
                'skip');

//Question No 45
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total for using this route in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for the route no. ${Questions.learningRouteLength}?",
                "Actual costs",
                220.0,
                "",
                Questions.learningRouteText);
          } else if (widget.CheckAnswer[m] == "By motorcycle") {
            DbHelper.insatance.deleteWithquestion(
                'How did go to the learning community on route?');
            _insert('How did go to the learning community on route?',
                'By motorcycle', 'OK');

            //MotorCycle and Car dono ka steps same ha
            //Ya container baad ma jaka change hoga
            //Question No 39
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go on route no. ${Questions.learningRouteLength}?",
                "Distance",
                220.0,
                "",
                Questions.learningRouteText);
          } else if (widget.CheckAnswer[m] == "By bike") {
            DbHelper.insatance.deleteWithquestion(
                'How did go to the learning community on route?');
            _insert('How did go to the learning community on route?', 'By bike',
                'OK');

            if (Questions.learningRouteLength <= Questions.totalLearningRoute) {
              //Question No 38
              return educationmultipleoptionsContainer(
                  """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the learning community.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This also includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>ON FOOT</strong></p>
<p>You went to the learning community by foot.</p>


""",
                  "",
                  "Education",
                  "How did ${Questions.educationYouIdentity} go to the learning community on route no. ${Questions.learningRouteLength}?",
                  "Transportation",
                  [
                    "By car",
                    "By public transport",
                    "By motorcycle",
                    "By bike",
                    "By foot"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "",
                  Questions.learningRouteText);
            } else {
              //Question No 41
              return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening</p>
<p> </p>
<p> </p>


""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours while traveling to a learning community?",
                  "More than 8 hours",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "By foot") {
            DbHelper.insatance.deleteWithquestion(
                'How did go to the learning community on route?');
            _insert('How did go to the learning community on route?', 'By foot',
                'OK');

            if (Questions.learningRouteLength <= Questions.totalLearningRoute) {
              //Question No 38
              return educationmultipleoptionsContainer(
                  """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the learning community.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This also includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>ON FOOT</strong></p>
<p>You went to the learning community by foot.</p>


""",
                  "",
                  "Education",
                  "How did ${Questions.educationYouIdentity} go to the learning community on route no. ${Questions.learningRouteLength}?",
                  "Transportation",
                  [
                    "By car",
                    "By public transport",
                    "By motorcycle",
                    "By bike",
                    "By foot"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "",
                  Questions.learningRouteText);
            } else {
              //Question No 41
              return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening</p>
<p> </p>
<p> </p>


""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours while traveling to a learning community?",
                  "More than 8 hours",
                  220.0,
                  "",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 39
      else if (widget.CheckCompleteQuestion ==
              "From where to where did ${Questions.educationYouIdentity} go on route no. ${Questions.learningRouteLength}?" &&
          widget.CheckQuestion == "Distance") {
        DbHelper.insatance
            .deleteWithquestion('From where to where did go on route?');
        _insert('From where to where did go on route?',
            Questions.learningRouteText, 'OK');

        //Question No 40
        return educationcalculationContainer("""
<p><strong>Number of trips</strong></p>
<p>Please enter here how often you used this route to got to the learning community in 2019.</p>
<p>Kindly note that the app will already consider the round trip in case it is applicable.</p>
<p> </p>


""",
            "",
            "Education",
            "How often did ${Questions.educationYouIdentity} use the route no. ${Questions.learningRouteLength}?",
            "Number of drives",
            220.0,
            "",
            Questions.learningRouteText);
      }

      //Answer No 40
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} use the route no. ${Questions.learningRouteLength - 1}?" &&
          widget.CheckQuestion == "Number of drives") {
        DbHelper.insatance.deleteWithquestion('How often did use the route?');
        _insert(
            'How often did use the route?', Questions.learningRouteText, 'OK');

        if (Questions.learningRouteLength <= Questions.totalLearningRoute) {
          //Question No 38
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the learning community.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This also includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>ON FOOT</strong></p>
<p>You went to the learning community by foot.</p>


""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} go to the learning community on route no. ${Questions.learningRouteLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "",
              Questions.learningRouteText);
        } else {
          //Question No 41
          return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening</p>
<p> </p>


""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours while traveling to a learning community?",
              "More than 8 hours",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 45
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend in total for the route no. ${Questions.learningRouteLength - 1}?" &&
          widget.CheckQuestion == "Actual costs") {
        DbHelper.insatance
            .deleteWithquestion('How much did spend in total for the route?');
        _insert('How much did spend in total for the route?',
            Questions.learningRouteText, 'OK');

        if (Questions.learningRouteLength <= Questions.totalLearningRoute) {
          //Question No 38
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the learning community.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This also includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>ON FOOT</strong></p>
<p>You went to the learning community by foot.</p>


""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} go to the learning community on route no. ${Questions.learningRouteLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "",
              Questions.learningRouteText);
        } else {
          //Question No 41
          return educationyesnoContainer("""
<p><strong>More than 8 hours</strong></p>
<p>Here you can state if you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening</p>
<p> </p>


""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours while traveling to a learning community?",
              "More than 8 hours",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 41
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.educationYouIdentity} been away from home and ${Questions.educationYourIdentity} campus for more than 8 hours while traveling to a learning community?" &&
          widget.CheckQuestion == "More than 8 hours") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have been away from home and campus for more than 8 hours while traveling to a learning community?');
          _insert(
              'Have been away from home and campus for more than 8 hours while traveling to a learning community?',
              'No',
              'OK');

          //Question No 43
          return educationyesnoContainer("""
<p><strong>Additional travel costs</strong></p>
<p>In case you had other costs in 2019 due to your travels this can be stated here.</p>
<p>Additional costs could be:</p>
<ul>
<li>Baggage fees</li>
<li>Professional phone calls</li>
<li>Tolls</li>
<li>Parking fees</li>
<li>Further expenses e.g. petrol cost, visa fees, cost of passport photos or charges for using your credit card abroad</li>
</ul>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to learning communities, e.g. parking?",
              "Additional costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have been away from home and campus for more than 8 hours while traveling to a learning community?');
          _insert(
              'Have been away from home and campus for more than 8 hours while traveling to a learning community?',
              'skip',
              'skip');

          //Question No 43
          return educationyesnoContainer("""
<p><strong>Additional travel costs</strong></p>
<p>In case you had other costs in 2019 due to your travels this can be stated here.</p>
<p>Additional costs could be:</p>
<ul>
<li>Baggage fees</li>
<li>Professional phone calls</li>
<li>Tolls</li>
<li>Parking fees</li>
<li>Further expenses e.g. petrol cost, visa fees, cost of passport photos or charges for using your credit card abroad</li>
</ul>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to learning communities, e.g. parking?",
              "Additional costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have been away from home and campus for more than 8 hours while traveling to a learning community?');
          _insert(
              'Have been away from home and campus for more than 8 hours while traveling to a learning community?',
              'Yes',
              'OK');

//Question No 42
          return educationcalculationContainer("""
<p><strong>Days with more than 8 hours</strong></p>
<p>Here you can state on how many days you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>


""",
              "",
              "Education",
              "How many days, in total during the tax year, have ${Questions.educationYouIdentity} been away for more than 8 hours for study groups?",
              "Days at learning community",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 42
      else if (widget.CheckCompleteQuestion ==
              "How many days, in total during the tax year, have ${Questions.educationYouIdentity} been away for more than 8 hours for study groups?" &&
          widget.CheckQuestion == "Days at learning community") {
        DbHelper.insatance.deleteWithquestion(
            'How many days, in total during the tax year, have been away for more than 8 hours for study groups?');
        _insert(
            'How many days, in total during the tax year, have been away for more than 8 hours for study groups?',
            Questions.trainingText,
            'OK');

        //Question No 43
        return educationyesnoContainer("""
<p><strong>Additional travel costs</strong></p>
<p>In case you had other costs in 2019 due to your travels this can be stated here.</p>
<p>Additional costs could be:</p>
<ul>
<li>Baggage fees</li>
<li>Professional phone calls</li>
<li>Tolls</li>
<li>Parking fees</li>
<li>Further expenses e.g. petrol cost, visa fees, cost of passport photos or charges for using your credit card abroad</li>
</ul>
<p> </p>
<p> </p>


""",
            "",
            "Education",
            "Have ${Questions.educationYouIdentity} had additional costs due to travelling to learning communities, e.g. parking?",
            "Additional costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 43
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to learning communities, e.g. parking?" &&
          widget.CheckQuestion == "Additional costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have had additional costs due to travelling to learning communities, e.g. parking?');
          _insert(
              'Have had additional costs due to travelling to learning communities, e.g. parking?',
              'No',
              'OK');

          //Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have had additional costs due to travelling to learning communities, e.g. parking?');
          _insert(
              'Have had additional costs due to travelling to learning communities, e.g. parking?',
              'skip',
              'skip');

          //Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have had additional costs due to travelling to learning communities, e.g. parking?');
          _insert(
              'Have had additional costs due to travelling to learning communities, e.g. parking?',
              'Yes',
              'OK');

//Question No 44
          return educationcalculationContainer("""
<p><strong>Additional costs</strong></p>
<p>Add up your actual costs from 2019 and enter the total here.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>


""",
              "",
              "Education",
              "How much additional costs have ${Questions.educationYouIdentity} had in total when going to learning communities?",
              "Total additional costs",
              220.0,
              "calculation",
              Questions.trainingText);
        }
      }

      //Answer No 44
      else if (widget.CheckCompleteQuestion ==
              "How much additional costs have ${Questions.educationYouIdentity} had in total when going to learning communities?" &&
          widget.CheckQuestion == "Total additional costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much additional costs have had in total when going to learning communities?');
        _insert(
            'How much additional costs have had in total when going to learning communities?',
            Questions.trainingText,
            'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      // ====== Learning Community Ends ====== //

      // ====== Unpaid internship Starts ====== //

      //Answer No 46
      else if (widget.CheckCompleteQuestion ==
              "How many unpaid internships did ${Questions.educationYouIdentity} participate in?" &&
          widget.CheckQuestion == "Number of internships") {
        DbHelper.insatance.deleteWithquestion(
            'How many unpaid internships did participate in?');
        _insert('How many unpaid internships did participate in?',
            Questions.trainingText, 'OK');

        //Question No 47
        return educationtwooptionContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
            "Destination no. ${Questions.unpaidInternLength}",
            ["Germany", "Abroad"],
            430.0,
            "",
            Questions.unpaidInternText);
      }

      //Answer No 47
      else if (widget.CheckCompleteQuestion ==
              "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion ==
              "Destination no. ${Questions.unpaidInternLength}") {
        if (widget.CheckAnswer[0] == "Germany") {
          DbHelper.insatance
              .deleteWithquestion('Where did complete unpaid internship?');
          _insert('Where did complete unpaid internship?', 'Germany', 'OK');

          //Question No 48
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the unpaid internship.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} get to ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.unpaidInternText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('Where did complete unpaid internship?');
          _insert('Where did complete unpaid internship?', 'skip', 'skip');

          //Question No 48
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the unpaid internship.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} get to ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.unpaidInternText);
        } else if (widget.CheckAnswer[0] == "Abroad") {
          DbHelper.insatance
              .deleteWithquestion('Where did complete unpaid internship?');
          _insert('Where did complete unpaid internship?', 'Abroad', 'OK');

//Question No 48
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the unpaid internship.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went by your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} get to ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.unpaidInternText);
        }
      }

      //Answer No 48
      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.educationYouIdentity} get to ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Transportation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "By car") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'By car', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 49
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go by car/motorcycle to unpaid internship no. ${Questions.unpaidInternLength}?",
                "Distance",
                220.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'skip', 'skip');

            //Ya container baad ma jaka change hoga
            //Question No 49
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go by car/motorcycle to unpaid internship no. ${Questions.unpaidInternLength}?",
                "Distance",
                220.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "By public transport") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'By public transport',
                'OK');

            //Question No 61
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total for using this route in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for going to unpaid internship no. ${Questions.unpaidInternLength}?",
                "Actual costs",
                370.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "By motorcycle") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'By motorcycle', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 49
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go by car/motorcycle to unpaid internship no. ${Questions.unpaidInternLength}?",
                "Distance",
                220.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "By bike") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'By bike', 'OK');

//Question No 51
            return educationmultithreeContainer(
                """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowances can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>


""",
                "",
                "Education",
                "Did any of these absences apply to ${Questions.educationYouIdentity} during ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
                "Absence",
                [
                  "More than 8 hours",
                  "24 hours due to overnight stay",
                  "Arrival/departure days with overnight stay",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "By foot") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'By foot', 'OK');

//Question No 51
            return educationmultithreeContainer(
                """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowances can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>


""",
                "",
                "Education",
                "Did any of these absences apply to ${Questions.educationYouIdentity} during ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
                "Absence",
                [
                  "More than 8 hours",
                  "24 hours due to overnight stay",
                  "Arrival/departure days with overnight stay",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "By plane") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'By plane', 'OK');

            //Question No 61
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total for using this route in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for going to unpaid internship no. ${Questions.unpaidInternLength}?",
                "Actual costs",
                370.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "By ferry") {
            DbHelper.insatance
                .deleteWithquestion('How did get to unpaid internship?');
            _insert('How did get to unpaid internship?', 'By ferry', 'OK');

            //Question No 61
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total for using this route in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for going to unpaid internship no. ${Questions.unpaidInternLength}?",
                "Actual costs",
                370.0,
                "",
                Questions.unpaidInternText);
          }
        }
      }

      //Answer No 49
      else if (widget.CheckCompleteQuestion ==
              "From where to where did ${Questions.educationYouIdentity} go by car/motorcycle to unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Distance") {
        DbHelper.insatance.deleteWithquestion(
            'From where to where did go by car/motorcycle to unpaid internship?');
        _insert(
            'From where to where did go by car/motorcycle to unpaid internship?',
            Questions.unpaidInternText,
            'OK');

        //Question No 50
        return educationcalculationContainer("""
<p><strong>Number of drives</strong></p>
<p>Please enter here how often you used this route to get to the unpaid internship in 2019.</p>
<p>Please note that the app will consider the round trip in the case this applicable.</p>
<p> </p>
<p> </p>


""",
            "",
            "Education",
            "How often did ${Questions.educationYouIdentity} use this route to ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
            "Number of drives",
            370.0,
            "",
            Questions.unpaidInternText);
      }

      //Answer No 50
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} use this route to ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Number of drives") {
        DbHelper.insatance.deleteWithquestion(
            'How often did use this route to unpaid internship?');
        _insert('How often did use this route to unpaid internship?',
            Questions.unpaidInternText, 'OK');

        //Question No 51
        return educationmultithreeContainer(
            """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowances can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>


""",
            "",
            "Education",
            "Did any of these absences apply to ${Questions.educationYouIdentity} during ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
            "Absence",
            [
              "More than 8 hours",
              "24 hours due to overnight stay",
              "Arrival/departure days with overnight stay",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.unpaidInternText);
      }

      //Answer No 61
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend in total for going to unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Actual costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much did spend in total for going to unpaid internship?');
        _insert('How much did spend in total for going to unpaid internship?',
            Questions.unpaidInternText, 'OK');

        //Question No 51
        return educationmultithreeContainer(
            """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowances can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>


""",
            "",
            "Education",
            "Did any of these absences apply to ${Questions.educationYouIdentity} during ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
            "Absence",
            [
              "More than 8 hours",
              "24 hours due to overnight stay",
              "Arrival/departure days with overnight stay",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.unpaidInternText);
      }

      //Answer No 51
      else if (widget.CheckCompleteQuestion ==
              "Did any of these absences apply to ${Questions.educationYouIdentity} during ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Absence") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "More than 8 hours") {
            DbHelper.insatance.deleteWithquestion(
                'Did any of these absences apply to during unpaid internship?');
            _insert(
                'Did any of these absences apply to during unpaid internship?',
                'More than 8 hours',
                'OK');

            //Question No 52
            return educationcalculationContainer("""
<p><strong>Days with more than 8 hours</strong></p>
<p>Here you can state on how many days within the first three months of your unpaid internship you were away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening. For each internship, the period is limited to the first three months.</p>
<p>If there is an interruption of at least four consecutive weeks (e.g. due to illness, holidays, etc.) the period begins again so that the days in the first three months after the interruption can be added to the days above.</p>
<p> </p>


""",
                "",
                "Education",
                "How many times did ${Questions.educationYouIdentity} spend more than 8 hours away from home while participating in an unpaid internship no. ${Questions.unpaidInternLength}?",
                "Days at unpaid internship",
                370.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] ==
              "24 hours due to overnight stay") {
            DbHelper.insatance.deleteWithquestion(
                'Did any of these absences apply to during unpaid internship?');
            _insert(
                'Did any of these absences apply to during unpaid internship?',
                '24 hours due to overnight stay',
                'OK');

            if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
              //Question No 47
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
                  "Destination no. ${Questions.unpaidInternLength}",
                  ["Germany", "Abroad"],
                  220.0,
                  "",
                  Questions.unpaidInternText);
            } else {
              //Question No 55
              return educationmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] ==
              "Arrival/departure days with overnight stay") {
            DbHelper.insatance.deleteWithquestion(
                'Did any of these absences apply to during unpaid internship?');
            _insert(
                'Did any of these absences apply to during unpaid internship?',
                'Arrival/departure days with overnight stay',
                'OK');

//Question No 58
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How many arrival & departure days did ${Questions.educationYouIdentity} have in connection with overnight stays when participating in an unpaid internship no. ${Questions.unpaidInternLength}?",
                "Arrival/departure days",
                220.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Did any of these absences apply to during unpaid internship?');
            _insert(
                'Did any of these absences apply to during unpaid internship?',
                'No',
                'OK');

            if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
              //Question No 47
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
                  "Destination no. ${Questions.unpaidInternLength}",
                  ["Germany", "Abroad"],
                  220.0,
                  "",
                  Questions.unpaidInternText);
            } else {
              //Question No 55
              return educationmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Did any of these absences apply to during unpaid internship?');
            _insert(
                'Did any of these absences apply to during unpaid internship?',
                'skip',
                'skip');

            if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
              //Question No 47
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
                  "Destination no. ${Questions.unpaidInternLength}",
                  ["Germany", "Abroad"],
                  220.0,
                  "",
                  Questions.unpaidInternText);
            } else {
              //Question No 55
              return educationmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 52

      else if (widget.CheckCompleteQuestion ==
              "How many times did ${Questions.educationYouIdentity} spend more than 8 hours away from home while participating in an unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Days at unpaid internship") {
        DbHelper.insatance.deleteWithquestion('Days at unpaid internship');
        _insert('Days at unpaid internship', Questions.unpaidInternText, 'OK');

        //Question No 53
        //For No 280.0
        //For rest 220.0
        return educationmultithreeContainer(
            """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>


""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} receive free meals?",
            "Free meals",
            ["Breakfast", "Lunch", "Dinner", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.unpaidInternText);
      }

      //Answer No 53
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} receive free meals?" &&
          widget.CheckQuestion == "Free meals" &&
          Questions.unpaidInternText.contains("UNPAID INTERNSHIP")) {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Breakfast") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'Breakfast', 'OK');

            //Question No 54
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?",
                "Number of breakfast",
                370.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "Lunch") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'Lunch', 'OK');

            //Question No 56
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary lunch?",
                "Number of lunch",
                370.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "Dinner") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'Dinner', 'OK');

//Question No 57
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary dinner?",
                "Number of dinner",
                370.0,
                "",
                Questions.unpaidInternText);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'No', 'OK');

            if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
              //Question No 47
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
                  "Destination no. ${Questions.unpaidInternLength}",
                  ["Germany", "Abroad"],
                  220.0,
                  "",
                  Questions.unpaidInternText);
            } else {
              //Question No 55
              return educationmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'skip', 'skip');

            if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
              //Question No 47
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
                  "Destination no. ${Questions.unpaidInternLength}",
                  ["Germany", "Abroad"],
                  220.0,
                  "",
                  Questions.unpaidInternText);
            } else {
              //Question No 55
              return educationmultipleoptionsContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 54
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?" &&
          widget.CheckQuestion == "Number of breakfast" &&
          Questions.unpaidInternText.contains("UNPAID INTERNSHIP")) {
        DbHelper.insatance
            .deleteWithquestion('receive complimentary breakfast?');
        _insert('receive complimentary breakfast?', Questions.unpaidInternText,
            'OK');

        if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
          //Question No 47
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
              "Destination no. ${Questions.unpaidInternLength}",
              ["Germany", "Abroad"],
              220.0,
              "",
              Questions.unpaidInternText);
        } else {
          //Question No 55
          return educationmultipleoptionsContainer(
              """
<p><strong>Accommodation costs</strong></p>
<p>Here you can state if you had costs due to overnight stays outside your flat. This could be the case if you stayed in a hotel or similar. It is also possible to state rent here in the case you had to temporarily lease another apartment due to your internship.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 56
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary lunch?" &&
          widget.CheckQuestion == "Number of lunch" &&
          Questions.unpaidInternText.contains("UNPAID INTERNSHIP")) {
        DbHelper.insatance.deleteWithquestion('receive complimentary lunch?');
        _insert(
            'receive complimentary lunch?', Questions.unpaidInternText, 'OK');

        if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
          //Question No 47
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
              "Destination no. ${Questions.unpaidInternLength}",
              ["Germany", "Abroad"],
              220.0,
              "",
              Questions.unpaidInternText);
        } else {
          //Question No 55
          return educationmultipleoptionsContainer(
              """
<p><strong>Accommodation costs</strong></p>
<p>Here you can state if you had costs due to overnight stays outside your flat. This could be the case if you stayed in a hotel or similar. It is also possible to state rent here in the case you had to temporarily lease another apartment due to your internship.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 57
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary dinner?" &&
          widget.CheckQuestion == "Number of dinner" &&
          Questions.unpaidInternText.contains("UNPAID INTERNSHIP")) {
        DbHelper.insatance.deleteWithquestion('receive complimentary dinner?');
        _insert(
            'receive complimentary dinner?', Questions.unpaidInternText, 'OK');

        if (Questions.unpaidInternLength <= Questions.totalUnpaidIntern) {
          //Question No 47
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} complete ${Questions.educationYourIdentity} unpaid internship no. ${Questions.unpaidInternLength}?",
              "Destination no. ${Questions.unpaidInternLength}",
              ["Germany", "Abroad"],
              220.0,
              "",
              Questions.unpaidInternText);
        } else {
          //Question No 55
          return educationmultipleoptionsContainer(
              """
<p><strong>Accommodation costs</strong></p>
<p>Here you can state if you had costs due to overnight stays outside your flat. This could be the case if you stayed in a hotel or similar. It is also possible to state rent here in the case you had to temporarily lease another apartment due to your internship.</p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 58
      else if (widget.CheckCompleteQuestion ==
              "How many arrival & departure days did ${Questions.educationYouIdentity} have in connection with overnight stays when participating in an unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Arrival/departure days") {
        DbHelper.insatance.deleteWithquestion(
            'How many arrival & departure days did have in connection with overnight stays when participating in an unpaid internship?');
        _insert(
            'How many arrival & departure days did have in connection with overnight stays when participating in an unpaid internship?',
            Questions.unpaidInternText,
            'OK');

        //Question No 59
        return educationyesnoContainer("""
<p><strong>Accommodation costs</strong></p>
<p>Here you can state if you had costs due to overnight stays outside your flat. This could be the case if you stayed in a hotel or similar. It is also possible to state rent here in the case you had to temporarily lease another apartment due to your internship.</p>
<p> </p>


""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} have accommodation costs while participating in an unpaid internship no. ${Questions.unpaidInternLength}?",
            "Accommodation costs",
            220.0,
            "",
            Questions.unpaidInternText);
      }

      //Answer No 59
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} have accommodation costs while participating in an unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Accommodation costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'have accommodation costs while participating in an unpaid internship?');
          _insert(
              'have accommodation costs while participating in an unpaid internship?',
              'No',
              'OK');

          //Question No 53
          return educationmultithreeContainer(
              """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} receive free meals?",
              "Free meals",
              ["Breakfast", "Lunch", "Dinner", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.unpaidInternText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'have accommodation costs while participating in an unpaid internship?');
          _insert(
              'have accommodation costs while participating in an unpaid internship?',
              'skip',
              'skip');
          //Question No 53
          return educationmultithreeContainer(
              """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} receive free meals?",
              "Free meals",
              ["Breakfast", "Lunch", "Dinner", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.unpaidInternText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'have accommodation costs while participating in an unpaid internship?');
          _insert(
              'have accommodation costs while participating in an unpaid internship?',
              'Yes',
              'OK');

          //Question No 60
          return educationcalculationContainer("""
<p><strong>Amount accommodation costs</strong></p>
<p>Add up your actual costs from 2019 and enter the total here.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>


""",
              "",
              "Education",
              "How much did ${Questions.educationYouIdentity} spend in total on accommodation while participating in an unpaid internship no. ${Questions.unpaidInternLength}?",
              "Amount accommodation costs",
              260.0,
              "",
              Questions.unpaidInternText);
        }
      }

      //Answer No 60
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend in total on accommodation while participating in an unpaid internship no. ${Questions.unpaidInternLength}?" &&
          widget.CheckQuestion == "Amount accommodation costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much did spend in total on accommodation while participating in an unpaid internship?');
        _insert(
            'How much did spend in total on accommodation while participating in an unpaid internship?',
            Questions.unpaidInternText,
            'OK');

        //Question No 53
        return educationmultithreeContainer(
            """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>


""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} receive free meals?",
            "Free meals",
            ["Breakfast", "Lunch", "Dinner", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.unpaidInternText);
      }

      //Answer No 55
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} have any additional costs while traveling to the unpaid internships?" &&
          widget.CheckQuestion == "Additional costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Parking") {
            DbHelper.insatance.deleteWithquestion(
                'Did have any additional costs while traveling to the unpaid internships?');
            _insert(
                'Did have any additional costs while traveling to the unpaid internships?',
                'Parking',
                'OK');

            //Question No 62
            return educationcalculationContainer("""
<p><strong>Parking fees</strong></p>
<p>Please enter the total costs resulting from parking charges. Remember, only expenses from 2019 are relevant.</p>
<p>The expenses for <strong>parking spaces and car parks</strong> are deductible.                   </p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for parking?",
                "Parking costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Baggage") {
            DbHelper.insatance.deleteWithquestion(
                'Did have any additional costs while traveling to the unpaid internships?');
            _insert(
                'Did have any additional costs while traveling to the unpaid internships?',
                'Baggage',
                'OK');

            //Question No 63
            return educationcalculationContainer("""
<p><strong>Baggage fees</strong></p>
<p>Please enter the total amount spent on baggage fees. Please note only expenses from 2019 are relevant.</p>
<p>Baggage fees may be charged for transportation of baggage by an <strong>airline or bus company.</strong></p>
<p>Baggage fees may also be charged if you store your baggage in a <strong>locker</strong>.</p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for baggage?",
                "Baggage costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Toll") {
            DbHelper.insatance.deleteWithquestion(
                'Did have any additional costs while traveling to the unpaid internships?');
            _insert(
                'Did have any additional costs while traveling to the unpaid internships?',
                'Toll',
                'OK');

            //Question No 64
            return educationcalculationContainer("""
<p><strong>Tolls charges</strong></p>
<p>Please enter the total costs resulting from toll charges. Remember, only expenses from 2019 are relevant.</p>
<p>These include <strong>road tolls and motorway tolls</strong> you had to pay.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for tolls?",
                "Toll costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Business Calls") {
            DbHelper.insatance.deleteWithquestion(
                'Did have any additional costs while traveling to the unpaid internships?');
            _insert(
                'Did have any additional costs while traveling to the unpaid internships?',
                'Business Calls',
                'OK');

//Question No 65
            return educationcalculationContainer("""
<p><strong>Business calls</strong></p>
<p>Please enter the total costs resulting from business calls. Remember, only expenses from 2019 are relevant.</p>
<p>These include also your spending for <strong>professional telephone conversations with your employer or their business partners.</strong></p>
<p><strong> </strong></p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for business calls?",
                "Business call costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Other") {
            DbHelper.insatance.deleteWithquestion(
                'Did have any additional costs while traveling to the unpaid internships?');
            _insert(
                'Did have any additional costs while traveling to the unpaid internships?',
                'Other',
                'OK');

//Question No 66
            return educationcalculationContainer("""
<p><strong>Other travel costs</strong></p>
<p>If you had other travel costs, please enter them here. Remember, only expenses from 2019 are relevant.</p>
<p>Here we mean travel costs that don't fit in any other section.</p>
<p><strong>For example:</strong></p>
<ul>
<li>Costs for passport photos</li>
<li>Visa fees</li>
<li>Credit card fees when abroad</li>
<li>Tips</li>
</ul>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for other costs?",
                "Other costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Did have any additional costs while traveling to the unpaid internships?');
            _insert(
                'Did have any additional costs while traveling to the unpaid internships?',
                'No',
                'OK');

            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Did have any additional costs while traveling to the unpaid internships?');
            _insert(
                'Did have any additional costs while traveling to the unpaid internships?',
                'skip',
                'skip');

            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          }
        }
      }

      //Answer No 62
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} pay for parking?" &&
          widget.CheckQuestion == "Parking costs") {
        DbHelper.insatance.deleteWithquestion('How much did pay for parking?');
        _insert('How much did pay for parking?', Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 63
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} pay for baggage?" &&
          widget.CheckQuestion ==
              "How much did ${Questions.educationYouIdentity} pay for baggage?") {
        DbHelper.insatance.deleteWithquestion('How much did pay for baggage?');
        _insert('How much did pay for baggage?', Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 64
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} pay for tolls?" &&
          widget.CheckQuestion == "Toll costs") {
        DbHelper.insatance.deleteWithquestion('How much did pay for tolls?');
        _insert('How much did pay for tolls?', Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 65
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} pay for business calls?" &&
          widget.CheckQuestion == "Business call costs") {
        DbHelper.insatance
            .deleteWithquestion('How much did pay for business calls?');
        _insert('How much did pay for business calls?', Questions.trainingText,
            'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 66
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} pay for other costs?" &&
          widget.CheckQuestion == "Other costs") {
        DbHelper.insatance
            .deleteWithquestion('How much did pay for pay for other costs?');
        _insert(
            'How much did pay for other costs?', Questions.trainingText, 'OK');

        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      // ====== Unpaid internship Ends ====== //

      // ====== Excursion Starts ======= //

//Answer No 67
      else if (widget.CheckCompleteQuestion ==
              "To how many excursions did ${Questions.educationYouIdentity} go?" &&
          widget.CheckQuestion == "Number of excursions") {
        DbHelper.insatance.deleteWithquestion('To how many excursions did go?');
        _insert(
            'To how many excursions did go?', Questions.excursionText, 'OK');

        //Question No 68
        return educationtwooptionContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
            "Destination no. ${Questions.excursionLength}",
            ["Germany", "Abroad"],
            430.0,
            "",
            Questions.excursionText);
      }

      //Answer No 68
      else if (widget.CheckCompleteQuestion ==
              "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion ==
              "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?") {
        if (widget.CheckAnswer[0] == "Germany") {
          DbHelper.insatance.deleteWithquestion('Where did go on excursion?');
          _insert('Where did go on excursion?', 'Germany', 'OK');

          //Question No 69
          //For car, motorcycle 220.0
          //For public transport, plane ,ferry 220.0
          //for bike , foot 370.0
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate what type of transport you used on the trip.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went in your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} go to excursion no. ${Questions.excursionLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.excursionText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion('Where did go on excursion?');
          _insert('Where did go on excursion?', 'Germany', 'OK');

          //Question No 69
          //For car, motorcycle 220.0
          //For public transport, plane ,ferry 220.0
          //for bike , foot 370.0
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate what type of transport you used on the trip.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went in your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} go to excursion no. ${Questions.excursionLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.excursionText);
        } else if (widget.CheckAnswer[0] == "Abroad") {
          DbHelper.insatance.deleteWithquestion('Where did go on excursion?');
          _insert('Where did go on excursion?', 'Abroad', 'OK');

          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate what type of transport you used on the trip.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went in your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} go to excursion no. ${Questions.excursionLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.excursionText);
        }
      }

      //Answer No 69
      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.educationYouIdentity} go to excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Transportation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "By car") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'By car', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 70
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                "Distance",
                220.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'skip', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 70
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                "Distance",
                220.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "By public transport") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'By public transport', 'OK');

            //Question No 82
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total to go to this excursion in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for going to excursion no. ${Questions.excursionLength}?",
                "Actual costs",
                370.0,
                "calculation",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "By motorcycle") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'By motorcycle', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 70
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                "Distance",
                220.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "By bike") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'By bike', 'OK');

//Question No 72
            //For more than 8 220.0
            //For Arrival/departure 220.0
            return educationmultithreeContainer(
                """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
                "",
                "Education",
                "Do any of these kind of absences apply to ${Questions.educationYouIdentity} for excursion no. ${Questions.excursionLength}?",
                "Absence",
                [
                  "More than 8 hours",
                  "24 hours due to overnight stay",
                  "Arrival/departure days with overnight stay",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "By foot") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'By foot', 'OK');

//Question No 72
            return educationmultithreeContainer(
                """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
                "",
                "Education",
                "Do any of these kind of absences apply to ${Questions.educationYouIdentity} for excursion no. ${Questions.excursionLength}?",
                "Absence",
                [
                  "More than 8 hours",
                  "24 hours due to overnight stay",
                  "Arrival/departure days with overnight stay",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "By plane") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'By plane', 'OK');

//Question No 82
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total to go to this excursion in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for going to excursion no. ${Questions.excursionLength}?",
                "Actual costs",
                370.0,
                "calculation",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "By ferry") {
            DbHelper.insatance.deleteWithquestion('How did go on excursion?');
            _insert('How did go on excursion?', 'By ferry', 'OK');

//Question No 82
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total to go to this excursion in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>
<p><strong> </strong></p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend in total for going to excursion no. ${Questions.excursionLength}?",
                "Actual costs",
                370.0,
                "calculation",
                Questions.excursionText);
          }
        }
      }

      //Answer No 70
      else if (widget.CheckCompleteQuestion ==
              "From where to where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Distance") {
        DbHelper.insatance.deleteWithquestion('where did go on excursion?');
        _insert('where did go on excursion?', Questions.excursionText, 'OK');

        //Question No 71
        return educationcalculationContainer("""
<p><strong>Number of drives</strong></p>
<p>Please enter here how often you used this route to got to this excursion in 2019</p>
<p>Kindly note that the app will already consider the round trip in case it is applicable.</p>
<p> </p>
""",
            "",
            "Education",
            "How often did ${Questions.educationYouIdentity} use the route to excursion no. ${Questions.excursionLength}?",
            "Number of drives",
            370.0,
            "",
            Questions.excursionText);
      }

      //Answer No 71
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} use the route to excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Number of drives") {
        DbHelper.insatance.deleteWithquestion('where did go on excursion?');
        _insert('where did go on excursion?', Questions.excursionText, 'OK');

        //Question No 72

        return educationmultithreeContainer(
            """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
            "",
            "Education",
            "Do any of these kind of absences apply to ${Questions.educationYouIdentity} for excursion no. ${Questions.excursionLength}?",
            "Absence",
            [
              "More than 8 hours",
              "24 hours due to overnight stay",
              "Arrival/departure days with overnight stay",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.excursionText);
      }

      //Answer No 82
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend in total for going to excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Actual costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much did spend in total for going to excursion?');
        _insert('How much did spend in total for going to excursion?',
            Questions.excursionText, 'OK');

        //Question No 72
        return educationmultithreeContainer(
            """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
            "",
            "Education",
            "Do any of these kind of absences apply to ${Questions.educationYouIdentity} for excursion no. ${Questions.excursionLength}?",
            "Absence",
            [
              "More than 8 hours",
              "24 hours due to overnight stay",
              "Arrival/departure days with overnight stay",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.excursionText);
      }

      //Answer No 72
      else if (widget.CheckCompleteQuestion ==
              "Do any of these kind of absences apply to ${Questions.educationYouIdentity} for excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Absence") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "More than 8 hours") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kind of absences apply to for excursion?');
            _insert('Do any of these kind of absences apply to for excursion?',
                'More than 8 hours', 'OK');

            //Question No 73
            return educationcalculationContainer("""
<p><strong>Days with more than 8 hours</strong></p>
<p>Here you can state on how many days you have been away for more than 8 hours. This applies for one-day trips where you have been away from home for more than 8 hours. In this case you leave in the morning and return home in the evening.</p>
<p> </p>
""",
                "",
                "Education",
                "How many days have ${Questions.educationYouIdentity} been away for more than 8 hours when going to excursion no. ${Questions.excursionLength}?",
                "Days at excursion",
                370.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] ==
              "24 hours due to overnight stay") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kind of absences apply to for excursion?');
            _insert('Do any of these kind of absences apply to for excursion?',
                '24 hours due to overnight stay', 'OK');

            if (Questions.excursionLength <= Questions.totalExcursion) {
              //Question No 68
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                  "Destination no. ${Questions.excursionLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.excursionText);
            } else {
              //Question No 78
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] ==
              "Arrival/departure days with overnight stay") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kind of absences apply to for excursion?');
            _insert('Do any of these kind of absences apply to for excursion?',
                'Arrival/departure days with overnight stay', 'OK');

            //Question No 79
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How many arrival & departure days did ${Questions.educationYouIdentity} have in connection with overnight stays at excursion no. ${Questions.excursionLength}?",
                "Arrival/departure",
                220.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kind of absences apply to for excursion?');
            _insert('Do any of these kind of absences apply to for excursion?',
                'skip', 'OK');

            if (Questions.excursionLength <= Questions.totalExcursion) {
              //Question No 68
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                  "Destination no. ${Questions.excursionLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.excursionText);
            } else {
              //Question No 78
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kind of absences apply to for excursion?');
            _insert('Do any of these kind of absences apply to for excursion?',
                'No', 'OK');

            if (Questions.excursionLength <= Questions.totalExcursion) {
              //Question No 68
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                  "Destination no. ${Questions.excursionLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.excursionText);
            } else {
              //Question No 78
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 73
      else if (widget.CheckCompleteQuestion ==
              "How many days have ${Questions.educationYouIdentity} been away for more than 8 hours when going to excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Days at excursion") {
        DbHelper.insatance.deleteWithquestion(
            'How many days have been away for more than 8 hours when going to excursion?');
        _insert(
            'How many days have been away for more than 8 hours when going to excursion?',
            Questions.excursionText,
            'OK');

        //Question No 74
        //For No 280.0
        //For rest 220.0
        return educationmultithreeContainer(
            """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} receive free meals?",
            "Free meals",
            ["Breakfast", "Lunch", "Dinner", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.excursionText);
      }

      //Answer No 79
      else if (widget.CheckCompleteQuestion ==
              "How many arrival & departure days did ${Questions.educationYouIdentity} have in connection with overnight stays at excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Arrival/departure") {
        DbHelper.insatance.deleteWithquestion(
            'How many arrival & departure days did have in connection with overnight stays at excursion?');
        _insert(
            'How many arrival & departure days did have in connection with overnight stays at excursion?',
            Questions.excursionText,
            'OK');

        //Question No 80
        //For No 370.0
        //For yes 220.0
        return educationyesnoContainer("""
<p><strong>Accommodation costs</strong></p>
<p>Here you can state if you had costs due to overnight stays outside your flat. This could be the case if you stayed in a hotel or the like. It is also possible to state rent here in case you had to temporarily lease another apartment due to your excursion.</p>
<p> </p>
""",
            "",
            "Education",
            "Have ${Questions.educationYouIdentity} had accommodation costs when going to excursion no. ${Questions.excursionLength}?",
            "Accommodation costs",
            220.0,
            "",
            Questions.excursionText);
      }

      //Answer No 80
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.educationYouIdentity} had accommodation costs when going to excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Accommodation costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Have had accommodation costs when going to excursion?');
          _insert('Have had accommodation costs when going to excursion?', 'No',
              'OK');

          //Question No 74
          return educationmultithreeContainer(
              """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} receive free meals?",
              "Free meals",
              ["Breakfast", "Lunch", "Dinner", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.excursionText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Have had accommodation costs when going to excursion?');
          _insert('Have had accommodation costs when going to excursion?',
              'skip', 'OK');

          //Question No 74
          return educationmultithreeContainer(
              """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} receive free meals?",
              "Free meals",
              ["Breakfast", "Lunch", "Dinner", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.excursionText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Have had accommodation costs when going to excursion?');
          _insert('Have had accommodation costs when going to excursion?',
              'Yes', 'OK');

          //Question No 81
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much did ${Questions.educationYouIdentity} spend in total for the accommodation when going on excursion no. ${Questions.excursionLength}?",
              "Amount accommodation costs",
              370.0,
              "calculation",
              Questions.excursionText);
        }
      }

      //Answer No 81
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend in total for the accommodation when going on excursion no. ${Questions.excursionLength}?" &&
          widget.CheckQuestion == "Amount accommodation costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much did spend in total for the accommodation when going on excursion?');
        _insert(
            'How much did spend in total for the accommodation when going on excursion?',
            Questions.excursionText,
            'OK');

        //Question No 74
        return educationmultithreeContainer(
            """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} receive free meals?",
            "Free meals",
            ["Breakfast", "Lunch", "Dinner", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.excursionText);
      }

      //Answer No 74
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} receive free meals?" &&
          widget.CheckQuestion == "Free meals" &&
          Questions.excursionText.contains("EXCURSION")) {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Breakfast") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'Breakfast', 'OK');

            //Question No 75
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?",
                "Number of breakfast",
                220.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "Lunch") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'Lunch', 'OK');

            //Question No 76
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary lunch?",
                "Number of lunch",
                220.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "Dinner") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'Dinner', 'OK');

//Question No 77
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary dinner?",
                "Number of dinner",
                220.0,
                "",
                Questions.excursionText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'skip', 'skip');

            if (Questions.excursionLength <= Questions.totalExcursion) {
              //Question No 68
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                  "Destination no. ${Questions.excursionLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.excursionText);
            } else {
              //Question No 78
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion('receive free meals?');
            _insert('receive free meals?', 'No', 'OK');

            if (Questions.excursionLength <= Questions.totalExcursion) {
              //Question No 68
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
                  "Destination no. ${Questions.excursionLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.excursionText);
            } else {
              //Question No 78
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 75
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?" &&
          widget.CheckQuestion == "Number of breakfast" &&
          Questions.excursionText.contains("EXCURSION")) {
        DbHelper.insatance.deleteWithquestion(
            'How often did receive complimentary breakfast?');
        _insert('How often did receive complimentary breakfast?', 'No', 'OK');

        if (Questions.excursionLength <= Questions.totalExcursion) {
          //Question No 68
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
              "Destination no. ${Questions.excursionLength}",
              ["Germany", "Abroad"],
              430.0,
              "",
              Questions.excursionText);
        } else {
          //Question No 78
          return educationmultipleoptionsContainer(
              """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 76
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary lunch?" &&
          widget.CheckQuestion == "Number of lunch" &&
          Questions.excursionText.contains("EXCURSION")) {
        DbHelper.insatance
            .deleteWithquestion('How often did receive complimentary lunch?');
        _insert('How often did receive complimentary lunch?',
            Questions.excursionText, 'OK');

        if (Questions.excursionLength <= Questions.totalExcursion) {
          //Question No 68
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
              "Destination no. ${Questions.excursionLength}",
              ["Germany", "Abroad"],
              430.0,
              "",
              Questions.excursionText);
        } else {
          //Question No 78
          return educationmultipleoptionsContainer(
              """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 77
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary dinner?" &&
          widget.CheckQuestion == "Number of dinner" &&
          Questions.excursionText.contains("EXCURSION")) {
        DbHelper.insatance
            .deleteWithquestion('How often did receive complimentary dinner?');
        _insert('How often did receive complimentary dinner?',
            Questions.excursionText, 'OK');

        if (Questions.excursionLength <= Questions.totalExcursion) {
          //Question No 68
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} go on excursion no. ${Questions.excursionLength}?",
              "Destination no. ${Questions.excursionLength}",
              ["Germany", "Abroad"],
              430.0,
              "",
              Questions.excursionText);
        } else {
          //Question No 78
          return educationmultipleoptionsContainer(
              """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 78
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to excursions?" &&
          widget.CheckQuestion == "Additional costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Parking") {
            DbHelper.insatance.deleteWithquestion(
                'Have had additional costs due to travelling to excursions?');
            _insert(
                'Have had additional costs due to travelling to excursions?',
                'Parking',
                'OK');

            //Same as unpaid internship
            //Question No 62
            return educationcalculationContainer("""
<p><strong>Parking fees</strong></p>
<p>Please enter the total costs resulting from parking charges. Remember, only expenses from 2019 are relevant.</p>
<p>The expenses for <strong>parking spaces and car parks</strong> are deductible.                   </p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for parking?",
                "Parking costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Baggage") {
            DbHelper.insatance.deleteWithquestion(
                'Have had additional costs due to travelling to excursions?');
            _insert(
                'Have had additional costs due to travelling to excursions?',
                'Baggage',
                'OK');

            //Same as unpaid internship
            //Question No 63
            return educationcalculationContainer("""
<p><strong>Baggage fees</strong></p>
<p>Please enter the total amount spent on baggage fees. Please note only expenses from 2019 are relevant.</p>
<p>Baggage fees may be charged for transportation of baggage by an <strong>airline or bus company.</strong></p>
<p>Baggage fees may also be charged if you store your baggage in a <strong>locker</strong>.</p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for baggage?",
                "Baggage costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Toll") {
            DbHelper.insatance.deleteWithquestion(
                'Have had additional costs due to travelling to excursions?');
            _insert(
                'Have had additional costs due to travelling to excursions?',
                'Toll',
                'OK');

            //Same as unpaid internship
            //Question No 64
            return educationcalculationContainer("""
<p><strong>Tolls charges</strong></p>
<p>Please enter the total costs resulting from toll charges. Remember, only expenses from 2019 are relevant.</p>
<p>These include <strong>road tolls and motorway tolls</strong> you had to pay.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for tolls?",
                "Toll costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Business Calls") {
            DbHelper.insatance.deleteWithquestion(
                'Have had additional costs due to travelling to excursions?');
            _insert(
                'Have had additional costs due to travelling to excursions?',
                'Business Calls',
                'OK');

            //Same as unpaid internship
//Question No 65
            return educationcalculationContainer("""
<p><strong>Business calls</strong></p>
<p>Please enter the total costs resulting from business calls. Remember, only expenses from 2019 are relevant.</p>
<p>These include also your spending for <strong>professional telephone conversations with your employer or their business partners.</strong></p>
<p><strong> </strong></p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for business calls?",
                "Business call costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Other") {
            DbHelper.insatance.deleteWithquestion(
                'Have had additional costs due to travelling to excursions?');
            _insert(
                'Have had additional costs due to travelling to excursions?',
                'Other',
                'OK');

            //Same as unpaid internship
//Question No 66
            return educationcalculationContainer("""
<p><strong>Other travel costs</strong></p>
<p>If you had other travel costs, please enter them here. Remember, only expenses from 2019 are relevant.</p>
<p>Here we mean travel costs that don't fit in any other section.</p>
<p><strong>For example:</strong></p>
<ul>
<li>Costs for passport photos</li>
<li>Visa fees</li>
<li>Credit card fees when abroad</li>
<li>Tips</li>
</ul>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for other costs?",
                "Other costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Have had additional costs due to travelling to excursions?');
            _insert(
                'Have had additional costs due to travelling to excursions?',
                'No',
                'OK');

            //Same as unpaid internship
            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Have had additional costs due to travelling to excursions?');
            _insert(
                'Have had additional costs due to travelling to excursions?',
                'skip',
                'skip');

            //Same as unpaid internship
            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          }
        }
      }

      // ====== Excursion Ends ======= //

      // ====== Semester abroad Starts ====== //

      //Answer No 83

      else if (widget.CheckCompleteQuestion ==
              "To how many semester abroad did ${Questions.educationYouIdentity} go?" &&
          widget.CheckQuestion == "Number of semester abroad") {
        DbHelper.insatance
            .deleteWithquestion('To how many semester abroad did go?');
        _insert('To how many semester abroad did go?', Questions.semesterText,
            'OK');

        //Question No 84
        return educationtwooptionContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
            "Destination no. ${Questions.semesterLength}",
            ["Germany", "Abroad"],
            430.0,
            "",
            Questions.semesterText);
      }

      //Answer No 84
      else if (widget.CheckCompleteQuestion ==
              "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion ==
              "Destination no. ${Questions.semesterLength}") {
        if (widget.CheckAnswer[0] == "Germany") {
          DbHelper.insatance
              .deleteWithquestion('To how many semester abroad did go?');
          _insert('To how many semester abroad did go?', 'Germany', 'OK');

          //Question No 85
          //For car, motorcycle 220.0
          //For public transport, plane ,ferry 220.0
          //for bike , foot 370.0
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the semester abroad.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went in your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} travel to ${Questions.educationYourIdentity} semester abroad no. ${Questions.semesterLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.semesterText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
              .deleteWithquestion('To how many semester abroad did go?');
          _insert('To how many semester abroad did go?', 'skip', 'OK');

          //Question No 85
          //For car, motorcycle 220.0
          //For public transport, plane ,ferry 220.0
          //for bike , foot 370.0
          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the semester abroad.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went in your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} travel to ${Questions.educationYourIdentity} semester abroad no. ${Questions.semesterLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.semesterText);
        } else if (widget.CheckAnswer[0] == "Abroad") {
          DbHelper.insatance
              .deleteWithquestion('To how many semester abroad did go?');
          _insert('To how many semester abroad did go?', 'Abroad', 'OK');

          return educationmultipleoptionsContainer(
              """
<p><strong>Means of transport</strong></p>
<p>Please indicate which means of transport you used to get to the semester abroad.</p>
<p>You can choose from the following:</p>
<p><strong>CAR</strong></p>
<p>You went in your own car.</p>
<p><strong>BUS OR TRAIN</strong></p>
<p>You used public transport to get there. This includes taxis or car sharing.</p>
<p><strong>MOTORCYCLE</strong></p>
<p>You went by motorcycle.</p>
<p><strong>BICYCLE</strong></p>
<p>You went by bike.</p>
<p><strong>BY FOOT</strong></p>
<p>You went to the unpaid internship by foot.</p>
<p><strong>PLANE</strong></p>
<p>You went by plane.</p>
<p><strong>FERRY</strong></p>
<p>You went by ferry.</p>
""",
              "",
              "Education",
              "How did ${Questions.educationYouIdentity} travel to ${Questions.educationYourIdentity} semester abroad no. ${Questions.semesterLength}?",
              "Transportation",
              [
                "By car",
                "By public transport",
                "By motorcycle",
                "By bike",
                "By foot",
                "By plane",
                "By ferry"
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
              "",
              Questions.semesterText);
        }
      }

      //Answer No 85
      else if (widget.CheckCompleteQuestion ==
              "How did ${Questions.educationYouIdentity} travel to ${Questions.educationYourIdentity} semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Transportation") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "By car") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert('How did travel to semester abroad?', 'By car', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 86
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} to semester abroad no. ${Questions.semesterLength}?",
                "Distance",
                220.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert('How did travel to semester abroad?', 'skip', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 86
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} to semester abroad no. ${Questions.semesterLength}?",
                "Distance",
                220.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "By public transport") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert('How did travel to semester abroad?', 'By public transport',
                'OK');

            //Question No 98
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total to go to this semester abroad in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend for the round trip going to semester abroad no. ${Questions.semesterLength}?",
                "Actual costs",
                370.0,
                "calculation",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "By motorcycle") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert(
                'How did travel to semester abroad?', 'By motorcycle', 'OK');

            //Ya container baad ma jaka change hoga
            //Question No 86
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "From where to where did ${Questions.educationYouIdentity} to semester abroad no. ${Questions.semesterLength}?",
                "Distance",
                220.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "By bike") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert('How did travel to semester abroad?', 'By bike', 'OK');

//Question No 88
            //For More than 8 hours 220.0
            //Arrival/departure 220.0
            return educationmultithreeContainer(
                """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
                "",
                "Education",
                "Do any of these kinds of absences apply to ${Questions.educationYouIdentity} for semester abroad no. ${Questions.semesterLength} in the 1st three months?",
                "Absence",
                [
                  "More than 8 hours",
                  "24 hours due to overnight stay",
                  "Arrival/departure days with overnight stay",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "By foot") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert('How did travel to semester abroad?', 'By foot', 'OK');

//Question No 88
            return educationmultithreeContainer(
                """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
                "",
                "Education",
                "Do any of these kinds of absences apply to ${Questions.educationYouIdentity} for semester abroad no. ${Questions.semesterLength} in the 1st three months?",
                "Absence",
                [
                  "More than 8 hours",
                  "24 hours due to overnight stay",
                  "Arrival/departure days with overnight stay",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                220.0,
                "No",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "By plane") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert('How did travel to semester abroad?', 'By plane', 'OK');

            //Question No 98
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total to go to this semester abroad in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend for the round trip going to semester abroad no. ${Questions.semesterLength}?",
                "Actual costs",
                370.0,
                "calculation",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "By ferry") {
            DbHelper.insatance
                .deleteWithquestion('How did travel to semester abroad?');
            _insert('How did travel to semester abroad?', 'By ferry', 'OK');

            //Question No 98
            return educationcalculationContainer("""
<p><strong>Actual costs</strong></p>
<p>Please enter how much you actually spent in total to go to this semester abroad in 2019.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>
""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend for the round trip going to semester abroad no. ${Questions.semesterLength}?",
                "Actual costs",
                370.0,
                "calculation",
                Questions.semesterText);
          }
        }
      }

      //Answer No 86
      else if (widget.CheckCompleteQuestion ==
              "From where to where did ${Questions.educationYouIdentity} to semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Distance") {
        DbHelper.insatance
            .deleteWithquestion('From where to where did to semester abroad?');
        _insert('From where to where did to semester abroad?',
            Questions.semesterText, 'OK');

        //Question No 87
        return educationcalculationContainer("""
<p><strong>Number of drives</strong></p>
<p>Please enter here how often you used this route to got to this semester abroad in 2019.</p>
<p>Kindly note that the app will already consider the round trip in case it is applicable.</p>
<p> </p>
""",
            "",
            "Education",
            "How often did ${Questions.educationYouIdentity} use the route to semester abroad no. ${Questions.semesterLength}?",
            "Number of drives",
            370.0,
            "",
            Questions.semesterText);
      }

      //Answer No 87
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} use the route to semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Number of drives") {
        DbHelper.insatance.deleteWithquestion(
            'How often did use the route to semester abroad?');
        _insert('How often did use the route to semester abroad?',
            Questions.semesterText, 'OK');

        //Question No 88
        return educationmultithreeContainer(
            """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
            "",
            "Education",
            "Do any of these kinds of absences apply to ${Questions.educationYouIdentity} for semester abroad no. ${Questions.semesterLength} in the 1st three months?",
            "Absence",
            [
              "More than 8 hours",
              "24 hours due to overnight stay",
              "Arrival/departure days with overnight stay",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.semesterText);
      }

      //Answer No 98
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend for the round trip going to semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Actual costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much did spend for the round trip going to semester abroad?');
        _insert(
            'How much did spend for the round trip going to semester abroad?',
            Questions.semesterText,
            'OK');

        //Question No 88
        return educationmultithreeContainer(
            """
<p><strong>Absence</strong></p>
<p>In some cases, daily allowance can be claimed for certain absences. The app considers the respective lump sums based on your statements.</p>
<p><strong>MORE THAN 8 HOURS</strong></p>
<p>This can apply for one-day trips where you have been away from home for more than 8 hours. In this case, you leave in the morning and return home in the evening.</p>
<p><strong>24 HOURS DUE TO AN OVERNIGHT STAY</strong></p>
<p>This applies to multi-day trips during which you are not at home for several days because of overnight stays.</p>
<p><strong>ARRIVAL AND DEPARTURE DUE TO AN OVERNIGHT STAY</strong></p>
<p>In this case, you are traveling for several days, you arrive on one day and depart on another because of an overnight stay. Please note that these days are not days with an absence of more than 8 hours.</p>
<p>Please note that different absences cannot be specified on the same day. Only a maximum of one absence can apply for each day.</p>
<p> </p>
""",
            "",
            "Education",
            "Do any of these kinds of absences apply to ${Questions.educationYouIdentity} for semester abroad no. ${Questions.semesterLength} in the 1st three months?",
            "Absence",
            [
              "More than 8 hours",
              "24 hours due to overnight stay",
              "Arrival/departure days with overnight stay",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.semesterText);
      }

      //Answer No 88

      else if (widget.CheckCompleteQuestion ==
              "Do any of these kinds of absences apply to ${Questions.educationYouIdentity} for semester abroad no. ${Questions.semesterLength} in the 1st three months?" &&
          widget.CheckQuestion == "Absence") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "More than 8 hours") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?');
            _insert(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?',
                'More than 8 hours',
                'OK');

            //Question No 89
            return educationcalculationContainer("""
<p><strong>Days with more than 8 hours</strong></p>
<p>Here you can state on how many days you have been away for more than 8 hours within the first three months of the semester abroad. In this case you leave in the morning and return home in the evening. If you got to the same semester abroad the period to consider absence days is limited to the first three months.</p>
<p>If there is an interruption of at least four consecutive weeks (e.g. due to illness, holidays, etc.) the period begins again so that the days in the first three months after the interruption can be added to the days above.</p>
<p> </p>
""",
                "",
                "Education",
                "How many days have ${Questions.educationYouIdentity} been away for more than 8 hours while traveling to semester abroad no. ${Questions.semesterLength}?",
                "Days at excursion",
                370.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] ==
              "24 hours due to overnight stay") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?');
            _insert(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?',
                '24 hours due to overnight stay',
                'OK');

            if (Questions.semesterLength <= Questions.totalSemester) {
              //Question No 84
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
                  "Destination no. ${Questions.semesterLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.semesterText);
            } else {
              //Question No 94
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] ==
              "Arrival/departure days with overnight stay") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?');
            _insert(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?',
                'Arrival/departure days with overnight stay',
                'OK');

            //Question No 95
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How many arrival & departure days did ${Questions.educationYouIdentity} have in connection with overnight stays within the first three months at semester abroad no. ${Questions.semesterLength}?",
                "Arrival/departure days",
                220.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?');
            _insert(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?',
                'skip',
                'skip');

            if (Questions.semesterLength <= Questions.totalSemester) {
              //Question No 84
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
                  "Destination no. ${Questions.semesterLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.semesterText);
            } else {
              //Question No 94
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?');
            _insert(
                'Do any of these kinds of absences apply to for semester abroad in the 1st three months?',
                'No',
                'OK');

            if (Questions.semesterLength <= Questions.totalSemester) {
              //Question No 84
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
                  "Destination no. ${Questions.semesterLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.semesterText);
            } else {
              //Question No 94
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 89
      else if (widget.CheckCompleteQuestion ==
              "How many days have ${Questions.educationYouIdentity} been away for more than 8 hours while traveling to semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Days at excursion") {
        DbHelper.insatance.deleteWithquestion(
            'How many days have been away for more than 8 hours while traveling to semester abroad?');
        _insert(
            'How many days have been away for more than 8 hours while traveling to semester abroad?',
            Questions.semesterText,
            'OK');

        //Question No 90
        //For No 280.0
        //For rest 220.0
        return educationmultithreeContainer(
            """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} receive free meals?",
            "Free meals",
            ["Breakfast", "Lunch", "Dinner", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.semesterText);
      }

      //Answer No 95

      else if (widget.CheckCompleteQuestion ==
              "How many arrival & departure days did ${Questions.educationYouIdentity} have in connection with overnight stays within the first three months at semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Arrival/departure days") {
        DbHelper.insatance.deleteWithquestion('Arrival/departure days');
        _insert('Arrival/departure days', Questions.semesterText, 'OK');

        //Question No 96
        //For No 370.0
        //For yes 220.0
        return educationyesnoContainer("""
<p><strong>Accommodation costs</strong></p>
<p>Here you can state if you had costs due to overnight stays outside your flat. This could be the case if you stayed in a hotel or the like. It is also possible to state rent here in case you had to temporarily lease another apartment due to your semester abroad.</p>
<p> </p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} have any accommodation costs while traveling to semester abroad no. ${Questions.semesterLength}?",
            "Accommodation costs",
            220.0,
            "",
            Questions.semesterText);
      }

      //Answer No 96
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} have any accommodation costs while traveling to semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Accommodation costs") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'Did have any accommodation costs while traveling to semester abroad?');
          _insert(
              'Did have any accommodation costs while traveling to semester abroad?',
              'No',
              'OK');

          //Question No 90
          return educationmultithreeContainer(
              """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} receive free meals?",
              "Free meals",
              ["Breakfast", "Lunch", "Dinner", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.semesterText);
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'Did have any accommodation costs while traveling to semester abroad?');
          _insert(
              'Did have any accommodation costs while traveling to semester abroad?',
              'skip',
              'OK');

          //Question No 90
          return educationmultithreeContainer(
              """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} receive free meals?",
              "Free meals",
              ["Breakfast", "Lunch", "Dinner", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.semesterText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'Did have any accommodation costs while traveling to semester abroad?');
          _insert(
              'Did have any accommodation costs while traveling to semester abroad?',
              'Yes',
              'OK');

          //Question No 97
          return educationcalculationContainer("""
<p><strong>Amount accommodation costs</strong></p>
<p>Add up your actual costs from 2019 and enter the total here.</p>
<p><strong>You should be able to prove your costs by keeping the bills in case the tax office asks for a verification.</strong></p>
<p><strong> </strong></p>
""",
              "",
              "Education",
              "How much did ${Questions.educationYouIdentity} spend in total, for accommodation while traveling to semester abroad no. ${Questions.semesterLength}?",
              "Amount accommodation costs",
              370.0,
              "calculation",
              Questions.semesterText);
        }
      }

      //Answer No 97
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend in total, for accommodation while traveling to semester abroad no. ${Questions.semesterLength}?" &&
          widget.CheckQuestion == "Amount accommodation costs") {
        DbHelper.insatance.deleteWithquestion(
            'How much did spend in total, for accommodation while traveling to semester abroad?');
        _insert(
            'How much did spend in total, for accommodation while traveling to semester abroad?',
            'Amount accommodation costs',
            'OK');

        //Question No 90
        return educationmultithreeContainer(
            """
<p><strong>Complimentary meals</strong></p>
<p>Please state whether someone provided or paid for meals during your absence. Choose from the applicable options below.</p>
<p>You can select several options.</p>
<p><strong>BREAKFAST</strong></p>
<p>Breakfast was provided to you.</p>
<p><strong>LUNCH</strong></p>
<p>Lunch was provided to you.</p>
<p><strong>DINNER</strong></p>
<p>Dinner was provided to you.</p>
<p> </p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} receive free meals?",
            "Free meals",
            ["Breakfast", "Lunch", "Dinner", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            220.0,
            "No",
            Questions.semesterText);
      }

      //Answer No 90
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} receive free meals?" &&
          widget.CheckQuestion == "Free meals" &&
          Questions.semesterText.contains("SEMESTER ABROAD")) {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Breakfast") {
            //Question No 91
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?",
                "Number of breakfast",
                260.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "Lunch") {
            //Question No 92
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary lunch?",
                "Number of lunch",
                260.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "Dinner") {
//Question No 93
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How often did ${Questions.educationYouIdentity} receive complimentary dinner?",
                "Number of dinner",
                260.0,
                "",
                Questions.semesterText);
          } else if (widget.CheckAnswer[m] == "skip") {
            if (Questions.semesterLength <= Questions.totalSemester) {
              //Question No 84
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
                  "Destination no. ${Questions.semesterLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.semesterText);
            } else {
              //Question No 94
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          } else if (widget.CheckAnswer[m] == "No") {
            if (Questions.semesterLength <= Questions.totalSemester) {
              //Question No 84
              return educationtwooptionContainer(
                  "<h1>Coming Soon!</h1>",
                  "",
                  "Education",
                  "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
                  "Destination no. ${Questions.semesterLength}",
                  ["Germany", "Abroad"],
                  430.0,
                  "",
                  Questions.semesterText);
            } else {
              //Question No 94
              return educationmultipleoptionsContainer(
                  """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
                  "",
                  "Education",
                  "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
                  "Additional costs",
                  [
                    "Parking",
                    "Baggage",
                    "Toll",
                    "Business Calls",
                    "Other",
                    "No"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png",
                    "images/check.png",
                    "images/check.png",
                    "images/check.png"
                  ],
                  220.0,
                  "No",
                  Questions.trainingText);
            }
          }
        }
      }

      //Answer No 91
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary breakfast?" &&
          widget.CheckQuestion == "Number of breakfast" &&
          Questions.semesterText.contains("SEMESTER ABROAD")) {
        if (Questions.semesterLength <= Questions.totalSemester) {
          //Question No 84
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
              "Destination no. ${Questions.semesterLength}",
              ["Germany", "Abroad"],
              430.0,
              "",
              Questions.semesterText);
        } else {
          //Question No 94
          return educationmultipleoptionsContainer(
              """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 92
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary lunch?" &&
          widget.CheckQuestion == "Number of lunch" &&
          Questions.semesterText.contains("SEMESTER ABROAD")) {
        if (Questions.semesterLength <= Questions.totalSemester) {
          //Question No 84
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
              "Destination no. ${Questions.semesterLength}",
              ["Germany", "Abroad"],
              430.0,
              "",
              Questions.semesterText);
        } else {
          //Question No 94
          return educationmultipleoptionsContainer(
              """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 93
      else if (widget.CheckCompleteQuestion ==
              "How often did ${Questions.educationYouIdentity} receive complimentary dinner?" &&
          widget.CheckQuestion == "Number of dinner" &&
          Questions.semesterText.contains("SEMESTER ABROAD")) {
        if (Questions.semesterLength <= Questions.totalSemester) {
          //Question No 84
          return educationtwooptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Where did ${Questions.educationYouIdentity} go to semester abroad no. ${Questions.semesterLength}?",
              "Destination no. ${Questions.semesterLength}",
              ["Germany", "Abroad"],
              430.0,
              "",
              Questions.semesterText);
        } else {
          //Question No 94
          return educationmultipleoptionsContainer(
              """
<p><strong>Additional travel costs</strong></p>
<p>Here, you can select one or more answers. Please note only expenses from 2019 are relevant.</p>
<p><strong>Parking fees</strong></p>
<ul>
<li>parking spaces or parking garages</li>
</ul>
<p><strong>Baggage fees</strong></p>
<ul>
<li>transport of baggage by airline or bus company</li>
<li>baggage lockers</li>
</ul>
<p><strong>Toll charges</strong></p>
<ul>
<li>road tolls and motorway tolls</li>
</ul>
<p><strong>Business calls</strong></p>
<ul>
<li>with colleagues or business partners</li>
</ul>
<p><strong>Other costs</strong></p>
<ul>
<li>tips</li>
<li>cancellation and rebooking charges</li>
</ul>
<p> </p>
<p> </p>
""",
              "",
              "Education",
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?",
              "Additional costs",
              ["Parking", "Baggage", "Toll", "Business Calls", "Other", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/check.png",
                "images/check.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        }
      }

      //Answer No 94
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.educationYouIdentity} had additional costs due to travelling to semesters abroad?" &&
          widget.CheckQuestion == "Additional costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Parking") {
            //Same as unpaid internship/excursion
            //Question No 62
            return educationcalculationContainer("""
<p><strong>Parking fees</strong></p>
<p>Please enter the total costs resulting from parking charges. Remember, only expenses from 2019 are relevant.</p>
<p>The expenses for <strong>parking spaces and car parks</strong> are deductible.                   </p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for parking?",
                "Parking costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Baggage") {
            //Same as unpaid internship/excursion
            //Question No 63
            return educationcalculationContainer("""
<p><strong>Baggage fees</strong></p>
<p>Please enter the total amount spent on baggage fees. Please note only expenses from 2019 are relevant.</p>
<p>Baggage fees may be charged for transportation of baggage by an <strong>airline or bus company.</strong></p>
<p>Baggage fees may also be charged if you store your baggage in a <strong>locker</strong>.</p>
<p> </p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for baggage?",
                "Baggage costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Toll") {
            //Same as unpaid internship/excursion
            //Question No 64
            return educationcalculationContainer("""
<p><strong>Tolls charges</strong></p>
<p>Please enter the total costs resulting from toll charges. Remember, only expenses from 2019 are relevant.</p>
<p>These include <strong>road tolls and motorway tolls</strong> you had to pay.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for tolls?",
                "Toll costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Business Calls") {
            //Same as unpaid internship/excursion
//Question No 65
            return educationcalculationContainer("""
<p><strong>Business calls</strong></p>
<p>Please enter the total costs resulting from business calls. Remember, only expenses from 2019 are relevant.</p>
<p>These include also your spending for <strong>professional telephone conversations with your employer or their business partners.</strong></p>
<p><strong> </strong></p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for business calls?",
                "Business call costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Other") {
            //Same as unpaid internship/excursion
//Question No 66
            return educationcalculationContainer("""
<p><strong>Other travel costs</strong></p>
<p>If you had other travel costs, please enter them here. Remember, only expenses from 2019 are relevant.</p>
<p>Here we mean travel costs that don't fit in any other section.</p>
<p><strong>For example:</strong></p>
<ul>
<li>Costs for passport photos</li>
<li>Visa fees</li>
<li>Credit card fees when abroad</li>
<li>Tips</li>
</ul>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for other costs?",
                "Other costs",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "No") {
            //Same as unpaid internship/excursion
            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "skip") {
            //Same as unpaid internship/excursion
            //Question No 10
            return educationyesnoContainer("""
<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>
<p> </p>

""",
                "",
                "Education",
                "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
                "Reimbursement of costs",
                220.0,
                "",
                Questions.trainingText);
          }
        }
      }

      // ====== Semester abroad Ends ====== //

      // ====== Travel Costs End ======

      // ====== Items for education (e.g. computer, office furniture etc.) Starts ======//

      //Answer No 99
      else if (widget.CheckCompleteQuestion ==
              "What kind of items did ${Questions.educationYouIdentity} buy in 2019 for training no. ${Questions.trainingLength}?" &&
          widget.CheckQuestion == "Item") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Office furniture") {
            //Question No 108
            return educationyesnoContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "Did ${Questions.educationYouIdentity} spend more than 952 EUR on any piece of office furniture?",
                "Furniture over 952 EUR",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Computer/laptop") {
            //Question No 100
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How much was the computer?",
                "Amount",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Computer accessories") {
            //Question No 104
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on computer accessories?",
                "Amount",
                320.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Tools") {
            //Question No 105
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} pay for this tool?",
                "Amount",
                320.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Other") {
//Question No 106
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "What kind of items did ${Questions.educationYouIdentity} buy?",
                "Items",
                220.0,
                "calculation",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "None of these") {
//Question No 102
            //For No 320.0
            //For rest 220.0
            return educationmultitwoContainer(
                """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
                "",
                "Education",
                "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
                "Previous years",
                ["Computer / Laptop", "Other expensive items", "No"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0,
                "No",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "skip") {
//Question No 102
            //For No 320.0
            //For rest 220.0
            return educationmultitwoContainer(
                """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
                "",
                "Education",
                "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
                "Previous years",
                ["Computer / Laptop", "Other expensive items", "No"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0,
                "No",
                Questions.trainingText);
          }
        }
      }

      //Answer No 100
      else if (widget.CheckCompleteQuestion == "How much was the computer?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 101
        return educationdateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "When did ${Questions.educationYouIdentity} buy the computer?",
            "Purchase date",
            320.0,
            "",
            Questions.trainingText);
      }

      //Answer No 101
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy the computer?" &&
          widget.CheckQuestion == "Purchase date") {
        //Question No 102
        return educationmultitwoContainer(
            """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
            "Previous years",
            ["Computer / Laptop", "Other expensive items", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0,
            "No",
            Questions.trainingText);
      }

      //Answer No 104
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on computer accessories?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 102
        return educationmultitwoContainer(
            """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
            "Previous years",
            ["Computer / Laptop", "Other expensive items", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0,
            "No",
            Questions.trainingText);
      }

      //Answer No 105
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} pay for this tool?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 102
        return educationmultitwoContainer(
            """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
            "Previous years",
            ["Computer / Laptop", "Other expensive items", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0,
            "No",
            Questions.trainingText);
      }

      //Answer No 106
      else if (widget.CheckCompleteQuestion ==
              "What kind of items did ${Questions.educationYouIdentity} buy?" &&
          widget.CheckQuestion == "Items") {
        //Question No 107
        return educationcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "How much did ${Questions.educationYouIdentity} spend on the ${Questions.educationTraItem}?",
            "Amount spent",
            320.0,
            "calculation",
            Questions.trainingText);
      }

      //Answer No 107
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on the ${Questions.educationTraItem}?" &&
          widget.CheckQuestion == "Amount spent") {
        //Question No 102
        return educationmultitwoContainer(
            """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
            "Previous years",
            ["Computer / Laptop", "Other expensive items", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0,
            "No",
            Questions.trainingText);
      }

      // ====== Office Furniture Starts ====== //

      //Answer No 108
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} spend more than 952 EUR on any piece of office furniture?" &&
          widget.CheckQuestion == "Furniture over 952 EUR") {
        if (widget.CheckAnswer[0] == "No") {
          //Question No 113
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          //Question No 113
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          //Question No 109
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How many pieces of furnitures cost more than 488 EUR?",
              "Number",
              430.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 109
      else if (widget.CheckCompleteQuestion ==
              "How many pieces of furnitures cost more than 488 EUR?" &&
          widget.CheckQuestion == "Number") {
        //Question No 110
        return educationdifferentoptionContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "What kind of furniture did ${Questions.educationYouIdentity} buy?",
            "Type",
            [
              "Desk",
              "Office chair",
              "Bookshelf",
              "Lamp",
              "Filing cabinet",
              "Other"
            ],
            220.0,
            "",
            Questions.educationExpfurniture);
      }

      //Answer No 110
      else if (widget.CheckCompleteQuestion ==
              "What kind of furniture did ${Questions.educationYouIdentity} buy?" &&
          widget.CheckQuestion == "Type") {
        if (widget.CheckAnswer[0] == "Desk") {
          //Question No 111
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much was the desk?",
              "Amount desk",
              220.0,
              "calculation",
              Questions.educationExpfurniture);
        } else if (widget.CheckAnswer[0] == "Office chair") {
          //Question No 114
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much was the office chair?",
              "Amount office chair",
              220.0,
              "calculation",
              Questions.educationExpfurniture);
        } else if (widget.CheckAnswer[0] == "Bookshelf") {
//Question No 116
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much was the bookshelf?",
              "Amount bookshelf",
              220.0,
              "calculation",
              Questions.educationExpfurniture);
        } else if (widget.CheckAnswer[0] == "Lamp") {
//Question No 118
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much was the lamp?",
              "Amount lamp",
              220.0,
              "calculation",
              Questions.educationExpfurniture);
        } else if (widget.CheckAnswer[0] == "Filing cabinet") {
//Question No 120
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much was the filing cabinet?",
              "Amount filing cabinet",
              220.0,
              "calculation",
              Questions.educationExpfurniture);
        } else if (widget.CheckAnswer[0] == "Other") {
//Question No 122
          //Ek space ziyada furniture sa pehla lgaya ha kyu ka collision na ho two questions ma yani 122 and 110 ma
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of  furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              220.0,
              "",
              Questions.educationExpfurniture);
        } else if (widget.CheckAnswer[0] == "skip") {
//Question No 122
          //Ek space ziyada furniture sa pehla lgaya ha kyu ka collision na ho two questions ma yani 122 and 110 ma
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of  furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              220.0,
              "",
              Questions.educationExpfurniture);
        }
      }

//Desk Starts //
      //Answer No 111
      else if (widget.CheckCompleteQuestion == "How much was the desk?" &&
          widget.CheckQuestion == "Amount desk") {
        //Question No 112
        return educationdateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "When did ${Questions.educationYouIdentity} buy the desk?",
            "Purchase date",
            430.0,
            "",
            Questions.educationExpfurniture);
      }

      //Answer No 112
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy the desk?" &&
          widget.CheckQuestion == "Purchase date") {
        if (Questions.expFurnitureLength <= Questions.totalExpFurniture) {
          //Question No 110
          return educationdifferentoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              [
                "Desk",
                "Office chair",
                "Bookshelf",
                "Lamp",
                "Filing cabinet",
                "Other"
              ],
              220.0,
              "",
              Questions.educationExpfurniture);
        } else {
          //Question No 113
          //For No 320.0
          //For Yes 220.0
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        }
      }

//Desk Ends //

      //Office Furniture Starts //
      //Answer No 114
      else if (widget.CheckCompleteQuestion ==
              "How much was the office chair?" &&
          widget.CheckQuestion == "Amount office chair") {
        //Question No 115
        return educationdateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "When did ${Questions.educationYouIdentity} buy the office chair?",
            "Purchase date",
            430.0,
            "",
            Questions.educationExpfurniture);
      }

      //Answer No 115
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy the office chair?" &&
          widget.CheckQuestion == "Purchase date") {
        if (Questions.expFurnitureLength <= Questions.totalExpFurniture) {
          //Question No 110
          return educationdifferentoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              [
                "Desk",
                "Office chair",
                "Bookshelf",
                "Lamp",
                "Filing cabinet",
                "Other"
              ],
              220.0,
              "",
              Questions.educationExpfurniture);
        } else {
          //Question No 113
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        }
      }

//Office Furniture Ends //

      //Bookshelf Starts //
      //Answer No 116
      else if (widget.CheckCompleteQuestion == "How much was the bookshelf?" &&
          widget.CheckQuestion == "Amount bookshelf") {
        //Question No 117
        return educationdateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "When did ${Questions.educationYouIdentity} buy the bookshelf?",
            "Purchase date",
            430.0,
            "",
            Questions.educationExpfurniture);
      }

      //Answer No 117
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy the bookshelf?" &&
          widget.CheckQuestion == "Purchase date") {
        if (Questions.expFurnitureLength <= Questions.totalExpFurniture) {
          //Question No 110
          return educationdifferentoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              [
                "Desk",
                "Office chair",
                "Bookshelf",
                "Lamp",
                "Filing cabinet",
                "Other"
              ],
              220.0,
              "",
              Questions.educationExpfurniture);
        } else {
          //Question No 113
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        }
      }

//Bookshelf Ends //

      //Lamp Starts //
      //Answer No 118
      else if (widget.CheckCompleteQuestion == "How much was the lamp?" &&
          widget.CheckQuestion == "Amount lamp") {
        //Question No 119
        return educationdateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "When did ${Questions.educationYouIdentity} buy the lamp?",
            "Purchase date",
            430.0,
            "",
            Questions.educationExpfurniture);
      }

      //Answer No 119
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy the lamp?" &&
          widget.CheckQuestion == "Purchase date") {
        if (Questions.expFurnitureLength <= Questions.totalExpFurniture) {
          //Question No 110
          return educationdifferentoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              [
                "Desk",
                "Office chair",
                "Bookshelf",
                "Lamp",
                "Filing cabinet",
                "Other"
              ],
              220.0,
              "",
              Questions.educationExpfurniture);
        } else {
          //Question No 113
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        }
      }

//Lamp Ends //

      //Filing cabinet Starts //
      //Answer No 120
      else if (widget.CheckCompleteQuestion ==
              "How much was the filing cabinet?" &&
          widget.CheckQuestion == "Amount filing cabinet") {
        //Question No 121
        return educationdateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "When did ${Questions.educationYouIdentity} buy the filing cabinet?",
            "Purchase date",
            430.0,
            "",
            Questions.educationExpfurniture);
      }

      //Answer No 121
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy the filing cabinet?" &&
          widget.CheckQuestion == "Purchase date") {
        if (Questions.expFurnitureLength <= Questions.totalExpFurniture) {
          //Question No 110
          return educationdifferentoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              [
                "Desk",
                "Office chair",
                "Bookshelf",
                "Lamp",
                "Filing cabinet",
                "Other"
              ],
              220.0,
              "",
              Questions.educationExpfurniture);
        } else {
          //Question No 113
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        }
      }

//Filing cabinet Ends //

      //Other Starts //

      //Answer No 122
      else if (widget.CheckCompleteQuestion ==
              "What kind of  furniture did ${Questions.educationYouIdentity} buy?" &&
          widget.CheckQuestion == "Type") {
        //Question No 123
        return educationcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "How much did ${Questions.educationYouIdentity} spent on the ${Questions.educationOtherFurniture}?",
            "Amount",
            220.0,
            "calculation",
            Questions.educationExpfurniture);
      }

      //Answer No 123
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spent on the ${Questions.educationOtherFurniture}?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 124
        return educationdateContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "When did ${Questions.educationYouIdentity} buy the ${Questions.educationOtherFurniture}?",
            "Purchase date",
            430.0,
            "",
            Questions.educationExpfurniture);
      }

      //Answer No 124
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy the ${Questions.educationOtherFurniture}?" &&
          widget.CheckQuestion == "Purchase date") {
        if (Questions.expFurnitureLength <= Questions.totalExpFurniture) {
          //Question No 110
          return educationdifferentoptionContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What kind of furniture did ${Questions.educationYouIdentity} buy?",
              "Type",
              [
                "Desk",
                "Office chair",
                "Bookshelf",
                "Lamp",
                "Filing cabinet",
                "Other"
              ],
              220.0,
              "",
              Questions.educationExpfurniture);
        } else {
          //Question No 113
          return educationyesnoContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?",
              "< 952 EUR",
              220.0,
              "",
              Questions.trainingText);
        }
      }

//Other Ends //

      //Answer No 113
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} spend less than 952 EUR on any piece of office furniture?" &&
          widget.CheckQuestion == "< 952 EUR") {
        if (widget.CheckAnswer[0] == "No") {
          //Question No 102
          return educationmultitwoContainer(
              """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
              "Previous years",
              ["Computer / Laptop", "Other expensive items", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          //Question No 102
          return educationmultitwoContainer(
              """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
              "Previous years",
              ["Computer / Laptop", "Other expensive items", "No"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0,
              "No",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          //Question No 125
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "How much did ${Questions.educationYouIdentity} spend on these items in total?",
              "Total amount",
              320.0,
              "calculation",
              Questions.trainingText);
        }
      }

//Answer No 125
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on these items in total?" &&
          widget.CheckQuestion == "Total amount") {
        //Question No 102
        return educationmultitwoContainer(
            """
<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state whether you spent more than 488 euros (until 2017) respectively 952 euro (as of 2018) on work equipment in past years (including Vat). Select "yes" if this applies to you. If you spent less click "no".</p>
<p>If the **cost of individual items of work equipment exceeded those costs they need to be depreciated over their usual service life.</p>
<p>Whether you can deduct it on this tax return depends on the year 2019 you bought the item, the price and the depreciation period. If there is a remaining value in you may enter that. How to work out remaining value is <u>shown here</u></p>
<p><u> </u></p>
""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?",
            "Previous years",
            ["Computer / Laptop", "Other expensive items", "No"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0,
            "No",
            Questions.trainingText);
      }

      // ====== Office Furniture Ends ====== //

      //Answer No 102
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} buy expensive items in the past few years for ${Questions.educationYourIdentity} training?" &&
          widget.CheckQuestion == "Previous years") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Computer / laptop") {
            //Question No 103
            return educationdateContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "When did ${Questions.educationYouIdentity} buy ${Questions.educationYourIdentity} computer?",
                "Purchase date",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "Other expensive items") {
            //Question No 127
            return educationcalculationContainer(
                "<h1>Coming Soon!</h1>",
                "",
                "Education",
                "How much other valuable items for training did ${Questions.educationYouIdentity} buy in previous years?",
                "Quantity",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "No") {
//Question No 126
            return educationyesnoContainer("""

<p><strong>Repairs/dry cleaning</strong></p>
<p>Please state whether you required repair or dry cleaning services for your training equipment.</p>
<p>For example, you can state whether your <strong>laptop</strong> needed repairs.</p>
<p> </p>


""",
                "",
                "Education",
                "Did ${Questions.educationYouIdentity} have any service costs for ${Questions.educationYourIdentity} training equipment?",
                "Maintenance costs",
                220.0,
                "",
                Questions.trainingText);
          } else if (widget.CheckAnswer[m] == "skip") {
//Question No 126
            return educationyesnoContainer("""

<p><strong>Repairs/dry cleaning</strong></p>
<p>Please state whether you required repair or dry cleaning services for your training equipment.</p>
<p>For example, you can state whether your <strong>laptop</strong> needed repairs.</p>
<p> </p>


""",
                "",
                "Education",
                "Did ${Questions.educationYouIdentity} have any service costs for ${Questions.educationYourIdentity} training equipment?",
                "Maintenance costs",
                220.0,
                "",
                Questions.trainingText);
          }
        }
      }

      //Answer No 103
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.educationYouIdentity} buy ${Questions.educationYourIdentity} computer?" &&
          widget.CheckQuestion == "Purchase date") {
        //Question No 126
        return educationyesnoContainer("""

<p><strong>Repairs/dry cleaning</strong></p>
<p>Please state whether you required repair or dry cleaning services for your training equipment.</p>
<p>For example, you can state whether your <strong>laptop</strong> needed repairs.</p>
<p> </p>


""",
            "",
            "Education",
            "Did ${Questions.educationYouIdentity} have any service costs for ${Questions.educationYourIdentity} training equipment?",
            "Maintenance costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 127
      else if (widget.CheckCompleteQuestion ==
              "How much other valuable items for training did ${Questions.educationYouIdentity} buy in previous years?" &&
          widget.CheckQuestion == "Quantity") {
        //Question No 128
        return educationcalculationContainer(
            "<h1>Coming Soon!</h1>",
            "",
            "Education",
            "What items did ${Questions.educationYouIdentity} purchase for ${Questions.educationYourIdentity} training?",
            "Items",
            220.0,
            "",
            Questions.equipmentText);
      }

      //Answer No 128
      else if (widget.CheckCompleteQuestion ==
              "What items did ${Questions.educationYouIdentity} purchase for ${Questions.educationYourIdentity} training?" &&
          widget.CheckQuestion == "Items") {
        //Question No 129
        return educationcalculationContainer("""

<p><strong>Depreciation of work equipment from past years</strong></p>
<p>Please state what amount you can depreciate for work equipment. If you are unsure continue reading below. We'll show you how to work out the correct amount.</p>
<p>If the <strong>cost including VAT of individual items of work equipment exceed 488 euros (until 2017) resp. 952 euro (as of 2018) </strong>then you cannot deduct the full cost at once.</p>
<p><strong>It has to be depreciated over its usual service life.</strong></p>
<p>The tax office determines the depreciation periods for you. You can find the correct period in the <strong>depreciation tables</strong> <u>AfA-Tabellen.</u></p>
<p>Divide the cost of the work equipment you bought by its usual service life as determined in the AFA tables. This will give you the depreciation amount.</p>
<p>There is a detailed explanation on how to work out the amount for this year <strong>in our article on taxfix.de</strong> <u>So funktioniert Abschreiben in der Steuererklärung.</u></p>
<p> </p>
<p> </p>


""",
            "",
            "Education",
            "What can ${Questions.educationYouIdentity} depreciate for item ${Questions.equipmentName} in 2019?",
            "Amount",
            220.0,
            "calculation",
            Questions.equipmentText);
      }

      //Answer No 129
      else if (widget.CheckCompleteQuestion ==
              "What can ${Questions.educationYouIdentity} depreciate for item ${Questions.equipmentName} in 2019?" &&
          widget.CheckQuestion == "Amount") {
        if (Questions.equipmentLength <= Questions.totalEquipment) {
          //Question No 128
          return educationcalculationContainer(
              "<h1>Coming Soon!</h1>",
              "",
              "Education",
              "What items did ${Questions.educationYouIdentity} purchase for ${Questions.educationYourIdentity} training?",
              "Items",
              220.0,
              "",
              Questions.equipmentText);
        } else {
          //Question No 126
          //For No 220.0
          //For Yes 320.0
          return educationyesnoContainer("""

<p><strong>Repairs/dry cleaning</strong></p>
<p>Please state whether you required repair or dry cleaning services for your training equipment.</p>
<p>For example, you can state whether your <strong>laptop</strong> needed repairs.</p>
<p> </p>


""",
              "",
              "Education",
              "Did ${Questions.educationYouIdentity} have any service costs for ${Questions.educationYourIdentity} training equipment?",
              "Maintenance costs",
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 126
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.educationYouIdentity} have any service costs for ${Questions.educationYourIdentity} training equipment?" &&
          widget.CheckQuestion == "Maintenance costs") {
        if (widget.CheckAnswer[0] == "No") {
          //Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "skip") {
          //Question No 10
          return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
              "",
              "Education",
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
              "Reimbursement of costs",
              220.0,
              "",
              Questions.trainingText);
        } else if (widget.CheckAnswer[0] == "Yes") {
          //Question No 130
          return educationmultitwoContainer(
              """
<p><strong>Repair or dry cleaning costs</strong></p>
<p>Select the applicable answer. You may select both if you had costs for both.</p>
<p>You can choose between:</p>
<ul>
<li>Dry cleaning costs</li>
<li>Repair costs</li>
</ul>
<p> </p>


""",
              "",
              "Education",
              "What costs did ${Questions.educationYouIdentity} have?",
              "Costs",
              ["Repairs", "Dry cleaning"],
              ["images/disabilityoption.png", "images/alimonypaidoption.png"],
              220.0,
              "",
              Questions.trainingText);
        }
      }

      //Answer No 130
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.educationYouIdentity} have?" &&
          widget.CheckQuestion == "Costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Repairs") {
            //Question No 131
            return educationcalculationContainer("""

<p><strong>Repair costs</strong></p>
<p>Please state how much you spent on the repair service. Keep in mind only repair costs from 2019 are relevant.</p>
<p>Tax offices commonly grant a standard amount of up to 110 euros for acquisition, repair or cleaning of work equipment.</p>
<p>Unless you can prove higher expenses you may claim this amount.</p>
<p>Of course, there is no <strong>guarantee</strong> but it's well worth a try.</p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on repairs?",
                "Repair costs",
                220.0,
                "calculation",
                Questions.equipmentText);
          } else if (widget.CheckAnswer[m] == "skip") {
            //Question No 131
            return educationcalculationContainer("""

<p><strong>Repair costs</strong></p>
<p>Please state how much you spent on the repair service. Keep in mind only repair costs from 2019 are relevant.</p>
<p>Tax offices commonly grant a standard amount of up to 110 euros for acquisition, repair or cleaning of work equipment.</p>
<p>Unless you can prove higher expenses you may claim this amount.</p>
<p>Of course, there is no <strong>guarantee</strong> but it's well worth a try.</p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on repairs?",
                "Repair costs",
                220.0,
                "calculation",
                Questions.equipmentText);
          } else if (widget.CheckAnswer[m] == "Dry cleaning") {
//Question No 132
            return educationcalculationContainer("""

<p><strong>Dry cleaning costs</strong></p>
<p>Please state how much you spent on cleaning services. Note that only cleaning costs from 2019 are relevant here.</p>
<ol>
<li>If someone reimbursed you for part of the cost you may only enter the expenses that you had yourself.</li>
<li>If you cleaned your training clothing at home then your tax deductible amount can be determined from the weight of the clothing, the washing machine program used (colored or not) and whether or not you made use of a dryer.</li>
</ol>
<p>For further assistance, there is a detailed list on <strong>our article on taxfix.de</strong> tax tips <u>Nichtbeanstandungsgrenzen – Kosten ohne Belege absetzen</u></p>
<p><u> </u></p>


""",
                "",
                "Education",
                "How much did ${Questions.educationYouIdentity} spend on dry cleaning?",
                "Dry cleaning costs",
                220.0,
                "calculation",
                Questions.equipmentText);
          }
        }
      }

      //Answer No 131
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on repairs?" &&
          widget.CheckQuestion == "Repair costs") {
        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      //Answer No 132
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.educationYouIdentity} spend on dry cleaning?" &&
          widget.CheckQuestion == "Dry cleaning costs") {
        //Question No 10
        return educationyesnoContainer("""

<p><strong>Reimbursement of training expenses</strong></p>
<p>Select "yes" if your employer or the employment agency has reimbursed you for costs incurred from training courses. Otherwise click "no".</p>
<p>Unfortunately, reimbursements <strong>do not reduce your tax bill</strong>.</p>
<p> </p>

""",
            "",
            "Education",
            "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?",
            "Reimbursement of costs",
            220.0,
            "",
            Questions.trainingText);
      }

      // ====== Items for education (e.g. computer, office furniture etc.) Ends ======//

      //Answer No 10
      else if (widget.CheckCompleteQuestion ==
              "Were the costs reimbursed by ${Questions.educationYourIdentity} employer or the employment agency?" &&
          widget.CheckQuestion == "Reimbursement of costs") {
        if (widget.CheckAnswer[0] == "No") {
          //Yaha multiple hoga dobara
          if (Questions.trainingLength <= Questions.totalTraining) {
            //Question No 5
            return educationdifferentoptionContainer(
                """

<p><strong>Type of training</strong></p>
<p>Please indicate here the type of training or study.</p>
<p><strong>DUAL STUDIES - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A UNIVERSITY OR COLLEGE AND LEARNED THE PRACTICAL PART IN A COMPANY.</strong></p>
<p><strong>VOCATIONAL TRAINING (AT VOCATIONAL SCHOOL AND IN THE COMPANY) - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A VOCATIONAL SCHOOL AND LEARNED THE PRACTICAL PART IN THE COMPANY WHERE YOU WERE TRAINED.</strong></p>
<p><strong>PART-TIME TRAINING (E.G. DISTANCE LEARNING) - YOU HAVE BEEN ENROLLED AS A STUDENT AT A DISTANCE UNIVERSITY IN ADDITION TO YOUR PROFESSIONAL ACTIVITIES.</strong></p>
<p><strong>FULL-TIME STUDIES - YOU HAVE STUDIED AS A FULL-TIME STUDENT AT A UNIVERSITY OR COLLEGE.</strong></p>
<p><strong>SCHOOL-BASED APPRENTICESHIP - YOU HAVE ATTENDED A TECHNICAL COLLEGE, NOT A UNIVERSITY, FULL-TIME FOR YOUR EDUCATION.</strong></p>
<p> </p>


""",
                "",
                "Education",
                "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?",
                "Kind of training",
                [
                  "Dual studies (job and university)",
                  "Vocational training (job and school)",
                  "Besides job (e.g. distance learning)",
                  "Full time study (university only)",
                  "School training",
                  "None of the above"
                ],
                220.0,
                "",
                Questions.trainingText);
          } else {
            //For partner Relation
            if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
                Questions.educationPartner == true) {
              educationPartner();
              //Question No 1
              return educationyesnoContainer("""
<p><strong>Graduated before 2019</strong></p>
<p>Please indicate here whether you have already completed a vocational or academic degree before the year 2019. The length of the training must have been at least 12 months for full-time training and was concluded through a final examination.</p>
<p> </p>


""",
                  "",
                  "Education",
                  "Did ${Questions.educationYouIdentity} complete any degrees or professional qualifications before 2019?",
                  "Degree before 2019",
                  220.0,
                  "",
                  "");
            } else {
              return FinishCategory(checkFamily, checkFamily, 4, true);
            }

            //return FinishCategory("Education Category", "Family Category");

          }
        } else if (widget.CheckAnswer[0] == "skip") {
          //Yaha multiple hoga dobara
          if (Questions.trainingLength <= Questions.totalTraining) {
            //Question No 5
            return educationdifferentoptionContainer(
                """

<p><strong>Type of training</strong></p>
<p>Please indicate here the type of training or study.</p>
<p><strong>DUAL STUDIES - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A UNIVERSITY OR COLLEGE AND LEARNED THE PRACTICAL PART IN A COMPANY.</strong></p>
<p><strong>VOCATIONAL TRAINING (AT VOCATIONAL SCHOOL AND IN THE COMPANY) - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A VOCATIONAL SCHOOL AND LEARNED THE PRACTICAL PART IN THE COMPANY WHERE YOU WERE TRAINED.</strong></p>
<p><strong>PART-TIME TRAINING (E.G. DISTANCE LEARNING) - YOU HAVE BEEN ENROLLED AS A STUDENT AT A DISTANCE UNIVERSITY IN ADDITION TO YOUR PROFESSIONAL ACTIVITIES.</strong></p>
<p><strong>FULL-TIME STUDIES - YOU HAVE STUDIED AS A FULL-TIME STUDENT AT A UNIVERSITY OR COLLEGE.</strong></p>
<p><strong>SCHOOL-BASED APPRENTICESHIP - YOU HAVE ATTENDED A TECHNICAL COLLEGE, NOT A UNIVERSITY, FULL-TIME FOR YOUR EDUCATION.</strong></p>
<p> </p>


""",
                "",
                "Education",
                "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?",
                "Kind of training",
                [
                  "Dual studies (job and university)",
                  "Vocational training (job and school)",
                  "Besides job (e.g. distance learning)",
                  "Full time study (university only)",
                  "School training",
                  "None of the above"
                ],
                220.0,
                "",
                Questions.trainingText);
          } else {
            //For partner Relation
            if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
                Questions.educationPartner == true) {
              educationPartner();
              //Question No 1
              return educationyesnoContainer("""
<p><strong>Graduated before 2019</strong></p>
<p>Please indicate here whether you have already completed a vocational or academic degree before the year 2019. The length of the training must have been at least 12 months for full-time training and was concluded through a final examination.</p>
<p> </p>


""",
                  "",
                  "Education",
                  "Did ${Questions.educationYouIdentity} complete any degrees or professional qualifications before 2019?",
                  "Degree before 2019",
                  220.0,
                  "",
                  "");
            } else {
              return FinishCategory(checkFamily, checkFamily, 4, true);
            }

            //return FinishCategory("Education Category", "Family Category");

          }
        } else if (widget.CheckAnswer[0] == "Yes") {
          //Question No 11
          return educationcalculationContainer("""

<p><strong>Amount of training costs reimbursed</strong></p>
<p>If you employer or the employment agency reimbursed you for costs, then you can enter the amount here.</p>
<p>Note that only reimbursements for 2019 count: both the cost and the reimbursement must be from 2019.</p>
<p>Unfortunately, reimbursements do not reduce your tax bill any further.</p>
<p> </p>


""", "", "Education", "How much money was reimbursed?", "Reimbursed", 210.0,
              "calculation", Questions.trainingText);
        }
      }

      //Answer No 11
      else if (widget.CheckCompleteQuestion ==
              "How much money was reimbursed?" &&
          widget.CheckQuestion == "Reimbursed") {
//    Yaha multiple hoga dobara
        if (Questions.trainingLength <= Questions.totalTraining) {
          //Question No 5
          return educationdifferentoptionContainer(
              """
<p><strong>Type of training</strong></p>
<p>Please indicate here the type of training or study.</p>
<p><strong>DUAL STUDIES - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A UNIVERSITY OR COLLEGE AND LEARNED THE PRACTICAL PART IN A COMPANY.</strong></p>
<p><strong>VOCATIONAL TRAINING (AT VOCATIONAL SCHOOL AND IN THE COMPANY) - YOU HAVE COMPLETED THE THEORETICAL PART OF YOUR TRAINING AT A VOCATIONAL SCHOOL AND LEARNED THE PRACTICAL PART IN THE COMPANY WHERE YOU WERE TRAINED.</strong></p>
<p><strong>PART-TIME TRAINING (E.G. DISTANCE LEARNING) - YOU HAVE BEEN ENROLLED AS A STUDENT AT A DISTANCE UNIVERSITY IN ADDITION TO YOUR PROFESSIONAL ACTIVITIES.</strong></p>
<p><strong>FULL-TIME STUDIES - YOU HAVE STUDIED AS A FULL-TIME STUDENT AT A UNIVERSITY OR COLLEGE.</strong></p>
<p><strong>SCHOOL-BASED APPRENTICESHIP - YOU HAVE ATTENDED A TECHNICAL COLLEGE, NOT A UNIVERSITY, FULL-TIME FOR YOUR EDUCATION.</strong></p>
<p> </p>
<p> </p>


""",
              "",
              "Education",
              "Which best applies to ${Questions.educationYourIdentity} training no. ${Questions.trainingLength}?",
              "Kind of training",
              [
                "Dual studies (job and university)",
                "Vocational training (job and school)",
                "Besides job (e.g. distance learning)",
                "Full time study (university only)",
                "School training",
                "None of the above"
              ],
              220.0,
              "",
              Questions.trainingText);
        } else {
          //For Partner Relation
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.educationPartner == true) {
            educationPartner();
            //Question No 1
            return educationyesnoContainer("""
<p><strong>Graduated before 2019</strong></p>
<p>Please indicate here whether you have already completed a vocational or academic degree before the year 2019. The length of the training must have been at least 12 months for full-time training and was concluded through a final examination.</p>
<p> </p>


""",
                "",
                "Education",
                "Did ${Questions.educationYouIdentity} complete any degrees or professional qualifications before 2019?",
                "Degree before 2019",
                220.0,
                "",
                "");
          } else {
            return FinishCategory(checkFamily, checkFamily, 4, true);
          }

          //return FinishCategory("Education Category", "Family Category");
        }
      }
    }
  }

  Widget educationyesnoContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationYesNoContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget educationcalculationContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationCalculationContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget educationdifferentoptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationDifferentOptionContainer(
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

  Widget educationmultipleoptionsContainer(
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
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationMultipleOptionsContainer(
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

  Widget educationtwooptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationTwoOptionContainer(
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

  Widget educationmultithreeContainer(
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
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationMultiThreeContainer(
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

  Widget educationdateContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData,
      String MultipleData) {
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationDateContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  Widget educationmultitwoContainer(
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
    Questions.educationAnimatedContainer = animatedcontainer;
    return EducationMultiTwoContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 320.0,
        additionalData: AdditionalData,
        multipleData: MultipleData);
  }

  void educationPartner() {
    Questions.educationAnimatedContainer = 220.0;

    qu.EducationAddAnswer("Partner", "", "", "", [], 60.0);
    Questions.educationPartner = false;

    Questions.educationYouIdentity = "your partner";
    Questions.educationYourIdentity = "your partner";

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
            Questions.educationAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EducationMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList =
                Questions.educationAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.educationAnswerShow = [];
            Questions.educationAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EducationMainQuestions(
                  CheckCompleteQuestion:
                      Questions.educationAnswerShow[currentIndex - 1]
                          ['completequestion'],
                  CheckQuestion: Questions.educationAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.educationAnswerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
          height: Questions.educationAnswerShow[currentIndex]
              ['containerheight'],
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
                        Questions.educationAnswerShow[currentIndex]['question'],
                        style: TextStyle(
                          color: Color(0xFF003350).withOpacity(0.803),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaBold',
                        ),
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
                            Questions.educationAnswerShow[currentIndex]
                                ['answer'][0],
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
            Questions.educationAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EducationMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList =
                Questions.educationAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.educationAnswerShow = [];
            Questions.educationAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EducationMainQuestions(
                  CheckCompleteQuestion:
                      Questions.educationAnswerShow[currentIndex - 1]
                          ['completequestion'],
                  CheckQuestion: Questions.educationAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.educationAnswerShow[currentIndex - 1]['answer'][0]
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
                          Questions.educationAnswerShow[currentIndex]
                              ['question'],
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
                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Colors.lightBlue)),
                        Container(
                            width: 140.0,
                            // color:Colors.blue,
                            child: AutoSizeText(
                              Questions.educationAnswerShow[currentIndex]
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
