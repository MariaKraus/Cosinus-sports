import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sportsapp/app_information.dart';
import 'package:sportsapp/get_device_data.dart';
import 'body_information.dart';
import 'calendar.dart';
import 'trainings_plan.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  _setIndex(i) {
    setState(() {
      index = i;
    });
  }

  Future<bool> _willPopCallback() async {
    if (index == 0) {
      return true; // return true if the route to be popped
    } else {
      _setIndex(0);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
              title: Text(widget.title),
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
            ),
          ])),

          // body is the majority of the screen.
          body: HomePageBody()));
}

class HomePageBody extends StatelessWidget {
  final setIndex;

  HomePageBody({Key? key, this.setIndex}) : super(key: key);
  final TrainingsPlan tPlan = TrainingsPlan();

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
            child: SizedBox(child: tPlan, height: 400),
          )
        ])),
      ))));

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      buildTrainingsPlanCard(context, 'LAST TRAINING'),
      ListTile(
          title: const Text("Training"),
          tileColor: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DeviceData()));
          }),
      ListTile(
          title: const Text("Wie trainiere ich effektiv?"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AppInformation()));
          }),
      ListTile(
        title: const Text("Calendar"),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TrainingCalendar()));
        },
      )
    ]);

/*
        floatingActionButton: FloatingActionButton.extended(
            tooltip: 'Add', // used by assistive technologies
            label: Text("Training", style: Theme.of(context).textTheme.button),
            focusColor: Theme.of(context).focusColor,
            backgroundColor: Theme.of(context).focusColor,
            extendedPadding: const EdgeInsets.all(50),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TrainingsMode()));
            })*/

/*
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
            child: SizedBox(child: tPlan, height: 400),
          )
        ])),
      ))));

*/
  }
}
