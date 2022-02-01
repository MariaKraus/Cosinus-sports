import 'package:flutter/material.dart';
import 'package:sportsapp/sportsapp_icons.dart';

const List<String> zones = ['gesund', 'fett', 'aerob', 'anaerob', 'gefahr'];
const List<int> durations = [30, 40, 50, 20, 0];
const List<Icon> appIcons = [
  Icon(SportsappIcons.apple_alt, size: 40, color: Colors.pink),
  Icon(SportsappIcons.weight, size: 40, color: Colors.pink),
  Icon(SportsappIcons.running, size: 40, color: Colors.pink),
  Icon(SportsappIcons.muscle_up, size: 40, color: Colors.pink),
  Icon(SportsappIcons.attention, size: 40, color: Colors.pink),
];
const double endNoZone = 50.0;
const double endHealthZone = 60.0;
const double endFatBurningZone = 70.0;
const double endAerobZone = 80.0;
const double endAnaerobZone = 90.0;
