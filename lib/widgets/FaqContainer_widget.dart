import 'package:flutter/material.dart';

class FaqContainer extends StatelessWidget {
  String heading;
  String textt;

  FaqContainer(this.heading, this.textt);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      width: 336,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading,
              style: TextStyle(
                color: Color(0xff003350).withOpacity(.803),
                fontSize: 18,
                wordSpacing: 1.2,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              textt,
              style: TextStyle(
                color: Color(0xff003350).withOpacity(.803),
                fontSize: 16,
                height: 1.2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
