import 'package:flutter/material.dart';
import 'package:easy_taxx/categoryfinishedscreens/Taxoffice.dart';
import 'package:easy_taxx/categoryfinishedscreens/Carryforward.dart';



class ConfirmIdentity extends StatefulWidget {

  @override
  _ConfirmIdentityState createState() =>  _ConfirmIdentityState();

}

class  _ConfirmIdentityState extends State<ConfirmIdentity> {

  double height;
  double width;
  double body_height;

  final Color lightbluecolor = Color(0xFF38B6FF);
  final Color redcolor = Color(0xFFFF2E00);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    body_height = height* 0.80;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(''),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: lightbluecolor, //change your color here
        ),
      ),
      body: Container(


        color: Colors.white,
        width: width,
        height: body_height ,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 72,
                color: redcolor,
                child:Container(
                  margin: EdgeInsets.only( right: 15.0,left:15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(child:Align(
                        alignment: Alignment.centerLeft,
                        child:Text(
                          'You have not verified your email address yet.',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,


                          ),
                        ),
                      ),),
                      SizedBox(height:12),
                      Align
                        (
                        alignment: Alignment.centerLeft,

                        child:Text(
                          '  Resend email ',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 15.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            color: Colors.black,


                          ),
                        ),
                      ),

                    ],
                  ),
                ),


              ),
              SizedBox(height:32),
              Container(
                color: Colors.grey[200],
                alignment: Alignment.center,



                  child: new Image.asset(
                    'images/files.png',
                    width: 370,
                    height: 240,

                  ),


              ),
              SizedBox(height:12),
              Container(
                margin: EdgeInsets.only(left:15.0,right: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:Text(
                    'Confirm Identity',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: Colors.black,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(left:15.0,right: 15.0),
                child:Align(
                  alignment: Alignment.centerLeft,
                  child:Text(
                    'Please list your primary (not savings) account here. This '
                        'will be used for your refund from the tax office and our'
                        ' one-time filing payment (if applicable).\n\n'
                        ' - Payslip\n'
                        ' - Back of Identity Card\n'
                        ' - Registration certificate\n',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: Colors.black,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
             Expanded(
               child: Align(
                 alignment: Alignment.bottomCenter,
                 child:Text(
                    'Upload Document ',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[400],


),
),
               ),
             ),




            ],

          ),
        ),



      ),
      bottomNavigationBar: BottomAppBar(


        child: Container(
          height: 50,
          // color:Colors.amber,

          margin: EdgeInsets.only(left:30.0,right: 30.0,bottom: 20.0, top: 15.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12.0) ),
            height: 30,
            onPressed: (){
              Navigator.pushReplacementNamed(context, 'allCategoryScreen');
              //print("cilcked");
            },
            child: Text(
              "Confirm",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 15.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: Colors.white,

              ),
            ),
            color: Colors.grey[600] ,
          ),
        ),
        //   ),
      ),

    );
  }
}



