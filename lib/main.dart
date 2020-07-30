import 'package:easy_taxx/categoryfinishedscreens/Bankdetails.dart';
import 'package:easy_taxx/categoryfinishedscreens/Personaldata.dart';
import 'package:easy_taxx/categoryfinishedscreens/sepadirectmandat.dart';
import 'package:easy_taxx/categoryfinishedscreens/totaltaxamount.dart';
import 'package:easy_taxx/livingsituation_flow/container3.dart';
import 'package:easy_taxx/SplashScreen/NewHere.dart';
import 'package:easy_taxx/SplashScreen/splashscreen.dart';
import 'package:easy_taxx/SplashScreen/startedScreen.dart';
import 'package:easy_taxx/SplashScreen/testStartedScreen.dart';
import 'package:easy_taxx/livingsituation_flow/container2.dart';
import 'package:easy_taxx/login.dart';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
//import 'package:easy_taxx/questions.dart';
import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/screens/category_progress.dart';
import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:easy_taxx/screens/contactOurSupport.dart';
import 'package:easy_taxx/screens/Faq.dart';
import 'package:easy_taxx/testing.dart';
import 'package:easy_taxx/testing2.dart';
import 'package:easy_taxx/widgets/CustomDropdown.dart';
import 'package:easy_taxx/widgets/my.dart';
import 'package:easy_taxx/widgets/select.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/allcategoryscreen.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFf2f6ff),
      body: SplashScreen(),
    ),
    theme: ThemeData(
      fontFamily: 'Helvetica',
    ),
    routes: <String, WidgetBuilder>{
      'GettingStartedScreens': (BuildContext context) => GettingStartedScreen(),
      'NewHere': (BuildContext context) => newHere(),
      'LoginPage': (BuildContext context) => loginPage(),
      'MainQuestions': (BuildContext context) => mainQuestions(),
      'Testing': (BuildContext context) => testing(),
      'SingleScreen': (BuildContext context) => Container2(),
      'testStartedScreens': (BuildContext context) => testStartedScreen(),
      'Employed': (BuildContext context) => Container3(),
      'DynamicContainer': (BuildContext context) => animation(),
      'allCategoryScreen': (BuildContext context) => AllCategoryScreen(),

//      'BottomBarUhasm' : (BuildContext context) => bottomBarUhasm(),
    },
  ));
}
