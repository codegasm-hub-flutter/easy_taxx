import 'package:easy_taxx/datamodels/dbModel.dart';
import 'package:easy_taxx/utils/Db_helper.dart';
import 'package:flutter/material.dart';

class testDb extends StatefulWidget {
  @override
  _testDbState createState() => _testDbState();
}

class _testDbState extends State<testDb> {
  List<Map<String, dynamic>> queryRow;

  List<Map<String, dynamic>> listt = [];
  Future getProjectDetails() async {
    queryRow = await DbHelper.insatance.queryAll();

    return queryRow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getProjectDetails(),
          builder: (context, snapshot) {
            if (getProjectDetails().toString() == null) {
              return Container();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int index) => Text("<" +
                      snapshot.data[index]['question'].toString() +
                      ">" +
                      snapshot.data[index]['answer'].toString() +
                      "</" +
                      snapshot.data[index]['question'].toString() +
                      ">"));
            }
          },
        ),
      ),
    );
  }
}
