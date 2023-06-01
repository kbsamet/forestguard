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
  String selectedIndex = "1h";

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

  void updateData(String index) {
    if (index == selectedIndex) return;
    setState(() {
      selectedIndex = index;
    });
    initHistoricalReadingData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreen,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkGreen,
            elevation: 0,
            title: const Text("ForestGuard"),
          ),
          body: Container(
            color: darkGreen,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: darkGreen,
                    child: Column(
                      children: [
                        DropdownButton(
                            value: selectedIndex,
                            focusColor: Colors.white,
                            style: const TextStyle(color: Colors.black),
                            selectedItemBuilder: (BuildContext context) => [
                                  "Son 1 saat",
                                  "Son 24 saat",
                                  "Son 1 hafta",
                                  "Son 1 ay"
                                ]
                                    .map((e) => Center(
                                            child: Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )))
                                    .toList(),
                            items: const [
                              DropdownMenuItem(
                                  value: "1h", child: Text("Son 1 saat")),
                              DropdownMenuItem(
                                  value: "1d", child: Text("Son 24 saat")),
                              DropdownMenuItem(
                                  value: "1w", child: Text("Son 1 hafta")),
                              DropdownMenuItem(
                                  value: "1m", child: Text("Son 1 ay")),
                            ],
                            onChanged: (e) => updateData(e!)),
                        SfCartesianChart(
                            plotAreaBackgroundColor: Colors.white,
                            enableAxisAnimation: true,
                            zoomPanBehavior: ZoomPanBehavior(
                                enableDoubleTapZooming: true,
                                enableMouseWheelZooming: true,
                                enablePinching: true,
                                enablePanning: true),
                            trackballBehavior: TrackballBehavior(
                                enable: true,
                                tooltipDisplayMode:
                                    TrackballDisplayMode.floatAllPoints),
                            title: ChartTitle(
                                text:
                                    "${widget.readingData.readingType} Geçmiş verileri",
                                textStyle:
                                    const TextStyle(color: Colors.white)),
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
                                  width: 3,
                                  pointColorMapper: (datum, index) =>
                                      datum.value >
                                              widget.readingData.dangerPoint
                                          ? Colors.red
                                          : lightGreen,
                                  animationDuration: 1000,
                                  dataSource: historicalReadingData,
                                  xValueMapper:
                                      (HistoricalReadingData sales, _) =>
                                          sales.date,
                                  yValueMapper:
                                      (HistoricalReadingData sales, _) =>
                                          sales.value),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
