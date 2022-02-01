import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInformation extends StatelessWidget {
  const AppInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
            child: Text(
      "Was bedeutet Trainingspuls? Der Trainingspuls beschreibt die Herzfrequenz, die während sportlicher Belastung erreicht wird. Sie wird in Schlägen pro Minute / Beats Per Minute (bpm) angegeben. Um das Maximale aus einem Workout schöpfen kann, lohnt es sich, in der richtigen Belastungszone, sprich: im richtigen Bereich der Herzfrequenz, zu trainieren. Es gibt fünf Belastungszonen, die Sportler gezielt nutzen können",
      style: Theme.of(context).textTheme.bodyText1,
    )));
  }
}
