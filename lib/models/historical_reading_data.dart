class HistoricalReadingData {
  final String date;
  final double value;

  HistoricalReadingData({required this.date, required this.value});

  factory HistoricalReadingData.fromJson(Map<String, dynamic> json) {
    return HistoricalReadingData(date: json['date'], value: json['value']);
  }
}
