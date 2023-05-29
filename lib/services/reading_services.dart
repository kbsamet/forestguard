import 'dart:convert';

import 'package:forestguard/models/historical_reading_data.dart';
import 'package:forestguard/util/api.dart';
import 'package:forestguard/util/consts.dart';
import 'package:http/http.dart';

import '../models/reading.dart';

const String apiUrl = "";

Future<Reading> getReadings() async {
  Response resp = await sendGetRequest("sensor/findLatestSensorData", null);
  Reading reading = Reading.fromJSON(jsonDecode(resp.body));

  return reading;
}

Future<List<HistoricalReadingData>> getHistoricalReadingData(
    int index, ReadingType type) async {
  Response resp = await sendGetRequest("sensor/findAllSensorData", null);
  List<HistoricalReadingData> historicalReadingData = [];
  for (Map<String, dynamic> data in jsonDecode(resp.body)) {
    historicalReadingData.add(HistoricalReadingData(
        date: data['createdAt'],
        value: double.parse(
            data[type.toString().toLowerCase().split('.').last].toString())));
  }
  int max = index == 0
      ? 60
      : (index == 1
          ? 24
          : index == 2
              ? 7
              : 30);

  return historicalReadingData;
}
