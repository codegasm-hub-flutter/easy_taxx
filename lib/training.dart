import 'package:easy_taxx/show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:responsive_container/responsive_container.dart';
//void main() => runApp(MaterialApp(home:HomeScreen()));

class training extends StatefulWidget {

  String text;
  String text2;
  String text3;

  training({Key key, @required this.text, this.text2,this.text3}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<training> {
  bool open = false;
  bool v3 = false;
  Widget circleButton(IconData iconData){
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, size: 30,),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }


  void timer()
  {
    Timer(Duration(seconds: 1), () {
      print("Yeah, this line is printed after 3 second");
      setState(() {
        open=true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .004;
    double maxHeight = MediaQuery.of(context).size.height * .55;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back,color: Color(0xFF38B6FF),size: 18.0,),
        title: Text('Living Situation',style: TextStyle(color: Colors.black,fontSize: 14.0),),
        centerTitle: true,
      ),
      body:  Stack(
        children: <Widget>[

          Positioned(
            bottom: 0,
            child:
            Container(
//            color: Colors.yellow,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
//
                  Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10,right: 10.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, 'SingleScreen');
                          },
                          child: Container(
                            height: 55.0,
                            width: 450.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(width: 1.0,color: Color(0xFF38B6FF))
                            ),
                            child:  Padding(
                                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Marital Status'),
                                    Row(children: <Widget>[
                                      Text('${widget.text2}',style: TextStyle(color: Color(0xFF38B6FF))),
                                      SizedBox(width: 10.0,),
                                      Icon(Icons.arrow_forward_ios,size: 12.0,color: Color(0xFF38B6FF),)
                                    ],)
                                  ],)
                            ),
                          ))

                  ),

                  Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10,right: 10.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, 'SingleScreen');
                          },
                          child: Container(
                            height: 130.0,
                            width: 450.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(width: 1.0,color: Color(0xFF38B6FF))
                            ),
                            child:  Padding(
                                padding: EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Personal Details'),
                                    SizedBox(height: 5.0,),
                                    Divider(thickness: 1.0,
                                      indent: 0.0,),
                                    SizedBox(height: 5.0,),
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Occupation'),
                                        Row(children: <Widget>[
                                          Text('${widget.text}',style: TextStyle(color: Color(0xFF38B6FF))),
                                          SizedBox(width: 10.0,),
                                          Icon(Icons.arrow_forward_ios,size: 12.0,color: Color(0xFF38B6FF),)
                                        ],)
                                      ],),


                                    SizedBox(height: 5.0,),
                                    Divider(thickness: 1.0,
                                      indent: 40.0,),
                                    SizedBox(height: 5.0,),
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Training'),
                                        Row(children: <Widget>[
                                          Text('${widget.text3}',style: TextStyle(color: Color(0xFF38B6FF))),
                                          SizedBox(width: 10.0,),
                                          Icon(Icons.arrow_forward_ios,size: 12.0,color: Color(0xFF38B6FF),)
                                        ],)
                                      ],),
                                  ],)),
                          ))

                  ),
                  SizedBox(height: 0),




                  AnimatedContainer(

                      duration: Duration(milliseconds: 400),
                      height: open ? maxHeight : minHeight,
                      width: MediaQuery.of(context).size.width,
//                    constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child:
                      SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child:
                          InkWell(
//                            onTap: () => setState(() => open = !open),
                            child:
                            Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFF38B6FF),
                                  ),
                                  height: 130.0,
                                  width: 450.0,

                                  child: Padding(padding: EdgeInsets.only(left: 20.0,top: 90.0),
                                    child: Text('Did you have any other income sources in 2019?',style: TextStyle(fontSize:20.0,color: Colors.white),),),

                                ),
                                SizedBox(height: 10.0,),
                                Container(
                                  height: 320.0,
                                  width: 450.0,
//                                        color: Colors.red,
                                  child: ListView(
                                    children: <Widget>[

                                      Divider(thickness: 1.0,height: 1.0,),
                                      GestureDetector(
//                                        onTap: (){
//                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                            return employeed(text: 'Employed',text2:'${widget.text}');
//                                          }));                        },
                                        child:
                                        Container(
                                          width: 400.0,
//                                        color: Color(0xFF38B6FF),
                                          child: Row(
                                            children: <Widget>[
                                              Checkbox(
                                                value: v3,
                                                onChanged: (bool value) {
                                                  print(value);

                                                  setState(() {
                                                    v3 = value;
                                                  });
                                                },
                                              ),
                                              Icon(Icons.timer),
                                              SizedBox(width: 10.0,),
                                              Text('Letting & Leasing')
                                            ],
                                          ),
                                        ),),
                                      Divider(thickness: 1.0,height: 1.0,),
                                      GestureDetector(
//                                        onTap: (){
//                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                            return employeed(text: 'Minijob (e.g.4.50 basis)',text2:'${widget.text}');
//                                          }));                        },
                                        child:Container(
                                          child: Row(
                                            children: <Widget>[
                                              Checkbox(
                                                value: v3,
                                                onChanged: (bool value) {
                                                  print(value);

                                                  setState(() {
                                                    v3 = value;
                                                  });
                                                },
                                              ),
                                              Icon(Icons.timer),
                                              SizedBox(width: 10.0,),
                                              Text('Sale of property')
                                            ],
                                          ),
                                        ),),
                                      Divider(thickness: 1.0,height: 1.0,),
                                      GestureDetector(
//                                        onTap: (){
//                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                            return employeed(text: 'Studying',text2:'${widget.text}');
//                                          }));                        },
                                        child:Container(
                                          child: Row(
                                            children: <Widget>[
                                              Checkbox(
                                                value: v3,
                                                onChanged: (bool value) {
                                                  print(value);

                                                  setState(() {
                                                    v3 = value;
                                                  });
                                                },
                                              ),
                                              Icon(Icons.timer),
                                              SizedBox(width: 10.0,),
                                              Text('Capital gains')
                                            ],
                                          ),
                                        ),),
                                      Divider(thickness: 1.0,height: 1.0,),
                                      GestureDetector(
//                                        onTap: (){
//                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                            return employeed(text: 'Training',text2:'${widget.text}');
//                                          }));                        },
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Checkbox(
                                                value: v3,
                                                onChanged: (bool value) {
                                                  print(value);

                                                  setState(() {
                                                    v3 = value;
                                                  });
                                                },
                                              ),
                                              Icon(Icons.timer),
                                              SizedBox(width: 10.0,),
                                              Text('Pensions')
                                            ],
                                          ),
                                        ),),
                                      Divider(thickness: 1.0,height: 1.0,),
                                      

                                    ],
                                  ),
                                ),
                              ],
                            ),

                          )))
                ],
              ),
            ),
          ),
        ],
      ),
    );


  }
  void showDefaultSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Hello from the default snackbar'),
        action: SnackBarAction(
          label: 'Click Me',
          onPressed: () {},
        ),
      ),
    );
  }
}