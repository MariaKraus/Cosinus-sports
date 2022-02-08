import 'package:intl/intl.dart';

Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  Map<String, dynamic> newStringMap = {};
  map.forEach((key, value) {
    newStringMap[key.toString()] = map[key];
  });
  return newStringMap;
}

Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  Map<DateTime, dynamic> newDTimeMap = {};
  map.forEach((key, value) {
    newDTimeMap[DateTime.parse(key)] = map[key];
  });
  return newDTimeMap;
}

transformMilliSeconds(int milliseconds) {
  int hundreds = (milliseconds / 10).truncate();
  int seconds = (hundreds / 100).truncate();
  int minutes = (seconds / 60).truncate();

  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "$minutesStr:$secondsStr";
}

sallyEdwards(age, weight, sex) {
  double base = (sex == "M") ? 214 : 210;
  return base - 0.5 * double.parse(age) - 0.11 * double.parse(weight);
}

getStringDate(DateTime date) {
  DateTime now = DateTime.now();
  return DateFormat('dd.MM.yyyy').format(date);
}
