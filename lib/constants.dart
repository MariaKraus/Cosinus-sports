import 'package:flutter/material.dart';
import 'package:sportsapp/sportsapp_icons.dart';

const List<String> zones = ['Gesund', 'Fett', 'Aerob', 'Anaerob', 'Gefahr'];
const List<Icon> appIcons = [
  Icon(SportsappIcons.apple_alt, size: 60, color: Colors.pink),
  Icon(SportsappIcons.weight, size: 60, color: Colors.pink),
  Icon(SportsappIcons.running, size: 60, color: Colors.pink),
  Icon(SportsappIcons.muscle_up, size: 60, color: Colors.pink),
  Icon(SportsappIcons.attention, size: 60, color: Colors.pink),
];
const double endNoZone = 50.0;
const double endHealthZone = 60.0;
const double endFatBurningZone = 70.0;
const double endAerobZone = 80.0;
const double endAnaerobZone = 90.0;
