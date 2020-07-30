import 'package:flutter/material.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/family_flow/familymainquestions.dart';


class FamilyFullAddress extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  double containerSize;
  String bigQuestion;

  FamilyFullAddress({this.identity,this.bigQuestion,this.completeQuestion,this.questionOption,this.containerSize});
  @override
  _FamilyFullAddressState createState() => _FamilyFullAddressState();
}

class _FamilyFullAddressState extends State<FamilyFullAddress> {

  TextEditingController _city = TextEditingController();
  TextEditingController _country = TextEditingController(text: "Germany");
  Questions qu =Questions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child:Column(
          children: <Widget>[
            SizedBox(
              height: 25.0,
            ),

            ListTile(
              leading: Icon(Icons.arrow_back_ios,color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),),
              trailing: GestureDetector(
                onTap: (){
                  AddData();
                },
                child: Text("Confirm",style: TextStyle(fontSize: 16.0,color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF)),),
              ),
            ),

            SizedBox(
              height: 15.0,
            ),

            ListTile(
                leading: Text("C/O, etc.:")

            ),

            Divider(
              thickness: 1.0,
            ),

            ListTile(
              leading:Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:Text("Street: ")),
              title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),


            ),

            Divider(
              thickness: 1.0,
            ),



            ListTile(
              leading:Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:Text("House no.: ")),
              title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),


            ),

            Divider(
              thickness: 1.0,
            ),





            ListTile(
              leading:Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:Text("Postal code: ")),
              title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),


            ),

            Divider(
              thickness: 1.0,
            ),





            ListTile(
              leading:Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:Text("City: ")),
              title: TextField(
                  controller: _city,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),


            ),

            Divider(
              thickness: 1.0,
            ),


            ListTile(
              leading:Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:Text("Country: ")),
              title: TextField(
                  enabled: false,
                  controller: _country,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey)
              ),


            ),

            Divider(
              thickness: 1.0,
            ),


          ],
        ),
      ),
    );
  }


  void AddData()
  {
    qu.FamilyAddAnswer(widget.identity,widget.bigQuestion,widget.completeQuestion, widget.questionOption, [_city.text+" , "+ _country.text], 55.0);

    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FamilyMainQuestions(CheckCompleteQuestion : widget.completeQuestion,CheckQuestion : widget.questionOption,CheckAnswer : ["ok"]);
    }));
  }
}
