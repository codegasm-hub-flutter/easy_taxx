import 'package:flutter/material.dart';

//void main() => runApp(SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatefulWidget {
  @override
  _SnackBarPageState createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
bool open = false;

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .1;
    double maxHeight = MediaQuery.of(context).size.height * .5;
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            backgroundColor: Color(0xFF38B6FF),
            content: AnimatedContainer(

              duration: Duration(milliseconds: 200),
              height: open ? maxHeight : minHeight,
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
//                      color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(child: Column(
              children: <Widget>[
                Column(
                    children: <Widget>[
                      SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => setState(() => open = !open),
                        child: Container(
                          width: 385,
                          height: 100,
//                            constraints: BoxConstraints(maxWidth: 400, maxHeight: 150),
                          decoration: BoxDecoration(
                            color: Color(0xFF38B6FF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),

                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Text('What is your official marital status in Germany?',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                      ),
//                        SingleChildScrollView(
//                          child:
//
//                          Column(children: <Widget>[
//
//                            Container(
////                            height:
//                              child: Column(
//                                children: <Widget>[
//                                  ListTile(
//                                    leading: Text('hello'),
//                                  ),
////                                  Text('hello'),
////                                  Text('hello'),
////                                  Text('hello'),
//                                ],
//                              )
//                            ),
//                          ],)
//
//                        )

                    ],
                  ),


            ]),),),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}