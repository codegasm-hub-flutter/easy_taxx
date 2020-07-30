import 'package:flutter/material.dart';
import 'package:easy_taxx/categoryfinishedscreens/ConfirmIdentity.dart';
import 'package:easy_taxx/categoryfinishedscreens/Taxoffice.dart';

class Bankdetails extends StatefulWidget {
  @override
  _BankdetailState createState() => _BankdetailState();
}

class _BankdetailState extends State<Bankdetails> {
  double height;
  double width;
  double body_height;
  String _valGender;
  List _listGender = ["Male", "Female"];
  final Color lightbluecolor = Color(0xFF38B6FF);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    body_height = height * 0.90;
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(''),
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData(
      //     color: lightbluecolor, //change your color here
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFf2f6ff),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                child: Container(
                  color: Color(0xFF38b6ff),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bank details',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please list your primary (not savings) account here. This '
                            'will be used for your refund from the tax office and our'
                            ' one-time filing payment (if applicable).',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 18.5,
                                color: Colors.white,
                                height: 1.2),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                color: Color(0xFFf2f6ff),
                width: width,
                height: body_height,
                child: Container(
                  color: Color(0xFFf2f6ff),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'ACCOUNT HOLDER ',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14.0,
                            fontFamily: 'Helvetica-Bold',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003350).withOpacity(0.803),
                          ),
                        ),
                      ),
                      TextField(
                        style: TextStyle(height: 1.0),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        )),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'IBAN ',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14.0,
                            fontFamily: 'Helvetica-Bold',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003350).withOpacity(0.803),
                          ),
                        ),
                      ),
                      TextField(
                        style: TextStyle(height: 1.0),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        )),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xFFf2f6ff),

        child: Container(
          height: 48,
          // color:Colors.amber,

          margin:
              EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0, top: 25.0),
          child: MaterialButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            height: 48,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ConfirmIdentity()));
              print("cilcked");
            },
            child: Text(
              "Confirm",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 16.0,
                fontFamily: 'Helvetica-Bold',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            color: lightbluecolor,
          ),
        ),
        //   ),
      ),
    );
  }
}
