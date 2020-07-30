import 'package:flutter/material.dart';

class ContactSupport extends StatefulWidget {
  @override
  _contactSupportState createState() => _contactSupportState();
}

class _contactSupportState extends State<ContactSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f6ff),
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
                  padding: const EdgeInsets.all(30.0),
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
                                size: 19,
                              ))),
                      SizedBox(height: 35),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Kontaktiere unser Support-Team',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Bei Fragen kannst du dich per E-Mail an unser Support-Team wenden.',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "Deine Frage an uns",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff003350).withOpacity(0.803),
                      fontWeight: FontWeight.bold,
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
                  height: 146,
                  width: 336,
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 37,
                    width: 167,
                    decoration: BoxDecoration(
                      color: Color(0xff38B6FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        "E-Mail versenden",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Text(
                    "Telefonisch erreichst du unser Support von Montag bis Freitag zwischen 10:00 Uhr und 17:30 Uhr.",
                    style: TextStyle(
                        fontSize: 16,
                        height: 1.2,
                        color: Color(0xff003350).withOpacity(.803)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 37,
                    width: 167,
                    decoration: BoxDecoration(
                      color: Color(0xff38B6FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        "Support anrufen",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
