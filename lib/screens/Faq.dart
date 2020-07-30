import 'package:easy_taxx/datamodels/FaqModel.dart';
import 'package:easy_taxx/widgets/FaqContainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_taxx/datamodels/FaqData.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              child: Container(
                color: Color(0xFF38b6ff),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 19,
                              ))),
                      SizedBox(height: 35),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Fragen zur Übermittlung und Bezahlung',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 22.0,
                            height: 1.2,
                            wordSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: faqq.map((f) {
                return Column(
                  children: <Widget>[
                    FaqContainer(f.heading, f.textt),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  final List<FAQ> faqq = [
    FAQ(
        heading: "Wie viel kostet easyTaxx?",
        textt:
            "Du kannst dir die easyTaxx Steuer-App kostenlos im App-Store herunterladen und dir ohne weitere Kosten ausrechnen lassen, mit welcher Steuererstattung du rechnen kannst. Erst ab einer Steuerrückzahlung von min. 50 Euro oder wenn du zur Abgabe verpflichtet bist, berechnet easyTaxx einmalig 12 Euro."),
    FAQ(
        heading: "Ergebnisse der Steuerberechnung",
        textt:
            "In vielen Fällen kannst du mit einer Rückerstattung zu viel gezahlter steuern rechnen. Dieser Betrag wird dir vom Finanzamt gezahlt, wenn es dir deinen Steuerbescheid schickt. Wenn du nicht zur Abgabe verpflichtet bist, ist die Abgabe deiner Steuererklärung bis zu einer berechneten Steuererstattung von 50 Euro komplett kostenlos."),
    FAQ(
        heading: "Verlustvortrag",
        textt:
            "Übersteigt die Summer deiner Kosten die Summe deiner Einnahmen, hast du in diesem Steuerjahr einen Verlust gemacht. Diesen kannst du mit einem Verlustvortrag in die nächsten Jahre mitnehmen. Dadurch mindert sich das zu versteuernde Einkommen für die zukünftigen Jahre. Die Übermittlung deiner Steuererklärung ist in diesem Fall kostenlos. Solltest du zur Abgabe verpflichtet sein, kostet die Übermittlung an dein Finazamt 12 Euro - unabhängig vom Ergebnis der Steuerberechnung."),
    FAQ(
        heading:
            "Verlustvortrag in Kombination mit Erstattung bzw. Nachzahlung",
        textt:
            "In einigen Fällen kann es vorkommen, dass du einerseits einen Verlustvortrag hast und zusätzlich mit einer Erstattung rechnen kannst oder Steuern zurückzahlen musst. Die App zeigt dir das Ergebnis der Berechnung an und, ob du für die Übermittlung Gebühren zahlen musst."),
    FAQ(
        heading:
            "Verlustvortrag in Kombination mit Erstattung bzw. Nachzahlung",
        textt:
            "In einigen Fällen kann es vorkommen, dass du einerseits einen Verlustvortrag hast und zusätzlich mit einer Erstattung rechnen kannst oder Steuern zurückzahlen musst. Die App zeigt dir das Ergebnis der Berechnung an und, ob du für die Übermittlung Gebühren zahlen musst."),
    FAQ(
        heading:
            "Als Ergebnis der Berechnung kann ich einen Verlustvortrag nutzen. Was bedeutet das?",
        textt:
            "Übersteigt die Summe deine rKosten die Summe deiner Einnahmen, hast du in diesem Steuerjahr einen Verlust gemacht. Diesen kannst du mit einem Verlustvortrag in die nächsten Jahre mitnehmen. Dadurch mindert sich das zu versteuernde Einkommen für die zukünftigen Jahre.\n\n"
            "Um diesen Steuerbonus in Form des Verlustvortrags zu erhalten, musst du deine Steuererklärung an dein Finanzamt übermitteln. Das kannst du mit easyTaxx kostenlos und direkt von dr App aus tun. Nur wenn du zur Abgabe verpflichtet bis, wird eine Gebühr von 12 Euro fällig. Vom Finanzamt erhältst du einen Bescheid über die Feststellung des Verlustvortrags.\n\n"
            "Bei deiner nächsten Steuererklärung, bei der du Steuern zahlen musst, werden die vorgetragenen Verluste steuerlich gegengerechnet. Im Ergebnis zahlst du weniger Steuern. Das Finanzamt merkt sich die Höhe und führt die Verrechnung automatisch durch."),
  ];
}
