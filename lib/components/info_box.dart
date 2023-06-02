import 'package:flutter/material.dart';
import 'package:forestguard/models/reading_display_data.dart';
import 'package:forestguard/util/consts.dart';

import '../screens/info_box_detail_screen.dart';

class InfoBox extends StatelessWidget {
  final ReadingDisplayData readingData;
  const InfoBox({super.key, required this.readingData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) =>
              InfoBoxDetailScreen(readingData: readingData)))),
      child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: readingData.readingValue > readingData.dangerPoint
                ? darkRed
                : lightGreen,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    readingData.readingType,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Arial"),
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: midGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("Geçmiş verileri göster"),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "${readingData.readingValue.toStringAsFixed(2)} ${readingData.readingUnit}",
                style: const TextStyle(
                  fontSize: 25,
                ),
              )
            ],
          )),
    );
  }
}
