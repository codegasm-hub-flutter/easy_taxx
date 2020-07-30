import 'package:flutter/material.dart';

class animation extends StatefulWidget {
  @override
  _animationState createState() => _animationState();
}

class _animationState extends State<animation> {

  List<String> litems = ["1","2","Third","4","5","6","7","8","9","10","11","12","13","14","15","1","2","Third","4","5","6","7","8","9","10","11","12","13","14","15",];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
        Container(
          height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(

                itemCount: litems.length,
                itemBuilder: (context, index){
                  return ListTile(leading: Text(litems[index]),);
    }
        ),
      ),
    );
  }
}
