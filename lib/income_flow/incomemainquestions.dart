//import 'package:easy_taxx/questions.dart';

import 'dart:io';
import 'package:easy_taxx/show.dart';
import 'package:easy_taxx/livingsituation_flow/container1.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/income_flow/payslipcontainer.dart';
import 'package:easy_taxx/income_flow/threeoptioncontainer.dart';
import 'package:easy_taxx/income_flow/datecontainer.dart';
import 'package:easy_taxx/income_flow/addresscontainer.dart';
import 'package:easy_taxx/income_flow/fouroptioncontainer.dart';
import 'package:easy_taxx/income_flow/calculationcontainer.dart';
import 'package:easy_taxx/income_flow/multithreecontainer.dart';
import 'package:easy_taxx/income_flow/yesnocontainer.dart';
import 'package:easy_taxx/income_flow/multipleoptionscontainer.dart';
import 'package:easy_taxx/income_flow/domaincontainer.dart';
import 'package:easy_taxx/income_flow/multipleoptionscontainerno.dart';
import 'package:easy_taxx/income_flow/twooptioncontainer.dart';
import 'package:easy_taxx/income_flow/valuablenamecontainer.dart';
import 'package:easy_taxx/income_flow/valuableownedcontainer.dart';
import 'package:easy_taxx/income_flow/threeoptionpayslipcontainer.dart';
import 'package:easy_taxx/finishcategory.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'preview_pdf.dart';

class IncomeMainQuestions extends StatefulWidget {
  String CheckCompleteQuestion;
  String CheckQuestion;
  List CheckAnswer;

  IncomeMainQuestions(
      {Key key,
      this.CheckCompleteQuestion,
      this.CheckQuestion,
      this.CheckAnswer})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<IncomeMainQuestions> {
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
  String checkShared = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = new TextEditingController();
  var _image;

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    setState(() {
      _image = null;
      _fileName = null;
    });
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
        // _insert(_path.toString());
        // print(_path.toString() + "....FILE PATH");

      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  Future<void> _photogallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;

      // _insert(_image.toString());
      // print(_image.toString() + "....IMAGE PATH");
    });
  }

  // void _insert(String imagee) async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     DbHelper.columnImage: imagee,
  //   };
  //   final id = await dbHelper.insert(row);
  //   DbHelper.insatance.delete(id);
  //   print('inserted row id: $id');
  // }

  // Future<void> _browsefiles() async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => FilePickerDemo()));
  // }

  _mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Browse Files', _openFileExplorer),
              _createTile(context, 'Photo Gallery', _photogallery),
            ],
          );
        });
  }

  ListTile _createTile(BuildContext context, String name, Function action) {
    return ListTile(
      title: Text(
        name,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  Future<String> _getStringKey() async {
    final prefs = await SharedPreferences.getInstance();
    // read
    final String myString = prefs.getString('miniJobCheck') ?? '';
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
    _getStringKey();
    //timer();
    Screenheight();
    DynamicContainer();
  }

  void Screenheight() {
    print("question length:" + Questions.incomeAnswerShow.length.toString());

    for (k = l; k < Questions.incomeAnswerShow.length; k++) {
      print("how manysdsdsd");
      screenHeightbig = 0.0;
      if (Questions.incomeAnswerShow[k]['identity'] == "You" ||
          Questions.incomeAnswerShow[k]['identity'] == "You & Partner" ||
          Questions.incomeAnswerShow[k]['identity'] == "Partner") {
        screenHeight = screenHeight + 70.0;
      } else if (Questions.incomeAnswerShow[k]['details'] == "") {
        screenHeight = screenHeight + 60.0;
        detail = true;
      } else {
        detailsHeight = Questions.incomeAnswerShow[k]['details'];

        for (l = k; l < Questions.incomeAnswerShow.length; l++) {
          if (Questions.incomeAnswerShow[l]['details'] == detailsHeight) {
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
    screenHeight = screenHeight + Questions.incomeAnimatedContainer;
    // screenHeight = screenHeight;
    print("Screen Height:" + screenHeight.toString());
//    print("Screen Height big:"+screenHeightbig.toString());

    detail = true;
  }

  void DynamicContainer() {
    hlength = 0;
    // print("question length:"+Questions.answerShow.length.toString());
    for (i = j; i < Questions.incomeAnswerShow.length; i++) {
      print("value oif i is:" + i.toString());

      print("dat is:" + i.toString());
      //You and your and your partner identity
      if (Questions.incomeAnswerShow[i]['identity'] == "You" ||
          Questions.incomeAnswerShow[i]['identity'] == "You & Partner" ||
          Questions.incomeAnswerShow[i]['identity'] == "Partner") {
        dynamicContainer.add(Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: Questions.incomeAnswerShow[i]['containerheight'],
          width: 450.0,
          child: Text(Questions.incomeAnswerShow[i]['identity'],
              style: TextStyle(fontSize: 40.0)),
        ));
      } else if (Questions.incomeAnswerShow[i]['details'] == "") {
        dynamicContainer.add(SingleSmallContainer(currentIndex: i)
//            Container(
//              margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
//              height: Questions.incomeAnswerShow[i]['containerheight'],
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
//                          child:AutoSizeText(Questions.incomeAnswerShow[i]['question'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                      ),
//                      Row(children: <Widget>[
//                        //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                        Container(
//                            width: 140.0,
//                            // color:Colors.blue,
//                            child:AutoSizeText(Questions.incomeAnswerShow[i]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
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
        detailOption = Questions.incomeAnswerShow[i]['details'];
        print(detailOption);
        countLongContainer = 0;
//print("ahsjasjasksss");

        //set length of data in details that how much data comes
        for (co = i; co < Questions.incomeAnswerShow.length; co++) {
          if (Questions.incomeAnswerShow[co]['details'] == detailOption) {
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
          if (Questions.incomeAnswerShow[j]['details'] == detailOption &&
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
                              Questions.incomeAnswerShow[i]['details'],
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
          if (Questions.incomeAnswerShow[j]['details'] == detailOption &&
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
//                              child:AutoSizeText(Questions.incomeAnswerShow[j]['question'],style: TextStyle(color: Colors.grey),minFontSize:14.0,maxLines: 1,overflow: TextOverflow.ellipsis,)
//                          ),
//                          Row(children: <Widget>[
//                            //Text(Questions.answerShow[i]['answer'],style: TextStyle(color: Color(0xFF38B6FF))),
//                            Container(
//                                width: 140.0,
//                                // color:Colors.blue,
//                                child:AutoSizeText(Questions.incomeAnswerShow[j]['answer'][0],textAlign: TextAlign.end,minFontSize: 14.0,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),)
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
                            "Income",
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
        //       onTap: (){
        //         Navigator.pushReplacementNamed(context, 'allCategoryScreen');
        //         //  Navigator.pop(context);
        //       },
        //       child:Icon(Icons.arrow_back_ios,color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),size: 20.0)
        //   ),
        //     title: Text('Income',style: TextStyle(color: Colors.black,fontSize: 14.0),),
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
                          IncomeChangeContainer(),
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

  Widget IncomeChangeContainer() {
    if (Questions.incomeAnswerShow.length == 0) {
      if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3)) {
        qu.IncomeAddAnswer("You", "", "", "", [], 60.0);
      }

      //qu.IncomeAddAnswer("You", "","","", [], 60.0);
      //last parameter for next screen container animated size which is 220.0
      //Question No 1
      //for no 340.0
      //for yes 220.0

      print(checkShared + " check shares in ifelse");

      if (checkShared == 'no') {
        return payslipContainer(""" """,
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} received ${Questions.incomeYourIdentity} annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
            "Annual payslip",
            340.0);
      } else {
        return yesnoContainer(
            """<p><strong>Multiple annual wage statement</strong></p>
<p>If you only had one employer during the whole year 2019, you usually only have one annual wage and tax certificate for that year.</p>
<p>However, if you changed employers or had a second job, you will have several annual wage and tax certificates.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "did ${Questions.incomeYouIdentity} receive more than one annual wage statement (e.g: due to different employers)?",
            "More than one payslip",
            220.0,
            "");
      }
    } else {
      //Answer No 1

      if ((widget.CheckCompleteQuestion ==
                  "Have ${Questions.incomeYouIdentity} received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?" ||
              widget.CheckCompleteQuestion ==
                  "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?") &&
          widget.CheckQuestion == "Annual payslip") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Have received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?');
          _insert(
              'Have received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?',
              'No',
              'OK');

          //Question No 2
          //for had ma mini job 220.0
          //for I had no employer 220.0
          //for I dont't know 220.0
          return threeoptionContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Why have ${Questions.incomeYouIdentity} not received your annual payslip (Lohnsteuerbescheinigung) for 2019?",
              "Reason",
              ["Had a mini job", "I had no employer", "I don't know"],
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Have received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?');
          _insert(
              'Have received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?',
              'Yes',
              'OK');

          // we will work later on it
          //For No 340.0
          //For yes 220.0
          //Question No 153
          return yesnoContainer(
              """<p><strong>Multiple annual wage statement</strong></p>
<p>If you only had one employer during the whole year 2019, you usually only have one annual wage and tax certificate for that year.</p>
<p>However, if you changed employers or had a second job, you will have several annual wage and tax certificates.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "did ${Questions.incomeYouIdentity} receive more than one annual wage statement (e.g: due to different employers)?",
              "More than one payslip",
              220.0,
              "");
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance
            ..deleteWithquestion(
                'Have received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?');
          _insert(
              'Have received your annual payslip(s) (Lohnsteuerbescheinigung) for 2019?',
              'skip',
              'skip');

          // we will work later on it
          //For No 340.0
          //For yes 220.0
          //Question No 153
          return yesnoContainer(
              """<p><strong>Multiple annual wage statement</strong></p>
<p>If you only had one employer during the whole year 2019, you usually only have one annual wage and tax certificate for that year.</p>
<p>However, if you changed employers or had a second job, you will have several annual wage and tax certificates.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "did ${Questions.incomeYouIdentity} receive more than one annual wage statement (e.g: due to different employers)?",
              "More than one payslip",
              220.0,
              "");
        }
      }

      //Answer No 2
      else if (widget.CheckCompleteQuestion ==
              "Why have ${Questions.incomeYouIdentity} not received your annual payslip (Lohnsteuerbescheinigung) for 2019?" &&
          widget.CheckQuestion == "Reason") {
        if (widget.CheckAnswer[0] == "Had a mini job") {
          DbHelper.insatance.deleteWithquestion(
              'Why have not received your annual payslip (Lohnsteuerbescheinigung) for 2019?');
          _insert(
              'Why have not received your annual payslip (Lohnsteuerbescheinigung) for 2019?',
              'Had a mini job',
              'OK');

          //For relation to enable work
          Questions.workCategoryEnable = "";

          //Agar sale of property select hoga living situation ma to phir ya sale date  wala sawal aiga wrna sales wala sawal aiga
          if (Questions.salePropertyIncome == "Sale of property") {
            //Question No 4
            return dateContainer(
                """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "When did ${Questions.incomeYouIdentity} sell the property?",
                "Sale date",
                220.0);
          } else {
            //Question No 10
            //For web domains 220.0
            //For Bitcoins 220.0
            //For other valuables 220.0
            // For None 430.0
            return multithreeContainer(
                """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} sold any assets?",
                "Sales",
                ["Web domains", "Bitcoins", "Other valuables", "None"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                430.0);
          }
        } else if (widget.CheckAnswer[0] == "I had no employer") {
          DbHelper.insatance.deleteWithquestion(
              'Why have not received your annual payslip (Lohnsteuerbescheinigung) for 2019?');
          _insert(
              'Why have not received your annual payslip (Lohnsteuerbescheinigung) for 2019?',
              'I had no employer',
              'OK');

          //For relation to enable work
          Questions.workCategoryEnable = "";

          //Agar sale of property select hoga living situation ma to phir ya sale date  wala sawal aiga wrna sales wala sawal aiga
          if (Questions.salePropertyIncome == "Sale of property") {
            //Question No 4
            return dateContainer(
                """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "When did ${Questions.incomeYouIdentity} sell the property?",
                "Sale date",
                220.0);
          } else {
            //Question No 10
            //For web domains 220.0
            //For Bitcoins 220.0
            //For other valuables 220.0
            // For None 430.0
            return multithreeContainer(
                """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} sold any assets?",
                "Sales",
                ["Web domains", "Bitcoins", "Other valuables", "None"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                430.0);
          }
        } else if (widget.CheckAnswer[0] == "I don't know") {
          DbHelper.insatance.deleteWithquestion(
              'Why have not received your annual payslip (Lohnsteuerbescheinigung) for 2019?');
          _insert(
              'Why have not received your annual payslip (Lohnsteuerbescheinigung) for 2019?',
              'I dont know',
              'OK');

          //For relation to enable work
          Questions.workCategoryEnable = "Work";

          //Question No 144
          return yesnoContainer(""" <p><strong>Annual payslip</strong></p>
<p>Please ask your employer to provide you with your annual payslip/wage and tax statement ('Lohnsteuerbescheinigung') for the year 2019.</p>
<p>Usually, you receive your <strong>annual payslip</strong> ('Ausdruck der elektronischen Lohnsteuerbescheinigung') from your employer at the end of the year or after termination of employment.</p>
<p>If you haven't received your annual payslip you can ask your employer to send it to you. Your employer is legally obligated to provide you with your annual payslip by the last day of February the following year. Your employer must also send this data electronically to the tax office. If you are not able to get in touch with your employer to receive the annual payslip, you can ask the tax office to provide you with a printout of this data.</p>
<p><strong>ONE PER EMPLOYER</strong></p>
<p>For each job, you will receive one annual payslip (or more than one, in rare cases).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
 """,
              "",
              "Income",
              "Please request the 'Lohnsteuerbescheinigung' from your employer.",
              "Request",
              220.0,
              "I have it already");
        }
      }

      //Answer No 144
      else if (widget.CheckCompleteQuestion ==
              "Please request the 'Lohnsteuerbescheinigung' from your employer." &&
          widget.CheckQuestion == "Request") {
        //For No 340.0
        //For yes 220.0
        //Question No 153
        return yesnoContainer(
            """<p><strong>Multiple annual wage statement</strong></p>
<p>If you only had one employer during the whole year 2019, you usually only have one annual wage and tax certificate for that year.</p>
<p>However, if you changed employers or had a second job, you will have several annual wage and tax certificates.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "did ${Questions.incomeYouIdentity} receive more than one annual wage statement (e.g: due to different employers)?",
            "More than one payslip",
            220.0,
            "");
      }

      //Answer No 153

      else if (widget.CheckCompleteQuestion ==
              "did ${Questions.incomeYouIdentity} receive more than one annual wage statement (e.g: due to different employers)?" &&
          widget.CheckQuestion == "More than one payslip") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'receive more than one annual wage statement (e.g: due to different employers)?');
          _insert(
              'receive more than one annual wage statement (e.g: due to different employers)?',
              'No',
              'OK');

          //Question No 145
          return threeoptionpayslipContainer(
              """ <p><strong>Annual payslip</strong></p>
<p>Please enter here all data from your annual payslip/wage and tax statement ('Lohnsteuerbescheinigung') for the year 2019. For this you can choose if you want to take a photo of your payslip, import an existing photo of your payslip, or enter the data manually.</p>
<p><strong>PHOTOGRAPH PAYSLIP</strong></p>
<p>This is the most comfortable way to enter the data from your annual payslip. Take a photo of the document, and the app automatically imports the relevant data. Then please verify the imported data. If any line is not correct, you can adjust it by clicking on the respective line.</p>
<p><strong>IMPORT PHOTO</strong></p>
<p>You can import a photo of your annual payslip. Note that this must be a photo. Uploading a PDF does not work because the app cannot read and convert the data.</p>
<p><strong>ENTER MANUALLY</strong></p>
<p>You can also enter all your annual payslip data by hand. Please leave empty those fields which are empty on your payslip.</p>
<p><strong>IMPORTANT</strong></p>
<p>You will normally receive your <strong>annual payslip</strong> from your employer at the end of the year or after termination of employment. This is <strong>not the same as your monthly payslip.</strong></p>
<p>The annual payslip contains your <strong>gross annual salary</strong>, your <strong>contributions to social security</strong> as well as the <strong>amount of tax withheld</strong>.</p> """,
              "",
              "Income",
              "Please choose an input method for ${Questions.incomeYourIdentity} payslip no. 1",
              "Reason",
              ["Scan payslip", "Upload Document", "Enter manually"],
              220.0,
              "PAYSLIP 1"); //ispa kaam  krna ha jb backend lga ga
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'receive more than one annual wage statement (e.g: due to different employers)?');
          _insert(
              'receive more than one annual wage statement (e.g: due to different employers)?',
              'Yes',
              'OK');

          //Question No 154
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "How many annual payslips (Lohnsteuerbescheinigung) have ${Questions.incomeYouIdentity} received for the entire year 2019?",
              "Number",
              340.0,
              "loop"); //ya check kro
        } else if (widget.CheckAnswer[0] == "skip") {
          DbHelper.insatance.deleteWithquestion(
              'receive more than one annual wage statement (e.g: due to different employers)?');
          _insert(
              'receive more than one annual wage statement (e.g: due to different employers)?',
              'skip',
              'skip');

          //Question No 145
          return threeoptionpayslipContainer(
              """ <p><strong>Annual payslip</strong></p>
<p>Please enter here all data from your annual payslip/wage and tax statement ('Lohnsteuerbescheinigung') for the year 2019. For this you can choose if you want to take a photo of your payslip, import an existing photo of your payslip, or enter the data manually.</p>
<p><strong>PHOTOGRAPH PAYSLIP</strong></p>
<p>This is the most comfortable way to enter the data from your annual payslip. Take a photo of the document, and the app automatically imports the relevant data. Then please verify the imported data. If any line is not correct, you can adjust it by clicking on the respective line.</p>
<p><strong>IMPORT PHOTO</strong></p>
<p>You can import a photo of your annual payslip. Note that this must be a photo. Uploading a PDF does not work because the app cannot read and convert the data.</p>
<p><strong>ENTER MANUALLY</strong></p>
<p>You can also enter all your annual payslip data by hand. Please leave empty those fields which are empty on your payslip.</p>
<p><strong>IMPORTANT</strong></p>
<p>You will normally receive your <strong>annual payslip</strong> from your employer at the end of the year or after termination of employment. This is <strong>not the same as your monthly payslip.</strong></p>
<p>The annual payslip contains your <strong>gross annual salary</strong>, your <strong>contributions to social security</strong> as well as the <strong>amount of tax withheld</strong>.</p> """,
              "",
              "Income",
              "Please choose an input method for ${Questions.incomeYourIdentity} payslip no. 1",
              "Reason",
              ["Scan payslip", "Upload Document", "Enter manually"],
              220.0,
              "PAYSLIP 1"); //ispa kaam  krna ha jb backend lga ga
        }
      }

      //Answer No 154
      else if (widget.CheckCompleteQuestion ==
              "How many annual payslips (Lohnsteuerbescheinigung) have ${Questions.incomeYouIdentity} received for the entire year 2019?" &&
          widget.CheckQuestion == "Number") {
        //Question No 145
        return threeoptionpayslipContainer(
            """ <p><strong>Annual payslip</strong></p>
<p>Please enter here all data from your annual payslip/wage and tax statement ('Lohnsteuerbescheinigung') for the year 2019. For this you can choose if you want to take a photo of your payslip, import an existing photo of your payslip, or enter the data manually.</p>
<p><strong>PHOTOGRAPH PAYSLIP</strong></p>
<p>This is the most comfortable way to enter the data from your annual payslip. Take a photo of the document, and the app automatically imports the relevant data. Then please verify the imported data. If any line is not correct, you can adjust it by clicking on the respective line.</p>
<p><strong>IMPORT PHOTO</strong></p>
<p>You can import a photo of your annual payslip. Note that this must be a photo. Uploading a PDF does not work because the app cannot read and convert the data.</p>
<p><strong>ENTER MANUALLY</strong></p>
<p>You can also enter all your annual payslip data by hand. Please leave empty those fields which are empty on your payslip.</p>
<p><strong>IMPORTANT</strong></p>
<p>You will normally receive your <strong>annual payslip</strong> from your employer at the end of the year or after termination of employment. This is <strong>not the same as your monthly payslip.</strong></p>
<p>The annual payslip contains your <strong>gross annual salary</strong>, your <strong>contributions to social security</strong> as well as the <strong>amount of tax withheld</strong>.</p> """,
            "",
            "Income",
            "Please choose an input method for ${Questions.incomeYourIdentity} payslip no. 1",
            "Reason",
            ["Scan payslip", "Upload Document", "Enter manually"],
            220.0,
            "PAYSLIP 1"); //ispa kaam  krna ha jb backend lga ga
      }

      //Answer No 145
      else if (widget.CheckCompleteQuestion ==
              "Please choose an input method for ${Questions.incomeYourIdentity} payslip no. 1" &&
          widget.CheckQuestion == "Reason") {
        if (widget.CheckAnswer[0] == "Upload Document") {
        } else {
          return Text("This work is done later");
        }
      }

      //Answer No 4
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} sell the property?" &&
          widget.CheckQuestion == "Sale date") {
        //Question No 5
        //yaha address ka size aga jaka change hoga
        return dateContainer(
            """ <p><strong>Sale of property: purchase date</strong></p>
<p>Please enter the date you purchased the property.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. Crucial factors are the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the seller.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "When did ${Questions.incomeYouIdentity} buy the property?",
            "Purchase date",
            220.0);
      }

      //Answer No 5
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} buy the property?" &&
          widget.CheckQuestion == "Purchase date") {
        //Question No 6
        return addressContainer("""<h1>Coming Soon!</h1> """, "", "Income",
            "What is the address of the property?", "Property address", 390.0);
      }

      //Answer No 6
      else if (widget.CheckCompleteQuestion ==
              "What is the address of the property?" &&
          widget.CheckQuestion == "Property address") {
        //Question No 7
        return fouroptionContainer(
            """ <p><strong>Sale of property: usage of property</strong></p>
<p>Please state whether you yourself lived in the property or whether other people used the property (also in part). Choose the options that apply.</p>
<p><strong>ANSWER: YES, THE WHOLE TIME</strong></p>
<p>You used the property for private purposes if:</p>
<ul>
<li>You live alone in the property</li>
<li>You live with family</li>
<li>You live with other people</li>
</ul>
<p><strong>ANSWER: PRIVATE AND THIRD PARTY USAGE</strong></p>
<p>Select this answer if you used the property for private purposes, and you also rented it out (and someone else lived there).</p>
<p><strong>ANSWER: FOR SOME TIME</strong></p>
<p>Select this answer if you lived in the property for a short period of time.</p>
<p><strong>NOT AT ALL</strong></p>
<p>Choose this answer if you have never lived in the property.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} use the property as ${Questions.incomeYourIdentity} own residence?",
            "Own residence",
            [
              "Yes, the entire time",
              "Yes, and also as a third-party rental",
              "Some of the time",
              "Not at all"
            ],
            220.0);
      }

      //Answer No 7
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.incomeYouIdentity} use the property as ${Questions.incomeYourIdentity} own residence?" &&
          widget.CheckQuestion == "Own residence") {
        if (widget.CheckAnswer[0] == "Yes, the entire time") {
          DbHelper.insatance
              .deleteWithquestion('Did use the property as own residence?');
          _insert('Did use the property as own residence?',
              'Yes, the entire time', 'OK');

          //Question No 8
          // Yes the entire time 362.0
          // Some of the time 220.0
          // Not at all 220.0
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What is the size of the property in square meters?",
              "Living area",
              362.0,
              "");
        } else if (widget.CheckAnswer[0] ==
            "Yes, and also as a third-party rental") {
          DbHelper.insatance
              .deleteWithquestion('Did use the property as own residence?');
          _insert('Did use the property as own residence?',
              'Yes, and also as a third-party rental', 'OK');

          //Question No 9
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "How many square meters did ${Questions.incomeYouIdentity} use yourself?",
              "Area used by self",
              220.0,
              "");
        } else if (widget.CheckAnswer[0] == "Some of the time") {
          DbHelper.insatance
              .deleteWithquestion('Did use the property as own residence?');
          _insert('Did use the property as own residence?', 'Some of the time',
              'OK');

          //Question No 8
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What is the size of the property in square meters?",
              "Living area",
              362.0,
              "");
        } else if (widget.CheckAnswer[0] == "Not at all") {
          DbHelper.insatance
              .deleteWithquestion('Did use the property as own residence?');
          _insert('Did use the property as own residence?', 'Not at all', 'OK');

          //Question No 8
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What is the size of the property in square meters?",
              "Living area",
              362.0,
              "");
        }
      }

      //Answer No 8
      else if (widget.CheckCompleteQuestion ==
              "What is the size of the property in square meters?" &&
          widget.CheckQuestion == "Living area") {
        if (Questions.residence == "Yes, the entire time") {
          //Question No 10
          //For web domains 220.0
          //For Bitcoins 220.0
          //For other valuables 220.0
          // For None 430.0
          return multithreeContainer(
              """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} sold any assets?",
              "Sales",
              ["Web domains", "Bitcoins", "Other valuables", "None"],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png"
              ],
              430.0);
        } else {
          //Question No 128
          return dateContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} move into the property?",
              "Move in",
              220.0);
        }
      }

      //Answer No 10
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.incomeYouIdentity} sold any assets?" &&
          widget.CheckQuestion == "Sales") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Web domains") {
            DbHelper.insatance.deleteWithquestion('Have sold any assets?');
            _insert('Have sold any assets?', 'Web domains', 'OK');

            //Question No 11
            return yesnoContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} sold more than one domain?",
                "Multiple domain sales",
                220.0,
                "");
          } else if (widget.CheckAnswer[m] == "Bitcoins") {
            DbHelper.insatance.deleteWithquestion('Have sold any assets?');
            _insert('Have sold any assets?', 'Bitcoins', 'OK');

            //Question No 12
            //For no 220.0
            // For yes 430.0

            // return yesnoContainer("""<h1>Coming Soon!</h1> """,
            //     "",
            //     "Income",
            //     "Have you sold more than one bitcoins?",
            //     "Multiple Bitcoins sales",
            //     220.0,
            //     "");

            return yesnoContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Have you owned the bitcoins for longer than a year?",
                "Owned over a year",
                220.0,
                "");
          } else if (widget.CheckAnswer[m] == "Other valuables") {
            DbHelper.insatance.deleteWithquestion('Have sold any assets?');
            _insert('Have sold any assets?', 'Other valuables', 'OK');

            //Question No 13
            return yesnoContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} sold more than one valuable?",
                "Multiple sales",
                220.0,
                "");
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance.deleteWithquestion('Have sold any assets?');
            _insert('Have sold any assets?', 'None', 'OK');

            //Question No 14
            //For Trainer 220.0
            //For Supervisor 220.0
            //For Instructor/ lecturer 220.0
            //For Conductor 220.0
            //For Organist 220.0
            //For Tour guide 220.0
            //For Referee 220.0
            //For Paramedic 220.0
            //For Amateur musician 220.0
            //For other activities for associations 220.0
            //For No 430.0
            return multioptionsContainerNo(
                """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
                "Secondary activities",
                [
                  "Trainer",
                  "Supervisor",
                  "Instructor / lecturer",
                  "Conductor",
                  "Organist",
                  "Tour guide",
                  "Referee",
                  "Paramedic",
                  "Amateur musician",
                  "Other activities for associations",
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
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0);
          }
        }
      } else if (widget.CheckCompleteQuestion ==
              "Have you sold more than one bitcoins?" &&
          widget.CheckQuestion == "Multiple Bitcoins sales") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Have sold more than one bitcoins?');
          _insert('Have sold more than one bitcoins?', 'No', 'OK');

          //Question No 18
          //For No 220.0
          //For yes 430.0
          return yesnoContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have you owned the bitcoins for longer than a year?",
              "Owned over a year",
              220.0,
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Have sold more than one bitcoins?');
          _insert('Have sold more than one bitcoins?', 'Yes', 'OK');

          //Question No 15(value)
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "How many bitcoins have you sold?",
              "How Many bitcoins.",
              220.0,
              "loop");
        }
      }

      //Answer No 11
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.incomeYouIdentity} sold more than one domain?" &&
          widget.CheckQuestion == "Multiple domain sales") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('Have sold more than one domain?');
          _insert('Have sold more than one domain?', 'No', 'OK');

          //Question No 18
          //For No 220.0
          //For yes 430.0
          return yesnoContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} owned the domain for longer than a year?",
              "Owned over a year",
              220.0,
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('Have sold more than one domain?');
          _insert('Have sold more than one domain?', 'Yes', 'OK');

          //Question No 15(value)
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "How many domains have you sold?",
              "How Many Domains.",
              220.0,
              "loop");
        }
      }

      //Answer No 18
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.incomeYouIdentity} owned the domain for longer than a year?" &&
          widget.CheckQuestion == "Owned over a year") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('owned the domain for longer than a year?');
          _insert('owned the domain for longer than a year?', 'No', 'OK');

          //Question No 16
          return dateContainer(
              """ <p><strong>Purchase date: web domain</strong></p>
<p>Please enter the date you bought the web domain.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the domain within 12 months of purchase, then profits of up to 600 euros are tax-free and you don't have to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed on the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} buy the domain?",
              "Date of purchase",
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('owned the domain for longer than a year?');
          _insert('owned the domain for longer than a year?', 'Yes', 'OK');

          //Question No 14
          //return yesnoContainer("","Income","Have you owned the Bitcoins for longer than a year?","Annual payslip",220.0);//abhi pata nhi
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        }
      } else if (widget.CheckCompleteQuestion ==
              "When did you buy the bitcoins?" &&
          widget.CheckQuestion == "Date of purchase") {
        //Question No 17
        return dateContainer(
            """ <p><strong>Date of sale: valuable object</strong></p>
<p>Please enter the date you sold the valuable object.</p>
<p><strong>Important:</strong></p>
<p>The date of sale must be in 2019.</p>
<p>If you sold the object within 12 months of purchase, then profits of up to 600 euros are tax-free and you do not need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return. If several valuable objects were sold together, which together cost more than 600 euros, this amount is also taxable.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "When did ${Questions.incomeYouIdentity} sell the Bitcoins?",
            "Date of sale",
            430.0);
      } else if (widget.CheckCompleteQuestion ==
              "At what price did you purchase the bitcoins?" &&
          widget.CheckQuestion == "Purchase price bitcoins") {
        //Question No 134
        return yesnoContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Any additional sale cost for bitcoins?",
            "Additional Sale Cost.",
            220.0,
            "");
      } else if (widget.CheckCompleteQuestion ==
              "Any additional sale cost for bitcoins?" &&
          widget.CheckQuestion == "Additional Sale Cost.") {
        if (widget.CheckAnswer[0] == "No") {
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          return calculationContainer(
              """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "How much was the additional cost of bitcoins sold?",
              "Domain Additional Cost.",
              220.0,
              "calculation");
        } else if (widget.CheckAnswer[0] == "skip") {
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        }
      } else if (widget.CheckCompleteQuestion ==
              "How much was the additional cost of bitcoins sold?" &&
          widget.CheckQuestion == "Domain Additional Cost.") {
        return multioptionsContainerNo(
            """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
            "Secondary activities",
            [
              "Trainer",
              "Supervisor",
              "Instructor / lecturer",
              "Conductor",
              "Organist",
              "Tour guide",
              "Referee",
              "Paramedic",
              "Amateur musician",
              "Other activities for associations",
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
              "images/check.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0);
      } else if (widget.CheckCompleteQuestion ==
              "At what price did you sell the bitcoins?" &&
          widget.CheckQuestion == "Sale price bitcoins") {
        //Question No 133
        return calculationContainer(
            """ <p><strong>Sale of property: price</strong></p>
<p>The basis of building depreciation calculation is the acquisition or construction cost of the property.</p>
<p>For this reason we need information such as the construction cost or purchase price. Please enter this information here.</p> """,
            "",
            "Income",
            "At what price did you purchase the bitcoins?",
            "Purchase price bitcoins",
            280.0,
            "calculation");
      } else if (widget.CheckCompleteQuestion ==
              "At what price did you purchase the bitcoins?" &&
          widget.CheckQuestion == "Purchase price bitcoins") {
        //Question No 134
        return calculationContainer(
            """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "At what price did you sell the domain?",
            "Sale price domain",
            220.0,
            "calculation");
      }

      //Answer No 16
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} buy the domain?" &&
          widget.CheckQuestion == "Date of purchase") {
        //Question No 17
        return dateContainer(
            """ <p><strong>Purchase date: web bitcoins</strong></p>
<p>Please enter the date you bought the web domain.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the bitcoins within 12 months of purchase, then profits of up to 600 euros are tax-free and you don't have to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed on the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "When did ${Questions.incomeYouIdentity} sell the domain?",
            "Date of purchase",
            220.0);
      } else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} sell the domain?" &&
          widget.CheckQuestion == "Date of purchase") {
        //Question No 17
        return calculationContainer(
            """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "At what price did you sell the domain?",
            "Sale price domain",
            220.0,
            "calculation");
      } else if (widget.CheckCompleteQuestion ==
              "At what price did you sell the domain?" &&
          widget.CheckQuestion == "Sale price domain") {
        //Question No 133
        return calculationContainer(
            """ <p><strong>Sale of property: price</strong></p>
<p>The basis of building depreciation calculation is the acquisition or construction cost of the property.</p>
<p>For this reason we need information such as the construction cost or purchase price. Please enter this information here.</p> """,
            "",
            "Income",
            "At what price did you purchase the domain?",
            "Purchase price domain",
            280.0,
            "calculation");
      } else if (widget.CheckCompleteQuestion ==
              "At what price did you purchase the domain?" &&
          widget.CheckQuestion == "Purchase price domain") {
        //Question No 134
        return yesnoContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Any additional sale cost for domain?",
            "Additional Sale Cost.",
            220.0,
            "");
      } else if (widget.CheckCompleteQuestion ==
              "Any additional sale cost for domain?" &&
          widget.CheckQuestion == "Additional Sale Cost.") {
        if (widget.CheckAnswer[0] == "No") {
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          return calculationContainer(
              """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "How much was the additional cost of domain sold?",
              "Domain Additional Cost.",
              220.0,
              "calculation");
        } else if (widget.CheckAnswer[0] == "skip") {
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        }
      } else if (widget.CheckCompleteQuestion ==
              "How much was the additional cost of domain sold?" &&
          widget.CheckQuestion == "Domain Additional Cost.") {
        return multioptionsContainerNo(
            """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
            "Secondary activities",
            [
              "Trainer",
              "Supervisor",
              "Instructor / lecturer",
              "Conductor",
              "Organist",
              "Tour guide",
              "Referee",
              "Paramedic",
              "Amateur musician",
              "Other activities for associations",
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
              "images/check.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0);
      } else if (widget.CheckCompleteQuestion ==
              "When did you sell the domain?" &&
          widget.CheckQuestion == "Date of sale") {
        //Question No 14
        //return yesnoContainer("","Income","Have you owned the Bitcoins for longer than a year?","Annual payslip",220.0);//abhi pata nhi
        return multioptionsContainerNo(
            """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
            "Secondary activities",
            [
              "Trainer",
              "Supervisor",
              "Instructor / lecturer",
              "Conductor",
              "Organist",
              "Tour guide",
              "Referee",
              "Paramedic",
              "Amateur musician",
              "Other activities for associations",
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
              "images/check.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0);
      }

      //Answer No 13
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.incomeYouIdentity} sold more than one valuable?" &&
          widget.CheckQuestion == "Multiple sales") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('sold more than one valuable?');
          _insert('sold more than one valuable?', 'No', 'OK');

          //Question No 22
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What did ${Questions.incomeYouIdentity} sell?",
              "Valuables",
              220.0,
              "");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('sold more than one valuable?');
          _insert('sold more than one valuable?', 'Yes', 'OK');

          //Question No 23

          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "How many valuable objects did ${Questions.incomeYouIdentity} sell?",
              "Number of sales",
              220.0,
              "loop");
        }
      }

      //Answer No 22

      else if (widget.CheckCompleteQuestion ==
              "What did ${Questions.incomeYouIdentity} sell?" &&
          widget.CheckQuestion == "Valuables") {
        //Question No 24
        //For Yes 430.0
        //For No 220.0
        return yesnoContainer(
            """ <p><strong>Possession for longer than one year: Bitcoins</strong></p>
<p>Please state whether the Bitcoins were in your possession for longer than one year.</p>
<p><strong>FIRST IN, FIRST OUT</strong></p>
<p>It is often the case that, when Bitcoins are purchased, the purchase date cannot be matched to each individual Bitcoin. Therefore we recommend using the first in, first out (FIFO) method. This means the first Bitcoins you sell are the first Bitcoins you bought.</p>
<p><strong>An example:</strong></p>
<p>Purchase 1: 5 April 2018 - 2 Bitcoins at 233.90 euros each Purchase 2: 17 December 2018 - 2 Bitcoins at 421.87 euros each</p>
<p>Now check when you sold the Bitcoins.</p>
<p>Sale 1: 16 June - 3 Bitcoins at 660 euros each</p>
<p>According to FIFO, first, the Bitcoins from purchase 1 are sold.</p>
<p>Now check how many Bitcoins you still own. In this case, it's 1 Bitcoin from purchase 2.</p>
<p>You can now see how long the Bitcoins were in your possession. Both of the sold Bitcoins from purchase 1 were in your possession for longer than a year (5 April 2018 to 16 June 2019). This sale is tax-free.</p>
<p>The other Bitcoin was in your possession for less than a year (17 December 2018 to 16 June 2019).</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} owned the " +
                "${Questions.singleValuableName}" +
                " for longer than one year?",
            "Owned over a year",
            430.0,
            "");
      }

//Answer No 24
      else if (widget.CheckCompleteQuestion ==
              "Have ${Questions.incomeYouIdentity} owned the " +
                  "${Questions.singleValuableName}" +
                  " for longer than one year?" &&
          widget.CheckQuestion == "Owned over a year") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('"Owned over a year');
          _insert('"Owned over a year', 'No', 'OK');

          //Question No 25
          return dateContainer(
              """ <p><strong>Purchase date: valuable object</strong></p>
<p>Please enter the date you bought the valuable object.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the object within 12 months of purchase, then profits of up to 600 euros are tax-free and you do not need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} purchase the " +
                  "${Questions.singleValuableName}?",
              "Date of purchase",
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('"Owned over a year');
          _insert('"Owned over a year', 'Yes', 'OK');

          print("This container");
          //Question No 14
          //return yesnoContainer("","Income","Have you owned the Bitcoins for longer than a year?","Annual payslip",220.0);//abhi pata nhi
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        }
      }

      //Answer No 25
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} purchase the " +
                  "${Questions.singleValuableName}?" &&
          widget.CheckQuestion == "Date of purchase") {
        //Question No 26
        return dateContainer(
            """ <p><strong>Date of sale: valuable object</strong></p>
<p>Please enter the date you sold the valuable object.</p>
<p><strong>Important:</strong></p>
<p>The date of sale must be in 2019.</p>
<p>If you sold the object within 12 months of purchase, then profits of up to 600 euros are tax-free and you do not need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return. If several valuable objects were sold together, which together cost more than 600 euros, this amount is also taxable.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "When did ${Questions.incomeYouIdentity} sell the " +
                "${Questions.singleValuableName}?",
            "Date of sale",
            430.0);
      }

      //Answer No 26
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} sell the " +
                  "${Questions.singleValuableName}?" &&
          widget.CheckQuestion == "Date of sale") {
        return multioptionsContainerNo(
            """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
            "Secondary activities",
            [
              "Trainer",
              "Supervisor",
              "Instructor / lecturer",
              "Conductor",
              "Organist",
              "Tour guide",
              "Referee",
              "Paramedic",
              "Amateur musician",
              "Other activities for associations",
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
              "images/check.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png"
            ],
            220.0);
      } else if (widget.CheckCompleteQuestion ==
              "How many domains have you sold?" &&
          widget.CheckQuestion == "How Many Domains.") {
        return yesnoContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} owned the domain for longer than a year?",
            "Owned over a year",
            220.0,
            "");
      } else if (widget.CheckCompleteQuestion ==
              "How many bitcoins have you sold?" &&
          widget.CheckQuestion == "How Many bitcoins.") {
        return yesnoContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Have you owned the bitcoins for longer than a year?",
            "Owned over a year.",
            220.0,
            "");
      } else if (widget.CheckCompleteQuestion ==
              "Have you owned the bitcoins for longer than a year?" &&
          widget.CheckQuestion == "Owned over a year.") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('owned the bitcoins for longer than a year?');
          _insert('owned the bitcoins for longer than a year?', 'No', 'OK');

          //Question No 16
          return dateContainer(
              """ <p><strong>Purchase date: web domain</strong></p>
<p>Please enter the date you bought the web domain.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the domain within 12 months of purchase, then profits of up to 600 euros are tax-free and you don't have to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed on the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did you buy the bitcoins?",
              "Date of purchase",
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('owned the bitcoins for longer than a year?');
          _insert('owned the bitcoins for longer than a year?', 'Yes', 'OK');

          //Question No 14
          //return yesnoContainer("","Income","Have you owned the Bitcoins for longer than a year?","Annual payslip",220.0);//abhi pata nhi
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        }
      } else if (widget.CheckCompleteQuestion ==
              "Have you owned the bitcoins for longer than a year?" &&
          widget.CheckQuestion == "Owned over a year.") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('owned the bitcoins for longer than a year?');
          _insert('owned the bitcoins for longer than a year?', 'No', 'OK');

          //Question No 16
          return dateContainer(
              """ <p><strong>Purchase date: web bitcoins</strong></p>
<p>Please enter the date you bought the web domain.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the bitcoins within 12 months of purchase, then profits of up to 600 euros are tax-free and you don't have to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed on the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did you buy the bitcoins?",
              "Date of purchase",
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('owned the bitcoins for longer than a year?');
          _insert('owned the bitcoins for longer than a year?', 'Yes', 'OK');

          //Question No 14
          //return yesnoContainer("","Income","Have you owned the Bitcoins for longer than a year?","Annual payslip",220.0);//abhi pata nhi
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        }
      }

      //Answer No 23 start
      else if ((widget.CheckCompleteQuestion ==
                  "How many valuable objects did ${Questions.incomeYouIdentity} sell?" &&
              widget.CheckQuestion == "Number of sales") ||
          Questions.valuableLength > 0) {
        print("Answer valuable is:" + widget.CheckAnswer[0].toString());
        print("Total valuable is:" + Questions.totalValuable.toString());
        if (widget.CheckQuestion == "Number of sales") {
          //Questions.domainLength += 1;
          //Question No 147
          return valuablenameContainer(
            """<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Valuable no. " +
                Questions.valuableLength.toString() +
                ": What did ${Questions.incomeYouIdentity} sell?",
            "Valuable no. " + Questions.valuableLength.toString(),
            220.0,
          );
        } else if (widget.CheckCompleteQuestion ==
                "Valuable no. " +
                    Questions.valuableLength.toString() +
                    ": What did ${Questions.incomeYouIdentity} sell?" &&
            widget.CheckQuestion ==
                "Valuable no. " + Questions.valuableLength.toString()) {
          //Question No 148
          return valuableownedContainer(
              """ <p><strong>Possession for longer than one year: Bitcoins</strong></p>
<p>Please state whether the Bitcoins were in your possession for longer than one year.</p>
<p><strong>FIRST IN, FIRST OUT</strong></p>
<p>It is often the case that, when Bitcoins are purchased, the purchase date cannot be matched to each individual Bitcoin. Therefore we recommend using the first in, first out (FIFO) method. This means the first Bitcoins you sell are the first Bitcoins you bought.</p>
<p><strong>An example:</strong></p>
<p>Purchase 1: 5 April 2018 - 2 Bitcoins at 233.90 euros each Purchase 2: 17 December 2018 - 2 Bitcoins at 421.87 euros each</p>
<p>Now check when you sold the Bitcoins.</p>
<p>Sale 1: 16 June - 3 Bitcoins at 660 euros each</p>
<p>According to FIFO, first, the Bitcoins from purchase 1 are sold.</p>
<p>Now check how many Bitcoins you still own. In this case, it's 1 Bitcoin from purchase 2.</p>
<p>You can now see how long the Bitcoins were in your possession. Both of the sold Bitcoins from purchase 1 were in your possession for longer than a year (5 April 2018 to 16 June 2019). This sale is tax-free.</p>
<p>The other Bitcoin was in your possession for less than a year (17 December 2018 to 16 June 2019).</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} owned the " +
                  Questions.singleValuableName +
                  " for longer than one year?",
              "Owned over a year",
              220.0,
              "VALUABLE " +
                  Questions.valuableLength.toString()); //abhi pata nhi
        } else if (widget.CheckAnswer[0] == "Yes") {
          print("Valuable length is:" + Questions.valuableLength.toString());

          if (Questions.valuableLength <= Questions.totalValuable) {
            print("Valuable length is:" + Questions.valuableLength.toString());
            //Question No 147
            return valuablenameContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Valuable no. " +
                  Questions.valuableLength.toString() +
                  ": What did ${Questions.incomeYouIdentity} sell?",
              "Valuable no. " + Questions.valuableLength.toString(),
              220.0,
            );
          } else {
            //Question No 14
            return multioptionsContainerNo(
                """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
                "Secondary activities",
                [
                  "Trainer",
                  "Supervisor",
                  "Instructor / lecturer",
                  "Conductor",
                  "Organist",
                  "Tour guide",
                  "Referee",
                  "Paramedic",
                  "Amateur musician",
                  "Other activities for associations",
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
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0);
          }
        } else if (widget.CheckAnswer[0] == "No") {
          //Question No 149
          return dateContainer(
              """ <p><strong>Purchase date: valuable object</strong></p>
<p>Please enter the date you bought the valuable object.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the object within 12 months of purchase, then profits of up to 600 euros are tax-free and you do not need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} purchase the " +
                  Questions.singleValuableName +
                  " ?",
              "Purchase date",
              220.0);
        } else if (widget.CheckQuestion == "Purchase date") {
          //Question No 150.0
          return dateContainer(
              """ <p><strong>Date of sale: valuable object</strong></p>
<p>Please enter the date you sold the valuable object.</p>
<p><strong>Important:</strong></p>
<p>The date of sale must be in 2019.</p>
<p>If you sold the object within 12 months of purchase, then profits of up to 600 euros are tax-free and you do not need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return. If several valuable objects were sold together, which together cost more than 600 euros, this amount is also taxable.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} sell the " +
                  Questions.singleValuableName +
                  " ?",
              "Date of sale",
              220.0);
        } else if (widget.CheckQuestion == "Date of sale") {
          if (Questions.valuableLength <= Questions.totalValuable) {
            print("Doman length is:" + Questions.domainLength.toString());
            //Question No 147
            return valuablenameContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Valuable no. " +
                  Questions.valuableLength.toString() +
                  ": What did ${Questions.incomeYouIdentity} sell?",
              "Valuable no. " + Questions.valuableLength.toString(),
              220.0,
            );
            //return domainContainer("", "Income", "Have you owned "+Questions.domainLength.toString()+  " domain(s) for longer than a year?", "For " + Questions.domainLength.toString() + " Years", 220.0, "SALE " + Questions.domainLength.toString()); //abhi pata nhi
          } else {
            //Question No 14
            //return yesnoContainer("","Income","Have you owned the Bitcoins for longer than a year?","Annual payslip",220.0);//abhi pata nhi
            return multioptionsContainerNo(
                """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
                "Secondary activities",
                [
                  "Trainer",
                  "Supervisor",
                  "Instructor / lecturer",
                  "Conductor",
                  "Organist",
                  "Tour guide",
                  "Referee",
                  "Paramedic",
                  "Amateur musician",
                  "Other activities for associations",
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
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0);
          }
        }
      }

      //Answer No 23 end

      //Answer No 15(Value)
      else if ((widget.CheckCompleteQuestion ==
                  "Have ${Questions.incomeYouIdentity} owned 1 domain(s) for longer than a year?" &&
              widget.CheckQuestion == "Number of sales") ||
          Questions.domainLength > 0) {
        if (widget.CheckQuestion == "Number of sales") {
          //Questions.domainLength += 1;
          //Question No 15
          return domainContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} owned " +
                  Questions.domainLength.toString() +
                  " domain(s) for longer than a year?",
              "For " + "${Questions.domainLength}" + " Years",
              220.0,
              "SALE " + Questions.domainLength.toString()); //abhi pata nhi
        } else if (widget.CheckAnswer[0] == "Yes") {
          print("Doman length is:" + Questions.domainLength.toString());

          if (Questions.domainLength <= Questions.totalDomain) {
            print("Doman length is:" + Questions.domainLength.toString());
            //Question No 15
            return domainContainer(
                """<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} owned " +
                    Questions.domainLength.toString() +
                    " domain(s) for longer than a year?",
                "For " + "${Questions.domainLength}" + " Years",
                220.0,
                "SALE " + Questions.domainLength.toString()); //abhi pata nhi
          } else {
            //Question No 14
            return multioptionsContainerNo(
                """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
                "Secondary activities",
                [
                  "Trainer",
                  "Supervisor",
                  "Instructor / lecturer",
                  "Conductor",
                  "Organist",
                  "Tour guide",
                  "Referee",
                  "Paramedic",
                  "Amateur musician",
                  "Other activities for associations",
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
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0);
          }
        } else if (widget.CheckAnswer[0] == "No") {
          //Question No 16
          return dateContainer(
              """ <p><strong>Purchase date: web domain</strong></p>
<p>Please enter the date you bought the web domain.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the domain within 12 months of purchase, then profits of up to 600 euros are tax-free and you don't have to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed on the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} buy the domain?",
              "Purchase date domain",
              220.0);
        } else if (widget.CheckQuestion == "Purchase date domain") {
          return dateContainer(
              """ <p><strong>Date of sale: web domain</strong></p>
<p>Please enter the date you sold the web domain.</p>
<p><strong>Important:</strong></p>
<p>The date of sale must be in 2019.</p>
<p>If you sold the domain within 12 months of the purchase, then profits of up to 600 euros are tax-free and you don't need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} sell the domain?",
              "Date of sale: domain",
              220.0);
        } else if (widget.CheckQuestion == "Date of sale: domain") {
          //Questions.domainLength += 1;
          print("oh date sale domain" + Questions.totalDomain.toString());
          print("oh date sale domain" + Questions.domainLength.toString());

          if (Questions.domainLength <= Questions.totalDomain) {
            print("Doman length is:" + Questions.domainLength.toString());
            //Question No 15
            return domainContainer(
                """<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} owned " +
                    Questions.domainLength.toString() +
                    " domain(s) for longer than a year?",
                "For " + "${Questions.domainLength}" + " Years",
                220.0,
                "SALE " + Questions.domainLength.toString()); //abhi pata nhi
            //return domainContainer("", "Income", "Have you owned "+Questions.domainLength.toString()+  " domain(s) for longer than a year?", "For " + Questions.domainLength.toString() + " Years", 220.0, "SALE " + Questions.domainLength.toString()); //abhi pata nhi
          } else {
            //Question No 14
            //return yesnoContainer("","Income","Have you owned the Bitcoins for longer than a year?","Annual payslip",220.0);//abhi pata nhi
            return multioptionsContainerNo(
                """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
                "Secondary activities",
                [
                  "Trainer",
                  "Supervisor",
                  "Instructor / lecturer",
                  "Conductor",
                  "Organist",
                  "Tour guide",
                  "Referee",
                  "Paramedic",
                  "Amateur musician",
                  "Other activities for associations",
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
                  "images/check.png",
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png"
                ],
                220.0);
          }
        }
      }
      //Answer No(15) value end

      //Answer No 12
      else if (widget.CheckCompleteQuestion ==
              "Have you owned the bitcoins for longer than a year?" &&
          widget.CheckQuestion == "Owned over a year") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion('"Owned over a year');
          _insert('"Owned over a year', 'No', 'OK');

          //Question No 20
          return dateContainer(
              """ <p><strong>Purchase date: valuable object</strong></p>
<p>Please enter the date you bought the valuable object.</p>
<p><strong>Important:</strong></p>
<p>The purchase date must be in 2019.</p>
<p>If you sold the object within 12 months of purchase, then profits of up to 600 euros are tax-free and you do not need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When did ${Questions.incomeYouIdentity} purchase the bitcoins?",
              "Date of purchase",
              220.0);
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion('"Owned over a year');
          _insert('"Owned over a year', 'Yes', 'OK');

          //Question No 14
          return multioptionsContainerNo(
              """ <p><strong>Secondary activities</strong></p>
<p>Please select here which kind of secondary activities you have done.</p>
<p>There are various fields of work you need to choose from:</p>
<p><strong>TRAINER / COACH</strong></p>
<p>Choose this option if your work was pedagogical in nature. For instance, perhaps you did one of the following:</p>
<ul>
<li>trainer at a sports club</li>
<li>choir leader</li>
</ul>
<p><strong>CARER</strong></p>
<p>As a carer you provide support to sick and disabled people that can no longer care for themselves. This also applies if you care for children or youths.</p>
<p><strong>TEACHER / LECTURER</strong></p>
<p>Teaching duties include the following for instance:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p><strong>CONDUCTOR</strong></p>
<p>The duties of a conductor include choir practices and performances.</p>
<p><strong>ORGANIST</strong></p>
<p>The duties of an organist include playing the organ at church services, for instance</p>
<p><strong>TOUR GUIDE</strong></p>
<p>You can include your voluntary work as a tour guide for museums and sightseeing tours here.</p>
<p><strong>REFEREE</strong></p>
<p>If you were a referee for a regional sport club, then select this option.</p>
<p><strong>PARAMEDIC</strong></p>
<p>As a paramedic you help people in emergencies and give first aid. You can enter this here.</p>
<p><strong>AMATEUR MUSICIAN</strong></p>
<p>You were active as an amateur musician and have had some performances. You can enter this here.</p>
<p><strong>OTHER SECONDARY ACTIVITIES</strong></p>
<p>Here you can include all jobs that are not pedagogical in nature. These can include:</p>
<ul>
<li>member of the jury at court</li>
<li>work for a religious community</li>
<li>voluntary fire brigade</li>
<li>helping to care for dementia patients</li>
<li>vote counter</li>
<li>and many more</li>
</ul>
<p><strong>REQUIREMENT: INDEPENDENCE FROM OCCUPATION</strong></p>
<ul>
<li>Your secondary activity is part-time and you spend a maximum of one third of the time on it compared to your regular job.</li>
</ul>
<p>It has no influence on your main job. You meet this requirement as a student, stay-at-home parent, pensioner or if you are unemployed.</p>
<ul>
<li>With your work you are supporting a charitable or non-profit organization or a public entity. Your secondary activity is charitable or religious in nature.</li>
</ul>
<p>A public entity could be a university or community college, for instance. A non-profit organization could be a sports club. Work in a club or a retirement home can be included.</p> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?",
              "Secondary activities",
              [
                "Trainer",
                "Supervisor",
                "Instructor / lecturer",
                "Conductor",
                "Organist",
                "Tour guide",
                "Referee",
                "Paramedic",
                "Amateur musician",
                "Other activities for associations",
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
                "images/check.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              220.0);
        }
      }

      //Answer No 20
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} purchase the bitcoins?" &&
          widget.CheckQuestion == "Date of purchase") {
        //Question No 21
        return dateContainer(
            """ <p><strong>Date of sale: valuable object</strong></p>
<p>Please enter the date you sold the valuable object.</p>
<p><strong>Important:</strong></p>
<p>The date of sale must be in 2019.</p>
<p>If you sold the object within 12 months of purchase, then profits of up to 600 euros are tax-free and you do not need to include the sale in your tax return.</p>
<p>Profits of more than 600 euros must be taxed to the full amount and included in your tax return. If several valuable objects were sold together, which together cost more than 600 euros, this amount is also taxable.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "When did ${Questions.incomeYouIdentity} sell the Bitcoins?",
            "Date of sale",
            430.0);
      }

      //Answer No 21
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} sell the Bitcoins?" &&
          widget.CheckQuestion == "Date of sale") {
        //Question No 14
        return calculationContainer(
            """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "At what price did you sell the bitcoins?",
            "Sale price bitcoins",
            220.0,
            "calculation");
      }

      //Answer No 14
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.incomeYouIdentity} have income from certain secondary activities?" &&
          widget.CheckQuestion == "Secondary activities") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Trainer") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?', 'Trainer',
                'OK');

            //Question 28 will come
            return calculationContainer(
                """ <p><strong>Income as trainer / coach</strong></p>
<p>Please enter how much you earned as a trainer / coach.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>Earnings of up to 2,400 euros a year are exempt from tax and social security.</p>
<p>Your proof of income could be a list of duties, a contract or another written agreement. If required, you must provide the tax office with this.</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as a trainer?",
                "Income trainer",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Supervisor") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Supervisor', 'OK');

            //Question 30 will come
            return calculationContainer(
                """ <p><strong>Income as care worker</strong></p>
<p>Please enter how much you earned as a care worker.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>As a care worker you provide support to sick and disabled people that can no longer care for themselves. A key characteristic of this occupation is that there is a pedagogical element.</p>
<p>Your proof of income could be a list of duties, a contract or another written agreement. If required you must provide the tax office with this.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as a care worker?",
                "Income care worker",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Instructor / lecturer") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Instructor / lecturer', 'OK');

            //Question 41 will come
            return calculationContainer(
                """ <p><strong>Income as teacher/lecturer</strong></p>
<p>Please enter how much you earned as a teacher/lecturer.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>Earnings of up to 2,400 euros a year are exempt from tax and social security.</p>
<p>Teaching duties can include the following:</p>
<ul>
<li>courses and lectures at schools and community colleges</li>
<li>maternity advice</li>
<li>first aid courses</li>
<li>swimming lessons</li>
</ul>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as an instructor?",
                "Income instructor",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Conductor") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Conductor', 'OK');

            //Question 43 will come
            return calculationContainer(
                """ <p><strong>Income as conductor</strong></p>
<p>Please enter how much you earned as a conductor.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>Earnings of up to 2,400 euros a year are exempt from tax and social security.</p>
<p>The duties of a conductor include practices and performances.</p>
<p>Your proof of income could be a list of duties, a contract or another written agreement. If required, you must provide the tax office with this.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as a conductor?",
                "Income conductor",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Organist") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Organist', 'OK');

            //Question 45 will come
            return calculationContainer("""
              <p><strong>Income as organist</strong></p>
<p>Please enter how much you earned as an organist.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>Earnings of up to 2,400 euros a year are exempt from tax and social security.</p>
<p>The duties of an organist could include playing the organ at church services, for instance.</p>
<p>Your proof of income could be a list of duties, a contract or another written agreement. If required, you must provide the tax office with this.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as an organist?",
                "Income organist",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Tour guide") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Tour guide', 'OK');

            //Question 47 will come
            return calculationContainer(""" """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as a tour guide?",
                "Income tour guide",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Referee") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?', 'Referee',
                'OK');

            //Question 49 will come
            return calculationContainer(
                """ p><strong>Income as a referee</strong></p>
<p>Please enter how much you earned as a referee.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>Earnings of up to 720 euros a year are exempt from tax and social security.</p>
<p>Your proof of income could be a list of duties, a contract or another written agreement. If required you must provide the tax office with this.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as a referee?",
                "Income as referee",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Paramedic") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Paramedic', 'OK');

            //Question 51 will come
            return calculationContainer(
                """ <p><strong>Income as a paramedic</strong></p>
<p>Please enter how much you earned as a paramedic.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>As a paramedic, you help people in emergencies and give first aid.</p>
<p>Your proof of income could be a list of duties, a contract or another written agreement. If required, you must provide the tax office with this.</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as a paramedic?",
                "Income paramedic",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Amateur musician") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Amateur musician', 'OK');

            //Question 53 will come
            return calculationContainer(
                """ <p><strong>Income as an amateur musician</strong></p>
<p>Please enter how much you earned as an amateur musician.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<p>Earnings of up to 720 euros a year are exempt from tax and social security.</p>
<p>The duties of a musician could include performing in clubs or charitable organizations</p>
<p>Your proof of income could be a list of duties, a contract or another written agreement. If required, you must provide the tax office with this.</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make as a musician?",
                "Income musician",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] ==
              "Other activities for associations") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?',
                'Other activities for associations', 'OK');

            //Question 55 will come
            return calculationContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "What kind of voluntary work did ${Questions.incomeYouIdentity} participate in?",
                "Kind of work",
                220.0,
                "");
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert(
                'have income from certain secondary activities?', 'No', 'OK');

            //Question No 27

            //For commission 220.0
            //For rental of movable assests 220.0
            //for post-contractual restraint 220.0
            //for other services 220.0
            //for No 430.0

            return multioptionsContainerNo(
                """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} receive any income for other services?",
                "Other income",
                [
                  "Commission",
                  "Rental of movable assets",
                  "Post-contractual restraint",
                  "Other services",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png"
                ],
                220.0);
          } else if (widget.CheckAnswer[m] == "skip") {
            DbHelper.insatance.deleteWithquestion(
                'have income from certain secondary activities?');
            _insert('have income from certain secondary activities?', 'skip',
                'skip');

            //Question No 27

            //For commission 220.0
            //For rental of movable assests 220.0
            //for post-contractual restraint 220.0
            //for other services 220.0
            //for No 430.0

            return multioptionsContainerNo(
                """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} receive any income for other services?",
                "Other income",
                [
                  "Commission",
                  "Rental of movable assets",
                  "Post-contractual restraint",
                  "Other services",
                  "No"
                ],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png",
                  "images/disabilityoption.png"
                ],
                220.0);
          }
        }
      }

      //Now Secondary Services Flow Start

      //Trainer Starts
      //Answer No 28
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as a trainer?" &&
          widget.CheckQuestion == "Income trainer") {
        //Question No 29
        return calculationContainer(
            """ <p><strong>Expenses as trainer/coach</strong></p>
<p>Please enter the expenses you had from your part-time position as a trainer/coach. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses can be counted for things such as long trips within Germany or abroad as well as costs for books and teaching materials.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to your work as a trainer?",
            "Costs trainer",
            430.0,
            "calculation");
      }

      //Answer No 29

      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to your work as a trainer?" &&
          widget.CheckQuestion == "Costs trainer") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }
      //Trainer Ends

      //Care worker Starts
      //Answer No 30
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as a care worker?" &&
          widget.CheckQuestion == "Income care worker") {
        //Question No 40
        return calculationContainer(
            """ <p><strong>Expenses as a care worker</strong></p>
<p>Please enter the amount of expenses you had from your part-time position as a carer. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses can be counted for things such as work clothes or dry cleaning.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to your work as a care worker?",
            "Costs care worker",
            430.0,
            "calculation");
      }

      //Answer No 40
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to your work as a care worker?" &&
          widget.CheckQuestion == "Costs care worker") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //Care worker Ends

      //Instructor Starts
      //Answer No 41
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as an instructor?" &&
          widget.CheckQuestion == "Income instructor") {
        //Question No 42
        return calculationContainer(
            """ <p><strong>Expenses as teacher/lecturer</strong></p>
<p>Please enter the amount of expenses you incurred from your part-time position as a teacher/lecturer. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses could be for things such as books and teaching materials.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} incur as an instructor?",
            "Costs instructor",
            430.0,
            "calculation");
      }

      //Answer No 42
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} incur as an instructor?" &&
          widget.CheckQuestion == "Costs instructor") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //Instructor Ends

      //Conductor Starts
      //Answer No 43
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as a conductor?" &&
          widget.CheckQuestion == "Income conductor") {
        //Question No 44
        return calculationContainer(
            """ <p><strong>Expenses as conductor</strong></p>
<p>Please enter the amount of expenses you had from your part-time position as a conductor. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses could be counted for things such as long journeys to choir practices and performances.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to our work as a conductor?",
            "Costs conductor",
            430.0,
            "calculation");
      }

      //Answer No 44
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to our work as a conductor?" &&
          widget.CheckQuestion == "Costs conductor") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //Conductor Ends

      //Organist Starts
      //Answer No 45
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as an organist?" &&
          widget.CheckQuestion == "Income organist") {
        //Question No 46
        return calculationContainer(
            """ <p><strong>Expenses as an organist</strong></p>
<p>Please enter the amount of expenses you had from your part-time position as an organist. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses could be for long journeys to and from practices, performances, or church services.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to your work as an organist?",
            "Costs organist",
            430.0,
            "calculation");
      }

      //Answer No 46
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to your work as an organist?" &&
          widget.CheckQuestion == "Costs organist") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //Organist Ends

      //tour guide Starts
      //Answer No 47
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as a tour guide?" &&
          widget.CheckQuestion == "Income tour guide") {
        //Question No 48
        return calculationContainer(
            """ <p><strong>Expenses as a tour guide</strong></p>
<p>Please enter the amount of expenses you had from your part-time position as a tour guide. Please note only expenses from 2019 are relevant.</p>
<p>Expenses could be for things such as journeys across Germany. You can also include costs for books/materials that contain essential knowledge for your job.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to your work as a tour guide?",
            "Costs tour guide",
            430.0,
            "calculation");
      }

      //Answer No 48
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to your work as a tour guide?" &&
          widget.CheckQuestion == "Costs tour guide") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //tour guide Ends

      //referee Starts
      //Answer No 49
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as a referee?" &&
          widget.CheckQuestion == "Income as referee") {
        //Question No 50
        return calculationContainer(
            """ <p><strong>Expenses as referee</strong></p>
<p>Please enter the amount of expenses you had from your part-time position as referee. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses could be for things such long journeys within Germany or abroad.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to your work as a referee?",
            "Costs referee",
            430.0,
            "calculation");
      }

      //Answer No 50
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to your work as a referee?" &&
          widget.CheckQuestion == "Costs referee") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //referee Ends

      //paramedic Starts
      //Answer No 51
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as a paramedic?" &&
          widget.CheckQuestion == "Income paramedic") {
        //Question No 52
        return calculationContainer(
            """ <p><strong>Expenses as a paramedic</strong></p>
<p>Please enter the amount of expenses you had from your part-time position as a paramedic. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses could be for things such as trips or acquisition and cleaning costs of work clothes.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to your work as a paramedic?",
            "Costs paramedic",
            430.0,
            "calculation");
      }

      //Answer No 52
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to your work as a paramedic?" &&
          widget.CheckQuestion == "Costs paramedic") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //paramedic Ends

      //musician Starts
      //Answer No 53
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make as a musician?" &&
          widget.CheckQuestion == "Income musician") {
        //Question No 54
        return calculationContainer(
            """ <p><strong>Expenses as an amateur musician</strong></p>
<p>Please enter the amount (expenses) you had as an amateur/part-time musician. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses could be for travel, soundchecks or performances.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to your work as a musician?",
            "Costs musician",
            430.0,
            "calculation");
      }

      //Answer No 54
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to your work as a musician?" &&
          widget.CheckQuestion == "Costs musician") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //musician Ends

      //voluntary work Starts
      //Answer No 55
      else if (widget.CheckCompleteQuestion ==
              "What kind of voluntary work did ${Questions.incomeYouIdentity} participate in?" &&
          widget.CheckQuestion == "Kind of work") {
        //Question No 56
        return calculationContainer(
            """ <p><strong>Income from another part-time position</strong></p>
<p>Please enter how much you earned from your part-time position.</p>
<p>Please note only income from 2019 is relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>It's important that this is not your main employment.</p>
<ul>
<li>treasurer</li>
<li>ground keeper</li>
<li>equipment manager</li>
<li>animal keeper</li>
</ul>
<p>Earnings of up to 720 euros a year are exempt from tax and social security.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "How much did ${Questions.incomeYouIdentity} make from voluntary work?",
            "Amount",
            220.0,
            "calculation");
      }

      //Answer No 56
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make from voluntary work?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 57
        return calculationContainer(
            """ <p><strong>Expenses from voluntary work</strong></p>
<p>Please enter the amount (expenses) you had from your voluntary work. Please note only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Expenses can be counted for things such as long trips within Germany or abroad as well as costs for books and teaching materials.</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to voluntary work?",
            "Costs voluntary work",
            430.0,
            "calculation");
      }

      //Answer No 57
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to voluntary work?" &&
          widget.CheckQuestion == "Costs voluntary work") {
        //Question No 27
        return multioptionsContainerNo(
            """ <p><strong>Other income</strong></p>
<p>Choose the answers that apply to you. You can select more than one option.</p>
<p><strong>VOLUNTARY WORK</strong></p>
<p>Choose this option if you worked in a position as a trainer, head of a club, an instructor for the fire brigade or within a charitable or church organization and earned money for this.</p>
<p><strong>COMMISSION</strong></p>
<p>Did you receive a referral commission for giving someone a good tip such as a good business, cheaper bank account, or better insurance? You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p><strong>RENTAL OF MOVABLE ASSETS</strong></p>
<p>Did you rent out any of your possessions? This includes cars, tools, machines etc.</p>
<p><strong>POST-CONTRACTUAL RESTRAINT</strong></p>
<p>Did you receive a post-contractual restraint payment at the end of your contract from your employer? If so, choose this option.</p>
<p><strong>OTHER SERVICES</strong></p>
<p>If you received income from other services, these can be stated here. Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any income for other services?",
            "Other income",
            [
              "Commission",
              "Rental of movable assets",
              "Post-contractual restraint",
              "Other services",
              "No"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //voluntary work Ends

      //Now Secondary Services Flow End

      //Answer No 27
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.incomeYouIdentity} receive any income for other services?" &&
          widget.CheckQuestion == "Other income") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Commission") {
            DbHelper.insatance
                .deleteWithquestion('receive any income for other services?');
            _insert(
                'receive any income for other services?', 'Commission', 'OK');

            //Question No 58
            return calculationContainer(
                """ <p><strong>Referral commissions: profit</strong></p>
<p>Please enter your total income from referral commissions in 2019.</p>
<p>If you received a one-off payment from a bank or insurance company because you referred a loved one or friend to join, then enter the amount here.</p>
<p>Commissions received as part of your job do not count. If you sell contracts as part of your job, then you do not need to include these commissions here. This is part of your salary.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make from commissions?",
                "Income commission",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Rental of movable assets") {
            DbHelper.insatance
                .deleteWithquestion('receive any income for other services?');
            _insert('receive any income for other services?',
                'Rental of movable assets', 'OK');

            //Question No 60
            return calculationContainer(
                """ <p><strong>Rental of movable assets: profit</strong></p>
<p>Please enter your total income from the rental of movable assets in 2019.</p>
<p>These include:</p>
<ul>
<li>cars</li>
<li>camper vans</li>
<li>boats</li>
<li>machines</li>
<li>tools</li>
</ul>
<p>We will then calculate automatically whether this amount is taxable.</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} make from movable assets (leasing)?",
                "Income leasing",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Post-contractual restraint") {
            DbHelper.insatance
                .deleteWithquestion('receive any income for other services?');
            _insert('receive any income for other services?',
                'Post-contractual restraint', 'OK');

            //Question No 62
            return calculationContainer(
                """ <p><strong>Post-contractual restraint: amount</strong></p>
<p>Please enter the total pay out you received due to a post-contractual restraint or non-competition clause in 2019. You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p>You should have received confirmation of these payments from your employer.</p> """,
                "",
                "Income",
                "How much compensation did ${Questions.incomeYouIdentity} receive due to a restraint or non-competition clause?",
                "Amount",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Other services") {
            DbHelper.insatance
                .deleteWithquestion('receive any income for other services?');
            _insert('receive any income for other services?', 'Other services',
                'OK');

//Question No 62
            return calculationContainer(
                """ <p><strong>OTHER SERVICES</strong></p>
<p>Every paid action needs to be taken into account if there is a contract. Excluding sales. Examples of income from other services are:</p>
<ul>
<li>Takeover of financial risks</li>
<li>Waiver of the legally prescribed boundary distance to the neighbour</li>
<li>Waiver of defence claims in the case of a registered trademark</li>
<li>Acceptance of a building project</li>
</ul>
<p>&nbsp;</p> """,
                "",
                "Income",
                "What kind of other services did ${Questions.incomeYouIdentity} receive?",
                "Kind of other services",
                220.0,
                "");
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance
                .deleteWithquestion('receive any income for other services?');
            _insert('receive any income for other services?', 'No', 'OK');

            //Question No 67
            return multioptionsContainerNo(
                """ <p><strong>Income replacement benefits</strong></p>
<p>Choose which options below apply to you. You can click and select multiple answers.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You now have to declare tax-free compensation, which you received in the year 2019. These include:</p>
<ul>
<li><strong>Unemployment benefit (ALG I)</strong> - You will receive unemployment benefits if you have previously paid into the statutory unemployment insurance and have fulfilled other conditions.</li>
<li><strong>Parental allowance</strong> - is a family benefit paid to help parents care for their newborn children.</li>
<li><strong>Sick pay</strong> - most employees who have state health insurance receive this if they are incapacitated for more than six weeks.</li>
<li><strong>Child sick pay</strong> - received by those with state insurance if the child is ill, needs to be cared for and the parent therefore they can not go to work.</li>
<li><strong>Maternity allowance (including subsidy)</strong> - is paid by the statutory health insurance during maternity leave.</li>
<li><strong>Unemployment assistance</strong> - is paid to regular soldiers who are unemployed and have at least two years of military service behind them.</li>
<li><strong>Insolvency allowance</strong> - paid to employees who suffer a loss of earnings due to the bankruptcy of their employer.</li>
<li><strong>Sickness benefits related to Federal War Victims Relief Act</strong> - is paid in the event of incapacity for work or inpatient rehab, inter alia for war victims, vaccinated persons or victims of violence.</li>
<li><strong>Compensation for loss of earnings under the Infection Protection Act</strong> - paid to an employees if they are quarantined due to infection with a transmissible pathogen.</li>
</ul>
<p>You don't have to include unemployment benefits ('Arbeitslosengeld II' / Hartz IV), housing benefits, child benefits, social benefits, strike benefits and sick pay from a private health insurer.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "Did ${Questions.incomeYouIdentity} receive any of the following payments?",
                "Compensation payment",
                [
                  "Unemployment benefits",
                  "Parental allowance",
                  "Sick pay",
                  "Sick pay for children",
                  "Maternity pay",
                  "Unemployment assistance",
                  "Insolvency allowance",
                  "Pension about benefits related to ‘Bundesversogungsgesetz’",
                  "Payments related to ‘Infektionsschutzgesetz’",
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
                  "images/disabilityoption.png"
                ],
                220.0);
          }
        }
      }

      //Now Other Services Flow Start

//commission Starts
      //Answer No 58
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make from commissions?" &&
          widget.CheckQuestion == "Income commission") {
        //Question No 59
        return calculationContainer(
            """ <p><strong>Referral commissions: additional costs</strong></p>
<p>Please enter the total additional costs you had due to receipt of referral commissions. Please note, only expenses from 2019 are relevant.</p>
<p>These could include journey costs, for example.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have related to earnings from the commission?",
            "Costs commission",
            430.0,
            "calculation");
      }

      //Answer No 59
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have related to earnings from the commission?" &&
          widget.CheckQuestion == "Costs commission") {
        //Question No 67
        return multioptionsContainerNo(
            """ <p><strong>Income replacement benefits</strong></p>
<p>Choose which options below apply to you. You can click and select multiple answers.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You now have to declare tax-free compensation, which you received in the year 2019. These include:</p>
<ul>
<li><strong>Unemployment benefit (ALG I)</strong> - You will receive unemployment benefits if you have previously paid into the statutory unemployment insurance and have fulfilled other conditions.</li>
<li><strong>Parental allowance</strong> - is a family benefit paid to help parents care for their newborn children.</li>
<li><strong>Sick pay</strong> - most employees who have state health insurance receive this if they are incapacitated for more than six weeks.</li>
<li><strong>Child sick pay</strong> - received by those with state insurance if the child is ill, needs to be cared for and the parent therefore they can not go to work.</li>
<li><strong>Maternity allowance (including subsidy)</strong> - is paid by the statutory health insurance during maternity leave.</li>
<li><strong>Unemployment assistance</strong> - is paid to regular soldiers who are unemployed and have at least two years of military service behind them.</li>
<li><strong>Insolvency allowance</strong> - paid to employees who suffer a loss of earnings due to the bankruptcy of their employer.</li>
<li><strong>Sickness benefits related to Federal War Victims Relief Act</strong> - is paid in the event of incapacity for work or inpatient rehab, inter alia for war victims, vaccinated persons or victims of violence.</li>
<li><strong>Compensation for loss of earnings under the Infection Protection Act</strong> - paid to an employees if they are quarantined due to infection with a transmissible pathogen.</li>
</ul>
<p>You don't have to include unemployment benefits ('Arbeitslosengeld II' / Hartz IV), housing benefits, child benefits, social benefits, strike benefits and sick pay from a private health insurer.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any of the following payments?",
            "Compensation payment",
            [
              "Unemployment benefits",
              "Parental allowance",
              "Sick pay",
              "Sick pay for children",
              "Maternity pay",
              "Unemployment assistance",
              "Insolvency allowance",
              "Pension about benefits related to ‘Bundesversogungsgesetz’",
              "Payments related to ‘Infektionsschutzgesetz’",
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
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //commission Ends

      //Rental of movable assets Starts
      //Answer No 60
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} make from movable assets (leasing)?" &&
          widget.CheckQuestion == "Income leasing") {
        //Question No 61
        return calculationContainer(
            """ <p><strong>Rental of movable assets: additional costs</strong></p>
<p>Please enter the total additional costs you had due to the rental of movable assets. Please note, only expenses from 2019 are relevant.</p>
<p>These could include <strong>advertising costs</strong> or <strong>broker fees</strong>.</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have related to the movable assets (leasing)?",
            "Costs leasing",
            430.0,
            "calculation");
      }

      //Answer No 61
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have related to the movable assets (leasing)?" &&
          widget.CheckQuestion == "Costs leasing") {
        //Question No 67
        return multioptionsContainerNo(
            """ <p><strong>Income replacement benefits</strong></p>
<p>Choose which options below apply to you. You can click and select multiple answers.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You now have to declare tax-free compensation, which you received in the year 2019. These include:</p>
<ul>
<li><strong>Unemployment benefit (ALG I)</strong> - You will receive unemployment benefits if you have previously paid into the statutory unemployment insurance and have fulfilled other conditions.</li>
<li><strong>Parental allowance</strong> - is a family benefit paid to help parents care for their newborn children.</li>
<li><strong>Sick pay</strong> - most employees who have state health insurance receive this if they are incapacitated for more than six weeks.</li>
<li><strong>Child sick pay</strong> - received by those with state insurance if the child is ill, needs to be cared for and the parent therefore they can not go to work.</li>
<li><strong>Maternity allowance (including subsidy)</strong> - is paid by the statutory health insurance during maternity leave.</li>
<li><strong>Unemployment assistance</strong> - is paid to regular soldiers who are unemployed and have at least two years of military service behind them.</li>
<li><strong>Insolvency allowance</strong> - paid to employees who suffer a loss of earnings due to the bankruptcy of their employer.</li>
<li><strong>Sickness benefits related to Federal War Victims Relief Act</strong> - is paid in the event of incapacity for work or inpatient rehab, inter alia for war victims, vaccinated persons or victims of violence.</li>
<li><strong>Compensation for loss of earnings under the Infection Protection Act</strong> - paid to an employees if they are quarantined due to infection with a transmissible pathogen.</li>
</ul>
<p>You don't have to include unemployment benefits ('Arbeitslosengeld II' / Hartz IV), housing benefits, child benefits, social benefits, strike benefits and sick pay from a private health insurer.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any of the following payments?",
            "Compensation payment",
            [
              "Unemployment benefits",
              "Parental allowance",
              "Sick pay",
              "Sick pay for children",
              "Maternity pay",
              "Unemployment assistance",
              "Insolvency allowance",
              "Pension about benefits related to ‘Bundesversogungsgesetz’",
              "Payments related to ‘Infektionsschutzgesetz’",
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
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //Rental of movable assets Ends

      //Rental of Post-contractual restraint Starts
      //Answer No 62
      else if (widget.CheckCompleteQuestion ==
              "How much compensation did ${Questions.incomeYouIdentity} receive due to a restraint or non-competition clause?" &&
          widget.CheckQuestion == "Amount") {
        //Question No 63
        return calculationContainer(
            """ <p><strong>Post-contractual restraint: additional costs</strong></p>
<p>Please enter the amount of additional costs you had due to a post-contractual restraint or non-competition clause. Please note only expenses in 2019 are relevant.</p>
<p>These could be legal or court costs, for instance.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to post-contractual restraint?",
            "Costs",
            430.0,
            "calculation");
      }

      //Answer No 63
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to post-contractual restraint?" &&
          widget.CheckQuestion == "Costs") {
        //Question No 67
        return multioptionsContainerNo(
            """ <p><strong>Income replacement benefits</strong></p>
<p>Choose which options below apply to you. You can click and select multiple answers.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You now have to declare tax-free compensation, which you received in the year 2019. These include:</p>
<ul>
<li><strong>Unemployment benefit (ALG I)</strong> - You will receive unemployment benefits if you have previously paid into the statutory unemployment insurance and have fulfilled other conditions.</li>
<li><strong>Parental allowance</strong> - is a family benefit paid to help parents care for their newborn children.</li>
<li><strong>Sick pay</strong> - most employees who have state health insurance receive this if they are incapacitated for more than six weeks.</li>
<li><strong>Child sick pay</strong> - received by those with state insurance if the child is ill, needs to be cared for and the parent therefore they can not go to work.</li>
<li><strong>Maternity allowance (including subsidy)</strong> - is paid by the statutory health insurance during maternity leave.</li>
<li><strong>Unemployment assistance</strong> - is paid to regular soldiers who are unemployed and have at least two years of military service behind them.</li>
<li><strong>Insolvency allowance</strong> - paid to employees who suffer a loss of earnings due to the bankruptcy of their employer.</li>
<li><strong>Sickness benefits related to Federal War Victims Relief Act</strong> - is paid in the event of incapacity for work or inpatient rehab, inter alia for war victims, vaccinated persons or victims of violence.</li>
<li><strong>Compensation for loss of earnings under the Infection Protection Act</strong> - paid to an employees if they are quarantined due to infection with a transmissible pathogen.</li>
</ul>
<p>You don't have to include unemployment benefits ('Arbeitslosengeld II' / Hartz IV), housing benefits, child benefits, social benefits, strike benefits and sick pay from a private health insurer.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any of the following payments?",
            "Compensation payment",
            [
              "Unemployment benefits",
              "Parental allowance",
              "Sick pay",
              "Sick pay for children",
              "Maternity pay",
              "Unemployment assistance",
              "Insolvency allowance",
              "Pension about benefits related to ‘Bundesversogungsgesetz’",
              "Payments related to ‘Infektionsschutzgesetz’",
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
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //Rental of Post-contractual restraint Ends

      //Other services Starts
      //Answer No 64
      else if (widget.CheckCompleteQuestion ==
              "What kind of other services did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Kind of other services") {
        //Question No 65
        return calculationContainer(
            """ <p><strong>Amount other services</strong></p>
<p>Please enter here the total amount you received in 2019 from [service name]</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "How much money did ${Questions.incomeYouIdentity} receive from ${Questions.serviceName}?",
            "Amount earnings",
            220.0,
            "calculation");
      }

      //Answer No 65
      else if (widget.CheckCompleteQuestion ==
              "How much money did ${Questions.incomeYouIdentity} receive from ${Questions.serviceName}?" &&
          widget.CheckQuestion == "Amount earnings") {
        //Question No 66
        return calculationContainer(
            """ <p><strong>Post-contractual restraint: additional costs</strong></p>
<p>Please enter the amount of additional costs you had due to a post-contractual restraint or non-competition clause. Please note only expenses in 2019 are relevant.</p>
<p>These could be legal or court costs, for instance.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What costs did ${Questions.incomeYouIdentity} have due to ${Questions.serviceName}?",
            "Costs",
            430.0,
            "calculation");
      }

      //Answer No 63
      else if (widget.CheckCompleteQuestion ==
              "What costs did ${Questions.incomeYouIdentity} have due to ${Questions.serviceName}?" &&
          widget.CheckQuestion == "Costs") {
        //Question No 67
        return multioptionsContainerNo(
            """ <p><strong>Income replacement benefits</strong></p>
<p>Choose which options below apply to you. You can click and select multiple answers.</p>
<p><strong>YOUR TAXES</strong></p>
<p>You now have to declare tax-free compensation, which you received in the year 2019. These include:</p>
<ul>
<li><strong>Unemployment benefit (ALG I)</strong> - You will receive unemployment benefits if you have previously paid into the statutory unemployment insurance and have fulfilled other conditions.</li>
<li><strong>Parental allowance</strong> - is a family benefit paid to help parents care for their newborn children.</li>
<li><strong>Sick pay</strong> - most employees who have state health insurance receive this if they are incapacitated for more than six weeks.</li>
<li><strong>Child sick pay</strong> - received by those with state insurance if the child is ill, needs to be cared for and the parent therefore they can not go to work.</li>
<li><strong>Maternity allowance (including subsidy)</strong> - is paid by the statutory health insurance during maternity leave.</li>
<li><strong>Unemployment assistance</strong> - is paid to regular soldiers who are unemployed and have at least two years of military service behind them.</li>
<li><strong>Insolvency allowance</strong> - paid to employees who suffer a loss of earnings due to the bankruptcy of their employer.</li>
<li><strong>Sickness benefits related to Federal War Victims Relief Act</strong> - is paid in the event of incapacity for work or inpatient rehab, inter alia for war victims, vaccinated persons or victims of violence.</li>
<li><strong>Compensation for loss of earnings under the Infection Protection Act</strong> - paid to an employees if they are quarantined due to infection with a transmissible pathogen.</li>
</ul>
<p>You don't have to include unemployment benefits ('Arbeitslosengeld II' / Hartz IV), housing benefits, child benefits, social benefits, strike benefits and sick pay from a private health insurer.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} receive any of the following payments?",
            "Compensation payment",
            [
              "Unemployment benefits",
              "Parental allowance",
              "Sick pay",
              "Sick pay for children",
              "Maternity pay",
              "Unemployment assistance",
              "Insolvency allowance",
              "Pension about benefits related to 'Bundesversogungsgesetz'",
              "Payments related to 'Infektionsschutzgesetz'",
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
              "images/disabilityoption.png"
            ],
            220.0);
      }

      //Other services Ends

//Now Other Services Flow End

      //Answer No 9
      else if (widget.CheckCompleteQuestion ==
              "How many square meters did ${Questions.incomeYouIdentity} use yourself?" &&
          widget.CheckQuestion == "Area used by self") {
        //Question No 127
        return calculationContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "How many square meters were used for other purposes?",
            "Area used by others",
            220.0,
            "");
      }

      //Answer No 127
      else if (widget.CheckCompleteQuestion ==
              "How many square meters were used for other purposes?" &&
          widget.CheckQuestion == "Area used by others") {
        //Question No 128
        return dateContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "When did ${Questions.incomeYouIdentity} move into the property?",
            "Move in",
            220.0);
      }

      //Answer No 128
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} move into the property?" &&
          widget.CheckQuestion == "Move in") {
        //Question No 129
        return dateContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "When did ${Questions.incomeYouIdentity} move out the property?",
            "Move out",
            220.0);
      }

      //Answer No 129
      else if (widget.CheckCompleteQuestion ==
              "When did ${Questions.incomeYouIdentity} move out the property?" &&
          widget.CheckQuestion == "Move out") {
        //Question No 130
        return dateContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "When did someone else move into the property?",
            "Move in (someone else)",
            220.0);
      }

      //Answer No 130
      else if (widget.CheckCompleteQuestion ==
              "When did someone else move into the property?" &&
          widget.CheckQuestion == "Move in (someone else)") {
        //Question No 131
        return dateContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "When did someone else move out of the property?",
            "Move out (someone else)",
            220.0);
      }

      //Answer No 131
      else if (widget.CheckCompleteQuestion ==
              "When did someone else move out of the property?" &&
          widget.CheckQuestion == "Move out (someone else)") {
        //Question No 132
        if (Questions.residence == "Yes, and also as a third-party rental") {
          //Question No 132
          return calculationContainer(
              """<p><strong>Sale of property: date of sale</strong></p>
<p>Please enter the date you sold the property. The sale must have been in 2019.</p>
<p><strong>WHY IT'S IMPORTANT</strong></p>
<p>Sale of property can be viewed as a private sale transaction. A crucial factor is the usage as well as the date of sale of the property.</p>
<p>You can find the date on your contract with the buyer.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "At what price did ${Questions.incomeYouIdentity} sell the property?",
              "Sale price",
              220.0,
              "calculation");
        } else {
          //Question No 134
          return twooptionContainer(
              """ <p><strong>Sale of property: age of property</strong></p>
<p>We need to know the completion date of the property to determine the correct period of depreciation</p>
<p>Please enter the correct date here.</p>
<p>You can find this information in the land register.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "When was the property built?",
              "Completion date",
              ["Before 01.01.1925", "After 31.12.1924"],
              220.0);
        }
      }

      //Answer No 132
      else if (widget.CheckCompleteQuestion ==
              "At what price did ${Questions.incomeYouIdentity} sell the property?" &&
          widget.CheckQuestion == "Sale price") {
        //Question No 133
        return calculationContainer(
            """ <p><strong>Sale of property: price</strong></p>
<p>The basis of building depreciation calculation is the acquisition or construction cost of the property.</p>
<p>For this reason we need information such as the construction cost or purchase price. Please enter this information here.</p> """,
            "",
            "Income",
            "What were the manufacturing or acquisition costs of the property?",
            "Purchase price",
            280.0,
            "calculation");
      }

      //Answer No 133
      else if (widget.CheckCompleteQuestion ==
              "What were the manufacturing or acquisition costs of the property?" &&
          widget.CheckQuestion == "Purchase price") {
        //Question No 134
        return twooptionContainer(
            """ <p><strong>Sale of property: age of property</strong></p>
<p>We need to know the completion date of the property to determine the correct period of depreciation</p>
<p>Please enter the correct date here.</p>
<p>You can find this information in the land register.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "When was the property built?",
            "Completion date",
            ["Before 01.01.1925", "After 31.12.1924"],
            220.0);
      }

      //Answer No 134
      else if (widget.CheckCompleteQuestion == "When was the property built?" &&
          widget.CheckQuestion == "Completion date") {
        if (widget.CheckAnswer[0] == "Before 01.01.1925") {
          DbHelper.insatance.deleteWithquestion('When was the property built?');
          _insert('When was the property built?', 'Before 01.01.1925', 'OK');

          //For No 220.0
          //For yes 430.0
          //Question No 135
          return yesnoContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "We have calculated €150.00 as the depreciation amount. Is that correct?",
              "Depreciation",
              220.0,
              "");
        } else if (widget.CheckAnswer[0] == "After 31.12.1924") {
          DbHelper.insatance.deleteWithquestion('When was the property built?');
          _insert('When was the property built?', 'After 31.12.1924', 'OK');

          //For No 220.0
          //For yes 430.0
          //Question No 135
          return yesnoContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "We have calculated €150.00 as the depreciation amount. Is that correct?",
              "Depreciation",
              220.0,
              "");
        }
      }

      //After cs I will do that
      //Answer No 135
      else if (widget.CheckCompleteQuestion ==
              "We have calculated €150.00 as the depreciation amount. Is that correct?" &&
          widget.CheckQuestion == "Depreciation") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance.deleteWithquestion(
              'We have calculated €150.00 as the depreciation amount. Is that correct?');
          _insert(
              'We have calculated €150.00 as the depreciation amount. Is that correct?',
              'No',
              'OK');

          //Question No 136
          return calculationContainer(
              """<p><strong>Sale of property: depreciation</strong></p>
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
              "",
              "Income",
              "We have calculated €150.00 as the depreciation amount. Is that correct?",
              "Depreciation amount",
              430.0,
              "calculation");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance.deleteWithquestion(
              'We have calculated €150.00 as the depreciation amount. Is that correct?');
          _insert(
              'We have calculated €150.00 as the depreciation amount. Is that correct?',
              'Yes',
              'OK');

          //Question No 137
          //For None 362.0
          //For rest of options 220.0
          return multioptionsContainerNo(
              """ <p><strong>Sale of property: additional costs</strong></p>
<p>If you had additional costs while selling your property in 2019, please select the options below accordingly. You can choose multiple answers.</p>
<p>When selling a property you incur additional costs.</p>
<p>This can include the following:</p>
<ul>
<li>Notary Notary costs arise, for example, if you need to create a notarial purchase contract.</li>
<li>Real estate transfer tax If you paid real estate transfer tax, select this option.</li>
<li>Advertising costs if you advertised your property on the Internet, you can enter the costs for this.</li>
<li>Bank costs Please specify if you required a separate bank account for your property.</li>
<li>Broker fees If a broker or real estate agent helped you to sell your property, then you can enter these costs here.</li>
<li>Loan interest Loan interest payments which are still due are tax deductible.</li>
</ul>
<p>In the following questions, we ask about these costs in more detail so that we can deduct them.</p>
<p>&nbsp;</p> """,
              "",
              "Income",
              "What other costs did ${Questions.incomeYouIdentity} have relating to the sale of property?",
              "Other costs",
              [
                "Notary costs",
                "Real estate transfer tax",
                "Advertising costs",
                "Bank costs",
                "Broker fees",
                "Loan interest",
                "None"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png",
                "images/check.png",
                "images/disabilityoption.png",
                "images/disabilityoption.png",
                "images/alimonypaidoption.png"
              ],
              220.0);
        }
      }

      //Answer No 136

      else if (widget.CheckCompleteQuestion ==
              "How much depreciation did ${Questions.incomeYouIdentity} declare?" &&
          widget.CheckQuestion == "Depreciation amount") {
        //Question No 137
        return multioptionsContainerNo(
            """ <p><strong>Sale of property: additional costs</strong></p>
<p>If you had additional costs while selling your property in 2019, please select the options below accordingly. You can choose multiple answers.</p>
<p>When selling a property you incur additional costs.</p>
<p>This can include the following:</p>
<ul>
<li>Notary Notary costs arise, for example, if you need to create a notarial purchase contract.</li>
<li>Real estate transfer tax If you paid real estate transfer tax, select this option.</li>
<li>Advertising costs if you advertised your property on the Internet, you can enter the costs for this.</li>
<li>Bank costs Please specify if you required a separate bank account for your property.</li>
<li>Broker fees If a broker or real estate agent helped you to sell your property, then you can enter these costs here.</li>
<li>Loan interest Loan interest payments which are still due are tax deductible.</li>
</ul>
<p>In the following questions, we ask about these costs in more detail so that we can deduct them.</p>
<p>&nbsp;</p> """,
            "",
            "Income",
            "What other costs did ${Questions.incomeYouIdentity} have relating to the sale of property?",
            "Other costs",
            [
              "Notary costs",
              "Real estate transfer tax",
              "Advertising costs",
              "Bank costs",
              "Broker fees",
              "Loan interest",
              "None"
            ],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png",
              "images/disabilityoption.png",
              "images/disabilityoption.png",
              "images/alimonypaidoption.png"
            ],
            220.0);
      }

      //Answer No 137
      else if (widget.CheckCompleteQuestion ==
              "What other costs did ${Questions.incomeYouIdentity} have relating to the sale of property?" &&
          widget.CheckQuestion == "Other costs") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Notary costs") {
            DbHelper.insatance.deleteWithquestion(
                'What other costs did have relating to the sale of property?');
            _insert(
                'What other costs did have relating to the sale of property?',
                'Notary costs',
                'OK');

            //Question No 138
            return calculationContainer(
                """ <p><strong>Sale of property: notary costs</strong></p>
<p>Please enter the total notary costs resulting from the sale of property. Remember, only expenses from 2019 are relevant.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} spend on notaries?",
                "Notary costs",
                362.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Real estate transfer tax") {
            DbHelper.insatance.deleteWithquestion(
                'What other costs did have relating to the sale of property?');
            _insert(
                'What other costs did have relating to the sale of property?',
                'Real estate transfer tax',
                'OK');

            //Question No 139
            return calculationContainer(
                """ <p><strong>Sale of property: real estate transfer tax</strong></p>
<p>Please enter how much you paid in real estate transfer tax. Remember, only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>Real estate transfer tax due on the acquisition of property. It is one of the additional costs when buying real estate.</p>
<p>Depending on the federal state, the tax rate is between 3.5% and 6.5%.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} spend on real estate transfer tax?",
                "Real estate transfer tax costs",
                362.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Advertising costs") {
            DbHelper.insatance.deleteWithquestion(
                'What other costs did have relating to the sale of property?');
            _insert(
                'What other costs did have relating to the sale of property?',
                'Advertising costs',
                'OK');

            //Question No 140
            return calculationContainer(
                """ <p><strong>Sale of property: advertising costs</strong></p>
<p>Please enter how much you paid in listing and advertising costs relating to the sale of property. Remember, only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>In order to sell your property more quickly you can list your real estate in magazines or advertise on websites. These costs are tax deductible.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} spend on advertising?",
                "Advertising costs",
                362.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Bank costs") {
            DbHelper.insatance.deleteWithquestion(
                'What other costs did have relating to the sale of property?');
            _insert(
                'What other costs did have relating to the sale of property?',
                'Bank costs',
                'OK');

            //Question No 141
            return calculationContainer("""  """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} spend on bank costs?",
                "Bank costs",
                362.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Broker fees") {
            DbHelper.insatance.deleteWithquestion(
                'What other costs did have relating to the sale of property?');
            _insert(
                'What other costs did have relating to the sale of property?',
                'Broker fees',
                'OK');

            //Question No 142
            return calculationContainer(
                """ <p><strong>Sale of property: broker fees</strong></p>
<p>Please enter how much you paid in broker or estate agent costs. Remember, only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>In order to sell a property, you can seek the help of a broker or estate agent. These costs are tax deductible.</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} spend on broker fees?",
                "Broker fees",
                362.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Loan interest") {
            DbHelper.insatance.deleteWithquestion(
                'What other costs did have relating to the sale of property?');
            _insert(
                'What other costs did have relating to the sale of property?',
                'Loan interest',
                'OK');

            //Question No 143
            return calculationContainer(
                """ <p><strong>Sale of property: loan interest</strong></p>
<p>Please enter how much you paid in loan interest. Remember, only expenses from 2019 are relevant.</p>
<p><strong>YOUR TAXES</strong></p>
<p>When you sell a property, the profit usually goes to paying down an existing loan or mortgage. If the profit is not sufficient to pay off the loan or mortgage, the you must continue making payments.</p>
<p>The interest due on these payments is tax deductible.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} spend on loan interest?",
                "Loan interest",
                362.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "None") {
            DbHelper.insatance.deleteWithquestion(
                'What other costs did have relating to the sale of property?');
            _insert(
                'What other costs did have relating to the sale of property?',
                'None',
                'OK');

            //Question No 10
            return multithreeContainer(
                """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} sold any assets?",
                "Sales",
                ["Web domains", "Bitcoins", "Other valuables", "None"],
                [
                  "images/disabilityoption.png",
                  "images/alimonypaidoption.png",
                  "images/survivorspension.png",
                  "images/check.png"
                ],
                430.0);
          }
        }
      }

      //Answer No 138
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} spend on notaries?" &&
          widget.CheckQuestion == "Notary costs") {
        //Question No 10
        return multithreeContainer(
            """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} sold any assets?",
            "Sales",
            ["Web domains", "Bitcoins", "Other valuables", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            430.0);
      }

      //Answer No 139
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} spend on real estate transfer tax?" &&
          widget.CheckQuestion == "Real estate transfer tax costs") {
        //Question No 10
        return multithreeContainer(
            """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} sold any assets?",
            "Sales",
            ["Web domains", "Bitcoins", "Other valuables", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            430.0);
      }

      //Answer No 140
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} spend on advertising?" &&
          widget.CheckQuestion == "Advertising costs") {
        //Question No 10
        return multithreeContainer(
            """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} sold any assets?",
            "Sales",
            ["Web domains", "Bitcoins", "Other valuables", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            430.0);
      }

      //Answer No 141
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} spend on bank costs?" &&
          widget.CheckQuestion == "Bank costs") {
        //Question No 10
        return multithreeContainer(
            """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} sold any assets?",
            "Sales",
            ["Web domains", "Bitcoins", "Other valuables", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            430.0);
      }

      //Answer No 142
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} spend on broker fees?" &&
          widget.CheckQuestion == "Broker fees") {
        //Question No 10
        return multithreeContainer(
            """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} sold any assets?",
            "Sales",
            ["Web domains", "Bitcoins", "Other valuables", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            430.0);
      }

      //Answer No 143
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} spend on loan interest?" &&
          widget.CheckQuestion == "Loan interest") {
        //Question No 10
        return multithreeContainer(
            """ <p><strong>Private sales</strong></p>
<p>Choose which items you sold in 2019. It does not matter if you got a profit or loss. Swapping also represents a sale. If you haven't sold any of these items, choose "None."</p>
<p><strong>You can select multiple options.</strong></p>
<p><strong>WEB DOMAINS</strong></p>
<ul>
<li>websites with the suffixes ".com" or ".de" etc.</li>
</ul>
<p><strong>BITCOINS</strong></p>
<ul>
<li>online currency</li>
</ul>
<p><strong>OTHER VALUABLE OBJECTS</strong></p>
<ul>
<li>gold</li>
<li>jewelry</li>
<li>art</li>
<li>stamps</li>
<li>coins</li>
<li>antiques</li>
<li>classic cars</li>
<li>boats</li>
</ul>
<p><strong>YOUR TAXES</strong></p>
<p>Include private sales if the object was <strong>in your</strong> <strong>possession for less than one year</strong> and the <strong>profit from the sale was over 600 euros.</strong></p>
<p>If the object was in your possession for more than one year, you do not need to do anything regardless of any profit.</p>
<p>You also do not need to do anything if the difference between the purchase and sale price is less than 600 euros (regardless of the length of ownership).</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>""",
            "",
            "Income",
            "Have ${Questions.incomeYouIdentity} sold any assets?",
            "Sales",
            ["Web domains", "Bitcoins", "Other valuables", "None"],
            [
              "images/disabilityoption.png",
              "images/alimonypaidoption.png",
              "images/survivorspension.png",
              "images/check.png"
            ],
            430.0);
      }

      //Answer No 67

      //Following Payments start
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.incomeYouIdentity} receive any of the following payments?" &&
          widget.CheckQuestion == "Compensation payment") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Unemployment benefits") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?',
                'Unemployment benefits', 'OK');

            //Question 71 will come
            return calculationContainer(
                """ <p><strong>Amount of unemployment benefits</strong></p>
<p>Please enter the amount of unemployment benefits ('Arbeitslosengeld I') you received. Remember, only amounts from 2019 are relevant.</p>
<p>You can find the amount of your unemployment benefits on your <strong>certificate of receipt of unemployment benefits</strong>. This is sent to you automatically by the employment agency by 28 February of the following year at the latest. If you have not received this document, get in touch with the employment agency.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information, because although unemployment benefits are tax-free, they are still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} receive in unemployment benefits?",
                "Unemployment benefits",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Parental allowance") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?',
                'Parental allowance', 'OK');

            //Question 120 will come
            return calculationContainer(
                """ <p><strong>Amount of parental allowance</strong></p>
<p>Please enter the annual total amount of parental allowance you received. Remember, only amounts from 2019 are relevant.</p>
<p>You can find the amount in your documents from your health insurance.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information, because although parental allowance is tax-free, it is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much parental allowance did ${Questions.incomeYouIdentity} get?",
                "Parental allowance",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Sick pay") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?', 'Sick pay', 'OK');

            //Question 83 will come
            return calculationContainer(
                """ <p><strong>Amount of sick pay</strong></p>
<p>Please enter the amount of sick pay you received in 2019. Remember, only amount from 2019 are relevant.</p>
<p>You can find the duration of your sick pay in documents sent to you by your health insurer. If you did not receive this document, get in touch with your health insurer.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information because although sick pay is tax-free, it is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much sick pay did ${Questions.incomeYouIdentity} receive?",
                "Sick pay",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Sick pay for children") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?',
                'Sick pay for children', 'OK');

            //Question 89 will come
            return calculationContainer(
                """ <p><strong>Amount of sick pay</strong></p>
<p>Please enter the amount of sick pay you received in 2019. Remember, only amount from 2019 are relevant.</p>
<p>You can find the duration of your sick pay in documents sent to you by your health insurer. If you did not receive this document, get in touch with your health insurer.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information because although sick pay is tax-free, it is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much sick pay did ${Questions.incomeYouIdentity} get for your child?",
                "Sick pay for children",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Maternity pay") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?', 'Maternity pay',
                'OK');

            //Question 96 will come
            return calculationContainer(
                """ <p><strong>Amount of maternity pay</strong></p>
<p>Please enter the annual amount of maternity pay you received from your health insurance. Remember, only amounts from 2019 are relevant.</p>
<p>You can find the amount of your maternity pay in documents sent to you by your health insurer. If you have not received this document, get in touch with your health insurer.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information, because although maternity pay is tax-free, is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much maternity pay did ${Questions.incomeYouIdentity} receive?",
                "Maternity pay",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Unemployment assistance") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?',
                'Unemployment assistance', 'OK');

            //Question 100 will come
            return calculationContainer(
                """ <p><strong>Amount of unemployment assistance</strong></p>
<p>Please enter the annual amount of unemployment assistance you received. Remember, only amounts from 2019 are relevant.</p>
<p>You can find the amount of your unemployment benefits in your documents confirming your receipt of unemployment assistance.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information, because although unemployment assistance is tax-free, it is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much employment assistance did ${Questions.incomeYouIdentity} receive?",
                "Unemployment assistance",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "Insolvency allowance") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?',
                'Insolvency allowance', 'OK');

            //Question 74 will come
            return calculationContainer(
                """ <p><strong>Amount of insolvency allowance</strong></p>
<p>Please enter the amount of insolvency allowance you received in 2019. Remember, only amounts from 2019 are relevant.</p>
<p>You can find the amount of your insolvency allowance on <strong>your certificate of receipt of insolvency allowance</strong>. This is sent to you automatically by the employment agency by 28 February of the following year at the latest. If you did not receive this document, get in touch with the employment agency.</p>
<p><strong>TAX-FREE</strong></p>
<p>We require this information because although insolvency allowance is tax-free, it is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much insolvency allowance did ${Questions.incomeYouIdentity} receive?",
                "Amount",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] ==
              "Pension about benefits related to 'Bundesversogungsgesetz'") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert(
                'receive any of the following payments?',
                'Pension about benefits related to Bundesversogungsgesetz',
                'OK');

            //Question 110 will come
            return calculationContainer(
                """ <p><strong>Payments related to the Protection against Infectious Diseases Act: amount</strong></p>
<p>Please enter the annual amount you received in compensation due to loss of earnings related to the Protection against Infectious Diseases Act in 2019.</p>
<p>You can find this information in your salary documents.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information, because although this compensation is tax-free, it is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much compensation did ${Questions.incomeYouIdentity} receive?",
                "Amount",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] ==
              "Payments related to 'Infektionsschutzgesetz'") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?',
                'Payments related to Infektionsschutzgesetz', 'OK');

            //Question 106 will come
            return calculationContainer(
                """ <p><strong>Payments related to the Protection against Infectious Diseases Act: amount</strong></p>
<p>Please enter the annual amount you received in compensation due to loss of earnings related to the Protection against Infectious Diseases Act in 2019.</p>
<p>You can find this information in your salary documents.</p>
<p><strong>TAX-FREE</strong></p>
<p>We need this information, because although this compensation is tax-free, it is still subject to the progression provision. This has an effect on the rest of your taxable income.</p>
<p>&nbsp;</p>
<p>&nbsp;</p> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} receive in compensation for Infektionsschutzgesetz?",
                "Amount",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[m] == "No") {
            DbHelper.insatance
                .deleteWithquestion('receive any of the following payments?');
            _insert('receive any of the following payments?', 'No', 'OK');

            if (Questions.alimonyReceivedIncome == "Alimony received") {
              //Question No 144
              return multithreeContainer(
                  """<h1>Coming Soon!</h1> """,
                  "",
                  "Income",
                  "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
                  "Type of alimony pay",
                  [
                    "Alimony payments",
                    "Compensation payments to prevent a pension rights adjustment",
                    "Payments as part of a pension rights adjustment"
                  ],
                  [
                    "images/disabilityoption.png",
                    "images/alimonypaidoption.png",
                    "images/survivorspension.png"
                  ],
                  340.0);
            }

            //For partner
            else if ((Questions.LivingCheck == 2 ||
                    Questions.LivingCheck == 3) &&
                Questions.incomePartner == true) {
              incomePartner();
              //Question No 1
              //for no 340.0
              //for yes 220.0
              return payslipContainer("""<h1>Coming Soon!</h1> """,
                  "",
                  "Income",
                  "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
                  "Annual payslip",
                  340.0);
            } else {
              return FinishCategory(
                  "Income Category", "Home Category", 2, true);
            }
          }
        }
      }

      //Following payments end

      //Answer No 71
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} receive in unemployment benefits?" &&
          widget.CheckQuestion == "Unemployment benefits") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }

        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 120
      else if (widget.CheckCompleteQuestion ==
              "How much parental allowance did ${Questions.incomeYouIdentity} get?" &&
          widget.CheckQuestion == "Parental allowance") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 83
      else if (widget.CheckCompleteQuestion ==
              "How much sick pay did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Sick pay") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 89
      else if (widget.CheckCompleteQuestion ==
              "How much sick pay did ${Questions.incomeYouIdentity} get for your child?" &&
          widget.CheckQuestion == "Sick pay for children") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 96
      else if (widget.CheckCompleteQuestion ==
              "How much maternity pay did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Maternity pay") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 100
      else if (widget.CheckCompleteQuestion ==
              "How much employment assistance did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Unemployment assistance") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 74
      else if (widget.CheckCompleteQuestion ==
              "How much insolvency allowance did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 110
      else if (widget.CheckCompleteQuestion ==
              "How much compensation did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      //Answer No 106
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} receive in compensation for Infektionsschutzgesetz?" &&
          widget.CheckQuestion == "Amount") {
        if (Questions.alimonyReceivedIncome == "Alimony received") {
          //Question No 144
          return multithreeContainer(
              """<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?",
              "Type of alimony pay",
              [
                "Alimony payments",
                "Compensation payments to prevent a pension rights adjustment",
                "Payments as part of a pension rights adjustment"
              ],
              [
                "images/disabilityoption.png",
                "images/alimonypaidoption.png",
                "images/survivorspension.png"
              ],
              340.0);
        }
        //For partner
        else if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }
      }

      // ====== Alimony Received Starts (Relation) ====== //
      //Answer No 144
      else if (widget.CheckCompleteQuestion ==
              "What type of alimony pay did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Type of alimony pay") {
        for (int m = 0; m < widget.CheckAnswer.length; m++) {
          if (widget.CheckAnswer[m] == "Alimony payments") {
            DbHelper.insatance
                .deleteWithquestion('What type of alimony pay did receive?');
            _insert('What type of alimony pay did receive?', 'Alimony payments',
                'OK');

            Questions.typeAlimonyPay = "Alimony payments";
            //Question No 145
            return threeoptionContainer(
                """<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Is the paying party deducting these payments as special expenses?",
                "Deductible",
                ["Yes, in full", "Yes, in part", "No"],
                220.0);
          } else if (widget.CheckAnswer[m] ==
              "Compensation payments to prevent a pension rights adjustment") {
            DbHelper.insatance
                .deleteWithquestion('What type of alimony pay did receive?');
            _insert(
                'What type of alimony pay did receive?',
                'Compensation payments to prevent a pension rights adjustment',
                'OK');

            Questions.typeAlimonyPay =
                "Compensation payments to prevent a pension rights adjustment";
            //Question No 145
            return threeoptionContainer(
                """<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Is the paying party deducting these payments as special expenses?",
                "Deductible",
                ["Yes, in full", "Yes, in part", "No"],
                220.0);
          } else if (widget.CheckAnswer[m] ==
              "Payments as part of a pension rights adjustment") {
            DbHelper.insatance
                .deleteWithquestion('What type of alimony pay did receive?');
            _insert('What type of alimony pay did receive?',
                'Payments as part of a pension rights adjustment', 'OK');

            Questions.typeAlimonyPay =
                "Payments as part of a pension rights adjustment";
            //Question No 145
            return threeoptionContainer(
                """<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Is the paying party deducting these payments as special expenses?",
                "Deductible",
                ["Yes, in full", "Yes, in part", "No"],
                220.0);
          }
        }
      }

      //Answer No 145

      // Alimony payments Starts
      else if (widget.CheckCompleteQuestion ==
              "Is the paying party deducting these payments as special expenses?" &&
          widget.CheckQuestion == "Deductible") {
        if (Questions.typeAlimonyPay == "Alimony payments") {
          if (widget.CheckAnswer[0] == "Yes, in full") {
            DbHelper.insatance.deleteWithquestion(
                'Is the paying party deducting these payments as special expenses?');
            _insert(
                'Is the paying party deducting these payments as special expenses?',
                'Yes, in full',
                'OK');

            Questions.alimonyIncomePayment = "Yes, in full";
            //Question No 146
            return calculationContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "How much alimony did ${Questions.incomeYouIdentity} receive?",
                "Amount alimony payments",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[0] == "Yes, in part") {
            DbHelper.insatance.deleteWithquestion(
                'Is the paying party deducting these payments as special expenses?');
            _insert(
                'Is the paying party deducting these payments as special expenses?',
                'Yes, in part',
                'OK');

            Questions.alimonyIncomePayment = "Yes, in part";
            //Question No 146
            return calculationContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "How much alimony did ${Questions.incomeYouIdentity} receive?",
                "Amount alimony payments",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[0] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Is the paying party deducting these payments as special expenses?');
            _insert(
                'Is the paying party deducting these payments as special expenses?',
                'No',
                'OK');

            //For partner
            if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
                Questions.incomePartner == true) {
              incomePartner();
              //Question No 1
              //for no 340.0
              //for yes 220.0
              return payslipContainer("""<h1>Coming Soon!</h1> """,
                  "",
                  "Income",
                  "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
                  "Annual payslip",
                  340.0);
            } else {
              return FinishCategory(
                  "Income Category", "Home Category", 2, true);
            }
          }
        } else if (Questions.typeAlimonyPay ==
            "Compensation payments to prevent a pension rights adjustment") {
          if (widget.CheckAnswer[0] == "Yes, in full") {
            DbHelper.insatance.deleteWithquestion(
                'Compensation payments to prevent a pension rights adjustment');
            _insert(
                'Compensation payments to prevent a pension rights adjustment',
                'Yes, in full',
                'OK');

            Questions.alimonyIncomePayment = "Yes, in full";
            //Question No 150
            return calculationContainer(
                """ <p><strong>Post-contractual restraint: amount</strong></p>
<p>Please enter the total pay out you received due to a post-contractual restraint or non-competition clause in 2019. You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p>You should have received confirmation of these payments from your employer.</p> """,
                "",
                "Income",
                "How much compensation did ${Questions.incomeYouIdentity} receive?",
                "Compensation amount",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[0] == "Yes, in part") {
            DbHelper.insatance.deleteWithquestion(
                'Compensation payments to prevent a pension rights adjustment');
            _insert(
                'Compensation payments to prevent a pension rights adjustment',
                'Yes, in part',
                'OK');

            Questions.alimonyIncomePayment = "Yes, in part";
            //Question No 150
            return calculationContainer(
                """ <p><strong>Post-contractual restraint: amount</strong></p>
<p>Please enter the total pay out you received due to a post-contractual restraint or non-competition clause in 2019. You only need to choose this option in case the commission is not included in your annual wage tax certificate.</p>
<p>You should have received confirmation of these payments from your employer.</p> """,
                "",
                "Income",
                "How much compensation did ${Questions.incomeYouIdentity} receive?",
                "Compensation amount",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[0] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Compensation payments to prevent a pension rights adjustment');
            _insert(
                'Compensation payments to prevent a pension rights adjustment',
                'No',
                'OK');

            //For partner
            if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
                Questions.incomePartner == true) {
              incomePartner();
              //Question No 1
              //for no 340.0
              //for yes 220.0
              return payslipContainer("""<h1>Coming Soon!</h1> """,
                  "",
                  "Income",
                  "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
                  "Annual payslip",
                  340.0);
            } else {
              return FinishCategory(
                  "Income Category", "Home Category", 2, true);
            }

            // return FinishCategory("Income Category", "Home Category");
          }
        } else if (Questions.typeAlimonyPay ==
            "Payments as part of a pension rights adjustment") {
          if (widget.CheckAnswer[0] == "Yes, in full" ||
              widget.CheckAnswer[0] == "Yes, in part") {
            DbHelper.insatance.deleteWithquestion(
                'Payments as part of a pension rights adjustment');
            _insert('Payments as part of a pension rights adjustment',
                widget.CheckAnswer[0], 'OK');

            //Question No 153
            return calculationContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "How much did ${Questions.incomeYouIdentity} receive as part of a pension rights adjustment?",
                "Adjustment amount",
                220.0,
                "calculation");
          } else if (widget.CheckAnswer[0] == "No") {
            DbHelper.insatance.deleteWithquestion(
                'Payments as part of a pension rights adjustment');
            _insert(
                'Payments as part of a pension rights adjustment', 'No', 'OK');

            //For partner
            if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
                Questions.incomePartner == true) {
              incomePartner();
              //Question No 1
              //for no 340.0
              //for yes 220.0
              return payslipContainer("""<h1>Coming Soon!</h1> """,
                  "",
                  "Income",
                  "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
                  "Annual payslip",
                  340.0);
            } else {
              return FinishCategory(
                  "Income Category", "Home Category", 2, true);
            }

            //return FinishCategory("Income Category", "Home Category");
          }
        }
      }

      //Answer No 146
      else if (widget.CheckCompleteQuestion ==
              "How much alimony did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Amount alimony payments") {
        if (Questions.alimonyIncomePayment == "Yes, in full") {
          DbHelper.insatance
              .deleteWithquestion('How much alimony did receive?');
          _insert('How much alimony did receive?', 'Yes, in full', 'OK');

          //Question no 147
          return yesnoContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have any costs related to receiving these payments?",
              "Related expenses",
              220.0,
              "");
        } else if (Questions.alimonyIncomePayment == "Yes, in part") {
          DbHelper.insatance
              .deleteWithquestion('How much alimony did receive?');
          _insert('How much alimony did receive?', 'Yes, in part', 'OK');

          //Question No 149
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What share of the payments ${Questions.incomeYouIdentity} received was deducted by the other party?",
              "Deductible share",
              220.0,
              "calculation");
        }
      }

      //Answer No 149
      else if (widget.CheckCompleteQuestion ==
              "What share of the payments ${Questions.incomeYouIdentity} received was deducted by the other party?" &&
          widget.CheckQuestion == "Deductible share") {
        //Question no 147
        return yesnoContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} have any costs related to receiving these payments?",
            "Related expenses",
            220.0,
            "");
      }

      // Alimony payments Ends

      // compensation payments to prevent a pension rights adjustment Starts

      //Answer No 150
      else if (widget.CheckCompleteQuestion ==
              "How much compensation did ${Questions.incomeYouIdentity} receive?" &&
          widget.CheckQuestion == "Compensation amount") {
        if (Questions.alimonyIncomePayment == "Yes, in full") {
          //Question no 147
          return yesnoContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Did ${Questions.incomeYouIdentity} have any costs related to receiving these payments?",
              "Related expenses",
              220.0,
              "");
        } else if (Questions.alimonyIncomePayment == "Yes, in part") {
          //Question No 151
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "What share of the payments ${Questions.incomeYouIdentity} received was deducted by the other party? ",
              "Deductible share",
              220.0,
              "calculation");
        }
      }

      //Answer No 151
      else if (widget.CheckCompleteQuestion ==
              "What share of the payments ${Questions.incomeYouIdentity} received was deducted by the other party? " &&
          widget.CheckQuestion == "Deductible share") {
        //Question no 152
        return calculationContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "What share of the payments ${Questions.incomeYouIdentity} received was deducted by the other party?  ",
            "Deductible share",
            220.0,
            "calculation");
      }

      //Answer No 152
      else if (widget.CheckCompleteQuestion ==
              "What share of the payments ${Questions.incomeYouIdentity} received was deducted by the other party?  " &&
          widget.CheckQuestion == "Deductible share") {
        //Question no 147
        return yesnoContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} have any costs related to receiving these payments?",
            "Related expenses",
            220.0,
            "");
      }

      // compensation payments to prevent a pension rights adjustment Ends

      // Payments as part of a pension rights adjustment Starts

      //Answer No 153
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} receive as part of a pension rights adjustment?" &&
          widget.CheckQuestion == "Adjustment amount") {
        //Question no 147
        return yesnoContainer("""<h1>Coming Soon!</h1> """,
            "",
            "Income",
            "Did ${Questions.incomeYouIdentity} have any costs related to receiving these payments?",
            "Related expenses",
            220.0,
            "");
      }

      // Payments as part of a pension rights adjustment Ends

      //Answer No 147
      else if (widget.CheckCompleteQuestion ==
              "Did ${Questions.incomeYouIdentity} have any costs related to receiving these payments?" &&
          widget.CheckQuestion == "Related expenses") {
        if (widget.CheckAnswer[0] == "No") {
          DbHelper.insatance
              .deleteWithquestion('How much alimony did receive?');
          _insert('How much alimony did receive?', 'No', 'OK');

          //For partner
          if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
              Questions.incomePartner == true) {
            incomePartner();
            //Question No 1
            //for no 340.0
            //for yes 220.0
            return payslipContainer("""<h1>Coming Soon!</h1> """,
                "",
                "Income",
                "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
                "Annual payslip",
                340.0);
          } else {
            return FinishCategory("Income Category", "Home Category", 2, true);
          }

          //return FinishCategory("Income Category","Home Category");
        } else if (widget.CheckAnswer[0] == "Yes") {
          DbHelper.insatance
              .deleteWithquestion('How much alimony did receive?');
          _insert('How much alimony did receive?', 'Yes', 'OK');

          //Question No 148
          return calculationContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "How much did ${Questions.incomeYouIdentity} spend related to receiving the alimony payments?",
              "Amount alimony",
              220.0,
              "calculation");
        }
      }

      //Answer No 148
      else if (widget.CheckCompleteQuestion ==
              "How much did ${Questions.incomeYouIdentity} spend related to receiving the alimony payments?" &&
          widget.CheckQuestion == "Amount alimony") {
        //For partner
        if ((Questions.LivingCheck == 2 || Questions.LivingCheck == 3) &&
            Questions.incomePartner == true) {
          incomePartner();
          //Question No 1
          //for no 340.0
          //for yes 220.0
          return payslipContainer("""<h1>Coming Soon!</h1> """,
              "",
              "Income",
              "Have ${Questions.incomeYouIdentity} received their annual payslip(s) (Lohnsteuerbescheinigung) for 2019?",
              "Annual payslip",
              340.0);
        } else {
          return FinishCategory("Income Category", "Home Category", 2, true);
        }

        //return FinishCategory("Income Category","Home Category");
      }

      // ====== Alimony Received Ends (Relation) ====== //

    }
  }

//Question No 1
  Widget payslipContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return PaySlipContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 362.0);
  }

  Widget threeoptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return ThreeOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 340.0);
  }

  Widget dateContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return DateContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0);
  }

  // is container ki cheeza aga jaka change hogi
  Widget addressContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return AddressContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0);
  }

  Widget fouroptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return FourOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 390.0);
  }

  Widget calculationContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String AdditionalData) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return CalculationContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        additionalData: AdditionalData);
  }

  Widget multithreeContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      List AnswerImages,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return MultiThreeContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 380.0);
  }

  Widget yesnoContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String request) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return YesNoContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        Request: request);
  }

  Widget multioptionsContainerNo(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      List AnswerImages,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return MultiOptionsContainerNo(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        answerImages: AnswerImages,
        containerSize: 430.0);
  }

  Widget domainContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String Sale) {
    print("hi domain");
    Questions.incomeAnimatedContainer = animatedcontainer;
    return DomainContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        sale: Sale);
  }

  Widget twooptionContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return TwoOptionContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 280.0);
  }

  Widget valuablenameContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return ValuableNameContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0);
  }

  Widget valuableownedContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      double animatedcontainer,
      String Sale) {
    //print("hi domain");
    Questions.incomeAnimatedContainer = animatedcontainer;
    return ValuableOwnedContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        containerSize: 220.0,
        sale: Sale);
  }

  Widget threeoptionpayslipContainer(
      String briefqstn,
      String Identity,
      String BigQuestion,
      String CompleteQuestion,
      String QuestionOption,
      List AnswerOption,
      double animatedcontainer,
      String payslipno) {
    Questions.incomeAnimatedContainer = animatedcontainer;
    return ThreeOptionPaySlipContainer(
        briefqstn: briefqstn,
        identity: Identity,
        bigQuestion: BigQuestion,
        completeQuestion: CompleteQuestion,
        questionOption: QuestionOption,
        answerOption: AnswerOption,
        containerSize: 340.0,
        PaySlipNo: payslipno);
  }

  void incomePartner() {
    Questions.incomeAnimatedContainer = 370.0;

    qu.IncomeAddAnswer("Partner", "", "", "", [], 60.0);
    Questions.incomePartner = false;

    Questions.incomeYouIdentity = "your partner";
    Questions.incomeYourIdentity = "your partner";

    Questions.totalDomain = 0;
    Questions.domainLength = 0;
    Questions.totalValuable = 0;
    Questions.valuableLength = 0;
    Questions.residence = "";
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
            Questions.incomeAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IncomeMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.incomeAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.incomeAnswerShow = [];
            Questions.incomeAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IncomeMainQuestions(
                  CheckCompleteQuestion: Questions
                      .incomeAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.incomeAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.incomeAnswerShow[currentIndex - 1]['answer'][0]
                  ]);
            }));
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0, right: 10.0),
          height: Questions.incomeAnswerShow[currentIndex]['containerheight'],
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
                        Questions.incomeAnswerShow[currentIndex]['question'],
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
                            Questions.incomeAnswerShow[currentIndex]['answer']
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
            Questions.incomeAnswerShow = [];

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IncomeMainQuestions(
                  CheckCompleteQuestion: "",
                  CheckQuestion: "",
                  CheckAnswer: []);
            }));
          } else {
            answerSubList = Questions.incomeAnswerShow.sublist(0, currentIndex);
            print("Answer sub list:$answerSubList");
            Questions.incomeAnswerShow = [];
            Questions.incomeAnswerShow.addAll(answerSubList);

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IncomeMainQuestions(
                  CheckCompleteQuestion: Questions
                      .incomeAnswerShow[currentIndex - 1]['completequestion'],
                  CheckQuestion: Questions.incomeAnswerShow[currentIndex - 1]
                      ['question'],
                  CheckAnswer: [
                    Questions.incomeAnswerShow[currentIndex - 1]['answer'][0]
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
                          Questions.incomeAnswerShow[currentIndex]['question'],
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
                              Questions.incomeAnswerShow[currentIndex]['answer']
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
