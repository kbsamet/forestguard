import 'dart:convert';

import 'package:forestguard/models/historical_reading_data.dart';
import 'package:forestguard/util/api.dart';
import 'package:forestguard/util/consts.dart';
import 'package:http/http.dart';
import 'package:jiffy/jiffy.dart';

import '../models/reading.dart';

const String apiUrl = "";

Future<Reading> getReadings() async {
  Response resp = await sendGetRequest("sensor/findLatestSensorData", null);
  Reading reading = Reading.fromJSON(jsonDecode(resp.body));

  return reading;
}

Future<List<HistoricalReadingData>> getHistoricalReadingData(
    String timeInterval, ReadingType type) async {
  Response resp =
      await sendGetRequest("sensor/findLatestSensorData/$timeInterval", null);
  List<HistoricalReadingData> historicalReadingData = [];
  for (Map<String, dynamic> data in (jsonDecode(resp.body) as List).reversed) {
    String date = "";
    switch (timeInterval) {
      case "1h":
        date = Jiffy(data['createdAt']).Hms;
        break;
      case "1d":
        date = Jiffy(data['createdAt']).Hms;
        break;
      case "1w":
        date = Jiffy(data['createdAt']).format("dd/MM hh:mm");
        break;
      case "1m":
        date = Jiffy(data['createdAt']).format("dd/MM hh:mm");
        break;
      default:
    }

    historicalReadingData.add(HistoricalReadingData(
        date: date,
        value: double.parse(
            data[type.toString().toLowerCase().split('.').last].toString())));
  }
  return historicalReadingData;
}
