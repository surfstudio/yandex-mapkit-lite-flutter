part of yandex_mapkit_lite;

/// A point at the specified coordinates.
class Point extends Equatable {
  const Point({
    required this.latitude,
    required this.longitude
  });

  // This was added to the fork.
  const Point.zero({this.latitude = 0, this.longitude = 0});

  /// The point's latitude.
  final double latitude;

  /// The point's longitude
  final double longitude;

  @override
  List<Object> get props => <Object>[
    latitude,
    longitude
  ];

  @override
  bool get stringify => true;

  // This getter was added to the fork.
  bool get isZero => latitude == 0 && longitude == 0;

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Point._fromJson(Map<dynamic, dynamic> json) {
    return Point(
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}
