import 'package:flutter/material.dart';
import 'package:easy_taxx/categoryfinishedscreens/Bankdetails.dart';
import 'package:easy_taxx/categoryfinishedscreens/SearchTaxoffice.dart';

class Taxoffice extends StatefulWidget {
  @override
  _TaxofficeState createState() => _TaxofficeState();
}

class _TaxofficeState extends State<Taxoffice> {
  double height;
  double width;
  double body_height;
  final Color lightbluecolor = Color(0xFF38B6FF);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    body_height = height * 0.90;
    return Scaffold(
      backgroundColor: Color(0xFFf2f6ff),
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
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              child: Container(
                color: Color(0xFF38B6FF),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ))),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Your Tax Office  ',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchTaxoffice()));
                          //     },
                          //  child: Icon(
                          //     Icons.info,
                          //     color: Colors.amber,
                          //     size: 24.0,
                          //    // onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchTaxoffice()));},
                          //   )
                          //   ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'The responsible tax office to send your tax declaration to. ',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18.0,
                            color: Colors.white,
                            height: 1.2,
                          ),
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
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Tax Office ',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003350).withOpacity(0.803),
                            ),
                          ),
                        ),

                        // InkWell(
                        //   child:
                        TextField(
                          cursorColor: Colors.grey,
                          style: TextStyle(height: 1.5),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          )),
                        ),
                        // onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchTaxoffice()));},
                        // ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xFFf2f6ff),

        child: Container(
          height: 48,
          // color:Colors.amber,

          margin:
              EdgeInsets.only(left: 30.0, right: 30.0, bottom: 25.0, top: 20.0),
          child: MaterialButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            height: 48,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Bankdetails()));
              print(height);
            },
            child: Text(
              "Confirm",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 16.0,
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
