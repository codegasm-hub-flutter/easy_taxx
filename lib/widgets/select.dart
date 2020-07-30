import 'package:direct_select/direct_select.dart';
import 'package:easy_taxx/widgets/my.dart';
import 'package:flutter/material.dart';

class Myselect extends StatefulWidget {
  @override
  _MyselectState createState() => _MyselectState();
}

class _MyselectState extends State<Myselect> {

    final elements1 = [
    "Breakfast",
    "Lunch",
    "2nd Snack",
    "Dinner",
    "3rd Snack",
  ];

   int selectedIndex1 = 0,
      selectedIndex2 = 0,
      selectedIndex3 = 0,
      selectedIndex4 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
               
                DirectSelect(
                
                    itemExtent: 50.0,
                    selectedIndex: selectedIndex1,
                    child: MySelectionItem(
                      isForList: false,
                      title: elements1[selectedIndex1],
                    ),
                    onSelectedItemChanged: (index) {
                      
                      setState(() {
                        selectedIndex1 = index;
                      });
                    },
                    items: _buildItems1()),
               
              ],
          ),
        ),
        ),

      );
  }
}