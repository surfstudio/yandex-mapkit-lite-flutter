import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/res/assets.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class CustomClusterizationMapStrategyDelegate extends MapStrategyDelegate {
  @override
  Widget buildActions(BuildContext context) => const SizedBox();

  /// There is only one placemark on the map.
  ///
  /// The placemark is a circle with a red number inside, which is incremented
  /// every time the user taps on the placemark.
  ///
  /// There is also a action button for incrementing.
  @override
  Set<MapObject> get mapObjects {
    return _clusteredObjects.where((element) => element.location != null).map((cluster) {
      if (cluster.isCluster ?? false) {
        return PlacemarkMapObject(
          point: cluster.location!,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(Assets.cluster),
            ),
          ),
          consumeTapEvents: true,
          text: PlacemarkText(
            text: cluster.pointsSize.toString(),
            style: const PlacemarkTextStyle(
              color: Colors.black,
              size: 10,
            ),
          ),
          opacity: 1,
          mapId: MapObjectId(cluster.clusterId!.toString()),
        );
      }

      final id = int.tryParse(cluster.markerId ?? '');

      return PlacemarkMapObject(
        point: cluster.location!,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              _selectedIds.contains(id) ? Assets.routeStart : Assets.routeEnd,
            ),
          ),
        ),
        consumeTapEvents: true,
        opacity: 1,
        mapId: MapObjectId(cluster.markerId!),
        onTap: (_, __) {
          if (id == null) return;

          if (_selectedIds.contains(id)) {
            _selectedIds.remove(id);
          } else {
            _selectedIds.add(id);
          }

          notifyListeners();
        },
      );
    }).toSet();
  }

  @override
  String get title => "Custom clusterization";

  late final List<ClusterableWrapper> _clusterables;

  late final Fluster<ClusterableWrapper> _fluster;

  CustomClusterizationMapStrategyDelegate() {
    /// Generate clusterables objects,
    /// which are used for Fluster tp
    /// generate clusters.
    _clusterables = _generateClusterables();

    /// Create Fluster instance.
    ///
    /// Fluster is a helper class to generate
    /// clusters for the map.
    ///
    /// It uses a quadtree data structure to
    /// efficiently cluster large amounts of
    /// points.
    _fluster = Fluster<ClusterableWrapper>(
      /// Any zoom value below minZoom will not generate clusters.
      minZoom: 0,

      /// Any zoom value above maxZoom will not generate clusters.
      maxZoom: 20,

      /// Cluster radius in pixels.
      radius: 150,

      /// Adjust the extent by powers of 2 (e.g. 512. 1024, ... max 8192) to get the
      /// desired distance between markers where they start to cluster.
      extent: 2048,

      /// The size of the KD-tree leaf node, which affects performance.
      nodeSize: 64,
      points: _clusterables,
      // ignore: avoid_types_on_closure_parameters
      createCluster: (BaseCluster? cluster, double? longitude, double? latitude) {
        return ClusterableWrapper(
          latitude: latitude,
          longitude: longitude,
          isCluster: true,
          clusterId: cluster?.id,
          pointsSize: cluster?.pointsSize,
          childMarkerId: cluster?.childMarkerId,
        );
      },
    );
  }

  List<ClusterableWrapper> _generateClusterables() => List.generate(
        100,
        (i) => ClusterableWrapper(
          latitude: Constants.defaultLocation.latitude + (0.1 * (i - 50)),
          longitude: Constants.defaultLocation.longitude + (0.1 * (i - 50)),
          isCluster: false,
          clusterId: 0,
          pointsSize: 0,
          markerId: '$i',
        ),
      );

  /// List of clustered objects.
  ///
  /// This list is updated every time the camera position changes.
  List<ClusterableWrapper> _clusteredObjects = [];

  /// Set of selected marker ids.
  ///
  /// This set is updated every time the user taps on a marker.
  ///
  /// Demonstrates, how efficient can custom clusterization be
  /// in comparison with out-of-the-box clusterization.
  final _selectedIds = <int>{};

  /// View expand factor.
  ///
  /// This factor is used to expand the visible region
  /// to make sure that all the markers are visible
  /// and clusters are generated with markers
  /// which are slightly outside the visible region.
  static const _viewExpandFactor = 0;

  @override
  void onCameraPositionChanged(
    CameraPosition cameraPosition,
    CameraUpdateReason reason,
    bool finished,
    VisibleRegion visibleRegion,
  ) {
    final zoom = cameraPosition.zoom;

    _clusteredObjects = _fluster.clusters(
      [
        visibleRegion.bottomLeft.longitude - _viewExpandFactor,
        visibleRegion.bottomLeft.latitude - _viewExpandFactor,
        visibleRegion.topRight.longitude + _viewExpandFactor,
        visibleRegion.topRight.latitude + _viewExpandFactor,
      ],
      zoom.toInt(),
    );

    notifyListeners();
  }
}

/// Wrapper for clusterable object.
///
/// This wrapper is used to demonstrate how to
/// use custom clusterization with Fluster.
///
/// See [Fluster] for more details.
class ClusterableWrapper implements Clusterable {
  @override
  String? childMarkerId;

  @override
  int? clusterId;

  @override
  bool? isCluster;

  @override
  double? latitude;

  @override
  double? longitude;

  @override
  String? markerId;

  @override
  int? pointsSize;

  ClusterableWrapper({
    this.latitude,
    this.longitude,
    this.isCluster,
    this.clusterId,
    this.pointsSize,
    this.markerId,
    this.childMarkerId,
  });

  Point? get location {
    if (latitude == null || longitude == null) return null;

    return Point(
      latitude: latitude!,
      longitude: longitude!,
    );
  }
}
