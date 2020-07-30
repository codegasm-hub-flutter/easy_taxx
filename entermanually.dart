import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class payslipentermanualy extends StatefulWidget {
  @override
  _payslipentermanualyState createState() => _payslipentermanualyState();
}

class _payslipentermanualyState extends State<payslipentermanualy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(onTap: () {}, child: Icon(CupertinoIcons.back)),
          title: ListTile(
            trailing: InkWell(onTap: () {}, child: Text("Continue")),
          )),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              headingsection(),
              Text("Steuerklasse:",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                onTap: () {
                  _showBottom();
                },
                decoration: InputDecoration(
                    hintText: "Choose",
                    hintStyle: TextStyle(color: Colors.blue, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("1. Bescheinigungszeitraum",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Add Date(From)",
                    hintStyle: TextStyle(color: Colors.blue, fontSize: 20.0)),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Add Date(Until)",
                    hintStyle: TextStyle(color: Colors.blue, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("3. Bruttoarbeitslohn",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("4. Lohnsteuer",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("5. Solidaritätszuschlag",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("6. Kirchensteuer",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("7. Kirchensteuer Ehegatte",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("10. Ermäßigt besteuerter Arbeitslohn",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("11. Lohnsteuer von 10.",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("12. Solidaritätszuschlag von 10.",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("13. Kirchensteuer Arbeitnehmer von 10.",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("14. Kirchensteuer Ehegatte von 10.",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("15. Kurzarbeitergeld, Zuschuss zum Mutterschaftsgeld…",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("17. Steuerfreie Arbeitgeberleistungen",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("18. Pauschalbesteuerte Arbeitgeberleistungen",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("19. Steuerpflichtige Entschädigungen",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  "20. Steuerfreie Verpflegungszuschüsse bei Auswärtstätigkeit",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  "21. Steuerfreie Arbeitgeberleistung bei doppelter Haushaltsführung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("22. a) Arbeitgeberanteil Gesetzliche Rentenversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  "22. b) Arbeitgeberanteil berufsständische Versorgungseinrichtung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("23. a) Arbeitnehmeranteil Gesetzliche Rentenversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  "23. b) Arbeitnehmeranteil berufsständische Versorgungseinrichtung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  "24. a) Zuschüsse Arbeitgeber Gesetzliche Krankenversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("24. b) Zuschüsse Arbeitgeber Private Krankenversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  "24. c) Zuschüsse Arbeitgeber Gesetzliche Pflegeversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("25. Arbeitnehmerbeitrag gesetzliche Krankenversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("26. Arbeitnehmerbeitrag Pflegeversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("27. Arbeitnehmerbeitrag Arbeitslosenversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("28. Beitrag private Kranken-/Pflege-Pflichtversicherung",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("33. Kindergeld",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "€0.00",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottom() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  title: new Text('Steuerklasse 1 (l)'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  title: new Text('Steuerklasse 2 (ll)'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  title: new Text('Steuerklasse 3 (lll)'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  title: new Text('Steuerklasse 4 (lV)'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  title: new Text('Steuerklasse 5 (V)'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget headingsection() {
    return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Text(
              'Lohnsteuerbescheinigung (Annual Payslip) for 2019',
              textAlign: TextAlign.left,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 16.0, bottom: 26.0),
              child: Text(
                """Lohnsteuerbescheinigung is the annual payslip.\nPlease enter the amount in form below.""",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.1,
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ));
  }
}
