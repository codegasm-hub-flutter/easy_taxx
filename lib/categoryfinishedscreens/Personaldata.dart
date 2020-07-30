import 'package:easy_taxx/widgets/menuItem.dart';
import 'package:easy_taxx/widgets/select.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/categoryfinishedscreens/Taxoffice.dart';
import 'package:menu_button/menu_button.dart';

class Personaldata extends StatefulWidget {
  @override
  _MyPersonaldataState createState() => _MyPersonaldataState();
}

class _MyPersonaldataState extends State<Personaldata> {
  double height;
  double width;
  double body_height;
  String _valGender;
  static String selectedItem = "M";

  List _listGender = ["Male", "Female"];
  final Color lightbluecolor = Color(0xFF38B6FF);

  Widget button = SizedBox(
    width: 83,
    height: 40,
    child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              selectedItem,
              style: TextStyle(color: Colors.yellow),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ))),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
              color: Color(0xFF38b6ff),
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
                    SizedBox(height: 35),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Personal Data',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'We need to collect some more personal data from you ',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 17.0,
                          height: 1.3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Column(children: <Widget>[
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              color: Color(0xFFf2f6ff),
              width: width,
              height: body_height,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'First Name ',
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
                    TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(height: 1.5),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      )),
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Last Name ',
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
                    TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(height: 1.5),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      )),
                    ),
                    SizedBox(height: 12),
                    Container(
                      margin: EdgeInsets.only(right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Date of Birth ',
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
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                'Gender ',
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
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            cursorColor: Colors.black,
                            style: TextStyle(height: 1.5),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            )),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding:
                              EdgeInsets.only(left: 2.0, right: 2.0, top: 10.0),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: NormalMenuButton(
                                theme: theme,
                              ),
                              // child:SizedBox(
                              //   child: Myselect(),
                              //   height: 100,width: 100,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'STEUERIDENTIFIKATIONSNUMMER',
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
                    TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(height: 1.5),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      )),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ],
      )),
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
                  MaterialPageRoute(builder: (context) => Taxoffice()));
              print("cilcked");
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
