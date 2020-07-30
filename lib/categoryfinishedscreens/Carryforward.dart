import 'package:flutter/material.dart';



//class PersonalData extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//
//        primarySwatch: Colors.blue,
//
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: Persondata (title: 'Flutter Demo Home Page'),
//    );
//  }
//}

class Carryforward extends StatefulWidget {

  @override
  _CarryforwardState createState() =>  _CarryforwardState();

}

class  _CarryforwardState extends State<Carryforward> {

  double height;
  double width;
  double body_height;
  final Color lightbluecolor = Color(0xFF38B6FF);
  List<int> getListItems(){
    List<int> numberlist = List(10);
    numberlist[0] = 5700;
    numberlist[1] = 1200;
    numberlist[2] = 970;
    numberlist[3] = 1840;
    numberlist[4] = 2520;
    numberlist[5] = 5700;
    numberlist[6] = 6200;
    numberlist[7] = 4970;
    numberlist[8] = 6840;
    numberlist[9] = 7520;
    var items = numberlist;
    return items;
  }
  Widget getListView(){
    var listitems = getListItems();
    var listView = ListView.builder(
        itemCount: listitems.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text('Gross Salary'),
            trailing: Text(listitems[index].toString()+'€'),
          );
        }
    );
    return listView;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    body_height = height* 0.90;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(''),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: lightbluecolor, //change your color here
        ),
      ),
      body:SingleChildScrollView(
    child:Column(
        children: <Widget>[

      Container(

        margin: EdgeInsets.only(left:15.0,right: 15.0),
        color: Colors.white,
        width: width,
        height: body_height ,
        child: Container(
          child: Column(
          children: <Widget>[
            SizedBox(height: 4),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'What a loss carryforward is',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,

                ),
              ),
            ),

            SizedBox(height: 8),
            Container(
               color: Colors.white,
                child: new Text(
                  'If your costs exceeded your income, then you’ve made a loss for this tax year.'
                      ' You can carry this loss over into the next year with a loss carryforward.'
                      ' This will reduce next year’s taxable income\n\n. '
                      '*How do i do that?*\n\n'
                      ' In order to make use of this tax bonus, you must send a tax return to the tax office.'
                      ' You can do this directly within the Easyfix app.'
                      ' You will then receive a statement from the tax office acknowledging your loss carryforward.\n\n'
                      ' With your next return, the losses that have been carried forward will be included.'
                      ' This means you will pay less tax. The tax office keeps a record of this amount and accounts for it automatically.',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    height: 1.2,
                    fontSize: 14.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,


                  ),
                ),
              ),

            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Taxes in detail',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,

                ),
              ),
            ),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,

              child:  Text(
                'Your income',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,

                ),
              ),
            ),
            SizedBox(height: 8,),

            Container(
           //   height: 360,
             child:  Expanded(
              child: getListView(),
              ),
            ),












          ],

        ),
        ),



      )])),
      bottomNavigationBar: BottomAppBar(


          child: Container(
            height: 60,
           // color:Colors.amber,

            margin: EdgeInsets.only(left:5.0,right: 5.0,bottom: 3.0, top: 10.0),
            child: new Row(

              children: <Widget>[

                Column(
                  children: <Widget>[
                    Text(
                      "REFUND :",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,

                      ),

                    ),
                    Text(
                      "0,00"+"€",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 27.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),

                    ),
                  ],

                ),


                Spacer(),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12.0) ),
                  height: 50,
                  onPressed: (){
                    //      Navigator.push(context, MaterialPageRoute(builder: (context)=>Persondata()));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Prepare submission",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 15.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,

                    ),
                  ),
                  color: lightbluecolor ,
                ),



              ],
            ),
          ),
     //   ),
      ),

    );
  }
}