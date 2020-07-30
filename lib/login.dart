import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textThirddFocusNode = new FocusNode();
  FocusNode textFourthFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf2f2f2),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: Icon(Icons.close,color: Color(0xFF38B6FF),),
        //   title: Text("Log in",style: TextStyle(color:Color(0xFF38B6FF),)),
        //   centerTitle: true,
        // ),

        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Text(
                        "Hello 👋 ",
                        style: TextStyle(
                          color: Color(0xFF003350).withOpacity(0.803),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF003350).withOpacity(0.803),
                            // fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                color: Color(0xFF003350).withOpacity(0.803),
                                // fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                        )),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Enter Your Pin',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003350).withOpacity(0.803),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 8.0),
                            //   child: Icon(
                            //     Icons.lock,
                            //     color: Colors.black,
                            //     size: 18,
                            //   ),
                            // ),
                          ],
                        )),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 0.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(4),
                                // border: Border.all(
                                //   color: Color(0xFF003350).withOpacity(0.803),
                                // )
                              ),
                              width: 40.0,
                              child: Center(
                                child: TextFormField(
                                  cursorColor:
                                      Color(0xFF003350).withOpacity(0.803),
                                  keyboardType: TextInputType.number,
                                  onFieldSubmitted: (String value) {
                                    FocusScope.of(context)
                                        .requestFocus(textSecondFocusNode);
                                  },
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFF003350).withOpacity(0.803),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '\u{25CF}',
                                    hintStyle: TextStyle(
                                        color: Color(0xff003350)
                                            .withOpacity(0.803),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                    border: InputBorder.none,
//                    hintStyle: TextStyle(fontSize: )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(4),
                                // border: Border.all(
                                //   color: Color(0xFF003350).withOpacity(0.803),
                                // )
                              ),
                              width: 40.0,
                              child: Center(
                                child: TextFormField(
                                  cursorColor:
                                      Color(0xFF003350).withOpacity(0.803),
                                  keyboardType: TextInputType.number,
                                  onFieldSubmitted: (String value) {
                                    FocusScope.of(context)
                                        .requestFocus(textThirddFocusNode);
                                  },
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  focusNode: textSecondFocusNode,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFF003350).withOpacity(0.803),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '\u{25CF}',
                                    hintStyle: TextStyle(
                                        color:
                                            Color(0xff003350).withOpacity(0.5),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                    border: InputBorder.none,
//                    hintStyle: TextStyle(fontSize: )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(4),
                                // border: Border.all(
                                //   color: Color(0xFF003350).withOpacity(0.803),
                                // )
                              ),
                              width: 40.0,
                              child: Center(
                                child: TextFormField(
                                  cursorColor:
                                      Color(0xFF003350).withOpacity(0.803),
                                  keyboardType: TextInputType.number,
                                  onFieldSubmitted: (String value) {
                                    FocusScope.of(context)
                                        .requestFocus(textFourthFocusNode);
                                  },
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  focusNode: textThirddFocusNode,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFF003350).withOpacity(0.803),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '\u{25CF}',
                                    hintStyle: TextStyle(
                                        color:
                                            Color(0xff003350).withOpacity(0.2),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                    border: InputBorder.none,
//                    hintStyle: TextStyle(fontSize: )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(4),
                                // border: Border.all(
                                //   color: Color(0xFF003350).withOpacity(0.803),
                                // )
                              ),
                              width: 40.0,
                              child: Center(
                                child: TextFormField(
                                  cursorColor:
                                      Color(0xFF003350).withOpacity(0.803),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  focusNode: textFourthFocusNode,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFF003350).withOpacity(0.803),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '\u{25CF}',
                                    hintStyle: TextStyle(
                                        color:
                                            Color(0xff003350).withOpacity(0.1),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                    border: InputBorder.none,
//                    hintStyle: TextStyle(fontSize: )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7.0,
                            ),
                            Text(
                              "Forgot?",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff003350).withOpacity(0.5),
                              ),
                            ),
                            // AutoSizeText(
                            //   'Forgot?',
                            //   style: TextStyle(
                            //       fontSize: 14.0,
                            //       color: Color(0xFF38B6FF),
                            //       fontWeight: FontWeight.bold),
                            // )
                          ],
                        )),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFF38B6FF),
                        borderRadius: BorderRadius.circular(10.0)),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 55.0,
                    child: Center(
                      child: AutoSizeText(
                        'Log in',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
