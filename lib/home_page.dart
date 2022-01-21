import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'body_information.dart';
import 'trainings_plan.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final TrainingsPlan tPlan = const TrainingsPlan();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(title),
            titleTextStyle: Theme.of(context).textTheme.caption,
            centerTitle: true),
        drawer: Drawer(
            child: ListView(children: <Widget>[
          ListTile(
            title: const Text("Body Information"),
            trailing: const Icon(Icons.arrow_back),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BodyInformation()));
            },
          ),
          ListTile(
            title: const Text("Effective Sport"),
            trailing: const Icon(Icons.arrow_back),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          )
        ])),

        // body is the majority of the screen.
        body: ListView(children: <Widget>[
          buildTrainingsPlanCard(context, 'TRAININGS PLAN'),
          ListTile(
              title: const Text("Effective Sport"),
              trailing: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BodyInformation()));
              }),
        ]),

        floatingActionButton: const FloatingActionButton(
          tooltip: 'Add', // used by assistive technologies
          child: Icon(Icons.add),
          onPressed: null,
        ),
      );

  Widget buildTrainingsPlanCard(BuildContext context, String title) => Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
          child: ExpandableNotifier(
              child: Expandable(
        collapsed: ExpandableButton(
            child: Column(children: <Widget>[
          Center(
              child: Text(title, style: Theme.of(context).textTheme.headline1)),
          Center(
              heightFactor: 5,
              child: LinearPercentIndicator(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                width: 380.0,
                lineHeight: 20.0,
                percent: 0.5,
                backgroundColor: Colors.grey,
                progressColor: Colors.pink,
              ))
        ])),
        expanded: ExpandableButton(
            child: Column(children: <Widget>[
          Center(
              child: Text(title, style: Theme.of(context).textTheme.headline1)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(child: tPlan.build(context), height: 600),
          )
        ])),
      ))));
}
