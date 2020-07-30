import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

class questionInQuestion extends StatefulWidget {
  String quest;
  String br_quest;

  questionInQuestion(this.quest, this.br_quest);

  @override
  _questionInQuestionState createState() => _questionInQuestionState();
}

class _questionInQuestionState extends State<questionInQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f6ff),
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
                    title: Image(
                      image: AssetImage("images/questionemoji.png"),
                      height: 39,
                      width: 36,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF38B6FF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 12),
                        color: Color(0xff1D436A).withOpacity(0.2),
                        blurRadius: 80,
                      ),
                    ]),
                margin: EdgeInsets.only(left: 15, right: 15),
                width: 336,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text(
                      //   "Foreign Residency",
                      //   style: TextStyle(
                      //     color: Color(0xff003350).withOpacity(.803),
                      //     fontSize: 18,
                      //     wordSpacing: 1.2,
                      //     letterSpacing: 1,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Html(
                        // "Answer „yes“ to this question if in 2019 you moved to Germany or abroad. This means you only had a temporary residence in Germany.",
                        data: widget.br_quest,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Text(
                      //   "Holidays (including for a longer period) have no bearing on your residency.",
                      //   style: TextStyle(
                      //     color: Color(0xff003350).withOpacity(.803),
                      //     fontSize: 16,
                      //     height: 1.2,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 12),
                        color: Color(0xff1D436A).withOpacity(0.2),
                        blurRadius: 80,
                      ),
                    ]),
                margin: EdgeInsets.only(left: 15, right: 15),
                width: 336,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sabbatical",
                        style: TextStyle(
                          color: Color(0xff003350).withOpacity(.803),
                          fontSize: 18,
                          wordSpacing: 1.2,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Html(
                        data: widget.quest,
//                        "A sabbatical year, for example, where you travel through a foreign country for months, does not apply here.",
                        // style: TextStyle(
                        //   color: Color(0xff003350).withOpacity(.803),
                        //   fontSize: 16,
                        //   height: 1.2,
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 180.0,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 2.3 / 3,
                margin: EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 20.0, top: 25.0),
                child: MaterialButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
                  height: 48,
                  onPressed: () {},
                  child: Text(
                    "Contact our support team",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16.0,
                      fontFamily: 'Helvetica-Bold',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF38B6FF),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   color: Color(0xfff2f6ff),

      //   child:
      //   //   ),
      // ),
    );
  }
}
