import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestguard/models/historical_reading_data.dart';
import 'package:forestguard/models/reading_display_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../services/reading_services.dart';
import '../util/consts.dart';

class InfoBoxDetailScreen extends StatefulWidget {
  final ReadingDisplayData readingData;
  const InfoBoxDetailScreen({super.key, required this.readingData});

  @override
  State<InfoBoxDetailScreen> createState() => _InfoBoxDetailScreenState();
}

class _InfoBoxDetailScreenState extends State<InfoBoxDetailScreen> {
  List<HistoricalReadingData> historicalReadingData = [];
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHistoricalReadingData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void initHistoricalReadingData() async {
    List<HistoricalReadingData> historicalReadingData =
        await getHistoricalReadingData(selectedIndex, widget.readingData.type);
    setState(() {
      this.historicalReadingData = historicalReadingData;
    });
  }

  void updateData(int index) {
    if (index == selectedIndex) return;
    setState(() {
      selectedIndex = index;
    });
    initHistoricalReadingData();
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
            color: darkGreen,
            child: Column(
              children: [
                SingleChildScrollView(
                    child: SfCartesianChart(
                        plotAreaBackgroundColor: Colors.white,
                        enableAxisAnimation: true,
                        title: ChartTitle(
                            text:
                                "${widget.readingData.readingType} Geçmiş verileri",
                            textStyle: const TextStyle(color: Colors.white)),
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        series: <LineSeries<HistoricalReadingData, String>>[
                      LineSeries<HistoricalReadingData, String>(
                          // Bind data source
                          color: lightGreen,
                          animationDuration: 1000,
                          dataSource: historicalReadingData,
                          xValueMapper: (HistoricalReadingData sales, _) =>
                              sales.date,
                          yValueMapper: (HistoricalReadingData sales, _) =>
                              sales.value),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                    value: selectedIndex,
                    focusColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                    selectedItemBuilder: (BuildContext context) =>
                        ["Son 1 saat", "Son 24 saat", "Son 1 hafta", "Son 1 ay"]
                            .map((e) => Center(
                                    child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.white),
                                )))
                            .toList(),
                    items: const [
                      DropdownMenuItem(value: 0, child: Text("Son 1 saat")),
                      DropdownMenuItem(value: 1, child: Text("Son 24 saat")),
                      DropdownMenuItem(value: 2, child: Text("Son 1 hafta")),
                      DropdownMenuItem(value: 3, child: Text("Son 1 ay")),
                    ],
                    onChanged: (e) => updateData(e!))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
