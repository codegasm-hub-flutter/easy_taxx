import 'package:flutter/material.dart';




class SearchTaxoffice extends StatefulWidget {

  @override
  _SearchTaxofficeState createState() =>  _SearchTaxofficeState();

}

class  _SearchTaxofficeState extends State<SearchTaxoffice> {

  double height;
  double width;
  double body_height;
  final Color lightbluecolor = Color(0xFF38B6FF);


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    body_height = height* 0.90;
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Tax Office',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            color: Colors.black,

          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: lightbluecolor, //change your color here
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        width: width,
        height: body_height ,
        child: Container(
          margin: EdgeInsets.only(left:15.0,right: 15.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              TextField(
                cursorColor: Colors.amber,

                style: TextStyle(height: 1.0),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                    filled: true,
                  border: const  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  hintText: " Search here ",
                  contentPadding: EdgeInsets.all(1),
                ),

              ),
              SizedBox(height: 12),

            ],

          ),
        ),



      ),


    );
  }
}