import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'incomemainquestions.dart';

class pdfPreviewer extends StatefulWidget {
  final String path;

  pdfPreviewer(this.path);

  @override
  _pdfPreviewerState createState() => _pdfPreviewerState();
}

class _pdfPreviewerState extends State<pdfPreviewer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_preview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f6ff),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Container(
              height: 105,
              color: Color(0xFF38B6FF),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 45.0,
                  ),
                  ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 22.0,
                            )
                            //     Image(
                            //   image: AssetImage("images/arrow_forward_ios.png"),
                            //   height: 16,
                            //   width: 9,
                            // ),
                            ),
                      ),
                      title: Center(
                        child: Text(
                          "Selected Document",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // title: Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     GestureDetector(
                      //       // onTap: () {},
                      //       // child: Icon(
                      //       //   Icons.person_outline,
                      //       //   color: Colors.white,
                      //       //   size: 32,
                      //       // ),
                      //       child: Image(image: AssetImage("images/allcategoryuser.png"),width: 18.0,height: 18.0,)
                      //     ),
                      //     SizedBox(width: 5,),

                      //   ],
                      // ),

                      trailing: Image(
                        color: Colors.transparent,
                        image: AssetImage("images/skip.png"),
                        width: 21.0,
                        height: 21.0,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        // color: Colors.blue[400],
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        alignment: Alignment.center,
        child: widget.path.contains("" + "payslip" + "") ||
                widget.path.contains("" + "Payslip" + "") ||
                widget.path.contains("" + "PAYSLIP" + "") ||
                widget.path.contains("" + "PaySlip" + "") ||
                widget.path.contains("" + "PAYslip" + "") ||
                widget.path.contains("" + "paySLIP" + "")
            ? PDFView(filePath: widget.path)
            : Text('this document is not a payslip'),
      ),
    );
  }
}
