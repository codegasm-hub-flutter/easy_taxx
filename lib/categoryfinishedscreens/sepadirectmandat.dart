import 'package:flutter/material.dart';

class sepaMandat extends StatefulWidget {
  @override
  _sepaMandatState createState() => _sepaMandatState();
}

class _sepaMandatState extends State<sepaMandat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f6ff),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
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
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                                'SPEA Direct Debit Mandat',
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
                                'Please select an account for your payment.'
                                ' If you select a new account, it must be a'
                                ' primary (not saving) account.',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 17.5,
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
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage("images/checked.png"),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Use refund account",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003350).withOpacity(0.803),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 55,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Elia Gilio",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF003350).withOpacity(0.803),
                            ),
                          ),
                          Text(
                            "DE4150010517012345789",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF003350).withOpacity(0.803),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage("images/unchecked.png"),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Enter new account",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA9AEB9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "Creditor",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003350).withOpacity(0.803),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "easyTaxx UG (haftungsbeschrankt)",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFFA9AEB9),
                          ),
                        ),
                        Text(
                          "Reimerstwiete 18",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFFA9AEB9),
                          ),
                        ),
                        Text(
                          "20457 Hamburg",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFFA9AEB9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFFA9AEB9),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "I authorize easyTaxx UG (haftungsbeschrankt)\n"),
                            TextSpan(text: "for a "),
                            TextSpan(
                                text: "SEPA direct debit mandate ",
                                style: TextStyle(color: Color(0xFF38B6FF))),
                            TextSpan(text: "with the bank\n"),
                            TextSpan(text: "details above."),
                          ]),
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
              EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0, top: 25.0),
          child: MaterialButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            height: 48,
            onPressed: () {},
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
            color: Color(0xFF38B6FF),
          ),
        ),
        //   ),
      ),
    );
  }
}
