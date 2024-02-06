part of yandex_mapkit_lite;

/// Geo object.
/// Can be displayed as a placemark, polyline, polygon, etc. depending on the geometry type.
class GeoObject extends Equatable {
  const GeoObject._(
      {required this.name,
      required this.descriptionText,
      required this.geometry,
      required this.boundingBox,
      required this.selectionMetadata,
      required this.aref});

  /// Object name
  final String name;

  /// The description of the object
  final String descriptionText;

  /// The object's geometry.
  final List<Geometry> geometry;

  /// A rectangular box around the object.
  final BoundingBox? boundingBox;

  /// Additional data for toponym objects.
  final GeoObjectSelectionMetadata? selectionMetadata;

  /// The name of the internet resource.
  final List<String> aref;

  @override
  List<Object?> get props => <Object?>[
        name,
        descriptionText,
        geometry,
        boundingBox,
        selectionMetadata,
        aref,
      ];

  @override
  bool get stringify => true;

  factory GeoObject._fromJson(Map<dynamic, dynamic> json) {
    final selectionMetadata = json['selectionMetadata'] != null
        ? GeoObjectSelectionMetadata._fromJson(json['selectionMetadata'])
        : null;

    return GeoObject._(
      name: json['name'] ?? '',
      descriptionText: json['descriptionText'] ?? '',
      geometry:
          json['geometry'].map<Geometry>((i) => Geometry._fromJson(i)).toList(),
      boundingBox: json['boundingBox'] != null
          ? BoundingBox._fromJson(json['boundingBox'])
          : null,
      selectionMetadata: selectionMetadata,
      aref: (json['aref'] as List<Object?>).cast<String>(),
    );
  }
}

/// Geo object metadata which is needed to select object
class GeoObjectSelectionMetadata extends Equatable {
  const GeoObjectSelectionMetadata._(
      {required this.objectId,
      required this.layerId,
      required this.dataSourceName});

  /// Object ID.
  final String objectId;

  /// Layer ID.
  final String layerId;

  /// Data source name
  final String dataSourceName;

  @override
  List<Object?> get props => <Object?>[objectId, layerId, dataSourceName];

  @override
  bool get stringify => true;

  factory GeoObjectSelectionMetadata._fromJson(Map<dynamic, dynamic> json) {
    return GeoObjectSelectionMetadata._(
        objectId: json['objectId'],
        layerId: json['layerId'],
        dataSourceName: json['dataSourceName']);
  }
}
