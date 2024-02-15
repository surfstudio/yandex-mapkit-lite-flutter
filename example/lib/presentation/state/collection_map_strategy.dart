import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/res/assets.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

/// Delegate for Yandex Map collection feature showcase strategy.
class ClusterMapStrategyDelegate extends MapStrategyDelegate {
  final _selectedPlaces = <int>{};

  void onPressed(int value) {
    if (_selectedPlaces.contains(value)) {
      _selectedPlaces.remove(value);
    } else {
      _selectedPlaces.add(value);
    }
    notifyListeners();
  }

  /// Switcher for clusterization.
  ///
  /// If set to true, the clusterization will be enabled, and
  /// the collection of placemarks will be grouped into clusters.
  ///
  /// If set to false, the clusterization will be disabled, and
  /// the collection of placemarks will be displayed as it is.
  ///
  /// The default value is true.
  ///
  /// The reason for this switcher is to demonstrate the flaws
  /// when interacting with the collection of placemarks in the
  /// clusterization mode.
  bool _isClusterizationEnabled = true;

  void switchClusterization() {
    _isClusterizationEnabled = !_isClusterizationEnabled;
    if (!_isClusterizationEnabled) _alternativeClusterIconUpdate = false;
    notifyListeners();
  }

  /// Switcher for cluster icon update.
  ///
  /// This switcher is used to demonstrate the workaround for the
  /// cluster icon update issue.
  ///
  /// If set to true, the cluster icon update will be enabled, and
  /// the collection of placemarks will be displayed as it is, however
  /// the selected placemarks will be displayed as a separate placemarks
  /// with a different icon. This is a workaround for the issue, when
  /// one icon in cluster is updated, all the icons in cluster are updated,
  /// which can cause performance issues and visual bugs caused by the
  /// native package limitations.
  ///
  /// But this workaround has its own issues, such as the selected placemarks
  /// will be displayed as a separate placemarks and they will not be included
  /// in the cluster, which can cause visual bugs. Consider using this workaround
  /// carefully.
  ///
  /// If set to false, the cluster icon update will be disabled, and
  /// the collection of placemarks will be displayed as it is.
  bool _alternativeClusterIconUpdate = false;

  void switchClusterIconUpdate() {
    _alternativeClusterIconUpdate = !_alternativeClusterIconUpdate;
    notifyListeners();
  }

  @override
  Widget buildActions(BuildContext context) => ListenableBuilder(
        listenable: this,
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (_isClusterizationEnabled) ...[
                FloatingActionButton.extended(
                  onPressed: switchClusterIconUpdate,
                  label: Text(
                      'Switch cluster icon update: ${_alternativeClusterIconUpdate ? 'ON' : 'OFF'}'),
                ),
                const SizedBox(height: 8),
              ],
              FloatingActionButton.extended(
                onPressed: switchClusterization,
                label: Text(
                    'Switch clusters: ${_isClusterizationEnabled ? 'ON' : 'OFF'}'),
              ),
            ],
          );
        },
      );

  PlacemarkMapObject _createPlacemark(int index) {
    return PlacemarkMapObject(
      opacity: 1,
      point: Point(
        latitude: Constants.defaultLocation.latitude + (0.1 * (index - 50)),
        longitude: Constants.defaultLocation.longitude + (0.1 * (index - 50)),
      ),
      onTap: (_, __) {
        onPressed(index);
      },
      consumeTapEvents: true,
      mapId: MapObjectId('cluster_unit_$index'),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            _selectedPlaces.contains(index) && !_alternativeClusterIconUpdate
                ? Assets.routeStart
                : Assets.routeEnd,
          ),
        ),
      ),
    );
  }

  PlacemarkMapObject _createSelectedPlacemark(int index) {
    return PlacemarkMapObject(
      opacity: 1,
      zIndex: 1,
      point: Point(
        latitude: Constants.defaultLocation.latitude + (0.1 * (index - 50)),
        longitude: Constants.defaultLocation.longitude + (0.1 * (index - 50)),
      ),
      onTap: (_, __) {
        onPressed(index);
      },
      consumeTapEvents: true,
      mapId: MapObjectId('cluster_unit_$index'),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(Assets.routeStart),
        ),
      ),
    );
  }

  @override
  Set<MapObject> get mapObjects {
    final placemarks = List.generate(
      100,
      _createPlacemark,
    );

    return {
      /// Clusterized placemarks collection.
      ///
      /// If clusterization is enabled, the collection of placemarks will be
      /// grouped into clusters.
      ///
      /// If clusterization is disabled, the collection of placemarks will be
      /// displayed as it is.
      if (_isClusterizationEnabled)
        ClusterizedPlacemarkCollection(
          mapId: const MapObjectId('cluster'),
          onClusterAdded: (self, cluster) async {
            return cluster.copyWith(
              appearance: PlacemarkMapObject(
                mapId: MapObjectId(
                    'cluster_child_${cluster.appearance.mapId.value}'),
                point: cluster.appearance.point,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(Assets.cluster),
                  ),
                ),
                text: PlacemarkText(
                  text: cluster.size.toString(),
                  style: const PlacemarkTextStyle(size: 10),
                ),
              ),
            );
          },
          placemarks: placemarks,
          radius: 5,
          minZoom: 5,
        )
      else
        ...placemarks,

      /// Selected placemarks collection.
      ///
      /// If clusterization workaorund is enabled, the selected placemarks will be displayed
      /// as a separate placemarks with a different icon on top of the clusterized placemarks.
      ///
      /// If clusterization workaorund is disabled, the selected placemarks will not be displayed,
      /// and we will try updating the placemark icon in the cluster, which will cause performance
      /// issues and visual bugs.
      if (_alternativeClusterIconUpdate)
        ..._selectedPlaces.map(_createSelectedPlacemark),
    };
  }

  @override
  String get title => "Map objects clusterization";
}
