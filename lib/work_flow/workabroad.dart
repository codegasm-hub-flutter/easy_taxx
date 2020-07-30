import 'package:flutter/material.dart';
import 'package:easy_taxx/work_flow/workmainquestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';

class WorkAbroad extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  double containerSize;
  String bigQuestion;


  WorkAbroad({this.identity,this.bigQuestion,this.completeQuestion,this.questionOption,this.containerSize});
  @override
  _WorkAbroadState createState() => _WorkAbroadState();
}

class _WorkAbroadState extends State<WorkAbroad> {
  TextEditingController _country = TextEditingController();
  Questions qu =Questions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Icon(Icons.clear,color: Colors.blue,),
        title: Text("Destination abroad",style: TextStyle(color: Colors.black,fontSize: 16.0),),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0,top: 22.0),
              child: GestureDetector(
                onTap: () {
                  AddCountry();
                },
                child: Text("Confirm",style: TextStyle(color: Colors.blue,fontSize: 14.0),),
              )
          ),
        ],
      ) ,
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child:Container(
            margin: EdgeInsets.only(left: 10.0,right: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left:4.0),
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Text("Country"),
                ),

                Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child:TextField(
                      controller: _country,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ],
            )),
      ),
    );
  }

  void AddCountry()
  {
    qu.WorkAddAnswer(widget.identity,widget.bigQuestion,widget.completeQuestion,widget.questionOption, [_country.text], 55.0);
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkMainQuestions(CheckCompleteQuestion : widget.completeQuestion,CheckQuestion : widget.questionOption,CheckAnswer : ["Abroad"]);
    }));
  }
}
