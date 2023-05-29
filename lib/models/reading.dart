class Reading {
  final double temperature;
  final double smoke;
  final double humidity;
  final bool isThreatOfFire;

  Reading({
    required this.temperature,
    required this.smoke,
    required this.humidity,
    required this.isThreatOfFire,
  });

  Reading.fromJSON(Map<String, dynamic> json)
      : temperature = double.parse(json['temperature'].toString()),
        smoke = double.parse(json['smoke'].toString()),
        humidity = double.parse(json['humidity'].toString()),
        isThreatOfFire = json['isFireExist'];
}
