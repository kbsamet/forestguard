import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forestguard/components/info_box.dart';
import 'package:forestguard/models/reading.dart';
import 'package:forestguard/services/reading_services.dart';
import 'package:forestguard/util/consts.dart';

import '../models/reading_display_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ReadingDisplayData> readingData = [];
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initReading();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      initReading();
    });
  }

  Future<void> showFireAlert() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(5),
          actionsPadding: const EdgeInsets.all(5),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          backgroundColor: const Color(0xffAC2737),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(
                Icons.warning_outlined,
                color: Colors.amber,
              ),
              Text(
                'Yangın Alarmı',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.warning_outlined,
                color: Colors.amber,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Yangın riski var!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Saat: ${"${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}"}\n${readingData.map((e) => "${e.readingType}: ${e.readingValue.toStringAsFixed(2)} ${e.readingUnit}").toList().join("\n")}",
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(
                  const Color(0xffAC2737),
                ),
              ),
              child: const Text(
                'Kapat',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void initReading() async {
    Reading reading = await getReadings();

    if (reading.isThreatOfFire && ModalRoute.of(context)?.isCurrent == true) {
      showFireAlert();
    }
    setState(() {
      readingData = [
        ReadingDisplayData(
            readingType: "Sıcaklık",
            readingValue: reading.temperature,
            readingUnit: "°C",
            type: ReadingType.temperature),
        ReadingDisplayData(
            readingType: "Nem",
            readingValue: reading.humidity,
            readingUnit: "%",
            type: ReadingType.humidity),
        ReadingDisplayData(
            readingType: "Duman",
            readingValue: reading.smoke,
            readingUnit: "ppm",
            type: ReadingType.smoke),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: const Text("ForestGuard"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            color: darkGreen,
            child: SingleChildScrollView(
              child: Column(
                  children:
                      readingData.map((e) => InfoBox(readingData: e)).toList()),
            ),
          ))
        ],
      ),
    );
  }
}
