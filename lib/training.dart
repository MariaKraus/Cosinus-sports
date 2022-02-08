import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'dart:typed_data';
import 'util.dart';
import 'constants.dart' as constants;

class TrainingsData extends StatefulWidget {
  TrainingsData({Key? key}) : super(key: key);

  late double _maxBpm;
  late final StopWatch timerHealthZone;
  late StopWatch activeSW = StopWatch();
  late final StopWatch timerFatBurningZone;
  late final StopWatch timerAerobeZone;
  late final StopWatch timerAnearobeZone;
  late final StopWatch timerWarningZone;
  late Map<DateTime, List<dynamic>> _trainingsData;
  late SharedPreferences prefs;
  late DateTime now;

  @override
  State<TrainingsData> createState() => _TrainingsDataState();
}

class _TrainingsDataState extends State<TrainingsData> {
  String _connectionStatus = "Disconnected";
  String _heartRate = "- bpm";
  var _device;
  bool _isConnected = false;
  bool earConnectFound = false;

  @override
  void initState() {
    super.initState();
    widget._trainingsData = {};
    widget.now = DateTime.now();
    widget.timerHealthZone = StopWatch();
    widget.timerFatBurningZone = StopWatch();
    widget.timerAerobeZone = StopWatch();
    widget.timerAnearobeZone = StopWatch();
    widget.timerWarningZone = StopWatch();
    initWatches();
  }

  void initWatches() async {
    widget.prefs = await SharedPreferences.getInstance();
    widget._trainingsData = Map<DateTime, List<dynamic>>.from(decodeMap(
        json.decode(widget.prefs.getString("trainingsData") ?? "{}")));
    List? dailyTraining = widget._trainingsData[
        DateTime(widget.now.year, widget.now.month, widget.now.day)];
    if (dailyTraining != null) {
      widget.timerHealthZone.setStartTime(dailyTraining[0]);
      widget.timerFatBurningZone.setStartTime(dailyTraining[1]);
      widget.timerAerobeZone.setStartTime(dailyTraining[2]);
      widget.timerAnearobeZone.setStartTime(dailyTraining[3]);
      widget.timerWarningZone.setStartTime(dailyTraining[4]);
    }
    Map<String, dynamic> _userInformation =
        json.decode(widget.prefs.getString("userInformation") ?? "{}");
    String _age = "";
    String _weight = "";
    String _sex = "";
    if (_userInformation.isNotEmpty) {
      _age = _userInformation["age"].toString();
      _weight = _userInformation["weight"].toString();
      _sex = _userInformation["sex"].toString();
    }
    setState(() {
      _heartRate = "- bpm";
      widget._maxBpm = sallyEdwards(_age, _weight, _sex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    List<int> dailyTraining = <int>[];
    dailyTraining.add(widget.timerHealthZone.elapsedMillis);
    dailyTraining.add(widget.timerFatBurningZone.elapsedMillis);
    dailyTraining.add(widget.timerAerobeZone.elapsedMillis);
    dailyTraining.add(widget.timerAnearobeZone.elapsedMillis);
    dailyTraining.add(widget.timerWarningZone.elapsedMillis);
    List? trainingsData = widget._trainingsData[
        DateTime(widget.now.year, widget.now.month, widget.now.day)];
    if (trainingsData == null) {
      trainingsData = [];
      for (int i = 0; i < 5; i++) {
        trainingsData.add(0);
      }
    }
    trainingsData[0] = dailyTraining[0];
    trainingsData[1] = dailyTraining[1];
    trainingsData[2] = dailyTraining[2];
    trainingsData[3] = dailyTraining[3];
    trainingsData[4] = dailyTraining[4];

    widget.prefs.setString(
        "trainingsData", json.encode(encodeMap(widget._trainingsData)));
    if (_device != null) {
      _device.disconnect();
    }
    FlutterBlue.instance.stopScan();
  }

  Future<void> updateHeartRate(rawData) async {
    Uint8List bytes = Uint8List.fromList(rawData);

    // based on GATT standard
    var bpm = bytes[1];
    if (!((bytes[0] & 0x01) == 0)) {
      bpm = (((bpm >> 8) & 0xFF) | ((bpm << 8) & 0xFF00));
    }

    var bpmLabel = "- bpm";
    if (bpm != 0) {
      bpmLabel = bpm.toString() + " bpm";
    }

    setState(() {
      _heartRate = bpmLabel;
    });

    double percent = bpm / widget._maxBpm * 100;

    if (percent < constants.endNoZone) {
      widget.activeSW.stop();
      //widget.activeSW = Stopwatch();
    } else if (percent < constants.endHealthZone) {
      if (widget.activeSW != widget.timerHealthZone) {
        widget.activeSW.stop();
        widget.activeSW = widget.timerHealthZone;
        widget.activeSW.start();
      }
    } else if (percent < constants.endFatBurningZone) {
      if (widget.activeSW != widget.timerFatBurningZone) {
        widget.activeSW.stop();
        widget.activeSW = widget.timerFatBurningZone;
        widget.activeSW.start();
      }
    } else if (percent < constants.endAerobZone) {
      if (widget.activeSW != widget.timerAerobeZone) {
        widget.activeSW.stop();
        widget.activeSW = widget.timerAerobeZone;
        widget.activeSW.start();
      }
    } else if (percent < constants.endAnaerobZone) {
      if (widget.activeSW != widget.timerAnearobeZone) {
        widget.activeSW.stop();
        widget.activeSW = widget.timerAnearobeZone;
        widget.activeSW.start();
      }
    } else {
      if (widget.activeSW != widget.timerWarningZone) {
        widget.activeSW.stop();
        widget.activeSW = widget.timerWarningZone;
        widget.activeSW.start();
      }
    }
  }

  Future<bool> _bleConnect() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    return flutterBlue.isOn;
  }

  void _connect() {
    FlutterBlue flutterBlue = FlutterBlue.instance;

    // start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) async {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name == "earconnect" && !earConnectFound) {
          earConnectFound =
              true; // avoid multiple connects attempts to same device
          _device = r.device;
          await flutterBlue.stopScan();

          r.device.state.listen((state) {
            // listen for connection state changes
            setState(() {
              _isConnected = state == BluetoothDeviceState.connected;
              _connectionStatus = (_isConnected) ? "Connected" : "Disconnected";
            });
          });

          await r.device.connect();

          var services = await r.device.discoverServices();

          for (var service in services) {
            // iterate over services
            for (var characteristic in service.characteristics) {
              // iterate over characterstics
              switch (characteristic.uuid.toString()) {
                case "0000a001-1212-efde-1523-785feabcd123":
                  print("Starting sampling ...");

                  await characteristic.write([
                    0x32,
                    0x31,
                    0x39,
                    0x32,
                    0x37,
                    0x34,
                    0x31,
                    0x30,
                    0x35,
                    0x39,
                    0x35,
                    0x35,
                    0x30,
                    0x32,
                    0x34,
                    0x35
                  ]);
                  await characteristic.setNotifyValue(true);
                  await Future.delayed(const Duration(seconds: 2));
                  break;

                case "00002a37-0000-1000-8000-00805f9b34fb":
                  characteristic.value
                      .listen((rawData) => updateHeartRate(rawData));
                  await characteristic.setNotifyValue(true);
                  await Future.delayed(const Duration(
                      seconds:
                          2)); // short delay before next bluetooth operation otherwise BLE crashes
                  break;
              }
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SizedBox.expand(
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Scaffold(
                appBar: AppBar(
                    title: Text("Training"),
                    titleTextStyle: Theme.of(context).textTheme.caption,
                    centerTitle: true),
                body: Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (_isConnected)
                              ((Column(children: [
                                Text(_connectionStatus),
                                Text(
                                  _heartRate,
                                  style: TextStyle(
                                    fontSize: 80,
                                    shadows: const <Shadow>[
                                      Shadow(
                                          offset: Offset(0.0, 00.0),
                                          blurRadius: 30.0,
                                          color: Colors.cyanAccent)
                                    ],
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ])))
                            else
                              Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey,
                                        onPrimary: Colors.white,
                                        shadowColor: Colors.black,
                                        elevation: 20,
                                        minimumSize: Size(300, 200),
                                        maximumSize: Size(300, 200),
                                        padding: const EdgeInsets.all(8)),
                                    onPressed: () async {
                                      bool s = await _bleConnect();
                                      if (s) {
                                        _connect();
                                      } else {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Bluetooth'),
                                            content: const Text(
                                                'Aktiviere Bluetooth in den Handy Einstellungen'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: Icon(Icons.bluetooth,
                                        color: Theme.of(context).hintColor,
                                        size: 60),
                                  )),
                          ])),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              //Text(constants.zones[0],
                              //    style: Theme.of(context).textTheme.headline3),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: constants.appIcons[0]),
                              Text(transformMilliSeconds(
                                  widget.timerHealthZone.elapsedMillis)),
                            ],
                          ),
                        )
                            //color: Colors.pink[500],
                            ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              //Text(constants.zones[1],
                              //    style: Theme.of(context).textTheme.headline3),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: constants.appIcons[1]),
                              Text(transformMilliSeconds(
                                  widget.timerFatBurningZone.elapsedMillis)),
                              //widget.timerFatBurningZone,
                            ],
                          ),
                        )
                            //color: Colors.pink[200],
                            ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              //Text(constants.zones[2],
                              //  style: Theme.of(context).textTheme.headline3),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: constants.appIcons[2]),
                              Text(transformMilliSeconds(
                                  widget.timerAerobeZone.elapsedMillis)),
                              //widget.timerAerobeZone,
                            ],
                          ),
                          //color: Colors.pink[300],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              //Text(constants.zones[3],
                              //  style: Theme.of(context).textTheme.headline3),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: constants.appIcons[3]),
                              Text(transformMilliSeconds(
                                  widget.timerAnearobeZone.elapsedMillis)),
                              //widget.timerAnearobeZone,
                            ],
                          ),
                        ),
                      )
                    ],
                  ))
                ]))));
  }
}

class StopWatch extends Stopwatch {
  int _startTimeMilliseconds = 0;

  StopWatch();

  setStartTime(startTime) {
    _startTimeMilliseconds = startTime;
  }

  get elapsedDuration {
    return Duration(
        microseconds: elapsedMicroseconds + (_startTimeMilliseconds * 1000));
  }

  get elapsedMillis {
    return elapsedMilliseconds + _startTimeMilliseconds;
  }
}
