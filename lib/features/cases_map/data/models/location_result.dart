class LocationResult {
  final String displayName;
  final double lat;
  final double lon;

  LocationResult({
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  factory LocationResult.fromJson(Map<String, dynamic> json) {
    return LocationResult(
      displayName: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}
