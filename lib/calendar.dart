import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';
import 'util.dart';
import 'constants.dart' as constants;

class TrainingCalendar extends StatefulWidget {
  const TrainingCalendar({Key? key}) : super(key: key);

  @override
  _TrainingCalendarState createState() => _TrainingCalendarState();
}

class _TrainingCalendarState extends State<TrainingCalendar> {
  late CalendarController _controller;
  late Map<DateTime, List<dynamic>> _trainingsEvents;
  late Map<DateTime, List<dynamic>> _trainingsPlan;
  late List? _selectedEvents;
  late TextEditingController _eventController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _trainingsEvents = {};
    _trainingsPlan = {};
    _selectedEvents = [];
    initTrainingEvents();
  }

  void initTrainingEvents() async {
    prefs = await SharedPreferences.getInstance();
    _trainingsEvents = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString("trainingsData") ?? "{}")));
    _trainingsPlan = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString("trainingsPlan") ?? "{}")));
    DateTime now = DateTime.now();
    setState(() {
      List<dynamic>? plan =
          _trainingsPlan[DateTime(now.year, now.month, now.day)];
      List<dynamic>? events =
          _trainingsEvents[DateTime(now.year, now.month, now.day)];
      if (plan != null) {
        if (events == null) {
          events = {} as List?;
          for (int i = 0; i < 5; i++) {
            events?.add(0);
          }
        }
        events?.addAll(plan);
      }
      _selectedEvents = events;

      //_selectedEvents?.addAll(plan!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Kalender"),
          titleTextStyle: Theme.of(context).textTheme.caption,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _trainingsEvents,
              initialCalendarFormat: CalendarFormat.week,
              initialSelectedDay: DateTime.now(),
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  selectedColor: Colors.green, //Theme.of(context).hintColor,
                  markersColor: Theme.of(context).primaryColor,
                  todayStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white),
                  weekendStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.pink)),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.grey[400])),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: const TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events, holidays) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                    )),
              ),
              calendarController: _controller,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          if (_selectedEvents!.isNotEmpty)
                            Container(
                                padding: const EdgeInsets.all(8),
                                child: constants.appIcons[0]),
                          if (_selectedEvents!.isNotEmpty)
                            Text(transformMilliSeconds(_selectedEvents![0])),
                          if (_selectedEvents!.length > 5)
                            Text("/  " +
                                transformMilliSeconds(
                                    (_selectedEvents![5] * 60000))),
                          //color: Colors.pink[500],
                        ])),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          if (_selectedEvents!.isNotEmpty)
                            Container(
                                padding: const EdgeInsets.all(8),
                                child: constants.appIcons[1]),
                          if (_selectedEvents!.isNotEmpty)
                            Text(transformMilliSeconds(_selectedEvents![1])),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          if (_selectedEvents!.isNotEmpty)
                            Container(
                                padding: const EdgeInsets.all(8),
                                child: constants.appIcons[2]),
                          if (_selectedEvents!.isNotEmpty)
                            Text(transformMilliSeconds(_selectedEvents![2])),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          if (_selectedEvents!.isNotEmpty)
                            Container(
                                padding: const EdgeInsets.all(8),
                                child: constants.appIcons[3]),
                          if (_selectedEvents!.isNotEmpty)
                            Text(transformMilliSeconds(_selectedEvents![3])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
