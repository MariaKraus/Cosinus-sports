import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart' as constants;
import 'util.dart';

class TrainingsPlan extends StatefulWidget {
  TrainingsPlan({Key? key, required this.date}) : super(key: key);
  final Duration healthZone = Duration();
  final Duration fatBurningZone = Duration();
  final Duration aerobeZone = Duration();
  final Duration anaerobeZone = Duration();
  final Duration warningZone = Duration();
  final List<String> labels = constants.zones;
  final List<Icon> appIcons = constants.appIcons;
  DateTime date;

  void setDate() {}

  @override
  State<StatefulWidget> createState() => _TrainingsplanState();
}

class _TrainingsplanState extends State<TrainingsPlan> {
  late SharedPreferences prefs;
  late Map<DateTime, List<dynamic>> _trainingsPlan;

  @override
  void initState() {
    super.initState();
    initTraining();
  }

  initTraining() async {
    prefs = await SharedPreferences.getInstance();
    _trainingsPlan = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString("trainingsData") ?? "{}")));
    List? dailyPlan = _trainingsPlan[
        DateTime(widget.date.year, widget.date.month, widget.date.day)];
    if (dailyPlan != null && dailyPlan.length == 9) {
      widget.healthZone.initDuration(dailyPlan[5]);
      widget.fatBurningZone.initDuration(dailyPlan[6]);
      widget.aerobeZone.initDuration(dailyPlan[7]);
      widget.anaerobeZone.initDuration(dailyPlan[8]);
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
  }

  void save() {
    if (widget.healthZone.durationController.text != "0" ||
        widget.fatBurningZone.durationController.text != "0" ||
        widget.aerobeZone.durationController.text != "0" ||
        widget.anaerobeZone.durationController.text != "0") {
      List<int> dailyPlan = <int>[];
      dailyPlan.add(int.parse(widget.healthZone.durationController.text));
      dailyPlan.add(int.parse(widget.fatBurningZone.durationController.text));
      dailyPlan.add(int.parse(widget.aerobeZone.durationController.text));
      dailyPlan.add(int.parse(widget.anaerobeZone.durationController.text));
      List? trainingsData = _trainingsPlan[
          DateTime(widget.date.year, widget.date.month, widget.date.day)];
      if (trainingsData == null) {
        trainingsData = [];
        for (int i = 0; i < 9; i++) {
          trainingsData.add(0);
        }
      }
      trainingsData[5] = dailyPlan[0];
      trainingsData[6] = dailyPlan[1];
      trainingsData[7] = dailyPlan[2];
      trainingsData[8] = dailyPlan[3];
      _trainingsPlan[
              DateTime(widget.date.year, widget.date.month, widget.date.day)] =
          trainingsData;
      //dailyPlan;
      prefs.setString("trainingsData", json.encode(encodeMap(_trainingsPlan)));
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
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: widget.appIcons[0]),
                      Text(widget.labels[0],
                          style: Theme.of(context).textTheme.headline3),
                      widget.healthZone,
                    ],
                  ),
                  //color: Colors.pink[500],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: widget.appIcons[1]),
                      Text(widget.labels[1],
                          style: Theme.of(context).textTheme.headline3),
                      widget.fatBurningZone
                    ],
                  ),
                  //color: Colors.pink[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: widget.appIcons[2]),
                      Text(widget.labels[2],
                          style: Theme.of(context).textTheme.headline3),
                      widget.aerobeZone
                    ],
                  ),
                  //color: Colors.pink[300],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: widget.appIcons[3]),
                      Text(widget.labels[3],
                          style: Theme.of(context).textTheme.headline3),
                      widget.anaerobeZone
                    ],
                  ),
                  //color: Colors.pink[400],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text(''),
                ),
                FloatingActionButton(
                    child: Text(
                      "Speichern",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    backgroundColor: Theme.of(context).backgroundColor,
                    hoverColor: Colors.black,
                    hoverElevation: 100,
                    onPressed: () {
                      save();
                    })
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.height / 8),
          child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                DateFormat('dd.MM.yyyy').format(widget.date),
                style: Theme.of(context).textTheme.headline6,
              ))),
    );
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
              suffixStyle: Theme.of(context).textTheme.bodyText2,
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
/* Container(
                padding: EdgeInsets.all(16),
                child: Text(DateFormat('dd.MM.yyyy').format(DateTime.now()), style: Theme.of(context).textTheme.bodyText1,)),*/