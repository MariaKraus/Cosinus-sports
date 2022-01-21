import 'package:flutter/material.dart';

class TrainingsPlan extends StatelessWidget {
  const TrainingsPlan({Key? key}) : super(key: key);
  final Duration healthZone = const Duration();
  final Duration fatBurningZone = const Duration();
  final Duration aerobeZone = const Duration();
  final Duration anaerobeZone = const Duration();
  final Duration warningZone = const Duration();
  final List<String> labels = const [
    'Gesundheit',
    'Fettverbrennung',
    'aerob',
    'anaerob',
    'Warnzone'
  ];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
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
                      Text(labels[0],
                          style: Theme.of(context).textTheme.headline3),
                      healthZone,
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Heed not the rabble'),
                  color: Colors.pink[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Sound of screams but the'),
                  color: Colors.pink[300],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Who scream'),
                  color: Colors.pink[400],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Revolution is coming...'),
                  color: Colors.pink[500],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Revolution, they...'),
                  color: Colors.pink[600],
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

      /*GridView.count(
          // Create a grid with 2 columns in portrait mode, or 3 columns in
          // landscape mode.
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(5, (index) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  labels[index],
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Center(child: healthZone)
            ]);
          }));*/
    });
  }
}

// Define a custom Form widget.
class Duration extends StatefulWidget {
  const Duration({Key? key}) : super(key: key);

  @override
  _DurationState createState() => _DurationState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _DurationState extends State<Duration> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  final durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          TextField(
              controller: durationController,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.pink[900],
                hintStyle: Theme.of(context).textTheme.bodyText1,
                suffixText: 'Min',
                suffixStyle: Theme.of(context).textTheme.bodyText1,
              )),
        ],
      ),
    );
  }
}
  /*DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Montag',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Dienstag',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Mittwoch',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Donnerstag',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Freitag',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Samstag',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Sonntag',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
            DataCell(Text('Student')),
          ],
        ),
      ],
    );
  }
  */

