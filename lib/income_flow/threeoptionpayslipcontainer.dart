import 'package:easy_taxx/livingsituation_flow/container2.dart';
import 'package:easy_taxx/screens/questionsInQuestion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_taxx/income_flow//incomemainquestions.dart';
import 'package:easy_taxx/MainAppQuestion/questions.dart';
import 'package:easy_taxx/datamodels/designfile.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'preview_pdf.dart';

class ThreeOptionPaySlipContainer extends StatefulWidget {
  String identity;
  String completeQuestion;
  String questionOption;
  double containerSize;
  String bigQuestion;
  String briefqstn;
  List answerOption = [];
  String PaySlipNo;

  ThreeOptionPaySlipContainer(
      {this.identity,
      this.briefqstn,
      this.bigQuestion,
      this.completeQuestion,
      this.questionOption,
      this.answerOption,
      this.containerSize,
      this.PaySlipNo});

  @override
  _testing3State createState() => _testing3State();
}

class _testing3State extends State<ThreeOptionPaySlipContainer> {
  Questions qu = Questions();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = new TextEditingController();
  var _image;

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    setState(() {
      _image = null;
      _fileName = null;
    });
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
        // _insert(_path.toString());
        print(_path.toString() + "....FILE PATH");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => pdfPreviewer(_path)));
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  Future<void> _photogallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;

      // _insert(_image.toString());
      //print(_image.toString() + "....IMAGE PATH");
    });
  }

  // void _insert(String imagee) async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     DbHelper.columnImage: imagee,
  //   };
  //   final id = await dbHelper.insert(row);
  //   DbHelper.insatance.delete(id);
  //   print('inserted row id: $id');
  // }

  // Future<void> _browsefiles() async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => FilePickerDemo()));
  // }

  _mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Browse Files', _openFileExplorer),
              _createTile(context, 'Photo Gallery', _photogallery),
            ],
          );
        });
  }

  ListTile _createTile(BuildContext context, String name, Function action) {
    return ListTile(
      title: Text(
        name,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
    //print("okxjsdnsmd");
  }

  void timer() {
    Timer(Duration(seconds: 1), () {
      print("Yeah, this line is printed after 3 second");
      setState(() {
        open = true;
//        single=true;
      });
    });
  }

  bool open = false;
  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .008;
    double maxHeight = widget.containerSize;
    //double maxHeight = widget.containerSize;
    //double maxHeight = MediaQuery.of(context).size.height * .62;
    //double maxHeight =360.0;
    return AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: open ? maxHeight : minHeight,
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
//                            alignment: Alignment.lerp(1, 1, 0),
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        decoration: BoxDecoration(
          //color: Colors.grey[200],
          color: Color(0xFFf2f6ff),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: InkWell(
              onTap: () => setState(() => open = !open),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 140,
                    padding: EdgeInsets.only(top: 20),
                    // decoration: BoxDecoration(
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Color(0xFF38B6FF).withOpacity(1),
                    //       spreadRadius: 2,
                    //       blurRadius: 15,
                    //       offset: Offset(0,0), // changes position of shadow
                    //     ),
                    //   ],
                    // ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color(0xFF84868C).withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromARGB(0XFF, 0X38, 0Xb6, 0XFF),
                              ),
                              height: 140.0,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.width * 0.04,
                                top: 7.0,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return questionInQuestion(
                                            widget.completeQuestion,
                                            widget.briefqstn);
                                      }));
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          "images/question_mark.png"),
                                      width: questionMarkWidth,
                                      height: questionMarkHeight,
                                    ))),
                            Positioned(
                                left: MediaQuery.of(context).size.width / 30.0,
                                top: 20.0,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        color: Colors.black,
                                        wordSpacing: 3.0,
                                        height: 1.5),
                                  ),
                                )),
                            Positioned(
                              top: 40.0,
                              left: MediaQuery.of(context).size.width / 30.0,
                              right: MediaQuery.of(context).size.width / 30.0,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    widget.completeQuestion,
                                    style: TextStyle(
                                        fontSize: questionFontSize,
                                        color: Colors.white,
                                        wordSpacing: 3.0,
                                        fontFamily: "HelveticaBold",
                                        fontWeight: FontWeight.bold,
                                        height: 1.5),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 180.0,
                    width: 450.0,
//                                        color: Colors.red,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: widget.answerOption.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    if (widget.answerOption[index] ==
                                        "Upload Document") {
                                      print(
                                          widget.answerOption[index] + "huhuh");
                                      _mainBottomSheet(context);
                                      print(_image.toString() +
                                          " name of path" +
                                          _path);
                                    } else {
                                      print(
                                          widget.answerOption[index] + "huhuh");
                                      qu.IncomeAddAnswer(
                                          widget.identity,
                                          widget.bigQuestion,
                                          widget.completeQuestion,
                                          widget.questionOption,
                                          [widget.answerOption[index]],
                                          55.0);

                                      Navigator.of(context).pop();
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return IncomeMainQuestions(
                                            CheckCompleteQuestion:
                                                widget.completeQuestion,
                                            CheckQuestion:
                                                widget.questionOption,
                                            CheckAnswer: [
                                              widget.answerOption[index]
                                            ]);
                                      }));
                                    }
                                  },
                                  child: Column(children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        widget.answerOption[index],
                                        style: TextStyle(
                                            color: Color(0xFF38B6FF),
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      height: 1.0,
                                    ),
                                  ]));
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
