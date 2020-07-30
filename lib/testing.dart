import 'package:flutter/material.dart';


class testing extends StatefulWidget {
  @override
  _testingState createState() => _testingState();
}

class _testingState extends State<testing> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .005;
    double maxHeight = MediaQuery.of(context).size.height * .5;
    return Scaffold(

      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[

            Container(
              child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0,),
                      Card(
                        child: ListTile(
                          leading: Text('hello'),
                        ),
                      )
                    ],
              ),
            )
          ],
        )
     )
    );
  }
}
