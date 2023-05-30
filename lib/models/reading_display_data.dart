import 'package:forestguard/util/consts.dart';

class ReadingDisplayData {
  final double readingValue;
  final String readingType;
  final String readingUnit;
  final ReadingType type;
  final num dangerPoint;

  ReadingDisplayData(
      {required this.readingValue,
      required this.readingType,
      required this.readingUnit,
      required this.type,
      required this.dangerPoint});
}
