import 'package:flutter/material.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class MapWidget extends StatelessWidget {
  final List<MapObject> mapObjects;

  final MapCreatedCallback? onControllerCreated;

  final TrafficChangedCallback? onTrafficChanged;

  final UserLocationCallback? onUserLocationUpdated;

  final CameraPositionCallback? onCameraPositionChanged;

  final bool allowUserInteractions;

  const MapWidget({
    required this.mapObjects,
    this.onControllerCreated,
    this.onTrafficChanged,
    this.onUserLocationUpdated,
    this.onCameraPositionChanged,
    this.allowUserInteractions = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      tiltGesturesEnabled: allowUserInteractions,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: allowUserInteractions,
      zoomGesturesEnabled: allowUserInteractions,
      fastTapEnabled: true,
      onMapCreated: onControllerCreated,
      mapObjects: mapObjects,
      onTrafficChanged: onTrafficChanged,
      onUserLocationAdded: onUserLocationUpdated,
      onCameraPositionChanged: onCameraPositionChanged,
      nightModeEnabled: Theme.of(context).brightness == Brightness.dark,
      logoAlignment: const MapAlignment(
        horizontal: HorizontalAlignment.left,
        vertical: VerticalAlignment.top,
      ),
    );
  }
}
