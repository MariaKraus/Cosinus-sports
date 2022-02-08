import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as constants;

class AppInformation extends StatelessWidget {
  const AppInformation({Key? key}) : super(key: key);
  static const IconData keyboard_arrow_down_outlined =
      IconData(0xf13d, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Information"),
            titleTextStyle: Theme.of(context).textTheme.caption,
            centerTitle: true),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                          child: Container(
                              child: RichText(
                                  text: TextSpan(
                                      text: "Was bedeutet Trainingspuls?  \n",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      children: <TextSpan>[
                            TextSpan(
                              text:
                                  "Der Trainingspuls beschreibt die Herzfrequenz, die während sportlicher Belastung erreicht wird. Sie wird in Schlägen pro Minute / Beats Per Minute (bpm) angegeben. \n Um das Maximale aus einem Workout schöpfen kann, lohnt es sich, in der richtigen Belastungszone, sprich: im richtigen Bereich der Herzfrequenz, zu trainieren. \n \n Es gibt fünf Belastungszonen, die Sportler gezielt nutzen können:",
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ])))),
                      Card(
                        child: ExpandableNotifier(
                            child: Expandable(
                                collapsed: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[0]),
                                    Text("Gesundheitszone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ])
                                ])),
                                expanded: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[0]),
                                    Text("Gesundheitszone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ]),
                                  SizedBox(
                                      height: 210,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                              child: RichText(
                                                  text: TextSpan(
                                            text:
                                                "Mit einem Trainingspuls in Höhe von 50 bis 60 Prozent der maximalen Pulsfrequenz befinden sich Sportler in der sogenannten Gesundheitszone.\nEin Training in der Gesundheitszone wird insbesondere zur Stabilisierung des Herz-Kreislauf-Systems und zur Rehabilitation eingesetzt. ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          )))))
                                ])))),
                      ),
                      Card(
                        child: ExpandableNotifier(
                            child: Expandable(
                                collapsed: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[1]),
                                    Text("Fettverbrennungszone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ])
                                ])),
                                expanded: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[1]),
                                    Text("Fettverbrennungszone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ]),
                                  SizedBox(
                                      height: 330,
                                      child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              child: RichText(
                                                  text: TextSpan(
                                            text:
                                                "Sobald die Pulsschläge einen Wert von 60 bis 70 Prozent der maximalen Pulsfrequenz erreicht haben, geht der Körper in den Fettverbrennungsmodus über. \nWenn Sie mit dieser Herzfrequenz trainieren, nutzt Ihr Körper vorrangig Fettsäuren für die Bereitstellung der benötigten Energie. Dennoch führt ein Training nicht zu einer rasanten Gewichtsabnahme. Diese ist neben der sportlichen Betätigung, insbesondere von der Ernährung abhängig. ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          )))))
                                ])))),
                      ),
                      Card(
                        child: ExpandableNotifier(
                            child: Expandable(
                                collapsed: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[2]),
                                    Text("Aerobe Zone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ])
                                ])),
                                expanded: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[2]),
                                    Text("Aerobe Zone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ]),
                                  SizedBox(
                                      height: 280,
                                      child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              child: RichText(
                                                  text: TextSpan(
                                            text:
                                                "Mit einer Pulsfrequenz von 70 - 80 Prozent der maximalen Pulsfrequenz tritt der Körper in die aerobe Zone ein.\nEin Training in diesem Frequenzbereich führt zu einer deutlichen Steigerung der Ausdauer. Darüber hinaus wird sowohl das Herz als auch das gesamte Atmungssystem gestärkt. Neben einer Verbesserung der aeroben Kapazität kommt es außerdem auch zu einer deutlichen Belastungssteigerung. ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          )))))
                                ])))),
                      ),
                      Card(
                        child: ExpandableNotifier(
                            child: Expandable(
                                collapsed: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[3]),
                                    Text("Anaerobe Zone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ])
                                ])),
                                expanded: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[3]),
                                    Text("Anaerobe Zone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ]),
                                  SizedBox(
                                      height: 300,
                                      child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              child: RichText(
                                                  text: TextSpan(
                                            text:
                                                "Erreicht der Trainingspuls den Bereich von über 80 Prozent der maximalen Pulsfrequenz, so tritt er in die anaerobe Zone ein.\nDiese wird häufig von Leistungssportlern für das sogenannte Entwicklungstraining genutzt. Es verbessert jedoch den Milchsäureabbau spürbar und verschiebt die anaerobe Schwelle immer weiter nach oben. Dadurch kann künftig eine wesentlich höhere Leistung erbracht werden.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          )))))
                                ])))),
                      ),
                      Card(
                        child: ExpandableNotifier(
                            child: Expandable(
                                collapsed: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[4]),
                                    Text("Warnzone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ])
                                ])),
                                expanded: ExpandableButton(
                                    child: Column(children: <Widget>[
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.all(16),
                                        child: constants.appIcons[4]),
                                    Text("Warnzone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ]),
                                  SizedBox(
                                      height: 330,
                                      child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              child: RichText(
                                                  text: TextSpan(
                                            text:
                                                "Letztlich wird die Herzfrequenzzone ab einer Pulsfrequenz von 90 Prozent oder höher als Warnzone bezeichnet. \nEin Training in diesem Zustand stellt eine maximale Belastung am äußersten Leistungslimit des Menschen dar. Aus diesem Grund ist es lediglich für professionelle Hochleistungssportler geeignet und sollte auch von ihnen mit großer Vorsicht behandelt werden. Selbst wenige Minuten in diesem Zustand werden von erfahrenen Profis als hochgradig anstrengend empfunden. ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          )))))
                                ])))),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Container(
                              child: RichText(
                                  text: TextSpan(
                                      text: "Die Maximale Pulsfrequenz \n",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "Die maximale Pulsfrequenz ist unter anderem vom Alter, dem Gewicht und der Größe einer Person abhängig. Darüber hinaus spielt natürlich auch der aktuelle Trainingsstatus eine große Rolle. Diese App berechnet die maximale Pulsfrequenz mit der Sally - Edwards Formel. Diese berechnet aus Geschlecht, Körpergewicht und Alter einen Näherungswert der maximalen Pulsfrequenz. Bei Menschen mit Vorerkrankung und sehr großen oder kleinen Menschen kann es zu Abweichungen kommen.",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ])))),
                    ])),
          );
        }));
  }
}
