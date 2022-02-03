import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodyInformation extends StatefulWidget {
  const BodyInformation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BodyInformationState();
}

class BodyInformationState extends State {
  late Map<String, List<dynamic>> _userInformation;
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  late String _sexPressed;

  @override
  initState() {
    super.initState();
    var prefs;
    _userInformation = json.decode(prefs.getString("userInformation") ?? "{}");
    if (_userInformation.isNotEmpty) {
      setState(() {
        _ageController.text = _userInformation[0].toString();
        _weightController.text = _userInformation[1].toString();
        _sexPressed = _userInformation[2].toString();
      });
    } else {
      setState(() {
        _ageController.text = "24";
        _sexPressed = "W";
        _weightController.text = "75";
      });
    }
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newStringMap = {};
    map.forEach((key, value) {
      newStringMap[key.toString()] = map[key];
    });
    return newStringMap;
  }

  Map<String, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<String, dynamic> newDTimeMap = {};
    newDTimeMap["sex"] = map["sex"];

    return newDTimeMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Alter")),
                      SizedBox(
                          width: 100,
                          child: Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: TextField(
                                controller: _ageController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).focusColor),
                                  ),
                                  filled: false,
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered),
                              )))
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Gewicht")),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _weightController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).focusColor),
                              ),
                              filled: false,
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              suffix: const Text("kg")),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Biologisches Geschlecht"),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: (_sexPressed == "W")
                                ? ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.pink))
                                : ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey)),
                            onPressed: () {
                              setState(() {
                                _sexPressed = "W";
                              });
                            },
                            child: const Text("Weiblich"),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: (_sexPressed == "M")
                                ? ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.pink))
                                : ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey)),
                            onPressed: () {
                              setState(() {
                                _sexPressed = "M";
                              });
                            },
                            child: const Text("Männlich"),
                          ))
                    ]),
                  ))
            ],
          ),
        ));
  }
}
