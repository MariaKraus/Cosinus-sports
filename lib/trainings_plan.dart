import 'package:flutter/material.dart';
import 'constants.dart' as constants;

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
  @override
  void initState() {
    super.initState();
    widget.healthZone.initDuration(widget.durations[0]);
    widget.fatBurningZone.initDuration(widget.durations[1]);
    widget.aerobeZone.initDuration(widget.durations[2]);
    widget.anaerobeZone.initDuration(widget.durations[3]);
    //widget.warningZone.initDuration(widget.durations[4]);
  }
  /*
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
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

/*
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    widget.durationController.dispose();
    super.dispose();
  }
*/
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
              )),
        ],
      ),
    );
  }
}
