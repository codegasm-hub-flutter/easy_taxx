import 'package:flutter/material.dart';

import 'package:easy_taxx/livingsituation_flow/mainQuestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';

class UnSupportedScreen extends StatefulWidget {

  String textImage;
  String textTitle;
  String textMessage;
  UnSupportedScreen({this.textImage,this.textTitle,this.textMessage});
  @override
  _UnSupoortedScreenState createState() => _UnSupoortedScreenState();
}

class _UnSupoortedScreenState extends State<UnSupportedScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          child:ListTile(
              leading:GestureDetector(
                  onTap: (){
                    //Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'allCategoryScreen');
                  },
                  child:Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF38B6FF),
                    size: 22.0,

                  )),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image(image: AssetImage("images/allcategoryuser.png"),width: 22.0,height: 22.0,)
                ],
              ),
              trailing: Image(image: AssetImage("images/allcategoryinbox.png"),width: 25.0,height: 25.0,)
          )),
          Container(
            height: 70.0,
            color: Color(0xFF38B6FF),
            padding: EdgeInsets.only(left: 10.0,right:10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
               width: MediaQuery.of(context).size.width*0.6,

              child:Text("You have not verified your email address yet.",style: TextStyle(color: Colors.white),)
                ),
               Text("Resend email",style: TextStyle(color: Colors.black),)
              ],
            ),
          ),

        Padding(
          padding: EdgeInsets.only(left: 10.0,bottom: 23.0,top: 20.0),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tax 2019',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
            )
          ],
        )),

        Divider(
          height: 1,
        ),

          Padding(
              padding: EdgeInsets.only(right: 10.0,top:10.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 30.0,
                      width: 120.0,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.red[100]
                      ),
                    child:Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child:Text('Unsupported',style: TextStyle(fontSize: 15.0,color: Colors.red),textAlign: TextAlign.center,
                  ))
                  )
                ],
              )),
          
          SizedBox(height: 40.0,),
          Image(image: AssetImage(widget.textImage),width: 90.0,height: 90.0,),

          Container(
            height: 50.0,
            padding: EdgeInsets.only(left:50.0,right:50.0,top: 10.0),
            child: Text(widget.textTitle,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),


            Container(
              height: 210.0,
              padding: EdgeInsets.only(left: 15.0,right:15.0,top: 8.0),
              child: Text(widget.textMessage,
              style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),


          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height /14.0,
          child:RaisedButton(
            onPressed: (){
              GoToCategory();
            },

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),

            ),
            color: Color(0xFF38B6FF),
            child: Text("Edit your answers",style: TextStyle(color: Colors.white,fontSize: 15.0),),
          ))

        ],
      ),
    ));
  }

  void GoToCategory()
  {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return mainQuestions(CheckQuestion : Questions.answerShow[Questions.answerShow.length-1]['question'],CheckAnswer : [Questions.answerShow[Questions.answerShow.length-1]['answer'][0]]);
    }));
  }
}
