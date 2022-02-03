import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart' as constants;
import 'util.dart';

class TrainingsPlan extends StatefulWidget {
  TrainingsPlan({Key? key}) : super(key: key);
  final Duration healthZone = Duration();
  final Duration fatBurningZone = Duration();
  final Duration aerobeZone = Duration();
  final Duration anaerobeZone = Duration();
  final Duration warningZone = Duration();
  final List<String> labels = constants.zones;
  final List<int> durations = constants.durations;
  final List<Icon> appIcons = constants.appIcons;

  @override
  State<StatefulWidget> createState() => _TrainingsplanState();
}

class _TrainingsplanState extends State<TrainingsPlan> {
  late SharedPreferences prefs;
  late Map<DateTime, List<dynamic>> _trainingsPlan;
  late DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    initTraining();
    //widget.warningZone.initDuration(widget.durations[4]);
  }

  initTraining() async {
    prefs = await SharedPreferences.getInstance();
    _trainingsPlan = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString("trainingsPlan") ?? "{}")));
    List? dailyPlan = _trainingsPlan[DateTime(now.year, now.month, now.day)];
    if (dailyPlan != null) {
      widget.healthZone.initDuration(dailyPlan[0]);
      widget.fatBurningZone.initDuration(dailyPlan[1]);
      widget.aerobeZone.initDuration(dailyPlan[2]);
      widget.anaerobeZone.initDuration(dailyPlan[3]);
    } else {
      widget.healthZone.initDuration(0);
      widget.fatBurningZone.initDuration(0);
      widget.aerobeZone.initDuration(0);
      widget.anaerobeZone.initDuration(0);
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
    if (widget.healthZone.durationController.text != "0" &&
        widget.fatBurningZone.durationController.text != "0" &&
        widget.aerobeZone.durationController.text != "0" &&
        widget.anaerobeZone.durationController.text != "0") {
      List<int> dailyPlan = <int>[];
      dailyPlan.add(int.parse(widget.healthZone.durationController.text));
      dailyPlan.add(int.parse(widget.fatBurningZone.durationController.text));
      dailyPlan.add(int.parse(widget.aerobeZone.durationController.text));
      dailyPlan.add(int.parse(widget.anaerobeZone.durationController.text));
      _trainingsPlan[DateTime(now.year, now.month, now.day)] = dailyPlan;
      prefs.setString("trainingsPlan", json.encode(encodeMap(_trainingsPlan)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Trainingsplan"),
            titleTextStyle: Theme.of(context).textTheme.caption,
            centerTitle: true),
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(widget.labels[0],
                            style: Theme.of(context).textTheme.headline3),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: widget.appIcons[0]),
                        widget.healthZone,
                      ],
                    ),
                    //color: Colors.pink[500],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(widget.labels[1],
                            style: Theme.of(context).textTheme.headline3),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: widget.appIcons[1]),
                        widget.fatBurningZone
                      ],
                    ),
                    //color: Colors.pink[200],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(widget.labels[2],
                            style: Theme.of(context).textTheme.headline3),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: widget.appIcons[2]),
                        widget.aerobeZone
                      ],
                    ),
                    //color: Colors.pink[300],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(widget.labels[3],
                            style: Theme.of(context).textTheme.headline3),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: widget.appIcons[3]),
                        widget.anaerobeZone
                      ],
                    ),
                    //color: Colors.pink[400],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(''),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(''),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

// Define a custom Form widget.
class Duration extends StatefulWidget {
  int duration = 30;
  Duration({Key? key}) : super(key: key);

  var durationController = TextEditingController();

  void initDuration(int duration) {
    durationController.text = duration.toString();
  }

  @override
  _DurationState createState() => _DurationState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _DurationState extends State<Duration> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    widget.durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          TextField(
            controller: widget.durationController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).hintColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).focusColor),
              ),
              filled: false,
              hintStyle: Theme.of(context).textTheme.bodyText1,
              suffixText: 'Min',
              suffixStyle: Theme.of(context).textTheme.bodyText1,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ],
      ),
    );
  }
}
