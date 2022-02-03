import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyInformation extends StatefulWidget {
  const BodyInformation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BodyInformationState();
}

class BodyInformationState extends State {
  late Map<String, dynamic> _userInformation;
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  late String _sexPressed = "";
  late SharedPreferences prefs;

  @override
  initState() {
    super.initState();
    initContoller();
  }

  void initContoller() async {
    prefs = await SharedPreferences.getInstance();
    _userInformation = json.decode(prefs.getString("userInformation") ?? "{}");
    if (_userInformation.isNotEmpty) {
      setState(() {
        _ageController.text = _userInformation["age"].toString();
        _weightController.text = _userInformation["weight"].toString();
        _sexPressed = _userInformation["sex"].toString();
      });
    } else {
      setState(() {
        _ageController.text = "30";
        _sexPressed = "M";
        _weightController.text = "75";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    Map<String, dynamic> stringMap = {};
    stringMap["age"] = _ageController.text;
    stringMap["weight"] = _weightController.text;
    stringMap["sex"] = _sexPressed;
    prefs.setString("userInformation", json.encode(stringMap));
    _ageController.dispose();
    _weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Profil"),
            titleTextStyle: Theme.of(context).textTheme.caption,
            centerTitle: true),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Alter")),
                      SizedBox(
                          width: 230,
                          child: Padding(
                              padding: EdgeInsets.only(left: 100),
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
                        width: 200,
                        child: Padding(
                          padding: EdgeInsets.only(left: 69),
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
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                suffix: const Text("kg")),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Biologisches Geschlecht")),
                      ]))),
              Column(children: [
                Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Padding(
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
                        ))),
                Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Padding(
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
                        )))
              ])
            ])));
  }
}
